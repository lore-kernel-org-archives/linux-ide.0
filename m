From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] sata_rcar: fix interrupt handling
Date: Sat, 1 Jun 2013 02:38:35 +0400
Message-ID: <201306010238.35442.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35495 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab3EaWic (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 May 2013 18:38:32 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so2146899lbi.5
        for <linux-ide@vger.kernel.org>; Fri, 31 May 2013 15:38:31 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org, vladimir.barinov@cogentembedded.com

The driver's interrupt handling code is too picky in deciding whether it should
handle an interrupt or not which causes completely unneeded spurious interrupts.
Thus make sata_rcar_{ata|serr}_interrupt() *void*; add ATA status register read
to sata_rcar_ata_interrupt() to clear an unexpected ATA interrupt -- it doesn't
get cleared by writing to the SATAINTSTAT register in the interrupt mode we use.

Also, in sata_rcar_ata_interrupt() we should check SATAINTSTAT register only for
enabled interrupts and we should clear  only those interrupts  that we have read
as active first time around, because else we have  a  race and risk clearing  an
interrupt that  can  occur between read  and write of the  SATAINTSTAT  register
and never registering it...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'for-3.10-fixes' branch of Tejun Heo's 'libata.git' repo.
It will cause some rejects when merged to 'for-3.11' branch... 

 drivers/ata/sata_rcar.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

Index: libata/drivers/ata/sata_rcar.c
===================================================================
--- libata.orig/drivers/ata/sata_rcar.c
+++ libata/drivers/ata/sata_rcar.c
@@ -619,17 +619,16 @@ static struct ata_port_operations sata_r
 	.bmdma_status		= sata_rcar_bmdma_status,
 };
 
-static int sata_rcar_serr_interrupt(struct ata_port *ap)
+static void sata_rcar_serr_interrupt(struct ata_port *ap)
 {
 	struct sata_rcar_priv *priv = ap->host->private_data;
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	int freeze = 0;
-	int handled = 0;
 	u32 serror;
 
 	serror = ioread32(priv->base + SCRSERR_REG);
 	if (!serror)
-		return 0;
+		return;
 
 	DPRINTK("SError @host_intr: 0x%x\n", serror);
 
@@ -642,7 +641,6 @@ static int sata_rcar_serr_interrupt(stru
 		ata_ehi_push_desc(ehi, "%s", "hotplug");
 
 		freeze = serror & SERR_COMM_WAKE ? 0 : 1;
-		handled = 1;
 	}
 
 	/* freeze or abort */
@@ -650,11 +648,9 @@ static int sata_rcar_serr_interrupt(stru
 		ata_port_freeze(ap);
 	else
 		ata_port_abort(ap);
-
-	return handled;
 }
 
-static int sata_rcar_ata_interrupt(struct ata_port *ap)
+static void sata_rcar_ata_interrupt(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	int handled = 0;
@@ -663,7 +659,9 @@ static int sata_rcar_ata_interrupt(struc
 	if (qc)
 		handled |= ata_bmdma_port_intr(ap, qc);
 
-	return handled;
+	/* be sure to clear ATA interrupt */
+	if (!handled)
+		sata_rcar_check_status(ap);
 }
 
 static irqreturn_t sata_rcar_interrupt(int irq, void *dev_instance)
@@ -678,20 +676,21 @@ static irqreturn_t sata_rcar_interrupt(i
 	spin_lock_irqsave(&host->lock, flags);
 
 	sataintstat = ioread32(priv->base + SATAINTSTAT_REG);
+	sataintstat &= SATA_RCAR_INT_MASK;
 	if (!sataintstat)
 		goto done;
 	/* ack */
-	iowrite32(sataintstat & ~SATA_RCAR_INT_MASK,
-		 priv->base + SATAINTSTAT_REG);
+	iowrite32(~sataintstat & 0x7ff, priv->base + SATAINTSTAT_REG);
 
 	ap = host->ports[0];
 
 	if (sataintstat & SATAINTSTAT_ATA)
-		handled |= sata_rcar_ata_interrupt(ap);
+		sata_rcar_ata_interrupt(ap);
 
 	if (sataintstat & SATAINTSTAT_SERR)
-		handled |= sata_rcar_serr_interrupt(ap);
+		sata_rcar_serr_interrupt(ap);
 
+	handled = 1;
 done:
 	spin_unlock_irqrestore(&host->lock, flags);
 
