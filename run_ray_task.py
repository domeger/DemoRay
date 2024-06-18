import ray

# Initialize Ray
ray.init(address='auto')

# Define a simple Ray task
@ray.remote
def hello_world():
    return "Hello, World!"

# Execute the task
result = ray.get(hello_world.remote())
print(result)