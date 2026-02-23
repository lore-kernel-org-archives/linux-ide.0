Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022AC1E834B;
	Mon, 23 Feb 2026 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874951; cv=none; b=Tu2I0m56YeVbs9oA0M8BbSaems6z8U2sMztIvUoOnmH62rffOT1XAl5igk1OfzCz0ywu7pc9wei437cv8FSQRgb7+enlfFIbvv5++AlmfzSdKy/bg5/ni278FdDzIPQejspcvCWtsuOpMPLjR79T3FO3pnWG+S+klBNUnITBApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874951; c=relaxed/simple;
	bh=PRoPLEmam5jXsIVW612S683TQ42kkWxDoN7I8FGcEvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guSss7UDg2ns/5JddRwgQ0HKb4SXha7J7wu/sXVVtdEWmZ5/6QnyXG1qK1tDWtbAF8am3Z/Csvbw1AcvybXGsNFX5GACPaY3EqBzMpgSQuNS+kIbChP+QO7zqEFYVlgkQ8ifWJimpG13qcNfY3xCsWT4tsmrNcLYIFMr71fnhJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQMoQptC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQMoQptC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771874950; x=1803410950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PRoPLEmam5jXsIVW612S683TQ42kkWxDoN7I8FGcEvI=;
  b=XQMoQptCMKktXbRA/S/lhFXuPCwLv1HbB77qJ8W5ID+/aEBttufNOWkg
   vT6BFy3HGH8d0VWjUCuDMzRP37ygm1IK53ZY8MbzGPoftaKgDv/e1zzIZ
   whWsAEjjhmDjstcwRCb7bJzT/a2Wx432Ev44wEj4oI+6ZNBzD4hPWL42a
   F3OKP80qNcdDZ7YRiBfaANpIBDZ+i4okhvR8rbK5nS2Re1MXdfV/Ipp39
   OqNu1NJ2KIJykxSblkMoVp9Agy+QmPCkX3YbuH4vwh40yFD6HqbBR36VP
   kO2mnJYVu2cZMDKVGGvUl9Pl5M5KrtH4ep3LSkOp4NFcinn5SXNFpmz/V
   g==;
X-CSE-ConnectionGUID: V4yDg6BzSuetcYb39d/epw==
X-CSE-MsgGUID: W2OT0jFpT/yTscgiIk7x5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84243620"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="84243620"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:29:10 -0800
X-CSE-ConnectionGUID: 7RdmHbU0TTSCn/5SthvuEA==
X-CSE-MsgGUID: 4VuPwxcSQGutYPODYlp7Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215802846"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:29:07 -0800
Date: Mon, 23 Feb 2026 21:29:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/1] ata: ahci-dwc: Remove not-going-to-be-supported
 code for Baikal SoC
Message-ID: <aZyqgNMtlpDoZVo_@smile.fi.intel.com>
References: <20260220133613.2392906-1-andriy.shevchenko@linux.intel.com>
 <20260223185754.GA151596-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223185754.GA151596-robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 12:57:54PM -0600, Rob Herring wrote:
> On Fri, Feb 20, 2026 at 02:35:46PM +0100, Andy Shevchenko wrote:
> > As noticed in the discussion [1] the Baikal SoC and platforms
> > are not going to be finalized, hence remove stale code.
> > 
> > Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > 
> > v2: dropped YAML and regmap.h (Niklas)
> > 
> >  .../bindings/ata/baikal,bt1-ahci.yaml         | 115 ------------------
> 
> Bindings are separate patches though anything only deleting lines is 
> automatic ack. ;)
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Thank you!

> Looks like you missed a few more cases:

Not really, see below my answers.

> Documentation/devicetree/bindings/bus/baikal,bt1-apb.yaml
> Documentation/devicetree/bindings/bus/baikal,bt1-axi.yaml
> Documentation/devicetree/bindings/cache/baikal,bt1-l2-ctl.yaml

These are not related to ATA subsystem.

> Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
> Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

These were missed in the respective previous submissions. Hence for these will
be two (or do you want a single? I think they will need different Fixes tags,
perhaps) patch to remove.

-- 
With Best Regards,
Andy Shevchenko


