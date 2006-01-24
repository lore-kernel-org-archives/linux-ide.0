From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/12] libata: implement ata_drive_probe_reset()
Date: Tue, 24 Jan 2006 17:05:22 +0900
Message-ID: <11380899221448-git-send-email-htejun@gmail.com>
References: <1138089921565-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:55317 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030233AbWAXIF1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 03:05:27 -0500
Received: by wproxy.gmail.com with SMTP id 57so1047990wri
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 00:05:26 -0800 (PST)
In-Reply-To: <1138089921565-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Most low level drivers share supported reset/classify actions and
sequence.  This patch implements ata_drive_probe_reset() which helps
constructing ->probe_reset from three component operations -
softreset, hardreset and postreset.  This minimizes duplicate code and
yet allows flexibility if needed. The three component operations can
also be shared by EH later.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   89 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    5 ++
 2 files changed, 94 insertions(+), 0 deletions(-)

a0161772ae1a16f1a4ffb5f830752ccc3bf44e9f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c70151a..48aa57e 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2280,6 +2280,94 @@ err_out:
 	DPRINTK("EXIT\n");
 }
 
+static int do_probe_reset(struct ata_port *ap, ata_reset_fn_t reset,
+			  ata_postreset_fn_t postreset,
+			  unsigned int *classes)
+{
+	int i, rc;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		classes[i] = ATA_DEV_UNKNOWN;
+
+	rc = reset(ap, 0, classes);
+	if (rc)
+		return rc;
+
+	/* If any class isn't ATA_DEV_UNKNOWN, consider classification
+	 * is complete and convert all ATA_DEV_UNKNOWN to
+	 * ATA_DEV_NONE.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (classes[i] != ATA_DEV_UNKNOWN)
+			break;
+
+	if (i < ATA_MAX_DEVICES)
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			if (classes[i] == ATA_DEV_UNKNOWN)
+				classes[i] = ATA_DEV_NONE;
+
+	if (postreset)
+		postreset(ap, classes);
+
+	return classes[0] != ATA_DEV_UNKNOWN ? 0 : -ENODEV;
+}
+
+/**
+ *	ata_drive_probe_reset - Perform probe reset with given methods
+ *	@ap: port to reset
+ *	@softreset: softreset method (can be NULL)
+ *	@hardreset: hardreset method (can be NULL)
+ *	@postreset: postreset method (can be NULL)
+ *	@classes: resulting classes of attached devices
+ *
+ *	Reset the specified port and classify attached devices using
+ *	given methods.  This function prefers softreset but tries all
+ *	possible reset sequences to reset and classify devices.  This
+ *	function is intended to be used for constructing ->probe_reset
+ *	callback by low level drivers.
+ *
+ *	Reset methods should follow the following rules.
+ *
+ *	- Return 0 on sucess, -errno on failure.
+ *	- If classification is supported, fill classes[] with
+ *	  recognized class codes.
+ *	- If classification is not supported, leave classes[] alone.
+ *	- If verbose is non-zero, print error message on failure;
+ *	  otherwise, shut up.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -EINVAL if no reset method is avaliable, -ENODEV
+ *	if classification fails, and any error code from reset
+ *	methods.
+ */
+int ata_drive_probe_reset(struct ata_port *ap,
+			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+			  ata_postreset_fn_t postreset, unsigned int *classes)
+{
+	int rc = -EINVAL;
+
+	if (softreset) {
+		rc = do_probe_reset(ap, softreset, postreset, classes);
+		if (rc == 0)
+			return 0;
+	}
+
+	if (!hardreset)
+		return rc;
+
+	rc = do_probe_reset(ap, hardreset, postreset, classes);
+	if (rc == 0 || rc != -ENODEV)
+		return rc;
+
+	if (softreset)
+		rc = do_probe_reset(ap, softreset, postreset, classes);
+
+	return rc;
+}
+
 static void ata_pr_blacklisted(const struct ata_port *ap,
 			       const struct ata_device *dev)
 {
@@ -5220,6 +5308,7 @@ EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
+EXPORT_SYMBOL_GPL(ata_drive_probe_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
 EXPORT_SYMBOL_GPL(ata_busy_sleep);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6f36d9a..3d7392e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -244,6 +244,8 @@ struct ata_queued_cmd;
 
 /* typedefs */
 typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
+typedef int (*ata_reset_fn_t)(struct ata_port *, int, unsigned int *);
+typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -481,6 +483,9 @@ extern void ata_port_probe(struct ata_po
 extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
+extern int ata_drive_probe_reset(struct ata_port *ap,
+			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+			ata_postreset_fn_t postreset, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
-- 
1.1.3


