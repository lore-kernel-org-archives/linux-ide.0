Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420287;
	b=0P2VLIE99k7GZqj44/T1Yk32QGf5l1HOkW/9VgG/o/d7L7Zc7L+v0jkkPVpKLdTbKr1D
	 Vf702UnOyu6IScN3RURr2tM6Rs2N2eB2vtEktkMU6HgVUfZOVOkuaJvDyH43rs+zOOyn0
	 zRsVsy84C9ev/mJ84eQcvuudAOiHIw43fMgL/2Ug39vntnzhf8L14xUeyvG9/qdWbLL5/
	 +G1Qg2MGNT9dtvbgJG8a/JIXK3KAIvWDUeEPmlP5yvFezxuiXJmMx+0Fr454Tw/ygsSwO
	 LQFsNSk/f6MUpTjmp8JYdJOXtSiP2VbUhPSOpSiYwtwuZpXBzsajIAZ/RvdagrNXAbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420287;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=oOG3LYk9vtgL9dcZ1ZryVaj5bJKrx63IWhlTOwABRsI=;
	b=XRutFBsrWLb9sA8EqPUyMlMXAgFTNKWDq7llWNt/Mt9Z1rXdYS74fKOwC2GFlgwqjj+Z
	 WKtEKrBQnG0WNXHnU79w5X+KjPIVeg8iCvRRREx+T2x+USRqRqZkFMy3VDPqkPFi3v7/E
	 mzM+KCTQjRdC0f0t3h+z7nB9i3znyHa4o07PAiGSg2srEWMMp8juGi0mzOVIkaaUo0LGO
	 uvmPdJRYZFPDuBvTe/0H0vlLQuTaXz5v+Yl4ruqGTh3i/lRHi0QG3X1VZgNj8Hp92zxy3
	 +v3KXWeM2FyLCUzKc6OILnwBBl2wEVKuXJ8IPhXUeHIFuTfgzHGxD0n8yrwuc/ECkUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVWme5c8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B2606A31C;
	Wed, 11 Nov 2026 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVWme5c8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818F51F00A05;
	Wed, 11 Nov 2026 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420286;
	bh=oOG3LYk9vtgL9dcZ1ZryVaj5bJKrx63IWhlTOwABRsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BVWme5c8j0wUINyJzlKMDwvaevI0nZziEzAPeor13Pn4GZ31y5dJ4xA0EfUfse4sX
	 Mh78P28sz14DHVHwxpdbRqJ4isoVassr8IrUZZ2wINBRnXbMVEPe/zQOGgZCNBcD1k
	 QJHZ0Uz0JEXuUzfNpmOW1r2TfG+8wi9eFQ3lKlArOtCksGpqlxlf3mcDfMnrBR4K36
	 qjSE/qtDHNdC3fJoRuQTeQKYkc+5qX2LVj4IvxfX0iF6QGPte/lwRxM1Z/tR3RFHi2
	 +s8h3GPUvE3vWCwqrnhqmtUdlLxamKzdOfz+P0/IqwIn9uiY8LgUoqEVmkSimZys40
	 e24CC4fRmBH/g==
Date: Wed, 11 Nov 2026 18:04:42 +0000
From: Lee Jones <lee@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Paolo Pisati <p.pisati@gmail.com>, linux-ide@vger.kernel.org,
	mfd@lists.linux.dev, dlemoal@kernel.org, cassel@kernel.org
Subject: Re: [PATCH v1 1/7] zorro: warp mfd: add the CS-Lab Warp
 multifunction parent
Message-ID: <20261111180442.GE6323@joneslee-macbookpro.roam.internal>
References: <20261111163735.227286-1-p.pisati@gmail.com>
 <20261111163735.227286-2-p.pisati@gmail.com>
 <sashiko-outbox-209365@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-209365@kernel.org>

On Wed, 11 Nov 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential
> issues to consider:
> - [Low] mfd: warp_mfd_probe() places new MFD core driver in
>   drivers/zorro/
> - [Low] mfd: warp_mfd_driver hard-codes mfd in names and uses wrong
>   subject prefix
> - [Low] mfd: warp_mfd_cells registers only a single child cell and
>   Kconfig mismatches code
> - [Low] mfd: warp_mfd_probe() passes z->dev.id instead of
>   PLATFORM_DEVID_AUTO

All of these are hard blockers.

Why are you adding a whole new subsystem for your device?

This clearly lives in drivers/mfd.

> --
> 
> commit 9af1a8469b32d3686430ab985b8dd9f3f752e76e
> Author: Paolo Pisati <p.pisati@gmail.com>
> 
> zorro: warp mfd: add the CS-Lab Warp multifunction parent
> 
> This commit adds a Zorro parent driver for the CS-Lab Warp 1260 board that
> registers the on-board IDE window as an mfd cell for pata_cswarp.
> 
> > diff --git a/drivers/zorro/Kconfig b/drivers/zorro/Kconfig
> > index 41475ad46e45f..c9ab9fb4b9ee7 100644
> > --- a/drivers/zorro/Kconfig
> > +++ b/drivers/zorro/Kconfig
> > @@ -17,3 +17,33 @@ config ZORRO_NAMES
> >  
> >  	  When in doubt, say Y.
> >  
> > +# Zorro multifunction drivers
> > +
> > +config WARP_MFD
> > +	tristate "CS-Lab Warp multifunction driver"
> > +	depends on ZORRO
> > +	select MFD_CORE
> [ ... ]
> > +	  This driver hands the IDE window to pata_cswarp - which needs
> > +	  idemode=native set in Warp Configuration to be of any use - and
> > +	  exposes the configuration and telemetry reachable over the dual-port
> > +	  RAM in sysfs: voltages, temperatures, fan, firmware version and
> > +	  Kickstart slot. Nothing else on the list has a driver yet.
> [ ... ]
> > diff --git a/drivers/zorro/Makefile b/drivers/zorro/Makefile
> > index 91ba82e633e76..6fe7cc1822dc1 100644
> > --- a/drivers/zorro/Makefile
> > +++ b/drivers/zorro/Makefile
> > @@ -7,6 +7,8 @@ obj-$(CONFIG_ZORRO)	+= zorro.o zorro-driver.o zorro-sysfs.o
> >  obj-$(CONFIG_PROC_FS)	+= proc.o
> >  obj-$(CONFIG_ZORRO_NAMES) +=  names.o
> >  
> > +obj-$(CONFIG_WARP_MFD) += warp-mfd.o
> 
> [Severity: Low]
> Should this driver and its local header live under drivers/mfd/ instead of
> drivers/zorro/?  Per the mfd subsystem guidelines, new core mfd drivers
> that call mfd_add_devices() or devm_mfd_add_devices(), along with headers
> shared only between the parent and its children, belong in drivers/mfd/.
> 
> > diff --git a/drivers/zorro/warp-mfd.c b/drivers/zorro/warp-mfd.c
> > new file mode 100644
> > index 0000000000000..94af7c9d0ea5e
> > --- /dev/null
> > +++ b/drivers/zorro/warp-mfd.c
> [ ... ]
> > +static const struct mfd_cell warp_mfd_cells[] = {
> > +	{
> > +		.name		= "warp-pata",
> > +		.num_resources  = 1,
> > +		.resources	= (const struct resource []) {
> > +			DEFINE_RES_MEM_NAMED(WARP_OFFSET_ATA, WARP_ATA_SIZE,
> > +					     "pata"),
> > +		}
> > +	}
> > +};
> 
> [Severity: Low]
> Is an mfd driver appropriate when warp_mfd_cells[] only registers a single
> child device?  The mfd subsystem guidelines require mfd to be used only for
> devices registering multiple children across different subsystems.
> 
> In addition, the Kconfig help text states that this driver exposes
> dual-port RAM configuration and telemetry in sysfs (voltages, temperatures,
> fan, firmware version, and Kickstart slot), none of which is present in
> this commit, and drivers/zorro/warp-mfd.h defines dual-port RAM offsets and
> sizes that have no users here.  Even later in the series, telemetry is
> added as custom sysfs attributes on the parent Zorro device rather than as
> a child device in the appropriate subsystem such as hwmon.
> 
> > +static int warp_mfd_probe(struct zorro_dev *z,
> > +			  const struct zorro_device_id *ent)
> > +{
> > +	int error;
> > +
> > +	dev_info(&z->dev, "Warp at %pR\n", &z->resource);
> > +
> > +	error = mfd_add_devices(&z->dev, z->dev.id, warp_mfd_cells,
> > +				ARRAY_SIZE(warp_mfd_cells), &z->resource,
> > +				0, NULL);
> > +	if (error) {
> > +		dev_err(&z->dev, "mfd_add_devices() failed %d\n", error);
> > +		return error;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void warp_mfd_remove(struct zorro_dev *z)
> > +{
> > +	mfd_remove_devices(&z->dev);
> > +}
> 
> [Severity: Low]
> This isn't a bug, but mfd guidelines prefer automatic platform device IDs
> over passing z->dev.id to mfd_add_devices() when subdevices do not require
> explicit numbering.  Using devm_mfd_add_devices() would also drop
> warp_mfd_remove() and keep child teardown ordered with devres resources
> added later in the series.
> 
> Similarly, warp_mfd_cells[] could use the standard mfd cell resource helper
> macro instead of open-coding .num_resources and a compound literal, and
> warp_mfd_init() / warp_mfd_exit() could use module_driver().
> 
> [ ... ]
> 
> > +static struct zorro_driver warp_mfd_driver = {
> > +	.name		= "warp-mfd",
> > +	.id_table	= warp_mfd_ids,
> > +	.probe		= warp_mfd_probe,
> > +	.remove		= warp_mfd_remove
> > +};
> 
> [Severity: Low]
> This isn't a bug, but mfd subsystem conventions avoid hard-coding "mfd" in
> driver, symbol, Kconfig, and file names (such as "warp-mfd",
> warp_mfd_driver, and warp-mfd.c), and expect commit subjects in the form
> "mfd: <driver>: <Capitalized description>".
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261111163735.227286-1-p.pisati@gmail.com?part=1

-- 
Lee Jones
