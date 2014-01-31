From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] ATA: SATA_MV: Fix probe failure when no phy exists
Date: Fri, 31 Jan 2014 11:54:11 +0100
Message-ID: <20140131105411.GC26003@lunn.ch>
References: <1391115035-25960-1-git-send-email-andrew@lunn.ch>
 <20140130221228.GB1063@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49618 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076AbaAaKyY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Jan 2014 05:54:24 -0500
Content-Disposition: inline
In-Reply-To: <20140130221228.GB1063@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

On Thu, Jan 30, 2014 at 07:12:28PM -0300, Ezequiel Garcia wrote:
> On Thu, Jan 30, 2014 at 09:50:35PM +0100, Andrew Lunn wrote:
> > Armada 370 and XP do not have a SATA phy driver.  The generic phy
> > layer does not cleanly support optional phys. It is not possible to
> > determine from the error code if there is expected to be a phy
> > according to DT, but it cannot be found, or no phy is listed in
> > DT. All that can be determined is that a phy is expected, but the
> > driver has not been loaded yet, in which case -EPROBE_DEFER is
> > returned. Thus for 370 and XP the driver failed to probe.  Play safe,
> > consider all errors except -EPROBE_DEFER to be none fatal and keep
> > going, and in the case of -EPROBE_DEFER exit the probe function with
> > that error code.
> > 
> > Tested on Kirkwood with a sata phy driver and on 370 without a sata
> > phy driver.
> > 
> > Reported-by: Jean Pihet <jean.pihet@linaro.org>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Tested-by: Gregory Clement <gregory.clement@free-electrons.com>
> > ---
> >  drivers/ata/sata_mv.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> > index eaa21eddbe70..148ff5a82c8b 100644
> > --- a/drivers/ata/sata_mv.c
> > +++ b/drivers/ata/sata_mv.c
> > @@ -4115,9 +4115,8 @@ static int mv_platform_probe(struct platform_device *pdev)
> >  		if (IS_ERR(hpriv->port_phys[port])) {
> >  			rc = PTR_ERR(hpriv->port_phys[port]);
> >  			hpriv->port_phys[port] = NULL;
> > -			if ((rc != -EPROBE_DEFER) && (rc != -ENODEV))
> > -				dev_warn(&pdev->dev, "error getting phy");
> > -			goto err;
> > +			if (rc == -EPROBE_DEFER)
> > +				goto err;
> 
> It feels a bit fishy to check for a specific errno.
> 
> How about not considering the lack of phy an error in all cases? In
> other words, remove the check completely.

Bad things would happen. EPROBE_DEFER means there is a phy driver, but
because of the non-deterministic ordering of loading drivers, it has
not been loaded yet. The sata_mv driver needs to fail its probe with
EPROBE_DEFER, giving the phy driver chance to load, and then when
sata_mv loads for a second time it will find the phy driver. If we
ignored the EPROBE_DEFER and sata_mv loaded, it would be out of sync
with the phy driver, resulting in the phy being turned off, and the
discs would never be found.

So

EPROBE_DEFER: We need to fail the probe, but it is not fatal.
ENOSYS: No generic PHY framework, sata_mv can load.
ENODEV: No phy, probably because it is optional and not there, sata_mv can load.
ENOMEM, EINVAL, etc are real errors and should probably be fatal and
returned by the probe function.

So i could reverse the comparison, look for ENOSYS and ENODEV and
allow the probe to succeed and return the error in all other cases.

> Isn't the phy used only for power saving purposes? Or do we want this
> for another purpose?

Yes. On Dove it can save around 10% of the idle power. I don't have
kirkwood numbers at the moment, but it is probably similar.
 
> Or as a different solution, can't we check for the compatible-string
> and only try to get a phy for orion-sata?

Orion5x cannot control its phy. Nor can PCI cards using the same IP
core in discreet chips. I also hope that at some point 370 and XP gain
phy support. I would really like this to work just like clocks do,
where the clocks are optional and if they are in the DT node they are
used, otherwise they are not.

      Andrew
