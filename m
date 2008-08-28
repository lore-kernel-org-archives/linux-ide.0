From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH,RFC] sata_mv: don't avoid clearing interrupt status on SoC host adapters
Date: Thu, 28 Aug 2008 22:04:48 +0200
Message-ID: <20080828200448.GA27837@xi.wantstofly.org>
References: <20080824030429.GA10230@xi.wantstofly.org> <48B40A1F.6090703@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xi.wantstofly.org ([83.160.184.112]:58419 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700AbYH1UEu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 16:04:50 -0400
Content-Disposition: inline
In-Reply-To: <48B40A1F.6090703@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Tue, Aug 26, 2008 at 09:50:23AM -0400, Mark Lord wrote:

> >For some reason, sata_mv doesn't clear interrupt status during init
> >when it's running on an SoC host adapter.  If the bootloader has
> >touched the SATA controller before starting Linux, Linux can end up
> >enabling the SATA interrupt with events pending, which will cause the
> >interrupt to be marked as spurious and then be disabled, which then
> >breaks all further accesses to the controller.
> >
> >This patch makes the SoC path clear interrupt status on init like in
> >the non-SoC case.
> >
> >Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
> >---
> > drivers/ata/sata_mv.c |   21 ++++++++++-----------
> > 1 files changed, 10 insertions(+), 11 deletions(-)
> >
> >diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> >index ad169ff..e829a3a 100644
> >--- a/drivers/ata/sata_mv.c
> >+++ b/drivers/ata/sata_mv.c
> >@@ -3131,19 +3131,18 @@ static int mv_init_host(struct ata_host *host, 
> >unsigned int board_idx)
> > 		writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
> > 	}
> > 
> >-	if (!IS_SOC(hpriv)) {
> >-		/* Clear any currently outstanding host interrupt conditions 
> >*/
> >-		writelfl(0, mmio + hpriv->irq_cause_ofs);
> >+	/* Clear any currently outstanding host interrupt conditions */
> >+	writelfl(0, mmio + hpriv->irq_cause_ofs);
> > 
> >-		/* and unmask interrupt generation for host regs */
> >-		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
> >+	/* and unmask interrupt generation for host regs */
> >+	writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
> >+
> >+	/*
> >+	 * enable only global host interrupts for now.
> >+	 * The per-port interrupts get done later as ports are set up.
> >+	 */
> >+	mv_set_main_irq_mask(host, 0, PCI_ERR);
> > 
> >-		/*
> >-		 * enable only global host interrupts for now.
> >-		 * The per-port interrupts get done later as ports are set 
> >up.
> >-		 */
> >-		mv_set_main_irq_mask(host, 0, PCI_ERR);
> >-	}
> > done:
> > 	return rc;
> > }
> 
> Looks fine to me -- Saeed Bishara did the SOC stuff, and Marvell
> refuses to show me any documentation for it.

Yeah, docs are often a problem (even internally).  However, this
particular bit has been opened up, and you can get a copy of the SoC
docs here:

	http://www.marvell.com/products/media/index.jsp

(Get the docs for the 5182, which is the only 5xxx series SoC that has
SATA built-in.)
