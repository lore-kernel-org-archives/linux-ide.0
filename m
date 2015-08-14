From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: footbridge_defconfig: disable IDE subsystem
Date: Fri, 14 Aug 2015 19:46:50 +0100
Message-ID: <20150814184649.GZ7557@n2100.arm.linux.org.uk>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
 <1439571876-13758-8-git-send-email-b.zolnierkie@samsung.com>
 <20150814174330.GY7557@n2100.arm.linux.org.uk>
 <4667234.QqV6GaKOSx@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59962 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbbHNSq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Aug 2015 14:46:59 -0400
Content-Disposition: inline
In-Reply-To: <4667234.QqV6GaKOSx@amdc1976>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Fri, Aug 14, 2015 at 08:08:13PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday, August 14, 2015 06:43:30 PM Russell King - ARM Linux wrote:
> > On Fri, Aug 14, 2015 at 07:04:23PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > This patch disables deprecated IDE subsystem in footbridge_defconfig
> > > (no IDE host drivers are selected in this config so there is no valid
> > > reason to enable IDE subsystem itself).
> > 
> > That's actually incorrect.  I use IDE on Footbridge because it works
> > loads with my CY82C693 board.  I never submitted the patches which make
> > CY82C693 work on ARM though...
> > 
> > However, the CY82C693 must not be allowed to use DMA (which is why the
> > ATA driver can't be used) - if it does, it locks the PCI bus.  It's
> > a hardware incompatibility between some PCI devices and the Footbridge.
> 
> PATA driver is the same in this regard as IDE one.  They both try to
> use DMA if supported by a device.  Would be great if you could fix
> them (or at least PATA one) to limit your setup to PIO automatically
> (please also note that you can limit libata to PIO manually these
> days).
> 
> When it comes to CY82C693 there is also a leftover issue with PATA
> driver that it only supports primary interface currently (BTW this is
> why I left Alpha's defconfig alone for now - it uses CY82C693).  I can
> look into fixing this (or assist in this work) if you are interested
> in it.

Well, it looks like the PCI layer has been screwed for this for some time:

cy82c693 0000:00:06.1: IDE controller (0x1080:0xc693 rev 0x00)
Cypress_IDE 0000:00:06.1: device not available (can't reserve [io  0x0170-0x0177])
Cypress_IDE 0000:00:06.1: device not available (can't reserve [io  0x0170-0x0177])
cy82c693 0000:00:06.1: couldn't enable device
Cypress_IDE: probe of 0000:00:06.1 failed with error -22

The PCI layer forces the standard legacy ports onto the Cypress device,
and then the "primary" resources get null'd out by the long-standing
CY82C693 quirk in the ARM bios32.c.

However - the ARM quick is not what causes the above - the above looks
to be caused by the generic PCI code going wrong - it adds those
legacy resources, and nothing ever connects them to the resource tree:

000000a0-000000bf : pic2
000000c0-000000df : dma2
00000213-00000213 : ISAPnP
000002f8-000002ff : serial8250.0

which then causes pci_enable_device() to fail.

I doubt CY82C693 even works on Alpha... or any IDE interface using the
legacy IO ports...  So it may take quite a bit of work to get going
again - not something I'm going to attempt prior to the 4.3 merge
window.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
