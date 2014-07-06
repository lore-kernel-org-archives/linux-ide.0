From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v2 1/2] libata: introduce ata_host_set_queue_depth()
Date: Sun,  6 Jul 2014 14:28:40 +0800
Message-ID: <1404628121-8158-2-git-send-email-haokexin@gmail.com>
References: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:41183 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbaGFG3m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2014 02:29:42 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so3710360pdb.39
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2014 23:29:42 -0700 (PDT)
In-Reply-To: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
("libata/ahci: accommodate tag ordered controllers"). The reason is
that the ata controller on this SoC only implement a queue depth of
16. When issuing the commands in tag order, all the commands in tag
16 ~ 17 are mapped to tag 0 unconditionally and then causes the sata
malfunction. It makes no senses to use a 32 queue in software while
the hardware has less queue depth. This patch provides the function
for libata to adjust the queue depth for a host controller.

Fixes: 8a4aeec8d2d6 ("libata/ahci: accommodate tag ordered controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Remove the changes for the ata tag helper functions.

 drivers/ata/libata-core.c | 29 ++++++++++++++++++++++++++---
 include/linux/libata.h    |  3 +++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8f3043165048..c9c51646d8e8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4728,14 +4728,14 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = NULL;
-	unsigned int i, tag;
+	unsigned int i, tag, max_queue = ap->host->queue_depth;
 
 	/* no command while frozen */
 	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
 		return NULL;
 
-	for (i = 0; i < ATA_MAX_QUEUE; i++) {
-		tag = (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
+	for (i = 0; i < max_queue; i++) {
+		tag = (i + ap->last_tag + 1) % max_queue;
 
 		/* the last tag is reserved for internal command. */
 		if (tag == ATA_TAG_INTERNAL)
@@ -5687,6 +5687,27 @@ static void ata_host_release(struct device *gendev, void *res)
 }
 
 /**
+ *	ata_host_set_queue_depth - set the ATA host controller's queue depth
+ *	@host: ATA host to be set for
+ *	@queue_depth: the queue depth implemented on this host controller
+ *
+ *	We would assume that the ATA host controller has 32 queue depth and
+ *	then set the host->queue_depth to 32 by default. If this is not true
+ *	for one specific ATA host controller, you need to invoke this function
+ *	to set the correct value.
+ */
+int ata_host_set_queue_depth(struct ata_host *host, unsigned int queue_depth)
+{
+	if (!queue_depth || queue_depth > ATA_MAX_QUEUE) {
+		dev_err(host->dev, "Invalid queue depth\n");
+		return -EINVAL;
+	}
+
+	host->queue_depth = queue_depth;
+	return 0;
+}
+
+/**
  *	ata_host_alloc - allocate and init basic ATA host resources
  *	@dev: generic device this host is associated with
  *	@max_ports: maximum number of ATA ports associated with this host
@@ -5731,6 +5752,7 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	mutex_init(&host->eh_mutex);
 	host->dev = dev;
 	host->n_ports = max_ports;
+	host->queue_depth = ATA_MAX_QUEUE;
 
 	/* allocate ports bound to this host */
 	for (i = 0; i < max_ports; i++) {
@@ -6855,6 +6877,7 @@ EXPORT_SYMBOL_GPL(ata_dev_next);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_scsi_unlock_native_capacity);
 EXPORT_SYMBOL_GPL(ata_host_init);
+EXPORT_SYMBOL_GPL(ata_host_set_queue_depth);
 EXPORT_SYMBOL_GPL(ata_host_alloc);
 EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
 EXPORT_SYMBOL_GPL(ata_slave_link_init);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5ab4e3a76721..3d912845f7df 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -593,6 +593,7 @@ struct ata_host {
 	struct device 		*dev;
 	void __iomem * const	*iomap;
 	unsigned int		n_ports;
+	unsigned int		queue_depth;
 	void			*private_data;
 	struct ata_port_operations *ops;
 	unsigned long		flags;
@@ -1104,6 +1105,8 @@ extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline);
 extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 
+extern int ata_host_set_queue_depth(struct ata_host *host,
+					unsigned int queue_depth);
 extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
 extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 			const struct ata_port_info * const * ppi, int n_ports);
-- 
1.9.3

