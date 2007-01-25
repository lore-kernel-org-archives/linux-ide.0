From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_via: don't diddle with ATA_NIEN in ->freeze
Date: Thu, 25 Jan 2007 20:46:59 +0900
Message-ID: <20070125114659.GD8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:28540 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbXAYLrH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 06:47:07 -0500
Received: by wr-out-0506.google.com with SMTP id 68so420525wra
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 03:47:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, j.taimr@chello.nl

vt6420 completely loses its ability to raise IRQ for ATAPI devices if
ATA_NIEN is diddled with in ->freeze.  Further investigation is
necessary to determine whether this problem is shared on other
controllers but it doesn't seem to be at this point.

Make vt6420's ->freeze only clear IRQ to fix this problem.  This makes
vt6420 relatively more prone to IRQ storms but the controller is way
too braindamaged to worry about that anyway.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, this fix is verified to fix J. Taimr's case and a few other
reported that 2.6.20-rc5 fixed their ATAPI detection problems too.  We
still have several case to hunt down but getting verified fixes in
early helps separating different causes.  Please include this in
#upstream-fixes.  Thanks.

 drivers/ata/sata_via.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: work/drivers/ata/sata_via.c
===================================================================
--- work.orig/drivers/ata/sata_via.c
+++ work/drivers/ata/sata_via.c
@@ -74,6 +74,7 @@ enum {
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void svia_noop_freeze(struct ata_port *ap);
 static void vt6420_error_handler(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
@@ -128,7 +129,7 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.freeze			= ata_bmdma_freeze,
+	.freeze			= svia_noop_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= vt6420_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
@@ -204,6 +205,15 @@ static void svia_scr_write (struct ata_p
 	outl(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
+static void svia_noop_freeze(struct ata_port *ap)
+{
+	/* Some VIA controllers choke if ATA_NIEN is manipulated in
+	 * certain way.  Leave it alone and just clear pending IRQ.
+	 */
+	ata_chk_status(ap);
+	ap->ops->irq_clear(ap);
+}
+
 /**
  *	vt6420_prereset - prereset for vt6420
  *	@ap: target ATA port
