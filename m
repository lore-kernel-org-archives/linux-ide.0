From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/9] libata: separate out ata_dev_reread_id()
Date: Tue, 15 May 2007 03:28:15 +0900
Message-ID: <11791672951781-git-send-email-htejun@gmail.com>
References: <11791672953697-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11791672953697-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

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
index 4166407..6f266c8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3675,8 +3675,8 @@ static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
 }
 
 /**
- *	ata_dev_revalidate - Revalidate ATA device
- *	@dev: device to revalidate
+ *	ata_dev_reread_id - Re-read IDENTIFY data
+ *	@adev: target ATA device
  *	@readid_flags: read ID flags
  *
  *	Re-read IDENTIFY page and make sure @dev is still attached to
@@ -3688,29 +3688,50 @@ static int ata_dev_same_device(struct ata_device *dev, unsigned int new_class,
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
index 8b71b73..13cb0c9 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -76,7 +76,8 @@ extern unsigned ata_exec_internal_sg(struct ata_device *dev,
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


