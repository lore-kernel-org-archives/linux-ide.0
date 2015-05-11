From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
Date: Mon, 11 May 2015 16:20:34 -0700
Message-ID: <20150511232034.GK32500@ld-irv-0074>
References: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
 <5550BF7D.6010107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5550BF7D.6010107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

Hi Kishon,

On Mon, May 11, 2015 at 08:11:01PM +0530, Kishon Vijay Abraham I wrote:
> On Thursday 23 April 2015 08:29 AM, Brian Norris wrote:
> >Here are my updates based on everyone's feedback. I'll try to include most of
> >the changelog info in each patch, but a few summary points for v1 -> v2:
> >
> >  - reworked the PHY DT binding so that we don't need do any custom xlate in the
> >    PHY driver
> >
> >  - moved all handling of the 'SATA_TOP_CTRL' block into the SATA driver,
> >    instead of sharing it between SATA and PHY drivers. This means we have to do
> >    a little extra work in sata_brcmstb.c to decide which ports to power on, but
> >    at least this way, we're really describing the hardware, not just how the SW
> >    frameworks want to use the hardware.
> 
> I don't see any problems with the PHY patches. Let me know If I can
> take this via linux-phy tree.

I think the only remaining objections were about endianness.
Incidentally, the PHY driver was using readl()/writel(), so that should
be OK then. It might be a problem for big endian MIPS, but this
particular PHY IP is not available on MIPS. If it ever is used there,
then we may need to patch in something like this:

	if (big endian MIPS)
		iowrite32be(val, addr);
	else
		iowrite32(val, addr);

But for now, I think all is OK, so feel free to take it. I'll just
rework/resend the SATA driver, SATA binding, and ARM/dts updates.

Brian
