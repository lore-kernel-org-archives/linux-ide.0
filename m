From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/13] libata: separate out ata_dev_reread_id()
Date: Mon, 23 Apr 2007 02:41:05 +0900
Message-ID: <11772636651116-git-send-email-htejun@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:40595 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbXDVRlM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:41:12 -0400
Received: by an-out-0708.google.com with SMTP id b33so1535304ana
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 10:41:11 -0700 (PDT)
In-Reply-To: <11772636651400-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out ata_dev_reread_id() from ata_dev_revalidate().
ata_dev_reread_id() reads IDENTIFY page and determines whether the
same device is still there.  ata_dev_revalidate() reconfigures after
reread completes.  This will be used by ACPI update.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   47 ++++++++++++++++++++++++++++++++------------
 drivers/ata/libata.h      |    3 +-
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6d0a946..7a6e8fd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3562,8 +3562,8 @@ static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
 }
 
 /**
- *	ata_dev_revalidate - Revalidate ATA device
- *	@dev: device to revalidate
+ *	ata_dev_reread_id - Re-read IDENTIFY data
+ *	@adev: target ATA device
  *	@readid_flags: read ID flags
  *
  *	Re-read IDENTIFY page and make sure @dev is still attached to
@@ -3575,29 +3575,50 @@ static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
  *	RETURNS:
  *	0 on success, negative errno otherwise
  */
-int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
+int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags)
 {
 	unsigned int class = dev->class;
 	u16 *id = (void *)dev->ap->sector_buf;
 	int rc;
 
-	if (!ata_dev_enabled(dev)) {
-		rc = -ENODEV;
-		goto fail;
-	}
-
 	/* read ID data */
 	rc = ata_dev_read_id(dev, &class, readid_flags, id);
 	if (rc)
-		goto fail;
+		return rc;
 
 	/* is the device still there? */
-	if (!ata_dev_same_device(dev, class, id)) {
-		rc = -ENODEV;
-		goto fail;
-	}
+	if (!ata_dev_same_device(dev, class, id))
+		return -ENODEV;
 
 	memcpy(dev->id, id, sizeof(id[0]) * ATA_ID_WORDS);
+	return 0;
+}
+
+/**
+ *	ata_dev_revalidate - Revalidate ATA device
+ *	@dev: device to revalidate
+ *	@readid_flags: read ID flags
+ *
+ *	Re-read IDENTIFY page, make sure @dev is still attached to the
+ *	port and reconfigure it according to the new IDENTIFY page.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, negative errno otherwise
+ */
+int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags)
+{
+	int rc;
+
+	if (!ata_dev_enabled(dev))
+		return -ENODEV;
+
+	/* re-read ID */
+	rc = ata_dev_reread_id(dev, readid_flags);
+	if (rc)
+		goto fail;
 
 	/* configure device according to the new ID */
 	rc = ata_dev_configure(dev);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5f4d40c..c40665a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -75,7 +75,8 @@ extern unsigned ata_exec_internal_sg(struct ata_device *dev,
 extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   unsigned int flags, u16 *id);
-extern int ata_dev_revalidate(struct ata_device *dev, unsigned int flags);
+extern int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags);
+extern int ata_dev_revalidate(struct ata_device *dev, unsigned int readid_flags);
 extern int ata_dev_configure(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
-- 
1.5.0.3


