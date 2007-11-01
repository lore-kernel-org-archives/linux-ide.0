From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/8] libata: move ata_set_mode() to libata-eh.c
Date: Fri,  2 Nov 2007 00:51:40 +0900
Message-ID: <1193932305604-git-send-email-htejun@gmail.com>
References: <11939323042554-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:20824 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbXKAPvr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 11:51:47 -0400
In-Reply-To: <11939323042554-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move ata_set_mode() to libata-eh.c.  ata_set_mode() is surely an EH
action and will be more tightly coupled with the rest of error
handling.  Move it to libata-eh.c.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   25 -------------------------
 drivers/ata/libata-eh.c   |   25 +++++++++++++++++++++++++
 drivers/ata/libata.h      |    2 +-
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9b6e7b8..ec2cb60 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3028,31 +3028,6 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 }
 
 /**
- *	ata_set_mode - Program timings and issue SET FEATURES - XFER
- *	@link: link on which timings will be programmed
- *	@r_failed_dev: out paramter for failed device
- *
- *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).  If
- *	ata_set_mode() fails, pointer to the failing device is
- *	returned in @r_failed_dev.
- *
- *	LOCKING:
- *	PCI/etc. bus probe sem.
- *
- *	RETURNS:
- *	0 on success, negative errno otherwise
- */
-int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
-{
-	struct ata_port *ap = link->ap;
-
-	/* has private set_mode? */
-	if (ap->ops->set_mode)
-		return ap->ops->set_mode(link, r_failed_dev);
-	return ata_do_set_mode(link, r_failed_dev);
-}
-
-/**
  *	ata_tf_to_host - issue ATA taskfile to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 6280eae..c909022 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2372,6 +2372,31 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	return rc;
 }
 
+/**
+ *	ata_set_mode - Program timings and issue SET FEATURES - XFER
+ *	@link: link on which timings will be programmed
+ *	@r_failed_dev: out paramter for failed device
+ *
+ *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).  If
+ *	ata_set_mode() fails, pointer to the failing device is
+ *	returned in @r_failed_dev.
+ *
+ *	LOCKING:
+ *	PCI/etc. bus probe sem.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno otherwise
+ */
+int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
+{
+	struct ata_port *ap = link->ap;
+
+	/* has private set_mode? */
+	if (ap->ops->set_mode)
+		return ap->ops->set_mode(link, r_failed_dev);
+	return ata_do_set_mode(link, r_failed_dev);
+}
+
 static int ata_link_nr_enabled(struct ata_link *link)
 {
 	struct ata_device *dev;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 90df58a..45c8a7e 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -85,7 +85,6 @@ extern int ata_dev_configure(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_link *link);
 extern int sata_set_spd_needed(struct ata_link *link);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
-extern int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern void ata_sg_clean(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
@@ -177,6 +176,7 @@ extern void ata_eh_report(struct ata_port *ap);
 extern int ata_eh_reset(struct ata_link *link, int classify,
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset);
+extern int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset,
-- 
1.5.2.4

