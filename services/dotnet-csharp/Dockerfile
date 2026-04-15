# ===============================
# BUILD STAGE
# ===============================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copia apenas csproj primeiro (melhora cache)
COPY Caderno_DG_C_Sharp/Caderno_DG_C_Sharp.csproj Caderno_DG_C_Sharp/
RUN dotnet restore "Caderno_DG_C_Sharp/Caderno_DG_C_Sharp.csproj"

COPY . .
RUN dotnet publish "Caderno_DG_C_Sharp/Caderno_DG_C_Sharp.csproj" -c Release -o /app/publish

# ===============================
# RUNTIME STAGE
# ===============================
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

COPY --from=build /app/publish .

# Porta interna padrão do Kestrel
ENV ASPNETCORE_URLS=http://+:80

EXPOSE 80

ENTRYPOINT ["dotnet", "Caderno_DG_C_Sharp.dll"]