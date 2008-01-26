From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 12/13] sata_mv ncq Remove post internal cmd op
Date: Sat, 26 Jan 2008 18:33:36 -0500
Message-ID: <479BC350.2030307@rtr.ca>
References: <479BC217.60709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3080 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbYAZXdh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 18:33:37 -0500
In-Reply-To: <479BC217.60709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

This driver currently has no need for the .post_internal_cmd op.
So get rid of it, to save unnecessary transitions between EDMA and non-EDMA modes.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-26 18:11:17.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-26 18:10:38.000000000 -0500
@@ -452,7 +452,6 @@
 static void mv_qc_prep_iie(struct ata_queued_cmd *qc);
 static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
 static void mv_error_handler(struct ata_port *ap);
-static void mv_post_int_cmd(struct ata_queued_cmd *qc);
 static void mv_eh_freeze(struct ata_port *ap);
 static void mv_eh_thaw(struct ata_port *ap);
 static void mv6_dev_config(struct ata_device *dev);
@@ -541,7 +540,6 @@
 	.irq_on			= ata_irq_on,
 
 	.error_handler		= mv_error_handler,
-	.post_internal_cmd	= mv_post_int_cmd,
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
 
@@ -570,7 +568,6 @@
 	.irq_on			= ata_irq_on,
 
 	.error_handler		= mv_error_handler,
-	.post_internal_cmd	= mv_post_int_cmd,
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
 	.qc_defer		= ata_std_qc_defer,
@@ -599,7 +596,6 @@
 	.irq_on			= ata_irq_on,
 
 	.error_handler		= mv_error_handler,
-	.post_internal_cmd	= mv_post_int_cmd,
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
 	.qc_defer		= ata_std_qc_defer,
@@ -2424,11 +2420,6 @@
 		  mv_hardreset, mv_postreset);
 }
 
-static void mv_post_int_cmd(struct ata_queued_cmd *qc)
-{
-	mv_stop_dma(qc->ap);
-}
-
 static void mv_eh_freeze(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
