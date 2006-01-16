From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Mon, 16 Jan 2006 22:04:18 +0100
Message-ID: <20060116210418.GG29663@stusta.de>
References: <20060113224252.38d8890f.rdunlap@xenotime.net> <20060116115607.GA18307@harddisk-recovery.nl> <20060116140713.GB18307@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751197AbWAPVES (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jan 2006 16:04:18 -0500
Content-Disposition: inline
In-Reply-To: <20060116140713.GB18307@harddisk-recovery.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

On Mon, Jan 16, 2006 at 03:07:13PM +0100, Erik Mouw wrote:
> On Mon, Jan 16, 2006 at 12:56:07PM +0100, Erik Mouw wrote:
> > On Fri, Jan 13, 2006 at 10:42:52PM -0800, Randy.Dunlap wrote:
> > > --- linux-2615-g9.orig/drivers/scsi/Kconfig
> > > +++ linux-2615-g9/drivers/scsi/Kconfig
> > > @@ -599,6 +599,11 @@ config SCSI_SATA_INTEL_COMBINED
> > >  	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
> > >  	default y
> > >  
> > > +config SCSI_SATA_ACPI
> > > +	bool
> > > +	depends on SCSI_SATA && ACPI
> > > +	default y
> > > +
> > 
> > Could you add some help text over here? At first glance I got the
> > impression this was a host driver that works through ACPI calls, but by
> > reading the rest of your patches it turns out it is a suspend/resume
> > helper.
> 
> Something like this should already be enough:
> 
>   This option enables support for SATA suspend/resume using ACPI.
> 
> If you really need this enabled to be able to use suspend/resume at
> all, you could add a line like:
> 
>   It's safe to say Y. If you say N, you might get serious disk
>   corruption when you suspend your machine.
>...

Why?

This is not a user-visible option...

> Erik

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

