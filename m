From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 1/3] libata/pdc_adma: make SFF EH handle non-bmdma
 SFF drivers and standardize pdc_adma ops
Date: Tue, 25 Mar 2008 21:34:39 +0900
Message-ID: <47E8F15F.50601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.177]:29852 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbYCYMes (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 08:34:48 -0400
Received: by ik-out-1112.google.com with SMTP id c28so897610ika.5
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 05:34:46 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

pdc_adma has interface similar to SFF but has its own DMA interface.
It currently implements noop bmdma ops to avoid crashing
ata_bmdma_error_handler() which BTW actually is EH for SFF drivers.

This patch makes ata_bmdma_error_handler() dereference bmdma ops iff
bmdma_addr is initialized as done in ata_bmdma_post_internal_cmd.
This change allows pdc_adma to standardize ops and use SFF
error_handler and post_internal_cmd.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>
---
This patch series in on top of #cleanup-sht-ops (ed75ba53) and not for
#upstream-fixes.  Tested with pdc_adma controllers Mark sent me. :-)

 drivers/ata/libata-sff.c |    3 ++-
 drivers/ata/pdc_adma.c   |   16 ++--------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 2a229a1..0e30c11 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -424,7 +424,8 @@ void ata_bmdma_error_handler(struct ata_port *ap)
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	if (qc && (qc->tf.protocol == ATA_PROT_DMA ||
+	if (ap->ioaddr.bmdma_addr &&
+	    qc && (qc->tf.protocol == ATA_PROT_DMA ||
 		   qc->tf.protocol == ATAPI_PROT_DMA)) {
 		u8 host_stat;
 
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 5ed065d..577a0e5 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -136,8 +136,6 @@ static void adma_port_stop(struct ata_port *ap);
 static void adma_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int adma_qc_issue(struct ata_queued_cmd *qc);
 static int adma_check_atapi_dma(struct ata_queued_cmd *qc);
-static void adma_bmdma_stop(struct ata_queued_cmd *qc);
-static u8 adma_bmdma_status(struct ata_port *ap);
 static void adma_freeze(struct ata_port *ap);
 static void adma_thaw(struct ata_port *ap);
 static int adma_prereset(struct ata_link *link, unsigned long deadline);
@@ -158,8 +156,6 @@ static struct ata_port_operations adma_ata_ops = {
 	.exec_command		= ata_exec_command,
 	.data_xfer		= ata_data_xfer,
 	.check_atapi_dma	= adma_check_atapi_dma,
-	.bmdma_stop		= adma_bmdma_stop,
-	.bmdma_status		= adma_bmdma_status,
 	.qc_prep		= adma_qc_prep,
 	.qc_issue		= adma_qc_issue,
 	.irq_on			= ata_irq_on,
@@ -168,6 +164,8 @@ static struct ata_port_operations adma_ata_ops = {
 	.thaw			= adma_thaw,
 	.prereset		= adma_prereset,
 	.softreset		= ata_std_softreset,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
@@ -204,16 +202,6 @@ static int adma_check_atapi_dma(struct ata_queued_cmd *qc)
 	return 1;	/* ATAPI DMA not yet supported */
 }
 
-static void adma_bmdma_stop(struct ata_queued_cmd *qc)
-{
-	/* nothing */
-}
-
-static u8 adma_bmdma_status(struct ata_port *ap)
-{
-	return 0;
-}
-
 static void adma_reset_engine(struct ata_port *ap)
 {
 	void __iomem *chan = ADMA_PORT_REGS(ap);
-- 
1.5.2.4

