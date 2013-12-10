From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH V6 3/3] ahci: imx: Add i.MX53 support
Date: Tue, 10 Dec 2013 14:51:16 +0100
Message-ID: <201312101451.16910.marex@denx.de>
References: <1385369222-5288-1-git-send-email-marex@denx.de> <20131210114738.GA4097@pengutronix.de> <20131210133723.GC26728@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:43403 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab3LJPNX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Dec 2013 10:13:23 -0500
In-Reply-To: <20131210133723.GC26728@S2101-09.ap.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Tuesday, December 10, 2013 at 02:37:27 PM, Shawn Guo wrote:
> On Tue, Dec 10, 2013 at 12:47:38PM +0100, Sascha Hauer wrote:
> > > @@ -34,10 +34,21 @@ enum {
> > > 
> > >  	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
> > >  
> > >  };
> > > 
> > > +enum ahci_imx_type {
> > > +	AHCI_IMX53,
> > > +	AHCI_IMX6Q,
> > > +};
> > 
> > Please next time introduce a SoC specific struct to encode the
> > differences between SoCs. This way you can abstract away the differences
> > in flags and function callbacks and don't end up with functions which
> > do completely different things for different SoCs like currently in
> > imx_sata_clock_enable(). The if (type == SOC_XY) style doesn't scale in
> > many drivers anymore.
> 
> Yea, I was thinking about the same thing when reviewing the patch in the
> first time, but decided to not comment on that because currently the
> added functions are doing the similar/related thing.  But I agree that
> SoC specific structure should be some thing more scalable and we should
> go for in the future.

Full ACK on this one, yes. Thus far, the chips are similar so that the ID is 
enough, once we get some more exotic chip, this should be changed to a 
structure. I guess the IOMUX register layout might be different on the MX7 at 
least for example ?

Best regards,
Marek Vasut
