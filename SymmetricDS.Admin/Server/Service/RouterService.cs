﻿using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Shengtai;
using Shengtai.Options;
using Shengtai.Web.Telerik;
using Shengtai.Web.Telerik.Mvc;
using SymmetricDS.Admin.WebApplication.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SymmetricDS.Admin.Server.Service
{
    public class RouterService : NpgsqlRepository<ServerDbContext, ConnectionStrings>, IApiService<int, RouterViewModel, Router>
    {
        private readonly ILogger<RouterService> logger;
        public RouterService(IOptions<AppSettings> options, ServerDbContext dbContext, ILogger<RouterService> logger) : base(options.Value, dbContext)
        {
            this.logger = logger;
        }

        public async Task<bool> CreateAsync(RouterViewModel model, IDataSource dataSource)
        {
            var router = new Router
            {
                RouterId = model.RouterId,
                ProjectId = model.Project.Id.Value,
                SourceNodeGroupId = model.SourceNodeGroup.Id.Value,
                TargetNodeId = model.TargetNode.Id.Value
            };
            await this.DbContext.Router.AddAsync(router);

            bool result = false;
            try
            {
                await this.DbContext.SaveChangesAsync();
                model.Id = router.Id;
                result = true;
            }
            catch(Exception e)
            {
                this.logger.LogCritical(e.Message);
            }

            return result;
        }

        public async Task<bool?> DestroyAsync(int key)
        {
            var router = await this.ReadAsync(key);
            if (router == null)
                return null;

            this.DbContext.Router.Remove(router);

            bool result = false;
            try
            {
                await this.DbContext.SaveChangesAsync();
                result = true;
            }
            catch { }

            return result;
        }

        public async Task<Router> ReadAsync(int key)
        {
            return await this.DbContext.Router.SingleOrDefaultAsync(r => r.Id == key);
        }

        public Task<IDataSourceResponse<RouterViewModel>> ReadAsync(DataSourceRequest request)
        {
            var responseData = this.DbContext.Router.Include("Project").Include("SourceNodeGroup").Include("TargetNode").Select(r => r);

            if (request.ServerFiltering != null) { }

            IDataSourceResponse<RouterViewModel> response = new DataSourceResponse<RouterViewModel> { TotalRowCount = responseData.Count() };

            if (request.ServerPaging != null)
            {
                int skip = Math.Max(request.ServerPaging.PageSize * (request.ServerPaging.Page - 1), 0);
                responseData = responseData.OrderBy(p => p.Id).Skip(skip).Take(request.ServerPaging.PageSize);
            }

            var dataCollection = responseData.ToList();
            foreach (var data in dataCollection)
                response.DataCollection.Add(RouterViewModel.NewInstance(data));

            return Task.FromResult(response);
        }

        public async Task<bool?> UpdateAsync(int key, RouterViewModel model, IDataSource dataSource)
        {
            var router = await this.ReadAsync(key);
            if (router == null)
                return null;

            router.RouterId = model.RouterId;
            router.ProjectId = model.Project.Id.Value;
            router.SourceNodeGroupId = model.SourceNodeGroup.Id.Value;
            router.TargetNodeId = model.TargetNode.Id.Value;

            bool result = false;
            try
            {
                await this.DbContext.SaveChangesAsync();
                result = true;
            }
            catch { }

            return result;
        }
    }
}
