using Azure.Monitor.OpenTelemetry.AspNetCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddReverseProxy()
    .LoadFromConfig(builder.Configuration.GetSection("ReverseProxy"));

builder.Services.AddOpenTelemetry()
    .UseAzureMonitor(o =>
    {
        o.ConnectionString = builder.Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"];
    })
    .WithTracing(t =>
    {
        // Listen to the YARP tracing activities
        t.AddSource("Yarp.ReverseProxy");
    });

var app = builder.Build();

app.MapReverseProxy();

app.Run();
