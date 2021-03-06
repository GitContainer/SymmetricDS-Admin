﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json.Serialization;
using Shengtai.Web.Telerik.Mvc;
using SymmetricDS.Admin.Server;
using SymmetricDS.Admin.Server.Service;
using SymmetricDS.Admin.WebApplication.Models;

namespace SymmetricDS.Admin.WebApplication
{
    public class Startup
    {
        public Startup(Microsoft.Extensions.Configuration.IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public Microsoft.Extensions.Configuration.IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                options.CheckConsentNeeded = context => true;
                options.MinimumSameSitePolicy = SameSiteMode.None;
            });

            string connectionString = Configuration.GetConnectionString("DefaultConnection");
            var assemblyName = typeof(Startup).GetTypeInfo().Assembly.GetName().Name;
            services.AddDbContext<ServerDbContext>(options =>
                options.UseNpgsql(connectionString, o => o.MigrationsAssembly(assemblyName)));

            services.AddMvc()
                .AddJsonOptions(o => o.SerializerSettings.ContractResolver = new DefaultContractResolver { NamingStrategy = null })
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

            services.AddOptions().Configure<AppSettings>(this.Configuration);

            services.AddScoped<IApiService<int, ProjectViewModel, Project>, ProjectService>().AddScoped<IProjectService, ProjectService>();
            services.AddScoped<IApiService<int, NodeGroupViewModel, NodeGroup>, NodeGroupService>().AddScoped<INodeGroupService, NodeGroupService>();
            services.AddScoped<IApiService<int, NodeViewModel, Node>, NodeService>().AddScoped<INodeService, NodeService>();
            services.AddScoped<IApiService<int, ChannelViewModel, Channel>, ChannelService>().AddScoped<IChannelService, ChannelService>();
            services.AddScoped<IApiService<int, TriggerViewModel, Trigger>, TriggerService>().AddScoped<ITriggerService, TriggerService>();
            services.AddScoped<IApiService<int, RouterViewModel, Router>, RouterService>();
            services.AddScoped<IApiService<string, TriggerRouterViewModel, TriggerRouter>, TriggerRouterService>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseStaticFiles();
            app.UseCookiePolicy();

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
