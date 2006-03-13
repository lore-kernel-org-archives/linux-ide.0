From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: implement ata_dev_init()
Date: Mon, 13 Mar 2006 15:19:26 +0900
Message-ID: <20060313061926.GA30429@htj.dyndns.org>
References: <11421469551948-git-send-email-htejun@gmail.com> <11421469552851-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:14093 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751430AbWCMGTb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 01:19:31 -0500
Received: by pproxy.gmail.com with SMTP id d42so815109pyd
        for <linux-ide@vger.kernel.org>; Sun, 12 Mar 2006 22:19:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <11421469552851-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Implement ata_dev_init() which is called before probing for new
device.  Note that ata_dev_init() is called only once for each
attached device while ata_dev_configure() can be called multiple times
for the same device.

This change will be used by following per-dev xfer_mask patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

fix-class-handling-in-ata_bus_probe[1] patch clashes with this one.
So, this is the regenerated patch.  All others apply fine with offets.

[1] http://article.gmane.org/gmane.linux.ide/8712

 libata-core.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2006-03-13 14:52:17.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2006-03-13 14:52:57.000000000 +0900
@@ -1045,6 +1045,25 @@ unsigned int ata_pio_need_iordy(const st
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
@@ -1371,8 +1390,10 @@ static int ata_bus_probe(struct ata_port
 	ata_port_probe(ap);
 
 	/* reset and determine device classes */
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		ata_dev_init(ap, &ap->device[i]);
 		classes[i] = ATA_DEV_UNKNOWN;
+	}
 
 	if (ap->ops->probe_reset) {
 		rc = ap->ops->probe_reset(ap, classes);
@@ -4607,8 +4628,6 @@ static void ata_host_init(struct ata_por
 			  struct ata_host_set *host_set,
 			  const struct ata_probe_ent *ent, unsigned int port_no)
 {
-	unsigned int i;
-
 	host->max_id = 16;
 	host->max_lun = 1;
 	host->max_channel = 1;
@@ -4635,9 +4654,6 @@ static void ata_host_init(struct ata_por
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->device[i].devno = i;
-
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
 	ap->stats.idle_irq = 1;
