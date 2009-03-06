From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] pata-rb532-cf: platform_get_irq() failure ignored
Date: Fri, 6 Mar 2009 17:43:18 +0100
Message-ID: <20090306164318.GF23767@nuty.nwl.cc>
References: <49AD2ADA.5030109@gmail.com> <49AFC43A.3040206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:39524 "EHLO orbit.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbZCFQxq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Mar 2009 11:53:46 -0500
Content-Disposition: inline
In-Reply-To: <49AFC43A.3040206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Roel Kluin <roel.kluin@gmail.com>, jgarzik@redhat.com, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Florian Fainelli <florian@openwrt.org>

Hi,

On Thu, Mar 05, 2009 at 07:23:22AM -0500, Jeff Garzik wrote:
> Roel Kluin wrote:
> >------------------------------>8-------------8<---------------------------------
> >platform_get_irq() can return -ENXIO, but since 'irq' is an unsigned int, 
> >it
> >does not show when the IRQ resource wasn't found.
> >
> >Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> >---
> >diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> >index ebfcda2..fe8178c 100644
> >--- a/drivers/ata/pata_rb532_cf.c
> >+++ b/drivers/ata/pata_rb532_cf.c
> >@@ -173,11 +173,12 @@ static __devinit int rb532_pata_driver_probe(struct 
> >platform_device *pdev)
> > 		return -EINVAL;
> > 	}
> > 
> >-	irq = platform_get_irq(pdev, 0);
> >-	if (irq <= 0) {
> >+	ret = platform_get_irq(pdev, 0);
> >+	if (ret <= 0) {
> > 		dev_err(&pdev->dev, "no IRQ resource found\n");
> > 		return -ENOENT;
> > 	}
> >+	irq = ret;
> > 
> > 	gpio = irq_to_gpio(irq);
> 
> ACK from Phil or Florian?

That's fine for me, though I didn't test it (I managed to break my
build-machine somehow, in an attempt to having the mainboard properly
grounded).

One could simplify the patch by making the variable 'irq' be signed
instead of unsigned. This would also prevent "abusing" the variable
'ret'. What do you think?

Greetings, Phil
