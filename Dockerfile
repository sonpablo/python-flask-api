FROM python:3.11

# Set the working directory
WORKDIR /app

COPY requirements.txt .

# Install CA certificates
RUN apt-get update && apt-get install -y ca-certificates

# Set trusted hosts for pip
ENV PIP_TRUSTED_HOST pypi.python.org
ENV PIP_TRUSTED_HOST pypi.org
ENV PIP_TRUSTED_HOST files.pythonhosted.org

# Install Flask
RUN pip install --trusted-host pypi.python.org --trusted-host pypi.org --trusted-host files.pythonhosted.org --no-cache-dir --upgrade -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the required port
EXPOSE 5000

# Command to run the application
CMD ["flask", "run", "--host", "0.0.0.0"]

# 1) docker build -t rest-apis-flask-python .         
# 2) docker run -dp 5005:5000 -w /app -v "$(pwd):/app" rest-apis-flask-python