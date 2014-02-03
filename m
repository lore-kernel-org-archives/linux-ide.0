From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] ATA: SATA_MV: Fix probe failure when no phy exists
Date: Mon, 3 Feb 2014 11:50:12 -0500
Message-ID: <20140203165012.GE8533@titan.lakedaemon.net>
References: <1391115035-25960-1-git-send-email-andrew@lunn.ch>
 <20140130221228.GB1063@localhost>
 <20140131105411.GC26003@lunn.ch>
 <52EFB69E.2000800@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58650 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbaBCQuT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 11:50:19 -0500
Content-Disposition: inline
In-Reply-To: <52EFB69E.2000800@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Kevin Hilman <khilman@linaro.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>


+ Kevin Hilman (context kept for Kevin)

Tejun, a request below.

On Mon, Feb 03, 2014 at 04:32:46PM +0100, Gregory CLEMENT wrote:
> Hi Andrew, Ezequiel,
> 
> On 31/01/2014 11:54, Andrew Lunn wrote:
> > On Thu, Jan 30, 2014 at 07:12:28PM -0300, Ezequiel Garcia wrote:
> >> On Thu, Jan 30, 2014 at 09:50:35PM +0100, Andrew Lunn wrote:
> >>> Armada 370 and XP do not have a SATA phy driver.  The generic phy
> >>> layer does not cleanly support optional phys. It is not possible to
> >>> determine from the error code if there is expected to be a phy
> >>> according to DT, but it cannot be found, or no phy is listed in
> >>> DT. All that can be determined is that a phy is expected, but the
> >>> driver has not been loaded yet, in which case -EPROBE_DEFER is
> >>> returned. Thus for 370 and XP the driver failed to probe.  Play safe,
> >>> consider all errors except -EPROBE_DEFER to be none fatal and keep
> >>> going, and in the case of -EPROBE_DEFER exit the probe function with
> >>> that error code.
> >>>
> >>> Tested on Kirkwood with a sata phy driver and on 370 without a sata
> >>> phy driver.
> 
> As expected kernel fails booting on Armada 370 and Armada XP when SATA
> is selected (so by default with mvebu_defconfig and multi_v7_defconfig)
> on 3.14-rc1. I would realy like to see this issue fixed for 3.14-rc2.
> 
> >>>
> >>> Reported-by: Jean Pihet <jean.pihet@linaro.org>
> >>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >>> Tested-by: Gregory Clement <gregory.clement@free-electrons.com>
> >>> ---
> >>>  drivers/ata/sata_mv.c | 5 ++---
> >>>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> >>> index eaa21eddbe70..148ff5a82c8b 100644
> >>> --- a/drivers/ata/sata_mv.c
> >>> +++ b/drivers/ata/sata_mv.c
> >>> @@ -4115,9 +4115,8 @@ static int mv_platform_probe(struct platform_device *pdev)
> >>>  		if (IS_ERR(hpriv->port_phys[port])) {
> >>>  			rc = PTR_ERR(hpriv->port_phys[port]);
> >>>  			hpriv->port_phys[port] = NULL;
> >>> -			if ((rc != -EPROBE_DEFER) && (rc != -ENODEV))
> >>> -				dev_warn(&pdev->dev, "error getting phy");
> >>> -			goto err;
> >>> +			if (rc == -EPROBE_DEFER)
> >>> +				goto err;
> >>
> >> It feels a bit fishy to check for a specific errno.
> 
> EPROBE_DEFER is a very special errno so from my point of view it is
> not so surprising to have a specific treatment for this case.
> 
> >>
> >> How about not considering the lack of phy an error in all cases? In
> >> other words, remove the check completely.
> > 
> > Bad things would happen. EPROBE_DEFER means there is a phy driver, but
> > because of the non-deterministic ordering of loading drivers, it has
> > not been loaded yet. The sata_mv driver needs to fail its probe with
> > EPROBE_DEFER, giving the phy driver chance to load, and then when
> > sata_mv loads for a second time it will find the phy driver. If we
> > ignored the EPROBE_DEFER and sata_mv loaded, it would be out of sync
> > with the phy driver, resulting in the phy being turned off, and the
> > discs would never be found.
> > 
> > So
> > 
> > EPROBE_DEFER: We need to fail the probe, but it is not fatal.
> > ENOSYS: No generic PHY framework, sata_mv can load.
> > ENODEV: No phy, probably because it is optional and not there, sata_mv can load.
> > ENOMEM, EINVAL, etc are real errors and should probably be fatal and
> > returned by the probe function.
> > 
> > So i could reverse the comparison, look for ENOSYS and ENODEV and
> > allow the probe to succeed and return the error in all other cases.
> 
> This looks more unusual for me, but I understand the logic. Indeed this
> solution seems better.
> 
> Andrew, could you post a new version?
> if you add the explanation you gave inside a comment just before the check,
> I am sure it will be perfectly acceptable.

Tejun,

This patch is needed for our arm-soc bootfarms to continue testing.  It
would be helpful if, once you're ok with the patch, we took it through
arm-soc.  Would you mind Ack'ing it once you're happy with it?

thx,

Jason.

> >> Isn't the phy used only for power saving purposes? Or do we want this
> >> for another purpose?
> > 
> > Yes. On Dove it can save around 10% of the idle power. I don't have
> > kirkwood numbers at the moment, but it is probably similar.
> >  
> >> Or as a different solution, can't we check for the compatible-string
> >> and only try to get a phy for orion-sata?
> > 
> > Orion5x cannot control its phy. Nor can PCI cards using the same IP
> > core in discreet chips. I also hope that at some point 370 and XP gain
> > phy support. I would really like this to work just like clocks do,
> > where the clocks are optional and if they are in the DT node they are
> > used, otherwise they are not.
> > 
> >       Andrew
> > 
> 
> 
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
