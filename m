From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/27] libata: separate out ata_std_prereset() from ata_sff_prereset()
Date: Tue, 25 Mar 2008 22:16:48 +0900
Message-ID: <12064510272015-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:16439 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbYCYNRd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:33 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2257948wra.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:33 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Separate out generic ATA portion from ata_sff_prereset() into
ata_std_prereset() and implement ata_sff_prereset() using the std
version.  Waiting for device readiness is the only SFF specific part.

ata_base_port_ops now has ata_std_prereset() for its prereset and
ata_sff_port_ops overrides it to ata_sff_prereset().  This change can
affect pdc_adma, ahci, sata_fsl and sata_sil24.  pdc_adma implements
its own prereset using ata_sff_prereset() and the rest has hardreset
and thus are unaffected by this change.

This change reflects real world situation.  There is no generic way to
wait for device readiness for non-SFF controllers and some of them
don't have any mechanism for that.  Non-sff drivers which don't have
hardreset should wrap ata_std_prereset() and wait for device readiness
itself but there's no such driver now and isn't likely to be popular
in the future either.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   17 ++++-------------
 drivers/ata/libata-sff.c  |   43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |    1 +
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7126d6f..4446477 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -74,7 +74,7 @@ const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
 const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
 const struct ata_port_operations ata_base_port_ops = {
-	.prereset		= ata_sff_prereset,
+	.prereset		= ata_std_prereset,
 	.hardreset		= sata_sff_hardreset,
 	.postreset		= ata_sff_postreset,
 	.error_handler		= ata_std_error_handler,
@@ -3378,7 +3378,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 }
 
 /**
- *	ata_sff_prereset - prepare for reset
+ *	ata_std_prereset - prepare for reset
  *	@link: ATA link to be reset
  *	@deadline: deadline jiffies for the operation
  *
@@ -3394,7 +3394,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
+int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
@@ -3414,16 +3414,6 @@ int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
 					"link for reset (errno=%d)\n", rc);
 	}
 
-	/* wait for !BSY if we don't know that no device is attached */
-	if (!ata_link_offline(link)) {
-		rc = ata_sff_wait_ready(ap, deadline);
-		if (rc && rc != -ENODEV) {
-			ata_link_printk(link, KERN_WARNING, "device not ready "
-					"(errno=%d), forcing hardreset\n", rc);
-			ehc->i.action |= ATA_EH_HARDRESET;
-		}
-	}
-
 	return 0;
 }
 
@@ -6051,6 +6041,7 @@ EXPORT_SYMBOL_GPL(ata_dev_disable);
 EXPORT_SYMBOL_GPL(sata_set_spd);
 EXPORT_SYMBOL_GPL(sata_link_debounce);
 EXPORT_SYMBOL_GPL(sata_link_resume);
+EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index c116016..9234bc0 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -47,6 +47,7 @@ const struct ata_port_operations ata_sff_port_ops = {
 
 	.freeze			= ata_sff_freeze,
 	.thaw			= ata_sff_thaw,
+	.prereset		= ata_sff_prereset,
 	.softreset		= ata_sff_softreset,
 	.error_handler		= ata_sff_error_handler,
 	.post_internal_cmd	= ata_sff_post_internal_cmd,
@@ -1607,6 +1608,48 @@ void ata_sff_thaw(struct ata_port *ap)
 }
 
 /**
+ *	ata_sff_prereset - prepare SFF link for reset
+ *	@link: SFF link to be reset
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	SFF link @link is about to be reset.  Initialize it.  It first
+ *	calls ata_std_prereset() and wait for !BSY if the port is
+ *	being softreset.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct ata_eh_context *ehc = &link->eh_context;
+	int rc;
+
+	rc = ata_std_prereset(link, deadline);
+	if (rc)
+		return rc;
+
+	/* if we're about to do hardreset, nothing more to do */
+	if (ehc->i.action & ATA_EH_HARDRESET)
+		return 0;
+
+	/* wait for !BSY if we don't know that no device is attached */
+	if (!ata_link_offline(link)) {
+		rc = ata_sff_wait_ready(ap, deadline);
+		if (rc && rc != -ENODEV) {
+			ata_link_printk(link, KERN_WARNING, "device not ready "
+					"(errno=%d), forcing hardreset\n", rc);
+			ehc->i.action |= ATA_EH_HARDRESET;
+		}
+	}
+
+	return 0;
+}
+
+/**
  *	ata_devchk - PATA device presence detection
  *	@ap: ATA channel to examine
  *	@device: Device to examine (starting at zero)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fad7952..fa138fd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -822,6 +822,7 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
 extern void sata_print_link_status(struct ata_link *link);
 extern void ata_port_probe(struct ata_port *);
 extern int sata_set_spd(struct ata_link *link);
+extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
-- 
1.5.2.4

