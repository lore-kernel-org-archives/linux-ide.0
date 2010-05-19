From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] libata-sff: kill dummy BMDMA ops from sata_qstor and pata_octeon_cf
Date: Wed, 19 May 2010 22:10:23 +0200
Message-ID: <1274299824-15691-6-git-send-email-tj@kernel.org>
References: <1274299824-15691-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45405 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661Ab0ESUKn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2010 16:10:43 -0400
In-Reply-To: <1274299824-15691-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Now that SFF and BMDMA are completely separate, sata_qstor and
pata_octeon_cf which inherit from ata_sff_port_ops don't need to worry
about BMDMA ops being called.  Kill the dummy BMDMA ops.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/pata_octeon_cf.c |   18 ------------------
 drivers/ata/sata_qstor.c     |   14 --------------
 2 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 3001109..06ddd91 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -750,20 +750,6 @@ static void octeon_cf_dev_config(struct ata_device *dev)
 }
 
 /*
- * Trap if driver tries to do standard bmdma commands.  They are not
- * supported.
- */
-static void unreachable_qc(struct ata_queued_cmd *qc)
-{
-	BUG();
-}
-
-static u8 unreachable_port(struct ata_port *ap)
-{
-	BUG();
-}
-
-/*
  * We don't do ATAPI DMA so return 0.
  */
 static int octeon_cf_check_atapi_dma(struct ata_queued_cmd *qc)
@@ -804,10 +790,6 @@ static struct ata_port_operations octeon_cf_ops = {
 	.sff_dev_select		= octeon_cf_dev_select,
 	.sff_irq_on		= octeon_cf_irq_on,
 	.sff_irq_clear		= octeon_cf_irq_clear,
-	.bmdma_setup		= unreachable_qc,
-	.bmdma_start		= unreachable_qc,
-	.bmdma_stop		= unreachable_qc,
-	.bmdma_status		= unreachable_port,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= octeon_cf_set_piomode,
 	.set_dmamode		= octeon_cf_set_dmamode,
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 0074351..daeebf1 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -120,8 +120,6 @@ static void qs_host_stop(struct ata_host *host);
 static void qs_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int qs_qc_issue(struct ata_queued_cmd *qc);
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc);
-static void qs_bmdma_stop(struct ata_queued_cmd *qc);
-static u8 qs_bmdma_status(struct ata_port *ap);
 static void qs_freeze(struct ata_port *ap);
 static void qs_thaw(struct ata_port *ap);
 static int qs_prereset(struct ata_link *link, unsigned long deadline);
@@ -137,8 +135,6 @@ static struct ata_port_operations qs_ata_ops = {
 	.inherits		= &ata_sff_port_ops,
 
 	.check_atapi_dma	= qs_check_atapi_dma,
-	.bmdma_stop		= qs_bmdma_stop,
-	.bmdma_status		= qs_bmdma_status,
 	.qc_prep		= qs_qc_prep,
 	.qc_issue		= qs_qc_issue,
 
@@ -190,16 +186,6 @@ static int qs_check_atapi_dma(struct ata_queued_cmd *qc)
 	return 1;	/* ATAPI DMA not supported */
 }
 
-static void qs_bmdma_stop(struct ata_queued_cmd *qc)
-{
-	/* nothing */
-}
-
-static u8 qs_bmdma_status(struct ata_port *ap)
-{
-	return 0;
-}
-
 static inline void qs_enter_reg_mode(struct ata_port *ap)
 {
 	u8 __iomem *chan = qs_mmio_base(ap->host) + (ap->port_no * 0x4000);
-- 
1.6.4.2

