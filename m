From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V6 3/3] ahci: imx: Add i.MX53 support
Date: Tue, 10 Dec 2013 21:37:27 +0800
Message-ID: <20131210133723.GC26728@S2101-09.ap.freescale.net>
References: <1385369222-5288-1-git-send-email-marex@denx.de>
 <1385369222-5288-3-git-send-email-marex@denx.de>
 <20131210114738.GA4097@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:20030
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752550Ab3LJNhK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Dec 2013 08:37:10 -0500
Content-Disposition: inline
In-Reply-To: <20131210114738.GA4097@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Tue, Dec 10, 2013 at 12:47:38PM +0100, Sascha Hauer wrote:
> > @@ -34,10 +34,21 @@ enum {
> >  	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
> >  };
> >  
> > +enum ahci_imx_type {
> > +	AHCI_IMX53,
> > +	AHCI_IMX6Q,
> > +};
> 
> Please next time introduce a SoC specific struct to encode the
> differences between SoCs. This way you can abstract away the differences
> in flags and function callbacks and don't end up with functions which
> do completely different things for different SoCs like currently in
> imx_sata_clock_enable(). The if (type == SOC_XY) style doesn't scale in
> many drivers anymore.

Yea, I was thinking about the same thing when reviewing the patch in the
first time, but decided to not comment on that because currently the
added functions are doing the similar/related thing.  But I agree that
SoC specific structure should be some thing more scalable and we should
go for in the future.

Shawn

