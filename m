From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V2 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Fri, 8 Apr 2011 18:18:10 +0200
Message-ID: <20110408161810.GX7285@pengutronix.de>
References: <1300355883-28484-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300355883-28484-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110408073625.GU7285@pengutronix.de>
 <010C9052C42A00499CE76D637FA5EE900D942F@039-SN1MPN1-001.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49635 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab1DHQSa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Apr 2011 12:18:30 -0400
Content-Disposition: inline
In-Reply-To: <010C9052C42A00499CE76D637FA5EE900D942F@039-SN1MPN1-001.039d.mgd.msft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhu Richard-R65037 <R65037@freescale.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "eric.miao@linaro.org" <eric.miao@linaro.org>

On Fri, Apr 08, 2011 at 08:49:28AM +0000, Zhu Richard-R65037 wrote:
> >
> > When I read code like this I think that a devm_clk_get is overdue.
> >
> > Also, the ahci driver should handle the regular
> [Richard]Sorry, I can't catch what's the exact means of this comment.

devm_* are a set of functions which track the resources a driver
allocates and frees them automatically when the driver exits. See for
example the ahci driver. It uses devm_kzalloc and devm_ioremap.
devm_clk_get would be nice to have also.

> 
> >
> > > +
> > > +   tmpdata = readl(addr + HOST_CAP);
> > > +   if (!(tmpdata & HOST_CAP_SSS)) {
> > > +           tmpdata |= HOST_CAP_SSS;
> > > +           writel(tmpdata, addr + HOST_CAP);
> > > +   }
> >
> > According to the AHCI spec this bit is read only.
> >
> > > +
> > > +   if (!(readl(addr + HOST_PORTS_IMPL) & 0x1))
> > > +           writel((readl(addr + HOST_PORTS_IMPL) | 0x1),
> > > +                   addr + HOST_PORTS_IMPL);
> >
> > This is also readonly.
> >
> [Richard]:About the RO marked bits defined in the SPEC, there are used
>  as R/W bits in MX53 AHCI implementation actually.
> Here are the hack debug log:
> ----------Log--------------------
> HOST_CAP: 0x6726ff80
> HOST_CAP: 0x6f26ff80 <------------ After set the SSS bit.
> HOST_PT_IMPL: 0x0
> HOST_PT_IMPL: 0x1    <------------ After set the IMPL bit
> ahci: SSS flag set, parallel bus scan disabled
> ahci ahci.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl platform mode
> ahci ahci.0: flags: ncq sntf stag pm led clo only pmp pio slum part ccc
> scsi0 : ahci
> ata1: SATA max UDMA/133 irq_stat 0x00000040, connection status changed irq 28
> MXC MTD nand Driver 3.0
> ----------End--------------------

Sigh. At least they tried to implement a standard...

> > > +
> > > +   tmpdata = clk_get_rate(clk) / 1000;
> > > +   clk_put(clk);
> > > +   writel(tmpdata, addr + HOST_TIMER1MS);
> >
> > This should be in a more generic place as it needs to be done for every
> > board. We can put this into some i.MX53 startup function.
> >
> [Richard]How about put these codes into one standalone file in .../arch/arm/plat-mxc/ folder,
>  and export the sata_init and sata_exit out for kinds of MX53 boards?

Yes, probably except the special clock usage on the loco board.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
