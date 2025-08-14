# Dockerfile for ragflow-server service
# Based on infiniflow/ragflow:v0.20.1
FROM infiniflow/ragflow:v0.20.1

# Set timezone and default environment variables
ENV TZ=Asia/Shanghai

# MCP server configuration (can be overridden at runtime)
ENV ENABLE_MCPSERVER="false"
ENV MCP_HOST="0.0.0.0"
ENV MCP_PORT="9382"
ENV MCP_BASE_URL="http://127.0.0.1:9380"
ENV MCP_SCRIPT_PATH="/ragflow/mcp/server/server.py"
ENV MCP_MODE="self-host"
ENV MCP_HOST_API_KEY="ragflow-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
ENV TRANSPORT_SSE_ENABLED="true"
ENV TRANSPORT_STREAMABLE_HTTP_ENABLED="true"
ENV JSON_RESPONSE="true"

# Create necessary directories
RUN mkdir -p /ragflow/logs /ragflow/history_data_agent

# Copy configuration files
COPY ./nginx/ragflow.conf /etc/nginx/conf.d/ragflow.conf
COPY ./nginx/proxy.conf /etc/nginx/proxy.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./service_conf.yaml.template /ragflow/conf/service_conf.yaml.template
COPY ./entrypoint.sh /ragflow/entrypoint.sh

# Make entrypoint script executable
RUN chmod +x /ragflow/entrypoint.sh

# Expose ports
EXPOSE 9380 80 443 9382

# Set entrypoint
ENTRYPOINT ["/ragflow/entrypoint.sh"]

# Add host.docker.internal mapping for Docker Desktop compatibility
# Note: This is handled differently in Railway, but keeping it for reference
# CMD ["sh", "-c", "echo $(ip route | awk '/default/ { print $3 }') host.docker.internal >> /etc/hosts && /ragflow/entrypoint.sh"]