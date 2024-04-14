from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional
from fastapi.middleware.cors import CORSMiddleware

# Import your LLM logic here
from langchain.agents import create_sql_agent 
from langchain.agents.agent_toolkits import SQLDatabaseToolkit 
from langchain.sql_database import SQLDatabase 
from langchain.llms.openai import OpenAI 
from langchain.agents import AgentExecutor 
from langchain.agents.agent_types import AgentType

# Configuration for your LLM and database
password = '1234'
username = 'postgres'
host ='localhost'
port ='5432'
mydatabase='postgres'
pg_uri = f"postgresql+psycopg2://{username}:{password}@{host}:{port}/{mydatabase}"
OPENAI_API_KEY = ""

# Initialize your LLM and toolkit here
# Ensure this is done securely and efficiently for production use

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)
class Query(BaseModel):
    user_query: str

@app.post("/get-answer/")
async def get_answer(query: Query):
    try:
        # Initialize your LLM, database, and toolkit here or use a pre-initialized instance
        # This is just a placeholder to show where your LLM logic would be executed
        # Replace with the actual code to execute the query through your LLM setup
        
        gpt = OpenAI(temperature=0, openai_api_key=OPENAI_API_KEY, model_name='gpt-3.5-turbo')
        db = SQLDatabase.from_uri(pg_uri)
        toolkit = SQLDatabaseToolkit(db=db, llm=gpt)
        agent_executor = create_sql_agent(
            llm=gpt,
            toolkit=toolkit,
            verbose=True,
            agent_type=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
        )
        answer = agent_executor.run(query.user_query)
        
        return {"answer": answer}
    except Exception as e:
        # print(e)
        # For debugging purposes, you can return the exception message
        # In production, you might not want to send such messages to the client
        raise HTTPException(status_code=500, detail=str(e))