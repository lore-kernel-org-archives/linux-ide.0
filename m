From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: patch "libata-sff: Fix oops for pnp devices with no ctl" causes
 regression
Date: Thu, 5 Jun 2008 12:19:35 +0100
Message-ID: <20080605121935.1a1ecb59@core>
References: <20080605050923.GD11811@wotan.suse.de>
	<20080605102424.0cf56c37@core>
	<20080605102129.GB11366@wotan.suse.de>
	<20080605103116.GC11366@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52921 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754429AbYFELfa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jun 2008 07:35:30 -0400
In-Reply-To: <20080605103116.GC11366@wotan.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: jgarzik@redhat.com, linux-ide@vger.kernel.org

> > @@ -1583,6 +1583,12 @@ inline unsigned int ata_sff_host_intr(struct ata_port *ap
> >         if (status & ATA_BUSY)
> >                 goto idle_irq;
> > 
> > +       /* check main status, clearing INTRQ */
> > +       status = ap->ops->sff_check_status(ap);
> > +       if (unlikely(status & ATA_BUSY))
> > +               goto idle_irq;
> > +
> > +

Aha all is revealed: and yes it would only show up on a few boxes

libata-sff: Don't assume that check_status is an SFF read

From: Alan Cox <alan@redhat.com>

For a few controllers the sff check status is actually a method not an I/O
access and we must call the method when doing the IRQ check
---

 drivers/ata/libata-sff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Signed-off-by: Alan Cox <alan@redhat.com>

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 90d20c6..215d186 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -278,7 +278,7 @@ static u8 ata_sff_irq_status(struct ata_port *ap)
 		    	return status;
 	}
 	/* Clear INTRQ latch */
-	status = ata_sff_check_status(ap);
+	status = ap->ops->sff_check_status(ap);
 	return status;
 }
 
