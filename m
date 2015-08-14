From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: footbridge_defconfig: disable IDE subsystem
Date: Fri, 14 Aug 2015 18:43:30 +0100
Message-ID: <20150814174330.GY7557@n2100.arm.linux.org.uk>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
 <1439571876-13758-8-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439571876-13758-8-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-ide@vger.kernel.org

On Fri, Aug 14, 2015 at 07:04:23PM +0200, Bartlomiej Zolnierkiewicz wrote:
> This patch disables deprecated IDE subsystem in footbridge_defconfig
> (no IDE host drivers are selected in this config so there is no valid
> reason to enable IDE subsystem itself).

That's actually incorrect.  I use IDE on Footbridge because it works
loads with my CY82C693 board.  I never submitted the patches which make
CY82C693 work on ARM though...

However, the CY82C693 must not be allowed to use DMA (which is why the
ATA driver can't be used) - if it does, it locks the PCI bus.  It's
a hardware incompatibility between some PCI devices and the Footbridge.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
