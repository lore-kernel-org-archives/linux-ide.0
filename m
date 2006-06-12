From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add host_set->next for legacy two host sets case
Date: Mon, 12 Jun 2006 14:17:27 +0900
Message-ID: <20060612051727.GD9166@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:56247 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751350AbWFLFRe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 01:17:34 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1553288nze
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 22:17:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

For a legacy ATA controller, libata registers two separate host sets.
There was no connection between the two hosts making it impossible to
traverse all ports related to the controller.  This patch adds
host_set->next which points to the second host_set and implements
ata_host_set_for_all_ports() which traverses all ports associated with
the controller.  This fixes the following bugs.

* On device removal, all ports hanging off the device are properly
  detached.  Prior to this patch, ports on the first host_set weren't
  detached casuing oops on driver unloading.

* On device removal, both host sets are freed

This will also be used by new power management code to suspend and
resume all ports of a controller.  host_set/port representation will
be improved to handle legacy controllers better and this host_set
linking hack will go away with it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |   15 +++++++++++++--
 drivers/scsi/libata-core.c  |   39 +++++++++++++++++++++++++++++++++------
 include/linux/libata.h      |    3 ++-
 3 files changed, 48 insertions(+), 9 deletions(-)

b1d1062e1b5b1de896b687118ed9a1926fd6f3b0
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 4bc0537..13fab97 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -1076,10 +1076,21 @@ int ata_pci_init_one (struct pci_dev *pd
 
 	/* FIXME: check ata_device_add return */
 	if (legacy_mode) {
-		if (legacy_mode & (1 << 0))
+		struct device *dev = &pdev->dev;
+		struct ata_host_set *host_set = NULL;
+
+		if (legacy_mode & (1 << 0)) {
 			ata_device_add(probe_ent);
-		if (legacy_mode & (1 << 1))
+			host_set = dev_get_drvdata(dev);
+		}
+
+		if (legacy_mode & (1 << 1)) {
 			ata_device_add(probe_ent2);
+			if (host_set) {
+				host_set->next = dev_get_drvdata(dev);
+				dev_set_drvdata(dev, host_set);
+			}
+		}
 	} else
 		ata_device_add(probe_ent);
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 014855e..357f253 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -94,6 +94,32 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 
+static struct ata_port *__ata_host_set_next_port(struct ata_port *ap,
+						 int *p_idx,
+						 struct ata_host_set *host_set)
+{
+	int idx = ++(*p_idx);
+
+	if (idx >= host_set->n_ports && host_set->next) {
+		idx -= host_set->n_ports;
+		host_set = host_set->next;
+	}
+
+	if (idx < host_set->n_ports)
+		return host_set->ports[idx];
+
+	return NULL;
+}
+
+/* No, it's not for_each_port.  The following macro traverses not only
+ * host_set->ports but also host_set->next->ports.  Don't use it
+ * unless you know what you're doing.  It will go away once legacy
+ * host handling is improved.
+ */
+#define ata_host_set_for_all_ports(ap, idx, host_set) \
+	for (ap = host_set->ports[0], idx = 0; ap; \
+	     ap = __ata_host_set_next_port(ap, &idx, host_set))
+
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
@@ -5510,16 +5536,15 @@ void ata_port_detach(struct ata_port *ap
 
 void ata_host_set_remove(struct ata_host_set *host_set)
 {
-	unsigned int i;
+	struct ata_port *ap;
+	int i;
 
-	for (i = 0; i < host_set->n_ports; i++)
-		ata_port_detach(host_set->ports[i]);
+	ata_host_set_for_all_ports(ap, i, host_set)
+		ata_port_detach(ap);
 
 	free_irq(host_set->irq, host_set);
 
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_port *ap = host_set->ports[i];
-
+	ata_host_set_for_all_ports(ap, i, host_set) {
 		ata_scsi_release(ap->host);
 
 		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
@@ -5537,6 +5562,8 @@ void ata_host_set_remove(struct ata_host
 	if (host_set->ops->host_stop)
 		host_set->ops->host_stop(host_set);
 
+	if (host_set->next)
+		kfree(host_set->next);
 	kfree(host_set);
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 61eea57..f03b866 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -356,7 +356,8 @@ struct ata_host_set {
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
-	struct ata_port *	ports[0];
+	struct ata_host_set	*next;		/* for legacy mode */
+	struct ata_port		*ports[0];
 };
 
 struct ata_queued_cmd {
-- 
1.3.2

