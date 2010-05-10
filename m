From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/23] libata-sff: clean up inheritance in several drivers
Date: Mon, 10 May 2010 21:41:33 +0200
Message-ID: <1273520507-32459-10-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44944 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756035Ab0EJTmU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:20 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

1. pata_cmd640 is PIO only.  Inherit from sff.

2. pata_macio is BMDMA.  Inherit from bmdma and drop explicit
   bmdma_mode_filter() setting.

3. In pata_marvell, unlike mv5, mv6 is BMDMA.  Inherit from bmdma and
   don't clear ->post_internal_cmd().

4. bf54x and icside are quasi-BMDMA controllers which don't use the
   standard BMDMA registers so they don't initialize bmdma_addr and
   inherit from sff to avoid the default mode_filter which disables
   DMA modes if bmdma_addr is not initialized.

For 2 and 3, this patch makes the drivers explicitly specify
->mode_filter to ATA_OP_NULL while inheriting from ata_bmdma_port_ops.
These will be removed by the next patch.

This patch makes all and only BMDMA drivers inherit from
ata_bmdma_port_ops to ease further SFF/BMDMA separation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/pata_bf54x.c  |    4 +++-
 drivers/ata/pata_cmd640.c |    4 ++--
 drivers/ata/pata_icside.c |    4 +++-
 drivers/ata/pata_macio.c  |    3 +--
 drivers/ata/sata_mv.c     |   24 ++++++++++++++++++++----
 5 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 7df072a..5c189ff 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1459,7 +1459,7 @@ static struct scsi_host_template bfin_sht = {
 };
 
 static struct ata_port_operations bfin_pata_ops = {
-	.inherits		= &ata_sff_port_ops,
+	.inherits		= &ata_bmdma_port_ops,
 
 	.set_piomode		= bfin_set_piomode,
 	.set_dmamode		= bfin_set_dmamode,
@@ -1489,6 +1489,8 @@ static struct ata_port_operations bfin_pata_ops = {
 
 	.port_start		= bfin_port_start,
 	.port_stop		= bfin_port_stop,
+
+	.mode_filter		= ATA_OP_NULL,	/* will be removed soon */
 };
 
 static struct ata_port_info bfin_port_info[] = {
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 45896b3..a792eb3 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -166,11 +166,11 @@ static int cmd640_port_start(struct ata_port *ap)
 }
 
 static struct scsi_host_template cmd640_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations cmd640_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_sff_port_ops,
 	/* In theory xfer_noirq is not needed once we kill the prefetcher */
 	.sff_data_xfer	= ata_sff_data_xfer_noirq,
 	.qc_issue	= cmd640_qc_issue,
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index fa812e2..832c8cc 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -321,7 +321,7 @@ static void pata_icside_postreset(struct ata_link *link, unsigned int *classes)
 }
 
 static struct ata_port_operations pata_icside_port_ops = {
-	.inherits		= &ata_sff_port_ops,
+	.inherits		= &ata_bmdma_port_ops,
 	/* no need to build any PRD tables for DMA */
 	.qc_prep		= ata_noop_qc_prep,
 	.sff_data_xfer		= ata_sff_data_xfer_noirq,
@@ -334,6 +334,8 @@ static struct ata_port_operations pata_icside_port_ops = {
 	.set_dmamode		= pata_icside_set_dmamode,
 	.postreset		= pata_icside_postreset,
 	.post_internal_cmd	= pata_icside_bmdma_stop,
+
+	.mode_filter		= ATA_OP_NULL,	/* will be removed soon */
 };
 
 static void __devinit
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 211b643..17e4e5d 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -917,7 +917,7 @@ static struct scsi_host_template pata_macio_sht = {
 };
 
 static struct ata_port_operations pata_macio_ops = {
-	.inherits		= &ata_sff_port_ops,
+	.inherits		= &ata_bmdma_port_ops,
 
 	.freeze			= pata_macio_freeze,
 	.set_piomode		= pata_macio_set_timings,
@@ -925,7 +925,6 @@ static struct ata_port_operations pata_macio_ops = {
 	.cable_detect		= pata_macio_cable_detect,
 	.sff_dev_select		= pata_macio_dev_select,
 	.qc_prep		= pata_macio_qc_prep,
-	.mode_filter		= ata_bmdma_mode_filter,
 	.bmdma_setup		= pata_macio_bmdma_setup,
 	.bmdma_start		= pata_macio_bmdma_start,
 	.bmdma_stop		= pata_macio_bmdma_stop,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 318862e..a033710 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -686,16 +686,27 @@ static struct ata_port_operations mv5_ops = {
 };
 
 static struct ata_port_operations mv6_ops = {
-	.inherits		= &mv5_ops,
+	.inherits		= &ata_bmdma_port_ops,
+
+	.lost_interrupt		= ATA_OP_NULL,
+
+	.qc_defer		= mv_qc_defer,
+	.qc_prep		= mv_qc_prep,
+	.qc_issue		= mv_qc_issue,
+
 	.dev_config             = mv6_dev_config,
-	.scr_read		= mv_scr_read,
-	.scr_write		= mv_scr_write,
 
+	.freeze			= mv_eh_freeze,
+	.thaw			= mv_eh_thaw,
+	.hardreset		= mv_hardreset,
+	.softreset		= mv_softreset,
 	.pmp_hardreset		= mv_pmp_hardreset,
 	.pmp_softreset		= mv_softreset,
-	.softreset		= mv_softreset,
 	.error_handler		= mv_pmp_error_handler,
 
+	.scr_read		= mv_scr_read,
+	.scr_write		= mv_scr_write,
+
 	.sff_check_status	= mv_sff_check_status,
 	.sff_irq_clear		= mv_sff_irq_clear,
 	.check_atapi_dma	= mv_check_atapi_dma,
@@ -703,6 +714,11 @@ static struct ata_port_operations mv6_ops = {
 	.bmdma_start		= mv_bmdma_start,
 	.bmdma_stop		= mv_bmdma_stop,
 	.bmdma_status		= mv_bmdma_status,
+
+	.port_start		= mv_port_start,
+	.port_stop		= mv_port_stop,
+
+	.mode_filter            = ATA_OP_NULL,  /* will be removed soon */
 };
 
 static struct ata_port_operations mv_iie_ops = {
-- 
1.6.4.2

