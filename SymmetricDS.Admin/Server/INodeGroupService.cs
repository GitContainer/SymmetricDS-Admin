﻿using Shengtai.Web.Telerik;
using Shengtai.Web.Telerik.Mvc;
using SymmetricDS.Admin.WebApplication.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace SymmetricDS.Admin.Server
{
    public interface INodeGroupService
    {
        ICollection<NodeGroupViewModel> Read(IFilterInfoCollection serverFiltering);
    }
}
