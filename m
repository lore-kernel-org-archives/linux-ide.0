Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445324BBFD;
	Thu, 30 Apr 2026 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510826; cv=none; b=SfgfvJ4AL7csrNH5XMOGlvGt6V0v0vFAd/okExvVXecAUbDNxL3TsBo3PGIP44WQAsQRJh/3QzZBUFHvQSgjmOfdDWcwBxpY//x6koaRlCy9+QItm7Rq/fh/2bav+6GhwtqOO/UawtC6hpLuJ+Gh5/6p3uRg1c0HdJx1Bupon3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510826; c=relaxed/simple;
	bh=EYWCu7pcpjJUbAqcj2oVsDuaMCGyOKj0egVRvkGiCao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD6i9CQ+JX7UDJsdZaFYq3CrSZhzIia+ve8Jvkd+oHq+5CNkTT9CrLrTmLIf0hx9w8aDomiyJOKP5Hhs2KOZU8Bj2ai7EPA7dqbNlKiIYWV7gltZnuYF5t80YR5tItMcfixdc0qb4H1lv3cuOyG1Qk2/wDYK9FYsffxdSuAkNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+hZsc41; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+hZsc41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777510825; x=1809046825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EYWCu7pcpjJUbAqcj2oVsDuaMCGyOKj0egVRvkGiCao=;
  b=W+hZsc41gO+vLWTGD4KBIhoVW/YZVgTUnHbIi2CUnhcxJYkTL0VyB/CL
   DktzFb1jpB+OG5cUL26sEi1RXW8THScSuRet7/WzslCUj2i4rwcEPTdFY
   HjN+VrmXSjtvEM3JdoHVfDm602wGI4kE0XnrdtZj9sjPOlz+HHiJ7KxeJ
   pT06Ua+cZSRW6J+AzYHmDX8dc6wMUHBifw6P93mYaliJ+1L7rx0mfQtFO
   FxG9r99Zhot04/9F9v1vLvOnTPnv/XAQIFMBLbrlL7Y8udwoV6TgY0lqz
   EUNKROBZOT9Ib+Ed7Xkvnz5hnQqrkWjSxZvhyFJv7DHnmLNNb1ct5Kf12
   A==;
X-CSE-ConnectionGUID: OaLRpVC3Tlqh62doSdKj4w==
X-CSE-MsgGUID: 3FayHJUxQh2kB8t9FYfR4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88765235"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="88765235"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 18:00:22 -0700
X-CSE-ConnectionGUID: jVdDLsXNTnyJvKxkcc+Yvg==
X-CSE-MsgGUID: cFU99KVIRJC2v6TqLQri6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="239452394"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 29 Apr 2026 18:00:20 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIFlI-00000000BkC-3Irb;
	Thu, 30 Apr 2026 01:00:16 +0000
Date: Thu, 30 Apr 2026 08:59:57 +0800
From: kernel test robot <lkp@intel.com>
To: dayou5941@163.com, dlemoal@kernel.org, cassel@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	liyouhong@kylinos.cn
Subject: Re: [PATCH] ata: libahci: fix panic when accessing ports beyond MMIO
 region
Message-ID: <202604300815.6kpEidbJ-lkp@intel.com>
References: <20260422080322.1006592-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422080322.1006592-1-dayou5941@163.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.1-rc1 next-20260429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/dayou5941-163-com/ata-libahci-fix-panic-when-accessing-ports-beyond-MMIO-region/20260422-192119
base:   linus/master
patch link:    https://lore.kernel.org/r/20260422080322.1006592-1-dayou5941%40163.com
patch subject: [PATCH] ata: libahci: fix panic when accessing ports beyond MMIO region
config: arm64-randconfig-003-20260430 (https://download.01.org/0day-ci/archive/20260430/202604300815.6kpEidbJ-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300815.6kpEidbJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300815.6kpEidbJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ata/libahci.c:614:18: warning: missing terminating '"' character [-Winvalid-pp-token]
     614 |                         dev_warn(dev, "Port %d (offset 0x%llx) exceeds MMIO region (0x%llx),
         |                                       ^
   drivers/ata/libahci.c:615:44: warning: missing terminating '"' character [-Winvalid-pp-token]
     615 |                                        truncating port map at port %d\n",
         |                                                                        ^
>> drivers/ata/libahci.c:614:18: error: expected expression
     614 |                         dev_warn(dev, "Port %d (offset 0x%llx) exceeds MMIO region (0x%llx),
         |                                       ^
   2 warnings and 1 error generated.


vim +614 drivers/ata/libahci.c

   428	
   429	/**
   430	 *	ahci_save_initial_config - Save and fixup initial config values
   431	 *	@dev: target AHCI device
   432	 *	@hpriv: host private area to store config values
   433	 *
   434	 *	Some registers containing configuration info might be setup by
   435	 *	BIOS and might be cleared on reset.  This function saves the
   436	 *	initial values of those registers into @hpriv such that they
   437	 *	can be restored after controller reset.
   438	 *
   439	 *	If inconsistent, config values are fixed up by this function.
   440	 *
   441	 *	If it is not set already this function sets hpriv->start_engine to
   442	 *	ahci_start_engine.
   443	 *
   444	 *	LOCKING:
   445	 *	None.
   446	 */
   447	void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
   448	{
   449		void __iomem *mmio = hpriv->mmio;
   450		void __iomem *port_mmio;
   451		unsigned long port_map;
   452		u32 cap, cap2, vers;
   453		unsigned long long mmio_size = 0;
   454		bool is_pci_dev = false;
   455		int i;
   456	
   457		/* make sure AHCI mode is enabled before accessing CAP */
   458		ahci_enable_ahci(mmio);
   459	
   460		/*
   461		 * Values prefixed with saved_ are written back to the HBA and ports
   462		 * registers after reset. Values without are used for driver operation.
   463		 */
   464	
   465		/*
   466		 * Override HW-init HBA capability fields with the platform-specific
   467		 * values. The rest of the HBA capabilities are defined as Read-only
   468		 * and can't be modified in CSR anyway.
   469		 */
   470		cap = readl(mmio + HOST_CAP);
   471		if (hpriv->saved_cap)
   472			cap = (cap & ~(HOST_CAP_SSS | HOST_CAP_MPS)) | hpriv->saved_cap;
   473		hpriv->saved_cap = cap;
   474	
   475		/* CAP2 register is only defined for AHCI 1.2 and later */
   476		vers = readl(mmio + HOST_VERSION);
   477		if ((vers >> 16) > 1 ||
   478		   ((vers >> 16) == 1 && (vers & 0xFFFF) >= 0x200))
   479			hpriv->saved_cap2 = cap2 = readl(mmio + HOST_CAP2);
   480		else
   481			hpriv->saved_cap2 = cap2 = 0;
   482	
   483		/* some chips have errata preventing 64bit use */
   484		if ((cap & HOST_CAP_64) && (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)) {
   485			dev_info(dev, "controller can't do 64bit DMA, forcing 32bit\n");
   486			cap &= ~HOST_CAP_64;
   487		}
   488	
   489		if ((cap & HOST_CAP_NCQ) && (hpriv->flags & AHCI_HFLAG_NO_NCQ)) {
   490			dev_info(dev, "controller can't do NCQ, turning off CAP_NCQ\n");
   491			cap &= ~HOST_CAP_NCQ;
   492		}
   493	
   494		if (!(cap & HOST_CAP_NCQ) && (hpriv->flags & AHCI_HFLAG_YES_NCQ)) {
   495			dev_info(dev, "controller can do NCQ, turning on CAP_NCQ\n");
   496			cap |= HOST_CAP_NCQ;
   497		}
   498	
   499		if ((cap & HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_NO_PMP)) {
   500			dev_info(dev, "controller can't do PMP, turning off CAP_PMP\n");
   501			cap &= ~HOST_CAP_PMP;
   502		}
   503	
   504		if ((cap & HOST_CAP_SNTF) && (hpriv->flags & AHCI_HFLAG_NO_SNTF)) {
   505			dev_info(dev,
   506				 "controller can't do SNTF, turning off CAP_SNTF\n");
   507			cap &= ~HOST_CAP_SNTF;
   508		}
   509	
   510		if ((cap2 & HOST_CAP2_SDS) && (hpriv->flags & AHCI_HFLAG_NO_DEVSLP)) {
   511			dev_info(dev,
   512				 "controller can't do DEVSLP, turning off\n");
   513			cap2 &= ~HOST_CAP2_SDS;
   514			cap2 &= ~HOST_CAP2_SADM;
   515		}
   516	
   517		if (!(cap & HOST_CAP_FBS) && (hpriv->flags & AHCI_HFLAG_YES_FBS)) {
   518			dev_info(dev, "controller can do FBS, turning on CAP_FBS\n");
   519			cap |= HOST_CAP_FBS;
   520		}
   521	
   522		if ((cap & HOST_CAP_FBS) && (hpriv->flags & AHCI_HFLAG_NO_FBS)) {
   523			dev_info(dev, "controller can't do FBS, turning off CAP_FBS\n");
   524			cap &= ~HOST_CAP_FBS;
   525		}
   526	
   527		if (!(cap & HOST_CAP_ALPM) && (hpriv->flags & AHCI_HFLAG_YES_ALPM)) {
   528			dev_info(dev, "controller can do ALPM, turning on CAP_ALPM\n");
   529			cap |= HOST_CAP_ALPM;
   530		}
   531	
   532		if ((cap & HOST_CAP_SXS) && (hpriv->flags & AHCI_HFLAG_NO_SXS)) {
   533			dev_info(dev, "controller does not support SXS, disabling CAP_SXS\n");
   534			cap &= ~HOST_CAP_SXS;
   535		}
   536	
   537		/* Override the HBA ports mapping if the platform needs it */
   538		port_map = readl(mmio + HOST_PORTS_IMPL);
   539		if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
   540			dev_info(dev, "forcing port_map 0x%lx -> 0x%x\n",
   541				 port_map, hpriv->saved_port_map);
   542			port_map = hpriv->saved_port_map;
   543		} else {
   544			hpriv->saved_port_map = port_map;
   545		}
   546	
   547		/* mask_port_map not set means that all ports are available */
   548		if (hpriv->mask_port_map) {
   549			dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",
   550				port_map,
   551				port_map & hpriv->mask_port_map);
   552			port_map &= hpriv->mask_port_map;
   553		}
   554	
   555		/* cross check port_map and cap.n_ports */
   556		if (port_map) {
   557			int map_ports = 0;
   558	
   559			for (i = 0; i < AHCI_MAX_PORTS; i++)
   560				if (port_map & (1 << i))
   561					map_ports++;
   562	
   563			/* If PI has more ports than n_ports, whine, clear
   564			 * port_map and let it be generated from n_ports.
   565			 */
   566			if (map_ports > ahci_nr_ports(cap)) {
   567				dev_warn(dev,
   568					 "implemented port map (0x%lx) contains more ports than nr_ports (%u), using nr_ports\n",
   569					 port_map, ahci_nr_ports(cap));
   570				port_map = 0;
   571			}
   572		}
   573	
   574		/* fabricate port_map from cap.nr_ports for < AHCI 1.3 */
   575		if (!port_map && vers < 0x10300) {
   576			port_map = (1 << ahci_nr_ports(cap)) - 1;
   577			dev_warn(dev, "forcing PORTS_IMPL to 0x%lx\n", port_map);
   578	
   579			/* write the fixed up value to the PI register */
   580			hpriv->saved_port_map = port_map;
   581		}
   582	
   583		is_pci_dev = dev_is_pci(dev);
   584		if (is_pci_dev) {
   585			struct pci_dev *pdev = to_pci_dev(dev);
   586	
   587			mmio_size = (unsigned long long)pci_resource_len(pdev, 5);
   588		}
   589	
   590		/*
   591		 * Preserve the ports capabilities defined by the platform. Note there
   592		 * is no need in storing the rest of the P#.CMD fields since they are
   593		 * volatile.
   594		 */
   595		for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
   596			if (hpriv->saved_port_cap[i])
   597				continue;
   598	
   599			port_mmio = __ahci_port_base(hpriv, i);
   600	
   601			/* Calculate offset from MMIO base */
   602			unsigned long long port_offset = (unsigned long long)port_mmio -
   603							 (unsigned long long)mmio;
   604			/* Check if port register block is within MMIO region */
   605			if (is_pci_dev && port_offset >= mmio_size) {
   606				/*
   607				 * Port registers exceed MMIO region boundary.
   608				 * Since ports are sequentially mapped (0x100 + i*0x80),
   609				 * all subsequent ports will also exceed the boundary.
   610				 *
   611				 * Update port_map to exclude this and all higher ports,
   612				 * then break out of the loop.
   613				 */
 > 614				dev_warn(dev, "Port %d (offset 0x%llx) exceeds MMIO region (0x%llx),
   615					       truncating port map at port %d\n",
   616					       i, port_offset, mmio_size, i-1);
   617	
   618				port_map = (1UL << i) - 1;
   619				hpriv->saved_port_map = port_map;
   620				break;
   621			}
   622	
   623			hpriv->saved_port_cap[i] =
   624				readl(port_mmio + PORT_CMD) & PORT_CMD_CAP;
   625		}
   626	
   627		/* record values to use during operation */
   628		hpriv->cap = cap;
   629		hpriv->cap2 = cap2;
   630		hpriv->version = vers;
   631		hpriv->port_map = port_map;
   632	
   633		if (!hpriv->start_engine)
   634			hpriv->start_engine = ahci_start_engine;
   635	
   636		if (!hpriv->stop_engine)
   637			hpriv->stop_engine = ahci_stop_engine;
   638	
   639		if (!hpriv->irq_handler)
   640			hpriv->irq_handler = ahci_single_level_irq_intr;
   641	}
   642	EXPORT_SYMBOL_GPL(ahci_save_initial_config);
   643	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
