From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/27] libata: clean up port_ops->sff_irq_clear()
Date: Tue, 25 Mar 2008 22:16:47 +0900
Message-ID: <12064510271441-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:23934 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbYCYNRh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:37 -0400
Received: by el-out-1112.google.com with SMTP id v27so1723842ele.17
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:36 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

->sff_irq_clear() is called only from SFF interrupt handler, so there
is no reason to initialize it for non-SFF controllers.  Also,
ata_sff_irq_clear() can handle both BMDMA and non-BMDMA SFF
controllers.

This patch kills ata_noop_irq_clear() and removes it from base
port_ops and sets ->sff_irq_clear to ata_sff_irq_clear() in sff
port_ops instead of bmdma port_ops.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   10 ----------
 drivers/ata/libata-sff.c  |    2 +-
 include/linux/libata.h    |    1 -
 3 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ce204fb..7126d6f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -74,7 +74,6 @@ const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
 const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
 const struct ata_port_operations ata_base_port_ops = {
-	.sff_irq_clear		= ata_noop_irq_clear,
 	.prereset		= ata_sff_prereset,
 	.hardreset		= sata_sff_hardreset,
 	.postreset		= ata_sff_postreset,
@@ -349,14 +348,6 @@ static void ata_force_horkage(struct ata_device *dev)
 }
 
 /**
- *	ata_noop_irq_clear - Noop placeholder for irq_clear
- *	@ap: Port associated with this ATA transaction.
- */
-void ata_noop_irq_clear(struct ata_port *ap)
-{
-}
-
-/**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
  *	@pmp: Port multiplier port
@@ -6055,7 +6046,6 @@ EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_do_set_mode);
 EXPORT_SYMBOL_GPL(ata_std_qc_defer);
 EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
-EXPORT_SYMBOL_GPL(ata_noop_irq_clear);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(ata_dev_disable);
 EXPORT_SYMBOL_GPL(sata_set_spd);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 04024a5..c116016 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -58,6 +58,7 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.sff_exec_command	= ata_sff_exec_command,
 	.sff_data_xfer		= ata_sff_data_xfer,
 	.sff_irq_on		= ata_sff_irq_on,
+	.sff_irq_clear		= ata_sff_irq_clear,
 
 	.port_start		= ata_sff_port_start,
 };
@@ -71,7 +72,6 @@ const struct ata_port_operations ata_bmdma_port_ops = {
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
-	.sff_irq_clear		= ata_sff_irq_clear,
 };
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index defeadb..fad7952 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -893,7 +893,6 @@ extern void ata_id_string(const u16 *id, unsigned char *s,
 			  unsigned int ofs, unsigned int len);
 extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
-extern void ata_noop_irq_clear(struct ata_port *ap);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active,
 				    void (*finish_qc)(struct ata_queued_cmd *));
-- 
1.5.2.4

