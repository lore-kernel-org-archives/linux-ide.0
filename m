From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] libata: Remove some redundant casts from pata_octeon_cf.c
Date: Tue, 31 Mar 2009 15:04:39 -0700
Message-ID: <1238537079-2584-1-git-send-email-ddaney@caviumnetworks.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:49075 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218AbZCaWFP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2009 18:05:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@redhat.com
Cc: linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

Please consider for 2.6.30.

 drivers/ata/pata_octeon_cf.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 0fe4ef3..0e71be1 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -503,7 +503,7 @@ static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct octeon_cf_port *cf_port;
 
-	cf_port = (struct octeon_cf_port *)ap->private_data;
+	cf_port = ap->private_data;
 	DPRINTK("ENTER\n");
 	/* issue r/w command */
 	qc->cursg = qc->sg;
@@ -596,7 +596,7 @@ static unsigned int octeon_cf_dma_finished(struct ata_port *ap,
 	if (ap->hsm_task_state != HSM_ST_LAST)
 		return 0;
 
-	cf_port = (struct octeon_cf_port *)ap->private_data;
+	cf_port = ap->private_data;
 
 	dma_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine));
 	if (dma_cfg.s.size != 0xfffff) {
@@ -657,7 +657,7 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
 			continue;
 
 		ocd = ap->dev->platform_data;
-		cf_port = (struct octeon_cf_port *)ap->private_data;
+		cf_port = ap->private_data;
 		dma_int.u64 =
 			cvmx_read_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine));
 		dma_cfg.u64 =
-- 
1.6.0.6

