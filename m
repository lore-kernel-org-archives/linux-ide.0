From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 16/27] libata: implement and use sata_std_hardreset()
Date: Tue, 25 Mar 2008 22:16:54 +0900
Message-ID: <12064510283768-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.182]:23744 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbYCYNRw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:52 -0400
Received: by el-out-1112.google.com with SMTP id v27so1723960ele.17
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:51 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Implement sata_std_hardreset(), which simply wraps around
sata_link_hardreset().  sata_std_hardreset() becomes new standard
hardreset method for sata_port_ops and sata_sff_hardreset() moves from
ata_base_port_ops to ata_sff_port_ops, which is where it really
belongs.

ata_is_builtin_hardreset() is added so that both
ata_std_error_handler() and ata_sff_error_handler() skip both builtin
hardresets if SCR isn't accessible.

piix_sidpr_hardreset() in ata_piix.c is identical to
sata_std_hardreset() in functionality and got replaced with the
standard function.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c    |   27 +--------------------------
 drivers/ata/libata-core.c |   30 +++++++++++++++++++++++++++++-
 drivers/ata/libata-eh.c   |    7 ++-----
 drivers/ata/libata-sff.c  |    9 ++++-----
 drivers/ata/libata.h      |    9 +++++++++
 include/linux/libata.h    |    2 ++
 6 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 16cb5b2..59fc549 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -168,8 +168,6 @@ static void piix_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static void ich_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static int ich_pata_cable_detect(struct ata_port *ap);
 static u8 piix_vmw_bmdma_status(struct ata_port *ap);
-static int piix_sidpr_hardreset(struct ata_link *link, unsigned int *class,
-				unsigned long deadline);
 static int piix_sidpr_scr_read(struct ata_port *ap, unsigned int reg, u32 *val);
 static int piix_sidpr_scr_write(struct ata_port *ap, unsigned int reg, u32 val);
 #ifdef CONFIG_PM
@@ -320,7 +318,7 @@ static struct ata_port_operations piix_sata_ops = {
 
 static struct ata_port_operations piix_sidpr_sata_ops = {
 	.inherits		= &piix_sata_ops,
-	.hardreset		= piix_sidpr_hardreset,
+	.hardreset		= sata_std_hardreset,
 	.scr_read		= piix_sidpr_scr_read,
 	.scr_write		= piix_sidpr_scr_write,
 };
@@ -1029,29 +1027,6 @@ static int piix_sidpr_scr_write(struct ata_port *ap, unsigned int reg, u32 val)
 	return 0;
 }
 
-static int piix_sidpr_hardreset(struct ata_link *link, unsigned int *class,
-				unsigned long deadline)
-{
-	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
-	int rc;
-
-	/* do hardreset */
-	rc = sata_link_hardreset(link, timing, deadline, NULL, NULL);
-	if (rc) {
-		ata_link_printk(link, KERN_ERR,
-				"COMRESET failed (errno=%d)\n", rc);
-		return rc;
-	}
-
-	/* TODO: phy layer with polling, timeouts, etc. */
-	if (ata_link_offline(link)) {
-		*class = ATA_DEV_NONE;
-		return 0;
-	}
-
-	return -EAGAIN;
-}
-
 #ifdef CONFIG_PM
 static int piix_broken_suspend(void)
 {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6982b91..1a32dea 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -75,7 +75,6 @@ const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
 const struct ata_port_operations ata_base_port_ops = {
 	.prereset		= ata_std_prereset,
-	.hardreset		= sata_sff_hardreset,
 	.postreset		= ata_std_postreset,
 	.error_handler		= ata_std_error_handler,
 };
@@ -84,6 +83,7 @@ const struct ata_port_operations sata_port_ops = {
 	.inherits		= &ata_base_port_ops,
 
 	.qc_defer		= ata_std_qc_defer,
+	.hardreset		= sata_std_hardreset,
 	.sff_dev_select		= ata_noop_dev_select,
 };
 
@@ -3623,6 +3623,33 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 }
 
 /**
+ *	sata_std_hardreset - COMRESET w/o waiting or classification
+ *	@link: link to reset
+ *	@class: resulting class of attached device
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Standard SATA COMRESET w/o waiting or classification.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 if link offline, -EAGAIN if link online, -errno on errors.
+ */
+int sata_std_hardreset(struct ata_link *link, unsigned int *class,
+		       unsigned long deadline)
+{
+	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	bool online;
+	int rc;
+
+	/* do hardreset */
+	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
+	*class = ATA_DEV_NONE;
+	return online ? -EAGAIN : rc;
+}
+
+/**
  *	ata_std_postreset - standard postreset callback
  *	@link: the target ata_link
  *	@classes: classes of attached devices
@@ -6172,6 +6199,7 @@ EXPORT_SYMBOL_GPL(sata_link_debounce);
 EXPORT_SYMBOL_GPL(sata_link_resume);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
+EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0a1ccab..777aa38 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2859,11 +2859,8 @@ void ata_std_error_handler(struct ata_port *ap)
 	struct ata_port_operations *ops = ap->ops;
 	ata_reset_fn_t hardreset = ops->hardreset;
 
-	/* sata_std_hardreset is inherited to all drivers from
-	 * ata_base_port_ops.  Ignore it if SCR access is not
-	 * available.
-	 */
-	if (hardreset == sata_sff_hardreset && !sata_scr_valid(&ap->link))
+	/* ignore built-in hardreset if SCR access is not available */
+	if (ata_is_builtin_hardreset(hardreset) && !sata_scr_valid(&ap->link))
 		hardreset = NULL;
 
 	ata_do_eh(ap, ops->prereset, ops->softreset, hardreset, ops->postreset);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 0b97e84..f464ca1 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -49,6 +49,7 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.thaw			= ata_sff_thaw,
 	.prereset		= ata_sff_prereset,
 	.softreset		= ata_sff_softreset,
+	.hardreset		= sata_sff_hardreset,
 	.postreset		= ata_sff_postreset,
 	.error_handler		= ata_sff_error_handler,
 	.post_internal_cmd	= ata_sff_post_internal_cmd,
@@ -2031,14 +2032,12 @@ void ata_sff_error_handler(struct ata_port *ap)
 
 	/* PIO and DMA engines have been stopped, perform recovery */
 
-	/* ata_sff_softreset and sata_sff_hardreset are inherited to
-	 * all SFF drivers from ata_sff_port_ops.  Ignore softreset if
-	 * ctl isn't accessible.  Ignore hardreset if SCR access isn't
-	 * available.
+	/* Ignore ata_sff_softreset if ctl isn't accessible and
+	 * built-in hardresets if SCR access isn't available.
 	 */
 	if (softreset == ata_sff_softreset && !ap->ioaddr.ctl_addr)
 		softreset = NULL;
-	if (hardreset == sata_sff_hardreset && !sata_scr_valid(&ap->link))
+	if (ata_is_builtin_hardreset(hardreset) && !sata_scr_valid(&ap->link))
 		hardreset = NULL;
 
 	ata_do_eh(ap, ap->ops->prereset, softreset, hardreset,
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index f3e9e3f..87e7c5b 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -38,6 +38,15 @@ struct ata_scsi_args {
 	void			(*done)(struct scsi_cmnd *);
 };
 
+static inline int ata_is_builtin_hardreset(ata_reset_fn_t reset)
+{
+	if (reset == sata_std_hardreset)
+		return 1;
+	if (reset == sata_sff_hardreset)
+		return 1;
+	return 0;
+}
+
 /* libata-core.c */
 enum {
 	/* flags for ata_dev_read_id() */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b51aaba..6c5bd23 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -851,6 +851,8 @@ extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *));
+extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
+			      unsigned long deadline);
 extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
 
-- 
1.5.2.4

