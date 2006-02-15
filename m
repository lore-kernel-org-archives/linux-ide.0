From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: implement ata_dev_revalidate()
Date: Wed, 15 Feb 2006 19:02:45 +0900
Message-ID: <11399977652043-git-send-email-htejun@gmail.com>
References: <11399977652752-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:7991 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751080AbWBOKCt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 05:02:49 -0500
Received: by zproxy.gmail.com with SMTP id z3so1534682nzf
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 02:02:48 -0800 (PST)
In-Reply-To: <11399977652752-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_revalidate() re-reads IDENTIFY PAGE of the given device and
makes sure it's the same device as the configured one.  Once it's
verified that it's the same device, @dev is configured according to
newly read IDENTIFY PAGE.  Note that revalidation currently doesn't
invoke transfer mode reconfiguration.

Criteria for 'same device'

* same class (of course)
* same model string
* same serial string
* if ATA, same n_sectors (to catch geometry parameter changes)

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  115 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    2 +
 2 files changed, 117 insertions(+), 0 deletions(-)

95213b21c681afd2eef1e5cbae21337208ac4c46
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 05dadf5..54ed8fd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2341,6 +2341,120 @@ int ata_drive_probe_reset(struct ata_por
 	return rc;
 }
 
+/**
+ *	ata_dev_same_device - Determine whether new ID matches configured device
+ *	@ap: port on which the device to compare against resides
+ *	@dev: device to compare against
+ *	@new_class: class of the new device
+ *	@new_id: IDENTIFY page of the new device
+ *
+ *	Compare @new_class and @new_id against @dev and determine
+ *	whether @dev is the device indicated by @new_class and
+ *	@new_id.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	1 if @dev matches @new_class and @new_id, 0 otherwise.
+ */
+static int ata_dev_same_device(struct ata_port *ap, struct ata_device *dev,
+			       unsigned int new_class, const u16 *new_id)
+{
+	const u16 *old_id = dev->id;
+	unsigned char model[2][41], serial[2][21];
+	u64 new_n_sectors;
+
+	if (dev->class != new_class) {
+		printk(KERN_WARNING
+		       "ata%u: dev %u class mismatch %d != %d\n",
+		       ap->id, dev->devno, dev->class, new_class);
+		return 0;
+	}
+
+	ata_id_c_string(old_id, model[0], ATA_ID_PROD_OFS, sizeof(model[0]));
+	ata_id_c_string(new_id, model[1], ATA_ID_PROD_OFS, sizeof(model[1]));
+	ata_id_c_string(old_id, serial[0], ATA_ID_SERNO_OFS, sizeof(serial[0]));
+	ata_id_c_string(new_id, serial[1], ATA_ID_SERNO_OFS, sizeof(serial[1]));
+	new_n_sectors = ata_id_n_sectors(new_id);
+
+	if (strcmp(model[0], model[1])) {
+		printk(KERN_WARNING
+		       "ata%u: dev %u model number mismatch '%s' != '%s'\n",
+		       ap->id, dev->devno, model[0], model[1]);
+		return 0;
+	}
+
+	if (strcmp(serial[0], serial[1])) {
+		printk(KERN_WARNING
+		       "ata%u: dev %u serial number mismatch '%s' != '%s'\n",
+		       ap->id, dev->devno, serial[0], serial[1]);
+		return 0;
+	}
+
+	if (dev->class == ATA_DEV_ATA && dev->n_sectors != new_n_sectors) {
+		printk(KERN_WARNING
+		       "ata%u: dev %u n_sectors mismatch %llu != %llu\n",
+		       ap->id, dev->devno, (unsigned long long)dev->n_sectors,
+		       (unsigned long long)new_n_sectors);
+		return 0;
+	}
+
+	return 1;
+}
+
+/**
+ *	ata_dev_revalidate - Revalidate ATA device
+ *	@ap: port on which the device to revalidate resides
+ *	@dev: device to revalidate
+ *	@post_reset: is this revalidation after reset?
+ *
+ *	Re-read IDENTIFY page and make sure @dev is still attached to
+ *	the port.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, negative errno otherwise
+ */
+int ata_dev_revalidate(struct ata_port *ap, struct ata_device *dev,
+		       int post_reset)
+{
+	unsigned int class;
+	u16 *id;
+	int rc;
+
+	if (!ata_dev_present(dev))
+		return 0;
+
+	class = dev->class;
+	id = NULL;
+
+	/* allocate & read ID data */
+	rc = ata_dev_read_id(ap, dev, &class, post_reset, &id);
+	if (rc)
+		goto fail;
+
+	/* is the device still there? */
+	if (!ata_dev_same_device(ap, dev, class, id)) {
+		rc = -ENODEV;
+		goto fail;
+	}
+
+	kfree(dev->id);
+	dev->id = id;
+
+	/* configure device according to the new ID */
+	return ata_dev_configure(ap, dev, 0);
+
+ fail:
+	printk(KERN_ERR "ata%u: dev %u revalidation failed (errno=%d)\n",
+	       ap->id, dev->devno, rc);
+	kfree(id);
+	return rc;
+}
+
 static void ata_pr_blacklisted(const struct ata_port *ap,
 			       const struct ata_device *dev)
 {
@@ -4956,6 +5070,7 @@ EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(ata_std_probe_reset);
 EXPORT_SYMBOL_GPL(ata_drive_probe_reset);
+EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
 EXPORT_SYMBOL_GPL(ata_busy_sleep);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e8e02a0..81014be 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -485,6 +485,8 @@ extern int ata_std_softreset(struct ata_
 extern int sata_std_hardreset(struct ata_port *ap, int verbose,
 			      unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
+extern int ata_dev_revalidate(struct ata_port *ap, struct ata_device *dev,
+			      int post_reset);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
-- 
1.1.5


