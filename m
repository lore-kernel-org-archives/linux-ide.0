Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081913F23BD;
	Wed, 10 Jun 2026 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087996; cv=none; b=mPwzfpWCyY9w6t/QTEfT2mcAoYh/olFx6qrCZR8vjU9ENBg14KxlaPPMXV/VMMdw2+JEwkLP6W9EoxMbeqNeeTwz9OUV1dwoAILcxJFDV6lSyYYnHAKrMMt1j4FC/8G1ExHladEueML4g3RbE8luqQvo/0DU7DVMm19b2k3m5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087996; c=relaxed/simple;
	bh=7W020RJn6vBn+npx2sgIfaFnVt8KsG299v5awVt9aio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSOBoWidyO5vYuJNpySR+eDjZ51WoJ7l/HPJe6JNLTaU6wZJFJL4YDEYx25hnaDMQlL31ikdZetRpvr8H7RI6CCldPIyk6ZB08p569EgbbjEyG1S84oSWU3BraLRtQsbunXhvrpmtNrE9D8mStvt/CQx0DOOIydoys0x0t36KTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfmQgsMI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfmQgsMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781087993; x=1812623993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7W020RJn6vBn+npx2sgIfaFnVt8KsG299v5awVt9aio=;
  b=KfmQgsMIVqG+Ypmc8M6/oAGgFWHOI1yX1O33ct+h8DK00HnPxwGldZF0
   Audgme2OyiTwJCkL5ObkCzp71ZulmOkfIJcRKlccQhTlhsXNJUL7NPSMf
   3W02so6rkUKHJAFWQinf+ciuGByfaUlXMeJ7nWvqFIUgKpRbCqm2xqdOa
   aJyItAhq3Tqfok7CiJv+ibgm/JYrL6uZDArkC+yynS816Wpiq1BSRLHyt
   Xsx/vTKwTPhDxsij1H1yrkoXZwKMSZ2x6bwK8zOFWpRaCvFAkm41yNKp8
   lZhwfSG/wpDjQ3UI/LCX4EvpfEmk4xqTcpNfkD9QIgiLGiIYTyklHBCQ4
   w==;
X-CSE-ConnectionGUID: m2slhPpfQ52EgDtG4+JKiw==
X-CSE-MsgGUID: 8sSfbqMuTo2e4ABV3vE0/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="69410799"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="69410799"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:39:52 -0700
X-CSE-ConnectionGUID: 4KzpZI0bRBCy5INo+gH7JA==
X-CSE-MsgGUID: HI7L/v7OQcSQyjoSPAuCbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="241999995"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:39:50 -0700
Date: Wed, 10 Jun 2026 13:39:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ata: pata_mpc52xx: switch to non-devm request_irq
 for proper ordering
Message-ID: <aik-8EhMkKFz8tyX@ashevche-desk.local>
References: <20260608214718.49503-1-rosenp@gmail.com>
 <20260608214718.49503-2-rosenp@gmail.com>
 <aie-w7BTHYYwTKvq@ryzen>
 <aifQgZwd8KzUOuKl@ashevche-desk.local>
 <CAKxU2N9kAe4Yc1iE7r0Gw=CyQWuaWwwN5uUBV_J0szAF90G3BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9kAe4Yc1iE7r0Gw=CyQWuaWwwN5uUBV_J0szAF90G3BQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 02:17:24PM -0700, Rosen Penev wrote:
> On Tue, Jun 9, 2026 at 1:36 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Jun 09, 2026 at 09:20:35AM +0200, Niklas Cassel wrote:
> > > On Mon, Jun 08, 2026 at 02:47:15PM -0700, Rosen Penev wrote:

...

> > > Andy, since you gave a talk about this recently.
> > > Surely there must be a better way than to migrate away from the device
> > > managed APIs.
> >
> > Thank for Cc'ing me.
> >
> > > Do you have some suggestion?
> >
> > This patch either way (are we going to devm fully or rollback to non-devm)
> > is half-baked.
> Note the fixes tag. The purpose is to get this backported.

See what I wrote below.

> > What I may suggest here is to extend this patch to cover the second
> > problematic place (*) and make it as a fix for backporting.

^^^

> > After that one may carefully go and finish converting probe to devm_*().
> >
> > *) https://elixir.bootlin.com/linux/v7.1-rc7/source/drivers/ata/pata_mpc52xx.c#L733
> > The call of irq_of_parse_and_map() should be moved after devm_kzalloc().
> > So, this fix should do what it does + the above.
> Doesn't matter much. task_irq gets requested, not ata_irq.

It matters, it's about memory allocation. It should go after devm_kzalloc().

> > P.S.
> > Someone may tide up this driver a lot, but this is out of the scope of
> > this patch. FWIW, the brief list of potential refactoring patches
> > based on probe (in unsorted order):
> > - use devm_platform_ioremap_resource()

> Done in later patch in this series.

Cool! Any plans for the rest?

> > - moving towards device_property_read_*()
> > - using dev_err_probe()
> > - use temporary variable to hold struct device pointer
> > - use fwnode_irq_get()
> > - apply multipliers from units.h and time.h (like HZ_PER_MHZ)
> > - moving to a new struct dev_pm_ops and pm_sleep_ptr() macro

-- 
With Best Regards,
Andy Shevchenko


