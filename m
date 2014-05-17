From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] ahci: imx: PLL clock needs 100us to settle down
Date: Sat, 17 May 2014 22:05:26 +0800
Message-ID: <20140517140525.GE10685@dragon>
References: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
 <CAOMZO5BDg1g=Gr6o8kW3X--ZajBsKZcKwSmse7374tC2e=ju1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:58890
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751049AbaEQOFz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2014 10:05:55 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5BDg1g=Gr6o8kW3X--ZajBsKZcKwSmse7374tC2e=ju1A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, May 17, 2014 at 10:58:20AM -0300, Fabio Estevam wrote:
> On Sat, May 17, 2014 at 9:46 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > The commit e783c51 (ahci: imx: software workaround for phy reset issue
> > in resume) calls imx_sata_phy_reset() to reset phy immediately after
> > SATA MPLL is enabled.  It seems working fine mostly, but fails in some
> > case as below.
> >
> > ...
> > ahci-imx 2200000.sata: failed to reset phy: -110
> > ahci-imx: probe of 2200000.sata failed with error -110
> >
> > After talking to the designer, we learnt that when enabling i.MX6Q SATA
> > MPLL, we need to wait 100us for it to settle down for safety.  Add this
> > required delay to fix above failure.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> On my sabresd board that was not connected to any sata disk I was
> always getting the 'failed to reset phy' error.

Damn.  I never noticed that the error is even there when no SATA disk is
attached.  Sorry.
> 
> With this patch the error goes away and the driver probes successfully.
> 
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks.

Shawn
