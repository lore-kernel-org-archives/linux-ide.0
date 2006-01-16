From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Mon, 16 Jan 2006 07:40:15 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0601160740020.24990@shark.he.net>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
 <20060116115607.GA18307@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:37519 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750958AbWAPPkX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2006 10:40:23 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 16 Jan 2006 07:40:16 -0800
In-Reply-To: <20060116115607.GA18307@harddisk-recovery.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

On Mon, 16 Jan 2006, Erik Mouw wrote:

> On Fri, Jan 13, 2006 at 10:42:52PM -0800, Randy.Dunlap wrote:
> > --- linux-2615-g9.orig/drivers/scsi/Kconfig
> > +++ linux-2615-g9/drivers/scsi/Kconfig
> > @@ -599,6 +599,11 @@ config SCSI_SATA_INTEL_COMBINED
> >  	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
> >  	default y
> >
> > +config SCSI_SATA_ACPI
> > +	bool
> > +	depends on SCSI_SATA && ACPI
> > +	default y
> > +
>
> Could you add some help text over here? At first glance I got the
> impression this was a host driver that works through ACPI calls, but by
> reading the rest of your patches it turns out it is a suspend/resume
> helper.

OK, will do.

> For quite some time we had no help text with the mysterious
> "ACPI0004,PNP0A05 and PNP0A06 Container Driver", no need to add another
> mysterious ACPI feature.

-- 
~Randy
