# ===============================
# BUILD STAGE
# ===============================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copia apenas csproj primeiro (melhora cache)
COPY *.csproj ./
RUN dotnet restore

# Copia restante do projeto
COPY . .

RUN dotnet publish -c Release -o /app/publish

# ===============================
# RUNTIME STAGE
# ===============================
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

COPY --from=build /app/publish .

# Porta interna padrão do Kestrel
ENV ASPNETCORE_URLS=http://+:5000

EXPOSE 5000

ENTRYPOINT ["dotnet", "SeuProjeto.dll"]