From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/8] libata: move ata_set_mode() to libata-eh.c
Date: Mon,  5 Nov 2007 14:45:11 +0900
Message-ID: <11942415162838-git-send-email-htejun@gmail.com>
References: <1194241515653-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:23587 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbXKEFpV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Nov 2007 00:45:21 -0500
In-Reply-To: <1194241515653-git-send-email-htejun@gmail.com>
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
index 164c7d9..0f02a07 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3234,31 +3234,6 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
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
index a37be1e..ae03201 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2392,6 +2392,31 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
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
index 0e6cf3a..9e9a2a9 100644
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
@@ -179,6 +178,7 @@ extern void ata_eh_report(struct ata_port *ap);
 extern int ata_eh_reset(struct ata_link *link, int classify,
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset);
+extern int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset,
-- 
1.5.2.4

