From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Wed, 13 Jul 2016 18:45:12 +0100
Message-ID: <20160713174512.GB1041@n2100.armlinux.org.uk>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <2773873.Jjn1O47GXr@wuerfel>
 <4818149.nzRaU7vJQE@amdc1976>
 <4264651.gPKphdYuCx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54078 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbcGMRph (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 13:45:37 -0400
Content-Disposition: inline
In-Reply-To: <4264651.gPKphdYuCx@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@baylibre.com>, "Nori, Sekhar" <nsekhar@ti.com>

On Wed, Jul 13, 2016 at 04:37:31PM +0200, Arnd Bergmann wrote:
> On Wednesday, July 13, 2016 12:59:23 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > 
> > On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
> > > On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> > > > This patch disables deprecated IDE subsystem in assabet_defconfig
> > > > (no IDE host drivers are selected in this config so there is no
> > > > valid reason to enable IDE subsystem itself).
> > > > 
> > > > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > 
> > > I think the series makes a lot of sense. I have checked your assertions
> > > in the changelogs and found no flaws in your logic, so I think we should
> > > take them all through arm-soc unless there are other concerns.
> > 
> > Thank you.
> > 
> > Should I resend everything or just patches that were not reposted yet
> > (the ones that were marked as RFT initially and got no feedback)?
> 
> I'd be fine with just getting a pull request with all the patches that
> had no negative feedback and that were not already applied (if any).

I'd actually say be very careful about this - there's a big difference
between the ATA subsystem and IDE subsystem.  I've had situations with
old platforms where stuff works with IDE and not ATA.

For example, using the CY82C693 driver used to work with the IDE
subsystem before it got broken on ARM systems with DMA disabled (because
the CY82C693 deadlocks the PCI bus on any BM-DMA).  From what I remember,
ATA provided no easy way to disable DMA on such interfaces.

I also looked at using ATA on EBSA110, and it was far from trivial due
to munged address lines and access size problems: with IDE, it was
easy to work around by redirecting the in*/out* appropriately on a
per-driver basis.  I forget exactly why ATA didn't work, but it didn't
and I came to the conclusion that it was not feasible to fix.

So, please don't assume that ATA can be simply slotted in instead of
IDE.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
