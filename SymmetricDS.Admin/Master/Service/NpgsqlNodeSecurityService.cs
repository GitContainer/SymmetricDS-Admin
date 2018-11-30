﻿using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Shengtai;
using Shengtai.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SymmetricDS.Admin.Master.Service
{
    public class NpgsqlNodeSecurityService : NpgsqlRepository<MasterDbContext, ConnectionStrings>, INodeSecurityService
    {
        public NpgsqlNodeSecurityService(IOptions<AppSettings> options, DbContextOptions<MasterDbContext> masterDbContextOptions) : base(options.Value, new MasterDbContext(masterDbContextOptions, options)) { }

        public bool CheckRegister(ICollection<string> nodeIds)
        {
            return NodeSecurityService.CheckRegister(nodeIds, this.DbContext);
        }
    }
}
