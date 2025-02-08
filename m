Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA485674E;
	Sat,  8 Feb 2025 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978012; cv=none; b=Bou05sY7yY3iS0msBVKSwXuQiPDjpvXhmT+x/A5LXaF9mz+iHkcH5DUw+SD0cltxGhX7dRAAaX/2L+ARNI69iWqNBZY65WB03PiPjUEj71WtTcy7ozbxV3hCYMEXqktlggXyZQ5gCOO0GXgtT4fffWVy0cdkz4SBHJuZqQTmD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978012; c=relaxed/simple;
	bh=Vf+orbI0MIxZ+NdnmW8ZrODzdSpawbZ5ZYwzT7WkFHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbQHAPgUL5IL6J1NiE7rsTwx54dfmsTNCJp2yaDjCQ3eR/zLG/ZdytGsTVpEs/z8M3mnNC3CmriJi2vqTwUjYjO7eHF2VC4LpR3+f8i3/ocBOXY3ti+7FnZGAGhwY/Mk3rDfhvv8kSw+e0gBkatXQpNEwNZ2wzT6bL72l4XmXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kv8AWxYy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kv8AWxYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738978008; x=1770514008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vf+orbI0MIxZ+NdnmW8ZrODzdSpawbZ5ZYwzT7WkFHs=;
  b=Kv8AWxYyZg+r4zhQRCIye+sQI73IRZebZApdl3398S2rE2ri4fHyVj7x
   8VDRL05amBD4ga/31Pfox1kvhGhmv4yG0HAclQ6+X14k8bcgFZje/8Oql
   MlMdAymvSUj3sqU7X8twqawD2cjd/9hfNR5rTPwHEGnb+I0rprTqq5XCQ
   4t7weH+rvjdf/jXXOKEI5RoFYOTFZQL9xMT6o5Pu0GogJwcK4ZKIeAfez
   o6sQYCC63k3vsMk4ZccN653/fajMRs1zIZXVJYsU6FZTk/Z/cF+vpmuga
   0vBNcAogolHhscMzZ5HB8y4TZi14j5BrKNzAA8lwWm1TWoYZjAjVQaX9g
   Q==;
X-CSE-ConnectionGUID: cDgnysi0RLWGqEVAS9U/Hg==
X-CSE-MsgGUID: ozhffzLQQOWqbGP+mvYBwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50613572"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="50613572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:26:47 -0800
X-CSE-ConnectionGUID: 3S9sGSljQLuj0EiY8i0xug==
X-CSE-MsgGUID: NQdROjzMTsa5FP6NHBmBrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="116720032"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2025 17:26:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgZcD-000zM7-1v;
	Sat, 08 Feb 2025 01:26:37 +0000
Date: Sat, 8 Feb 2025 09:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= via B4 Relay <devnull+j.ne.posteo.net@kernel.org>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 06/12] dt-bindings: pci: Convert fsl,mpc83xx-pcie to
 YAML
Message-ID: <202502080922.nK85none-lkp@intel.com>
References: <20250207-ppcyaml-v2-6-8137b0c42526@posteo.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ppcyaml-v2-6-8137b0c42526@posteo.net>

Hi Neuschäfer,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2014c95afecee3e76ca4a56956a936e23283f05b]

url:    https://github.com/intel-lab-lkp/linux/commits/J-Neusch-fer-via-B4-Relay/dt-bindings-powerpc-Add-Freescale-NXP-MPC83xx-SoCs/20250208-053519
base:   2014c95afecee3e76ca4a56956a936e23283f05b
patch link:    https://lore.kernel.org/r/20250207-ppcyaml-v2-6-8137b0c42526%40posteo.net
patch subject: [PATCH v2 06/12] dt-bindings: pci: Convert fsl,mpc83xx-pcie to YAML
reproduce: (https://download.01.org/0day-ci/archive/20250208/202502080922.nK85none-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502080922.nK85none-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/arch/powerpc/cxl.rst references a file that doesn't exist: Documentation/ABI/testing/sysfs-class-cxl
>> Warning: Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml references a file that doesn't exist: Documentation/devicetree/bindings/pci/fsl,pci.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
   Warning: Documentation/translations/zh_CN/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
