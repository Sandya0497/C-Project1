# Use a base image with GCC
FROM gcc:12.2.0 as build

WORKDIR /app

# Copy all source files and makefile
COPY . .

# Build the executable using make
RUN make

# Final stage: use a lightweight runtime image
FROM debian:stable-slim

WORKDIR /app

# Copy the compiled binary from the build stage
COPY --from=build /app/ABC.exe .

# Set default command
CMD ["./ABC.exe"]
