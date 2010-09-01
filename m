From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] libata: implement sata_link_scr_lpm() and make ata_dev_set_feature() global
Date: Wed,  1 Sep 2010 17:50:05 +0200
Message-ID: <1283356208-1884-3-git-send-email-tj@kernel.org>
References: <1283356208-1884-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35951 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755897Ab0IAPu2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Sep 2010 11:50:28 -0400
In-Reply-To: <1283356208-1884-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Link power management is about to be reimplemented.  Prepare for it.

* Implement sata_link_scr_lpm().

* Drop static from ata_dev_set_feature() and make it available to
  other libata files.

* Trivial whitespace adjustments.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   75 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/ata/libata.h      |    2 +
 include/linux/libata.h    |    2 +
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a7274f5..c8573e0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -91,8 +91,6 @@ const struct ata_port_operations sata_port_ops = {
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
-static unsigned int ata_dev_set_feature(struct ata_device *dev,
-					u8 enable, u8 feature);
 static void ata_dev_xfermask(struct ata_device *dev);
 static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
@@ -3628,7 +3626,7 @@ int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
  *	@params: timing parameters { interval, duratinon, timeout } in msec
  *	@deadline: deadline jiffies for the operation
  *
-*	Make sure SStatus of @link reaches stable state, determined by
+ *	Make sure SStatus of @link reaches stable state, determined by
  *	holding the same value where DET is not 1 for @duration polled
  *	every @interval, before @timeout.  Timeout constraints the
  *	beginning of the stable state.  Because DET gets stuck at 1 on
@@ -3760,6 +3758,72 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 }
 
 /**
+ *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
+ *	@link: ATA link to manipulate SControl for
+ *	@policy: LPM policy to configure
+ *	@spm_wakeup: initiate LPM transition to active state
+ *
+ *	Manipulate the IPM field of the SControl register of @link
+ *	according to @policy.  If @policy is ATA_LPM_MAX_POWER and
+ *	@spm_wakeup is %true, the SPM field is manipulated to wake up
+ *	the link.  This function also clears PHYRDY_CHG before
+ *	returning.
+ *
+ *	LOCKING:
+ *	EH context.
+ *
+ *	RETURNS:
+ *	0 on succes, -errno otherwise.
+ */
+int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+		      bool spm_wakeup)
+{
+	struct ata_eh_context *ehc = &link->eh_context;
+	bool woken_up = false;
+	u32 scontrol;
+	int rc;
+
+	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
+	if (rc)
+		return rc;
+
+	switch (policy) {
+	case ATA_LPM_MAX_POWER:
+		/* disable all LPM transitions */
+		scontrol |= (0x3 << 8);
+		/* initiate transition to active state */
+		if (spm_wakeup) {
+			scontrol |= (0x4 << 12);
+			woken_up = true;
+		}
+		break;
+	case ATA_LPM_MED_POWER:
+		/* allow LPM to PARTIAL */
+		scontrol &= ~(0x1 << 8);
+		scontrol |= (0x2 << 8);
+		break;
+	case ATA_LPM_MIN_POWER:
+		/* no restrictions on LPM transitions */
+		scontrol &= ~(0x3 << 8);
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	rc = sata_scr_write(link, SCR_CONTROL, scontrol);
+	if (rc)
+		return rc;
+
+	/* give the link time to transit out of LPM state */
+	if (woken_up)
+		msleep(10);
+
+	/* clear PHYRDY_CHG from SError */
+	ehc->i.serror &= ~SERR_PHYRDY_CHG;
+	return sata_scr_write(link, SCR_ERROR, SERR_PHYRDY_CHG);
+}
+
+/**
  *	ata_std_prereset - prepare for reset
  *	@link: ATA link to be reset
  *	@deadline: deadline jiffies for the operation
@@ -4551,6 +4615,7 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
 }
+
 /**
  *	ata_dev_set_feature - Issue SET FEATURES - SATA FEATURES
  *	@dev: Device to which command will be sent
@@ -4566,8 +4631,7 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
  *	RETURNS:
  *	0 on success, AC_ERR_* mask otherwise.
  */
-static unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable,
-					u8 feature)
+unsigned int ata_dev_set_feature(struct ata_device *dev, u8 enable, u8 feature)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
@@ -6720,6 +6784,7 @@ EXPORT_SYMBOL_GPL(sata_set_spd);
 EXPORT_SYMBOL_GPL(ata_wait_after_reset);
 EXPORT_SYMBOL_GPL(sata_link_debounce);
 EXPORT_SYMBOL_GPL(sata_link_resume);
+EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 1471462..65b6a73 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -86,6 +86,8 @@ extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 extern int ata_dev_configure(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
+extern unsigned int ata_dev_set_feature(struct ata_device *dev,
+					u8 enable, u8 feature);
 extern void ata_sg_clean(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index acfb650..da71bb9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -950,6 +950,8 @@ extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
+extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+			     bool spm_wakeup);
 extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *));
-- 
1.7.1

