Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFD2E371A
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949136; cv=none; b=j24k8rZ+1vkpzJXyZ6c1P94nJD0ziaC41DtHbxziRlvsuObY1NvoEItRFkL6DiZp3Hg+Aq3EDeQRKKTuWDJjWqI81DaSCZGD0ZaNTIoe0CbL49j0DZvA+71QaE8ze4UKLqdPpaaVreT+f06P+30m3AXY7jlnAS/R6cIjY2dvx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949136; c=relaxed/simple;
	bh=SGs2vOCD+oEAqmoiVNBCOf6GVQ76wy6LLeXWaxJzwtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxUHAPsT1XD/NyJySDx6Qp7q5u/svLhQ7Ml7gG613R3fiYzW1i2Aa5jXShL1NO1Nea8ruM1yUPYoXW6Gj4hQf/bS//JNY0VJdVxbOkNrR+87ftcdnXyDuO7D6omTtCPocVU1Ux3sWrMFNEv8pBerdRFEOdZN5fmXuQMAUpvl0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZ4P7I0p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZ4P7I0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751949133; x=1783485133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SGs2vOCD+oEAqmoiVNBCOf6GVQ76wy6LLeXWaxJzwtw=;
  b=XZ4P7I0pAMIW1bV+4CgfpdySvqljAmzgF+NdaEsvY6Rq3pwqpIyL+ukZ
   5UM1iqbY/RVNOPf/HXk8CI8Jv5Pwq0GZYWbZEOzGtKisluWW+ZA1w4nWK
   77GPgwjAWT/NMtbzym8oVAvUS+l/QvC6oRqP26Uj2Zn45lB4mNXr7jRSX
   BflPA9JcX02gVgiSofWsAOHqf8K9H/XoX+aAnB8GGc/aDe7IUtwV6ar9M
   aE+7uStiCVh7Rc6tIszROkN++Py2nEXz1lM8WSAghNMYdmadFWNxSZsvg
   U5CT6KPHej1PCKHjNIfvc5VUKuqMl8Y5DPOlenYZeATX7APDYIdzlQ1Xk
   w==;
X-CSE-ConnectionGUID: ZJuXuYWjRJCukf3AUa5CGA==
X-CSE-MsgGUID: eaOsl5GxS3WqDxbygMb5Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54104056"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="54104056"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 21:32:13 -0700
X-CSE-ConnectionGUID: 7DmqQOyQTSaGkwP/9ALLjg==
X-CSE-MsgGUID: LfsJr7ffQpaxYzuZNnfMLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="159727950"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Jul 2025 21:32:11 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZ000-0000zT-2O;
	Tue, 08 Jul 2025 04:32:08 +0000
Date: Tue, 8 Jul 2025 12:31:12 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/3] ata: libata-eh: Remove ata_do_eh()
Message-ID: <202507081215.hXgFd0Tv-lkp@intel.com>
References: <20250707105931.548315-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707105931.548315-3-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.16-rc5 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/ata-libata-eh-Make-ata_eh_followup_srst_needed-return-a-bool/20250707-190306
base:   linus/master
patch link:    https://lore.kernel.org/r/20250707105931.548315-3-dlemoal%40kernel.org
patch subject: [PATCH 2/3] ata: libata-eh: Remove ata_do_eh()
config: csky-randconfig-001-20250708 (https://download.01.org/0day-ci/archive/20250708/202507081215.hXgFd0Tv-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250708/202507081215.hXgFd0Tv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507081215.hXgFd0Tv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ata/libata-eh.c: In function 'ata_std_error_handler':
>> drivers/ata/libata-eh.c:4056:27: error: 'sata_sff_hardreset' undeclared (first use in this function); did you mean 'sata_std_hardreset'?
    4056 |              hardreset == sata_sff_hardreset) && !sata_scr_valid(&ap->link))
         |                           ^~~~~~~~~~~~~~~~~~
         |                           sata_std_hardreset
   drivers/ata/libata-eh.c:4056:27: note: each undeclared identifier is reported only once for each function it appears in


vim +4056 drivers/ata/libata-eh.c

  4038	
  4039	/**
  4040	 *	ata_std_error_handler - standard error handler
  4041	 *	@ap: host port to handle error for
  4042	 *
  4043	 *	Perform standard error handling sequence.
  4044	 *
  4045	 *	LOCKING:
  4046	 *	Kernel thread context (may sleep).
  4047	 */
  4048	void ata_std_error_handler(struct ata_port *ap)
  4049	{
  4050		struct ata_port_operations *ops = ap->ops;
  4051		ata_reset_fn_t hardreset = ops->hardreset;
  4052		int rc;
  4053	
  4054		/* Ignore built-in hardresets if SCR access is not available */
  4055		if ((hardreset == sata_std_hardreset ||
> 4056		     hardreset == sata_sff_hardreset) && !sata_scr_valid(&ap->link))
  4057			hardreset = NULL;
  4058	
  4059		ata_eh_autopsy(ap);
  4060		ata_eh_report(ap);
  4061	
  4062		rc = ata_eh_recover(ap, ops->prereset, ops->softreset,
  4063				    hardreset, ops->postreset, NULL);
  4064		if (rc) {
  4065			struct ata_device *dev;
  4066	
  4067			ata_for_each_dev(dev, &ap->link, ALL)
  4068				ata_dev_disable(dev);
  4069		}
  4070	
  4071		ata_eh_finish(ap);
  4072	}
  4073	EXPORT_SYMBOL_GPL(ata_std_error_handler);
  4074	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
