# We use this stage to build/prepare the dotnet app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-stage
WORKDIR /webappcontainer
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

# We use this stage to serve the app
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /webappcontainer
COPY --from=build-stage /webappcontainer/out .
ENTRYPOINT ["dotnet", "webappcontainer.dll"]
