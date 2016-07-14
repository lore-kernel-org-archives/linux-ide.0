From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Thu, 14 Jul 2016 11:59:23 +0200
Message-ID: <9239486.GVgcNxaS76@amdc1976>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <4264651.gPKphdYuCx@wuerfel> <20160713174512.GB1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59918 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbcGNKAh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2016 06:00:37 -0400
In-reply-to: <20160713174512.GB1041@n2100.armlinux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@baylibre.com>, "Nori, Sekhar" <nsekhar@ti.com>


Hi,

On Wednesday, July 13, 2016 06:45:12 PM Russell King - ARM Linux wrote:
> On Wed, Jul 13, 2016 at 04:37:31PM +0200, Arnd Bergmann wrote:
> > On Wednesday, July 13, 2016 12:59:23 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
> > > > On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > > > This patch disables deprecated IDE subsystem in assabet_defconfig
> > > > > (no IDE host drivers are selected in this config so there is no
> > > > > valid reason to enable IDE subsystem itself).
> > > > > 
> > > > > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > > > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > 
> > > > I think the series makes a lot of sense. I have checked your assertions
> > > > in the changelogs and found no flaws in your logic, so I think we should
> > > > take them all through arm-soc unless there are other concerns.
> > > 
> > > Thank you.
> > > 
> > > Should I resend everything or just patches that were not reposted yet
> > > (the ones that were marked as RFT initially and got no feedback)?
> > 
> > I'd be fine with just getting a pull request with all the patches that
> > had no negative feedback and that were not already applied (if any).
> 
> I'd actually say be very careful about this - there's a big difference
> between the ATA subsystem and IDE subsystem.  I've had situations with
> old platforms where stuff works with IDE and not ATA.
> 
> For example, using the CY82C693 driver used to work with the IDE
> subsystem before it got broken on ARM systems with DMA disabled (because
> the CY82C693 deadlocks the PCI bus on any BM-DMA).  From what I remember,
> ATA provided no easy way to disable DMA on such interfaces.

You can do this using libata.dma kernel parameter:

	libata.dma=	[LIBATA] DMA control
			libata.dma=0	  Disable all PATA and SATA DMA
			libata.dma=1	  PATA and SATA Disk DMA only
			libata.dma=2	  ATAPI (CDROM) DMA only
			libata.dma=4	  Compact Flash DMA only
			Combinations also work, so libata.dma=3 enables DMA
			for disks and CDROMs, but not CFs.

Or even force specific speed for chosen device using libata.force
kernel parameter:

	libata.force=	[LIBATA] Force configurations.  The format is comma
			separated list of "[ID:]VAL" where ID is
			PORT[.DEVICE].  PORT and DEVICE are decimal numbers
			matching port, link or device.  Basically, it matches
			the ATA ID string printed on console by libata.  If
			the whole ID part is omitted, the last PORT and DEVICE
			values are used.  If ID hasn't been specified yet, the
			configuration applies to all ports, links and devices.

			If only DEVICE is omitted, the parameter applies to
			the port and all links and devices behind it.  DEVICE
			number of 0 either selects the first device or the
			first fan-out link behind PMP device.  It does not
			select the host link.  DEVICE number of 15 selects the
			host link and device attached to it.

			The VAL specifies the configuration to force.  As long
			as there's no ambiguity shortcut notation is allowed.
			For example, both 1.5 and 1.5G would work for 1.5Gbps.
			The following configurations can be forced.
...
			* Transfer mode: pio[0-7], mwdma[0-4] and udma[0-7].
			  udma[/][16,25,33,44,66,100,133] notation is also
			  allowed.
...

However it would be the best to detect affected platforms from
ATA host driver and not enable DMA on them automatically (same
is true for IDE subsystem host driver equivalent).

> I also looked at using ATA on EBSA110, and it was far from trivial due
> to munged address lines and access size problems: with IDE, it was
> easy to work around by redirecting the in*/out* appropriately on a
> per-driver basis.  I forget exactly why ATA didn't work, but it didn't
> and I came to the conclusion that it was not feasible to fix.

You can define your own transport helpers in ATA subsystem (same
is true for IDE subsystem BTW) hacking in*()/out*() helpers is not
how it should be done.

Please just post patches / questions and I would be glad to help
with making ATA subsystem work on hardware that is currently limited
to IDE subsystem.

[ BTW from looking at examples given it seems that they don't work
  even with IDE subsystem nowadays. ]

> So, please don't assume that ATA can be simply slotted in instead of
> IDE.

I don't assume it.  Each case was reviewed separately and I replaced
only that host drivers in defconfigs that looked OK after doing full
code comparison between IDE and ATA versions.  If you know about
specific cases that won't work after my patches please let me know.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

