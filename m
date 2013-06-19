From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v1 3/3] imx: ahci: enable ahci sata on imx6q platforms
Date: Wed, 19 Jun 2013 02:38:18 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D307B86@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
 <1371462767-16630-4-git-send-email-r65037@freescale.com>
 <20130618030310.GD28381@S2101-09.ap.freescale.net>
 <0E83723C55F66F43A6041464FE31119D3057EF@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130618055925.GA6723@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:18945
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933453Ab3FSCiW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Jun 2013 22:38:22 -0400
In-Reply-To: <20130618055925.GA6723@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Shawn:
It's sounds right, platform is not right place to handle device/IP stuff.
I would kick off to your option2. Thanks.

Best Regards
Richard Zhu

-----Original Message-----
From: Shawn Guo [mailto:shawn.guo@linaro.org] 
Sent: Tuesday, June 18, 2013 1:59 PM
To: Zhu Richard-R65037
Cc: Richard Zhu; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; linux-ide@vger.kernel.org
Subject: Re: [v1 3/3] imx: ahci: enable ahci sata on imx6q platforms

On Tue, Jun 18, 2013 at 05:00:09AM +0000, Zhu Richard-R65037 wrote:
> > +enum {
> > +     HOST_CAP = 0x00,
> > +     HOST_CAP_SSS = (1 << 27), /* Staggered Spin-up */
> > +     HOST_CTL = 0x04, /* global host control */
> > +     HOST_RESET = (1 << 0),  /* reset controller; self-clear */
> > +     HOST_PORTS_IMPL = 0x0c, /* bitmap of implemented ports */
> > +     HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
> > +     HOST_VERSIONR = 0xf8, /* host version register*/
> > +
> > +     PORT_SATA_SR = 0x128, /* Port0 SATA Status */
> > +     PORT_PHY_CTL = 0x178, /* Port0 PHY Control */
> > +     PORT_PHY_CTL_PDDQ_LOC = 0x100000, /* PORT_PHY_CTL bits */ };
> > +
> 
> This is all about IP stuff.  Some of them are just replication of 
> definitions found in drivers/ata/ahci.h. I do not understand why we 
> need them in platform.  It's a sign to me that we are doing something 
> in platform code that should really be done in the device driver, no?
> 
> [Richard] Regarding to the AHCI SPEC, some bits of the ahci sata 
> registers are  specified to be RO, but they are RW in the design of fsl ahci ata in actually.
>  So the configurations of those bits are mandatory required in the  
> platform sata initialization.
> One HBA reset is better finished before start the configuration.
> That's why those registers/bits are re-defined in the platform level.
> 
> For, e.x:
> bit1 of the HOST_POSRTS_IMPL, HOST_CAP_SSS(bit27) of the HOST_CAP, are 
> RO specified in the AHCI SPEC. But they should be configured in the sata platform initialization.
> 
> BTW, HOST_TIMER1MS is defined by FSL, can't be used in the common codes.
> regarding to the AHCI SPEC.
> " Registers at offset A0h to FFh are vendor specific"

It sounds like to me that the generic ahci_platform driver does not perfectly fit imx6q sata device.  You're pushing all those bits that are not covered by the generic ahci_platform driver down to platform code.  This is not the right thing to do, and platform is not the right place to handle device/IP stuff.  I see two options you can go as below.

1. Create an imx6q sata specific compatible string and add code into
   generic ahci_platform driver to implement programming model for imx6q
   type of device.

2. The existing ahci_platform driver is not so useful for imx6q sata
   considering you have so many imx6q custom bits to add.  It might be
   more appropriate to create a custom ahci_platform driver for imx6q
   sata device with forking the generic one, just like what
   sata_highbank does.

I would go for option 2.

Shawn

