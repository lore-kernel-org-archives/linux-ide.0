Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F23EF65D;
	Tue,  9 Jun 2026 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994186; cv=none; b=ELdcotg5FL4RjsQhPkXYYX4zCngOSSBOuMK1wOC6F1qXZpWDdNZ1A6n71JRL5a6eTIDH0Pn1pUU/o6aQo9Z9GVPgpIC//4rcWzAhcpWuGUGvOAUfOD0bGrystwRGskGP7H06p5oHx2Z7FVMftzhSt90oMDtKLMO308X6OrhPMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994186; c=relaxed/simple;
	bh=Kixn9ir4ald59LCBFzIzgAUsegxekWY9QVkQFf60GEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9wHJVJpEbZw0UHXeASJtMvT15GL+iEZHOl1AkPO3k7KsRrahVloCRdy2l1/H21Ku53TXjIwm4bp+L6kkqdz+7JKJmezxVK93GTBqsQnaogG4Kj1Lbb3WI5QWq/Q0pY4iBdlmOTtr8PByzSAFpW9pE6rvG9q2FoX7BzCzXMMN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjLicdqO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjLicdqO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780994182; x=1812530182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kixn9ir4ald59LCBFzIzgAUsegxekWY9QVkQFf60GEg=;
  b=kjLicdqODGUBzcl0t5YsRrasNy1eJxgzCpVa4YUiJ4XXO4w8jp9SprSp
   bbeW50RIQnl55lj1Ru1pcrARCzFOeDS2JI7pBxxW5EZjcN8CQKyY/YkWk
   DVNvMkrMUs0+InBnTX9PcxCwf3Px6zerSFM3a+5bcoA3D05srHJy8YnzD
   7BcVy+8z8XBchgvjdg6kq/BKN884emZYwQkbQuscZw5KLifzH7ZVDhUpD
   rNgB5erkWNr6g2BNbaFMGeE318xLyqLyg83sBUToGIFMZWUhUBuN/1B/b
   sQvHipal+5BmeOsehgsPo6eezZ6mXUQrgIgytA8iQF6C8Kz3Im0FFyxiT
   g==;
X-CSE-ConnectionGUID: OwBl/FbCTwWJO4+P5vnQoQ==
X-CSE-MsgGUID: /Tyhv+u0R12G1XPd6fcbUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="99166464"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="99166464"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:36:21 -0700
X-CSE-ConnectionGUID: PtVMkNKHRkKJuNo3EkyfQQ==
X-CSE-MsgGUID: wN79FF5NStSMs6i9a3f/hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="250884020"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:36:19 -0700
Date: Tue, 9 Jun 2026 11:36:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ata: pata_mpc52xx: switch to non-devm request_irq
 for proper ordering
Message-ID: <aifQgZwd8KzUOuKl@ashevche-desk.local>
References: <20260608214718.49503-1-rosenp@gmail.com>
 <20260608214718.49503-2-rosenp@gmail.com>
 <aie-w7BTHYYwTKvq@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aie-w7BTHYYwTKvq@ryzen>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 09:20:35AM +0200, Niklas Cassel wrote:
> On Mon, Jun 08, 2026 at 02:47:15PM -0700, Rosen Penev wrote:
> > The BestComm task IRQ handler accesses priv->dmatsk, which is freed
> > by bcom_ata_release().  With devm_request_irq(), the handler remains
> > registered until devres unwinds after the error/remove function
> > returns, creating a window where the handler can access freed memory.
> > 
> > Switch to request_irq() / free_irq() so that the interrupt is
> > unregistered before bcom_ata_release() tears down the task.

...

> >  	task_irq = bcom_get_task_irq(dmatsk);
> > -	rv = devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
> > -				"ATA task", priv);
> > +	rv = request_irq(task_irq, &mpc52xx_ata_task_irq, 0,
> > +			  "ATA task", priv);
> >  	if (rv) {

> >  		dev_err(&op->dev, "error requesting DMA IRQ\n");

Side note: In case we leave devm_request_irq(), this message is a dup
and may be removed.

> > -		goto err2;
> > +		goto err_free_task;

Now, devm_*() should be never followed by goto. If we want to keep devm
approach, the original code has more issues.

> >  	}

...

> Andy, since you gave a talk about this recently.
> Surely there must be a better way than to migrate away from the device
> managed APIs.

Thank for Cc'ing me.

> Do you have some suggestion?

This patch either way (are we going to devm fully or rollback to non-devm)
is half-baked.

What I may suggest here is to extend this patch to cover the second
problematic place (*) and make it as a fix for backporting.

After that one may carefully go and finish converting probe to devm_*().

*) https://elixir.bootlin.com/linux/v7.1-rc7/source/drivers/ata/pata_mpc52xx.c#L733
The call of irq_of_parse_and_map() should be moved after devm_kzalloc().
So, this fix should do what it does + the above.

P.S.
Someone may tide up this driver a lot, but this is out of the scope of
this patch. FWIW, the brief list of potential refactoring patches
based on probe (in unsorted order):
- use devm_platform_ioremap_resource()
- moving towards device_property_read_*()
- using dev_err_probe()
- use temporary variable to hold struct device pointer
- use fwnode_irq_get()
- apply multipliers from units.h and time.h (like HZ_PER_MHZ)
- moving to a new struct dev_pm_ops and pm_sleep_ptr() macro

-- 
With Best Regards,
Andy Shevchenko


