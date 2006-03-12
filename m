From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: implement ata_dev_init()
Date: Sun, 12 Mar 2006 16:02:35 +0900
Message-ID: <11421469552851-git-send-email-htejun@gmail.com>
References: <11421469551948-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:31391 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751478AbWCLHCk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 02:02:40 -0500
Received: by zproxy.gmail.com with SMTP id 14so1067450nzn
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 23:02:40 -0800 (PST)
In-Reply-To: <11421469551948-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_dev_init() which is called before probing for new
device.  Note that ata_dev_init() is called only once for each
attached device while ata_dev_configure() can be called multiple times
for the same device.

This change will be used by following per-dev xfer_mask patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   33 +++++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 8 deletions(-)

85ebfaba5b9f0c02afa9a3a2bde8eb6bf14380d4
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 96954c7..eef67f5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1042,6 +1042,25 @@ unsigned int ata_pio_need_iordy(const st
 }
 
 /**
+ *	ata_dev_init - initialize ata_device structure
+ *	@ap: Port on which target device resides
+ *	@dev: Target device to initialize
+ *
+ *	Initialize @dev in preparation for device probing.  This
+ *	function is called only when a new device is about to be
+ *	probed.  ie. ata_dev_configure() is responsible for cleaning
+ *	up affected fields across revalidations.
+ *
+ *	LOCKING:
+ *	none.
+ */
+static void ata_dev_init(struct ata_port *ap, struct ata_device *dev)
+{
+	memset(dev, 0, sizeof(*dev));
+	dev->devno = dev - ap->device;
+}
+
+/**
  *	ata_dev_read_id - Read ID data from the specified device
  *	@ap: port on which target device resides
  *	@dev: target device
@@ -1367,11 +1386,14 @@ static int ata_bus_probe(struct ata_port
 
 	ata_port_probe(ap);
 
+	/* initialize devices and classes */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		ata_dev_init(ap, &ap->device[i]);
+		classes[i] = ATA_DEV_UNKNOWN;
+	}
+
 	/* reset */
 	if (ap->ops->probe_reset) {
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			classes[i] = ATA_DEV_UNKNOWN;
-
 		rc = ap->ops->probe_reset(ap, classes);
 		if (rc) {
 			printk("ata%u: reset failed (errno=%d)\n", ap->id, rc);
@@ -4606,8 +4628,6 @@ static void ata_host_init(struct ata_por
 			  struct ata_host_set *host_set,
 			  const struct ata_probe_ent *ent, unsigned int port_no)
 {
-	unsigned int i;
-
 	host->max_id = 16;
 	host->max_lun = 1;
 	host->max_channel = 1;
@@ -4634,9 +4654,6 @@ static void ata_host_init(struct ata_por
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->device[i].devno = i;
-
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
 	ap->stats.idle_irq = 1;
-- 
1.2.4


