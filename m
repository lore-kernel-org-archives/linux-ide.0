From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Mon, 16 Jan 2006 15:07:13 +0100
Message-ID: <20060116140713.GB18307@harddisk-recovery.com>
References: <20060113224252.38d8890f.rdunlap@xenotime.net> <20060116115607.GA18307@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:15445 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750791AbWAPOHP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2006 09:07:15 -0500
Content-Disposition: inline
In-Reply-To: <20060116115607.GA18307@harddisk-recovery.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

On Mon, Jan 16, 2006 at 12:56:07PM +0100, Erik Mouw wrote:
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

Something like this should already be enough:

  This option enables support for SATA suspend/resume using ACPI.

If you really need this enabled to be able to use suspend/resume at
all, you could add a line like:

  It's safe to say Y. If you say N, you might get serious disk
  corruption when you suspend your machine.

(Insert extra warnings about wolves and bears at will ;)


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
