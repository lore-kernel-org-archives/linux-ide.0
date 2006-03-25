From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] libata: implement ata_dev_enabled, disabled and present()
Date: Sat, 25 Mar 2006 09:53:05 +0900
Message-ID: <20060325005305.GD5288@htj.dyndns.org>
References: <11431815313764-git-send-email-htejun@gmail.com> <44240A67.7030001@pobox.com> <1143215493.18986.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:27951 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751248AbWCYAxL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 19:53:11 -0500
Received: by pproxy.gmail.com with SMTP id w49so841807pyg
        for <linux-ide@vger.kernel.org>; Fri, 24 Mar 2006 16:53:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1143215493.18986.11.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

This patch renames ata_dev_present() to ata_dev_enabled() and adds
ata_dev_disabled() and ata_dev_present().  This is to discern the
state where a device is present but disabled from not-present state.
This disctinction is necessary when configuring transfer mode because
device selection timing must not be violated even if a device fails to
configures.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

More explanation in the next patch.

 drivers/scsi/libata-core.c |   24 ++++++++++++------------
 drivers/scsi/libata-scsi.c |    4 ++--
 drivers/scsi/sata_mv.c     |    2 +-
 drivers/scsi/sata_sil.c    |    2 +-
 include/linux/libata.h     |   22 +++++++++++++++++++++-
 5 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 516b1a6..f3277f8 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -397,7 +397,7 @@ static const char *ata_mode_string(unsig
 
 static void ata_dev_disable(struct ata_port *ap, struct ata_device *dev)
 {
-	if (ata_dev_present(dev)) {
+	if (ata_dev_enabled(dev)) {
 		printk(KERN_WARNING "ata%u: dev %u disabled\n",
 		       ap->id, dev->devno);
 		dev->class++;
@@ -1210,7 +1210,7 @@ static int ata_dev_configure(struct ata_
 	unsigned int xfer_mask;
 	int i, rc;
 
-	if (!ata_dev_present(dev)) {
+	if (!ata_dev_enabled(dev)) {
 		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
 			ap->id, dev->devno);
 		return 0;
@@ -1389,7 +1389,7 @@ static int ata_bus_probe(struct ata_port
 
 		dev->class = classes[i];
 
-		if (!ata_dev_present(dev))
+		if (!ata_dev_enabled(dev))
 			continue;
 
 		WARN_ON(dev->id != NULL);
@@ -1556,7 +1556,7 @@ void sata_phy_reset(struct ata_port *ap)
 struct ata_device *ata_dev_pair(struct ata_port *ap, struct ata_device *adev)
 {
 	struct ata_device *pair = &ap->device[1 - adev->devno];
-	if (!ata_dev_present(pair))
+	if (!ata_dev_enabled(pair))
 		return NULL;
 	return pair;
 }
@@ -1769,7 +1769,7 @@ static int ata_host_set_pio(struct ata_p
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 
-		if (!ata_dev_present(dev))
+		if (!ata_dev_enabled(dev))
 			continue;
 
 		if (!dev->pio_mode) {
@@ -1793,7 +1793,7 @@ static void ata_host_set_dma(struct ata_
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 
-		if (!ata_dev_present(dev) || !dev->dma_mode)
+		if (!ata_dev_enabled(dev) || !dev->dma_mode)
 			continue;
 
 		dev->xfer_mode = dev->dma_mode;
@@ -1821,7 +1821,7 @@ static void ata_set_mode(struct ata_port
 		struct ata_device *dev = &ap->device[i];
 		unsigned int pio_mask, dma_mask;
 
-		if (!ata_dev_present(dev))
+		if (!ata_dev_enabled(dev))
 			continue;
 
 		ata_dev_xfermask(ap, dev);
@@ -1846,7 +1846,7 @@ static void ata_set_mode(struct ata_port
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 
-		if (!ata_dev_present(dev))
+		if (!ata_dev_enabled(dev))
 			continue;
 
 		if (ata_dev_set_mode(ap, dev))
@@ -2523,7 +2523,7 @@ int ata_dev_revalidate(struct ata_port *
 	u16 *id;
 	int rc;
 
-	if (!ata_dev_present(dev))
+	if (!ata_dev_enabled(dev))
 		return -ENODEV;
 
 	class = dev->class;
@@ -2647,7 +2647,7 @@ static void ata_dev_xfermask(struct ata_
 	/* use port-wide xfermask for now */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *d = &ap->device[i];
-		if (!ata_dev_present(d))
+		if (!ata_dev_enabled(d))
 			continue;
 		xfer_mask &= ata_pack_xfermask(d->pio_mask, d->mwdma_mask,
 					       d->udma_mask);
@@ -4256,7 +4256,7 @@ int ata_device_resume(struct ata_port *a
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
 	}
-	if (!ata_dev_present(dev))
+	if (!ata_dev_enabled(dev))
 		return 0;
 	if (dev->class == ATA_DEV_ATA)
 		ata_start_drive(ap, dev);
@@ -4274,7 +4274,7 @@ int ata_device_resume(struct ata_port *a
  */
 int ata_device_suspend(struct ata_port *ap, struct ata_device *dev, pm_message_t state)
 {
-	if (!ata_dev_present(dev))
+	if (!ata_dev_enabled(dev))
 		return 0;
 	if (dev->class == ATA_DEV_ATA)
 		ata_flush_cache(ap, dev);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 628191b..a117f98 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2353,7 +2353,7 @@ ata_scsi_find_dev(struct ata_port *ap, c
 		     (scsidev->lun != 0)))
 		return NULL;
 
-	if (unlikely(!ata_dev_present(dev)))
+	if (unlikely(!ata_dev_enabled(dev)))
 		return NULL;
 
 	if (!atapi_enabled || (ap->flags & ATA_FLAG_NO_ATAPI)) {
@@ -2747,7 +2747,7 @@ void ata_scsi_scan_host(struct ata_port 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		dev = &ap->device[i];
 
-		if (ata_dev_present(dev))
+		if (ata_dev_enabled(dev))
 			scsi_scan_target(&ap->host->shost_gendev, 0, i, 0, 0);
 	}
 }
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 275ed9b..bbe4ddc 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1985,7 +1985,7 @@ comreset_retry:
 	tf.nsect = readb((void __iomem *) ap->ioaddr.nsect_addr);
 
 	dev->class = ata_dev_classify(&tf);
-	if (!ata_dev_present(dev)) {
+	if (!ata_dev_enabled(dev)) {
 		VPRINTK("Port disabled post-sig: No device present.\n");
 		ata_port_disable(ap);
 	}
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 18c296c..d6c7086 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -264,7 +264,7 @@ static void sil_post_set_mode (struct at
 
 	for (i = 0; i < 2; i++) {
 		dev = &ap->device[i];
-		if (!ata_dev_present(dev))
+		if (!ata_dev_enabled(dev))
 			dev_mode[i] = 0;	/* PIO0/1/2 */
 		else if (dev->flags & ATA_DFLAG_PIO)
 			dev_mode[i] = 1;	/* PIO3/4 */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9fcc061..1d16293 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -663,11 +663,31 @@ static inline unsigned int ata_tag_valid
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
 }
 
-static inline unsigned int ata_class_present(unsigned int class)
+static inline unsigned int ata_class_enabled(unsigned int class)
 {
 	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI;
 }
 
+static inline unsigned int ata_class_disabled(unsigned int class)
+{
+	return class == ATA_DEV_ATA_UNSUP || class == ATA_DEV_ATAPI_UNSUP;
+}
+
+static inline unsigned int ata_class_present(unsigned int class)
+{
+	return ata_class_enabled(class) || ata_class_disabled(class);
+}
+
+static inline unsigned int ata_dev_enabled(const struct ata_device *dev)
+{
+	return ata_class_enabled(dev->class);
+}
+
+static inline unsigned int ata_dev_disabled(const struct ata_device *dev)
+{
+	return ata_class_disabled(dev->class);
+}
+
 static inline unsigned int ata_dev_present(const struct ata_device *dev)
 {
 	return ata_class_present(dev->class);
