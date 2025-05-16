Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2514884C;
	Fri, 16 May 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406036; cv=none; b=kDeY1zaEqkZG77hiIczx2vddIIWBLBuUTRGn6GX6Vn6zHzxLs3a3kD0jFUWjhO2YqZB5hJ3NTZUoNPWsZgVw5nyXyHreSU/83305GPac1wFZlIhzSFbrEJgeRkpJ7hhh1bCyO4M2g5y7HAG1Y6aQqM0dXcXdVeYvuihjdwwYO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406036; c=relaxed/simple;
	bh=Xd2ewTryFT54YmHxelw/SYdFHABh+lnf5nXNyKAWRpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1AL/PuBCsNn4vuM+hZGEwrCdr72d3Kc/DIIIRCpHWjKyVlbo0Bf3jHr3/bU9MMMKzbOrEzw6u1A7tP6o7CwBarsl8IDoCz8ur5vOh6KTqTapBqpqZ9bFWt07IGhm/hQyhrJS+wCxaQOy0jXZA2A3RYdV5bJoBvbrxll7ceNl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Loa/pVCD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Loa/pVCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747406034; x=1778942034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xd2ewTryFT54YmHxelw/SYdFHABh+lnf5nXNyKAWRpA=;
  b=Loa/pVCDxk8CkUNK329onsoCzisJ+HpztNYro8VnX5RuE6qRwwlMgvIQ
   /k+GNtFKAkwxeBzP1CBkeD+b9/TahpChNsI3TvqAA+giAkPePDrQV0YMZ
   706ReK97OIfgzyBJgK5RfnKhW0aYVm30Ps+t15q/f46ymQCL7RGeDKrgk
   1rxj48ZropY5CsVjgaqhviSAEI/6gwm3iUfsy4+DhYKVelbUbKs8pVous
   9Ox3Y4SvPyfaD2DWpX788rRLNXSi0UVktQzvPjsN22t5mfbfPX6HL8KoK
   0aSYFneK3AFOwzNehH0rAGEhN4DYEev9VkZwvqicRpd0BgOgvu3bEZXtJ
   A==;
X-CSE-ConnectionGUID: tdHyGEvlThCh+oWXFRvdwg==
X-CSE-MsgGUID: nM0oHVTsQzqhXj8sT2of4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49486315"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49486315"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 07:33:53 -0700
X-CSE-ConnectionGUID: dFyUi+U7QZWinDUfA4SXEg==
X-CSE-MsgGUID: xPA9VdCZQEa74+kZi1r9aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="162021416"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 16 May 2025 07:33:51 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFw8C-000JQF-26;
	Fri, 16 May 2025 14:33:48 +0000
Date: Fri, 16 May 2025 22:33:00 +0800
From: kernel test robot <lkp@intel.com>
To: hehuan1@eswincomputing.com, dlemoal@kernel.org, cassel@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc: oe-kbuild-all@lists.linux.dev, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, luyulin@eswincomputing.com,
	Huan He <hehuan1@eswincomputing.com>
Subject: Re: [PATCH v1 2/2] sata: eswin: Add eic7700 sata driver
Message-ID: <202505162248.OhCrILxm-lkp@intel.com>
References: <20250515090018.1720-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515090018.1720-1-hehuan1@eswincomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.15-rc6 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hehuan1-eswincomputing-com/dt-bindings-sata-eswin-Document-for-EIC7700-SoC/20250515-170607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250515090018.1720-1-hehuan1%40eswincomputing.com
patch subject: [PATCH v1 2/2] sata: eswin: Add eic7700 sata driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250516/202505162248.OhCrILxm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250516/202505162248.OhCrILxm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505162248.OhCrILxm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ata/ahci_eic7700.c:206:12: warning: 'eswin_ahci_resume' defined but not used [-Wunused-function]
     206 | static int eswin_ahci_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~
>> drivers/ata/ahci_eic7700.c:195:12: warning: 'eswin_ahci_suspend' defined but not used [-Wunused-function]
     195 | static int eswin_ahci_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~


vim +/eswin_ahci_resume +206 drivers/ata/ahci_eic7700.c

   194	
 > 195	static int eswin_ahci_suspend(struct device *dev)
   196	{
   197		int ret;
   198	
   199		ret = ahci_platform_suspend(dev);
   200		if (ret)
   201			return ret;
   202	
   203		return 0;
   204	}
   205	
 > 206	static int eswin_ahci_resume(struct device *dev)
   207	{
   208		int ret;
   209	
   210		ret = ahci_platform_resume(dev);
   211		if (ret)
   212			return ret;
   213	
   214		return 0;
   215	}
   216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
