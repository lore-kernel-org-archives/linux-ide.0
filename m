From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 24/27] libata: kill ata_noop_dev_select()
Date: Tue, 25 Mar 2008 22:17:02 +0900
Message-ID: <12064510291079-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:60507 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781AbYCYNR5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:57 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1755484rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:57 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Now that SFF assumptions are separated out from non-SFF reset
sequence, port_ops->sff_dev_select() is no longer necessary for
non-SFF controllers.  Kill ata_noop_dev_select() and ->sff_dev_select
initialization from base and other non-SFF port_ops.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c     |   19 -------------------
 drivers/scsi/ipr.c            |    1 -
 drivers/scsi/libsas/sas_ata.c |    1 -
 include/linux/libata.h        |    1 -
 4 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fad12d7..ce10edb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -84,7 +84,6 @@ const struct ata_port_operations sata_port_ops = {
 
 	.qc_defer		= ata_std_qc_defer,
 	.hardreset		= sata_std_hardreset,
-	.sff_dev_select		= ata_noop_dev_select,
 };
 
 const struct ata_port_operations sata_pmp_port_ops = {
@@ -1394,22 +1393,6 @@ static int ata_hpa_resize(struct ata_device *dev)
 }
 
 /**
- *	ata_noop_dev_select - Select device 0/1 on ATA bus
- *	@ap: ATA channel to manipulate
- *	@device: ATA device (numbered from zero) to select
- *
- *	This function performs no actual function.
- *
- *	May be used as the dev_select() entry in ata_port_operations.
- *
- *	LOCKING:
- *	caller.
- */
-void ata_noop_dev_select(struct ata_port *ap, unsigned int device)
-{
-}
-
-/**
  *	ata_dump_id - IDENTIFY DEVICE info debugging output
  *	@id: IDENTIFY DEVICE page to dump
  *
@@ -6141,7 +6124,6 @@ static unsigned int ata_dummy_qc_issue(struct ata_queued_cmd *qc)
 struct ata_port_operations ata_dummy_port_ops = {
 	.sff_check_status	= ata_dummy_check_status,
 	.sff_check_altstatus	= ata_dummy_check_status,
-	.sff_dev_select		= ata_noop_dev_select,
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= ata_dummy_qc_issue,
 	.freeze			= ata_dummy_noret,
@@ -6182,7 +6164,6 @@ EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
-EXPORT_SYMBOL_GPL(ata_noop_dev_select);
 EXPORT_SYMBOL_GPL(sata_print_link_status);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 5a95ea7..65dc18d 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -5247,7 +5247,6 @@ static bool ipr_qc_fill_rtf(struct ata_queued_cmd *qc)
 }
 
 static struct ata_port_operations ipr_sata_ops = {
-	.sff_dev_select = ata_noop_dev_select,
 	.phy_reset = ipr_ata_phy_reset,
 	.hardreset = ipr_sata_reset,
 	.post_internal_cmd = ipr_ata_post_internal,
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 5c114bb..a4811e4 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -344,7 +344,6 @@ static int sas_ata_scr_read(struct ata_port *ap, unsigned int sc_reg_in,
 }
 
 static struct ata_port_operations sas_sata_ops = {
-	.sff_dev_select		= ata_noop_dev_select,
 	.phy_reset		= sas_ata_phy_reset,
 	.post_internal_cmd	= sas_ata_post_internal,
 	.qc_prep		= ata_noop_qc_prep,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 03f4ae3..4584180 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -908,7 +908,6 @@ extern unsigned long ata_xfer_mode2mask(u8 xfer_mode);
 extern int ata_xfer_mode2shift(unsigned long xfer_mode);
 extern const char *ata_mode_string(unsigned long xfer_mask);
 extern unsigned long ata_id_xfermask(const u16 *id);
-extern void ata_noop_dev_select(struct ata_port *ap, unsigned int device);
 extern int ata_port_start(struct ata_port *ap);
 extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
 extern void ata_noop_qc_prep(struct ata_queued_cmd *qc);
-- 
1.5.2.4

