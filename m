From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] arm: footbridge_defconfig: disable IDE subsystem
Date: Fri, 14 Aug 2015 20:08:13 +0200
Message-ID: <4667234.QqV6GaKOSx@amdc1976>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
 <1439571876-13758-8-git-send-email-b.zolnierkie@samsung.com>
 <20150814174330.GY7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150814174330.GY7557@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-ide@vger.kernel.org


Hi,

On Friday, August 14, 2015 06:43:30 PM Russell King - ARM Linux wrote:
> On Fri, Aug 14, 2015 at 07:04:23PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > This patch disables deprecated IDE subsystem in footbridge_defconfig
> > (no IDE host drivers are selected in this config so there is no valid
> > reason to enable IDE subsystem itself).
> 
> That's actually incorrect.  I use IDE on Footbridge because it works
> loads with my CY82C693 board.  I never submitted the patches which make
> CY82C693 work on ARM though...
> 
> However, the CY82C693 must not be allowed to use DMA (which is why the
> ATA driver can't be used) - if it does, it locks the PCI bus.  It's
> a hardware incompatibility between some PCI devices and the Footbridge.

PATA driver is the same in this regard as IDE one.  They both try to
use DMA if supported by a device.  Would be great if you could fix
them (or at least PATA one) to limit your setup to PIO automatically
(please also note that you can limit libata to PIO manually these
days).

When it comes to CY82C693 there is also a leftover issue with PATA
driver that it only supports primary interface currently (BTW this is
why I left Alpha's defconfig alone for now - it uses CY82C693).  I can
look into fixing this (or assist in this work) if you are interested
in it.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
