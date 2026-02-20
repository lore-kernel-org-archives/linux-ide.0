Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39814344D99;
	Fri, 20 Feb 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594613; cv=none; b=WlaePcuMDS4hDGJVoKBR3X73G3tlcyzyxetUG5LywlV9OYoCK7MKAKOJFWAd0r3zIGVnNqcFzCQtzYhPxbSEPRHZq9vUhsp5scEIcAmCu5dCuiL0RWgjLrFHB5qKqkVzqIyoP1RZlBUCY2pvVcUITMMluPjgkLkWJAvkMPVcnyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594613; c=relaxed/simple;
	bh=PlBOH1LPvvAb0fUNxv2rMPhYjcQZm6qEGQwpPq3RvtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiifnR43RgsgUJ71m0rOcrH/fiOyKZMXCEAtwvErsThzoB28MNw1ZW30Vg8JQVCI8zA8iNV0YLb/3oPEtXZM/qqyjn7KJk+Gotm8unLa0e45JehBsCMPCm6tWsgxHID02KPuo48EixZZbtKtbmK3zi8MErk94ieYXC3IgrK0XvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFI/b7sl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFI/b7sl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771594612; x=1803130612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PlBOH1LPvvAb0fUNxv2rMPhYjcQZm6qEGQwpPq3RvtM=;
  b=aFI/b7slo+oahL4KokkEkP+5loJSvY8CZGSALFwfH5dlpZ5vqHXACOdm
   Qqjc92ar6+sNKhOxkmg1w2MTnfWH/B6i1wsdXHVu1Ufwge2vv4J7F5rvC
   QauQPYNsHrAWowVL7t/NIXRUlVfeWhdbFDZYKaBwSquBYRfkUhAdP3QZu
   d0XX+KcM13ZUA/GTs9/PEgkWEboWybvtUOZPQAJAP7PtRdr/cnHESoKww
   7i3O10iWJ1kAFN4Hmc1YkgqTYb97R8uHC5yWHTiv4BN4322G/frMkALpM
   ZcubvPF9oYjWYsM1dJz46UHZqI56jZeoLoVjIjGEZWQ4mAa4nYiz3LhcI
   w==;
X-CSE-ConnectionGUID: rN8fdb3xSl6Uikr8t1Wvdg==
X-CSE-MsgGUID: lKVXi3UvQO+DBi0NsfejtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="84046510"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="84046510"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:36:51 -0800
X-CSE-ConnectionGUID: tv/fpn4+Ry6B4KVH2Xgl6Q==
X-CSE-MsgGUID: sG4jQUhcSViUP2uzcvVh9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="213959314"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:36:50 -0800
Date: Fri, 20 Feb 2026 15:36:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ata: ahci-dwc: Remove not-going-to-be-supported
 code for Baikal SoC
Message-ID: <aZhjb6EF4nPi-hMI@smile.fi.intel.com>
References: <20260220104208.2326568-1-andriy.shevchenko@linux.intel.com>
 <aZhhO5lMa0p41_VR@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZhhO5lMa0p41_VR@ryzen>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 02:27:28PM +0100, Niklas Cassel wrote:
> On Fri, Feb 20, 2026 at 11:42:08AM +0100, Andy Shevchenko wrote:
> > As noticed in the discussion [1] the Baikal SoC and platforms
> > are not going to be finalized, hence remove stale code.

...

> >  #include <linux/kernel.h>
> >  #include <linux/libata.h>
> >  #include <linux/log2.h>
> > -#include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> 
> Since you are removing the, from what I can tell, unused syscon.h, I think
> we should remove the, from what I can tell, unused linux/regmap.h include
> as well.
> 
> (snip)
> 
> >  static const struct of_device_id ahci_dwc_of_match[] = {
> >  	{ .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
> >  	{ .compatible = "snps,spear-ahci", &ahci_dwc_plat },
> > -	{ .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },
> 
> If we are dropping support for baikal,bt1-ahci, then I think it makes sense
> to remove Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> as well.

Thanks, I have just sent a v2 with the suggested changes.

-- 
With Best Regards,
Andy Shevchenko


