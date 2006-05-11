From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/14] libata-link: implement and use link/device iterators
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <1147365023751-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:49436 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751870AbWEKQak (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:40 -0400
Received: by nf-out-0910.google.com with SMTP id g2so145743nfe
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:38 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Multiple links and different number of devices per link should be
considered to iterate over links and devices.  This patch implements
and uses link and device iterators - ata_port_for_each_link() and
ata_link_for_each_dev() - and ata_link_max_devices().

This change makes a lot of functions iterate over only possible
devices instead of from dev 0 to dev ATA_MAX_DEVICES.  All such
changes have been examined and nothing should be broken.

While at it, add a separating comment before device helpers to
distinguish them better from link helpers and others.

---

 drivers/scsi/libata-core.c |   71 +++++++++++++++++++------------------------
 drivers/scsi/libata-eh.c   |   72 +++++++++++++++++++++-----------------------
 drivers/scsi/libata-scsi.c |   10 +++---
 include/linux/libata.h     |   22 +++++++++++++
 4 files changed, 93 insertions(+), 82 deletions(-)

c3d11a19666ed32115710146ec33e24cb9336b7e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e132e47..501a752 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1313,8 +1313,9 @@ int ata_dev_configure(struct ata_device 
 {
 	struct ata_port *ap = dev->link->ap;
 	const u16 *id = dev->id;
+	struct ata_device *tdev;
 	unsigned int xfer_mask;
-	int i, rc;
+	int rc;
 
 	if (!ata_dev_enabled(dev)) {
 		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
@@ -1435,10 +1436,11 @@ int ata_dev_configure(struct ata_device 
 	}
 
 	ap->host->max_cmd_len = 0;
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
+	ata_link_for_each_dev(tdev, dev->link) {
 		ap->host->max_cmd_len = max_t(unsigned int,
 					      ap->host->max_cmd_len,
-					      ap->link.device[i].cdb_len);
+					      tdev->cdb_len);
+	}
 
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
@@ -1479,13 +1481,13 @@ static int ata_bus_probe(struct ata_port
 {
 	unsigned int classes[ATA_MAX_DEVICES];
 	int tries[ATA_MAX_DEVICES];
-	int i, rc, down_xfermask;
+	int rc, down_xfermask;
 	struct ata_device *dev;
 
 	ata_port_probe(ap);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		tries[i] = ATA_PROBE_MAX_TRIES;
+	ata_link_for_each_dev(dev, &ap->link)
+		tries[dev->devno] = ATA_PROBE_MAX_TRIES;
 
  retry:
 	down_xfermask = 0;
@@ -1493,9 +1495,7 @@ static int ata_bus_probe(struct ata_port
 	/* reset and determine device classes */
 	ap->ops->phy_reset(ap);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (!(ap->flags & ATA_FLAG_DISABLED) &&
 		    dev->class != ATA_DEV_UNKNOWN)
 			classes[dev->devno] = dev->class;
@@ -1508,11 +1508,9 @@ static int ata_bus_probe(struct ata_port
 	ata_port_probe(ap);
 
 	/* read IDENTIFY page and configure devices */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
-		if (tries[i])
-			dev->class = classes[i];
+	ata_link_for_each_dev(dev, &ap->link) {
+		if (tries[dev->devno])
+			dev->class = classes[dev->devno];
 
 		if (!ata_dev_enabled(dev))
 			continue;
@@ -1533,9 +1531,10 @@ static int ata_bus_probe(struct ata_port
 		goto fail;
 	}
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_enabled(&ap->link.device[i]))
+	ata_link_for_each_dev(dev, &ap->link) {
+		if (ata_dev_enabled(dev))
 			return 0;
+	}
 
 	/* no device present, disable port */
 	ata_port_disable(ap);
@@ -2077,16 +2076,17 @@ static int ata_dev_set_mode(struct ata_d
  */
 int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 {
+	struct ata_link *link = &ap->link;
 	struct ata_device *dev;
-	int i, rc = 0, used_dma = 0, found = 0;
+	int rc = 0, used_dma = 0, found = 0;
 
 	/* has private set_mode? */
 	if (ap->ops->set_mode) {
 		/* FIXME: make ->set_mode handle no device case and
 		 * return error code and failing device on failure.
 		 */
-		for (i = 0; i < ATA_MAX_DEVICES; i++) {
-			if (ata_dev_enabled(&ap->link.device[i])) {
+		ata_link_for_each_dev(dev, link) {
+			if (ata_dev_enabled(dev)) {
 				ap->ops->set_mode(ap);
 				break;
 			}
@@ -2095,11 +2095,9 @@ int ata_set_mode(struct ata_port *ap, st
 	}
 
 	/* step 1: calculate xfer_mask */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+	ata_link_for_each_dev(dev, link) {
 		unsigned int pio_mask, dma_mask;
 
-		dev = &ap->link.device[i];
-
 		if (!ata_dev_enabled(dev))
 			continue;
 
@@ -2118,8 +2116,7 @@ int ata_set_mode(struct ata_port *ap, st
 		goto out;
 
 	/* step 2: always set host PIO timings */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, link) {
 		if (!ata_dev_enabled(dev))
 			continue;
 
@@ -2136,9 +2133,7 @@ int ata_set_mode(struct ata_port *ap, st
 	}
 
 	/* step 3: set host DMA timings */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, link) {
 		if (!ata_dev_enabled(dev) || !dev->dma_mode)
 			continue;
 
@@ -2149,9 +2144,7 @@ int ata_set_mode(struct ata_port *ap, st
 	}
 
 	/* step 4: update devices' xfer mode */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, link) {
 		if (!ata_dev_enabled(dev))
 			continue;
 
@@ -2947,8 +2940,8 @@ static void ata_dev_xfermask(struct ata_
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
 	struct ata_host_set *hs = ap->host_set;
+	struct ata_device *d;
 	unsigned long xfer_mask;
-	int i;
 
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
 				      ap->mwdma_mask, ap->udma_mask);
@@ -2959,10 +2952,8 @@ static void ata_dev_xfermask(struct ata_
 	if (ap->cbl == ATA_CBL_PATA40)
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 
-	/* FIXME: Use port-wide xfermask for now */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *d = &link->device[i];
-
+	/* FIXME: Use link-wide xfermask for now */
+	ata_link_for_each_dev(d, link) {
 		if (ata_dev_absent(d))
 			continue;
 
@@ -5143,7 +5134,7 @@ static void ata_host_init(struct ata_por
 
 	ap->link.ap = ap;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+	for (i = 0; i < ata_link_max_devices(&ap->link); i++) {
 		struct ata_device *dev = &ap->link.device[i];
 		dev->link = &ap->link;
 		dev->devno = i;
@@ -5330,7 +5321,7 @@ int ata_device_add(const struct ata_prob
 			spin_lock_irqsave(&ap->host_set->lock, flags);
 
 			ap->link.eh_info.probe_mask =
-				(1 << ATA_MAX_DEVICES) - 1;
+				(1 << ata_link_max_devices(&ap->link)) - 1;
 			ap->link.eh_info.action |= ATA_EH_SOFTRESET;
 
 			set_bit(bit, &ap->flags);
@@ -5396,7 +5387,7 @@ err_free_ret:
 void ata_port_detach(struct ata_port *ap)
 {
 	unsigned long flags;
-	int i;
+	struct ata_device *dev;
 
 	if (!ap->ops->error_handler)
 		return;
@@ -5405,8 +5396,8 @@ void ata_port_detach(struct ata_port *ap
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
 	ap->flags |= ATA_FLAG_UNLOADING;
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->link.device[i].flags |= ATA_DFLAG_DETACH;
+	ata_link_for_each_dev(dev, &ap->link)
+		dev->flags |= ATA_DFLAG_DETACH;
 
 	ata_port_schedule_eh(ap);
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index cde769f..4026886 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1326,10 +1326,11 @@ static void ata_eh_report(struct ata_por
 static int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
 			unsigned int *classes)
 {
-	int i, rc;
+	struct ata_device *dev;
+	int rc;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		classes[i] = ATA_DEV_UNKNOWN;
+	ata_link_for_each_dev(dev, &ap->link)
+		classes[dev->devno] = ATA_DEV_UNKNOWN;
 
 	rc = reset(ap, classes);
 	if (rc)
@@ -1339,14 +1340,14 @@ static int ata_do_reset(struct ata_port 
 	 * is complete and convert all ATA_DEV_UNKNOWN to
 	 * ATA_DEV_NONE.
 	 */
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (classes[i] != ATA_DEV_UNKNOWN)
+	ata_link_for_each_dev(dev, &ap->link)
+		if (classes[dev->devno] != ATA_DEV_UNKNOWN)
 			break;
 
-	if (i < ATA_MAX_DEVICES)
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			if (classes[i] == ATA_DEV_UNKNOWN)
-				classes[i] = ATA_DEV_NONE;
+	if (dev)
+		ata_link_for_each_dev(dev, &ap->link)
+			if (classes[dev->devno] == ATA_DEV_UNKNOWN)
+				classes[dev->devno] = ATA_DEV_NONE;
 
 	return 0;
 }
@@ -1373,7 +1374,7 @@ static int ata_eh_reset(struct ata_port 
 	int verbose = !(ap->flags & ATA_FLAG_LOADING);
 	unsigned int action;
 	ata_reset_fn_t reset;
-	int i, did_followup_srst, rc;
+	int did_followup_srst, rc;
 
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine it to determine what kind of
@@ -1397,8 +1398,9 @@ static int ata_eh_reset(struct ata_port 
 		 * -ENODEV.
 		 */
 		if (rc == -ENODEV) {
-			for (i = 0; i < ATA_MAX_DEVICES; i++)
-				classes[i] = ATA_DEV_NONE;
+			struct ata_device *dev;
+			ata_link_for_each_dev(dev, &ap->link)
+				classes[dev->devno] = ATA_DEV_NONE;
 			return 0;
 		}
 
@@ -1487,13 +1489,11 @@ static int ata_eh_revalidate_and_attach(
 	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_device *dev;
 	unsigned long flags;
-	int i, rc = 0;
+	int rc = 0;
 
 	DPRINTK("ENTER\n");
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (ehc->i.action & ATA_EH_REVALIDATE && ata_dev_enabled(dev) &&
 		    (!ehc->i.dev || ehc->i.dev == dev)) {
 			if (ata_port_offline(ap)) {
@@ -1537,20 +1537,22 @@ static int ata_eh_revalidate_and_attach(
 
 static int ata_port_nr_enabled(struct ata_port *ap)
 {
-	int i, cnt = 0;
+	struct ata_device *dev;
+	int cnt = 0;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_enabled(&ap->link.device[i]))
+	ata_link_for_each_dev(dev, &ap->link)
+		if (ata_dev_enabled(dev))
 			cnt++;
 	return cnt;
 }
 
 static int ata_port_nr_vacant(struct ata_port *ap)
 {
-	int i, cnt = 0;
+	struct ata_device *dev;
+	int cnt = 0;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ap->link.device[i].class == ATA_DEV_UNKNOWN)
+	ata_link_for_each_dev(dev, &ap->link)
+		if (dev->class == ATA_DEV_UNKNOWN)
 			cnt++;
 	return cnt;
 }
@@ -1558,15 +1560,13 @@ static int ata_port_nr_vacant(struct ata
 static int ata_eh_skip_recovery(struct ata_port *ap)
 {
 	struct ata_eh_context *ehc = &ap->link.eh_context;
-	int i;
+	struct ata_device *dev;
 
 	if (ap->flags & ATA_FLAG_FROZEN || ata_port_nr_enabled(ap))
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (dev->class == ATA_DEV_UNKNOWN &&
 		    ehc->classes[dev->devno] != ATA_DEV_NONE)
 			return 0;
@@ -1602,14 +1602,12 @@ static int ata_eh_recover(struct ata_por
 {
 	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_device *dev;
-	int down_xfermask, i, rc;
+	int down_xfermask, rc;
 
 	DPRINTK("ENTER\n");
 
 	/* prep for recovery */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, &ap->link) {
 		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
 		/* process hotplug request */
@@ -1634,8 +1632,8 @@ static int ata_eh_recover(struct ata_por
 	if (ata_eh_skip_recovery(ap))
 		ehc->i.action = 0;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ehc->classes[i] = ATA_DEV_UNKNOWN;
+	ata_link_for_each_dev(dev, &ap->link)
+		ehc->classes[dev->devno] = ATA_DEV_UNKNOWN;
 
 	/* reset */
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
@@ -1724,8 +1722,8 @@ static int ata_eh_recover(struct ata_por
 
  out:
 	if (rc) {
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ata_dev_disable(&ap->link.device[i]);
+		ata_link_for_each_dev(dev, &ap->link)
+			ata_dev_disable(dev);
 	}
 
 	DPRINTK("EXIT, rc=%d\n", rc);
@@ -1790,7 +1788,8 @@ void ata_eh_scsi_hotplug(void *data)
 {
 	struct ata_port *ap = data;
 	unsigned long timeout;
-	int i, requeue = 0;
+	struct ata_device *dev;
+	int requeue = 0;
 
 	DPRINTK("ENTER\n");
 
@@ -1811,8 +1810,7 @@ void ata_eh_scsi_hotplug(void *data)
 		requeue = 1;
 
 	/* unplug detached devices */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, &ap->link) {
 		unsigned long flags;
 
 		if (!(dev->flags & ATA_DFLAG_DETACHED))
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 6d9384a..facde9e 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2775,19 +2775,18 @@ void ata_scsi_simulate(struct ata_device
 
 void ata_scsi_scan_host(struct ata_port *ap)
 {
-	unsigned int i;
+	struct ata_device *dev;
 
 	if (ap->flags & ATA_FLAG_DISABLED)
 		return;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, &ap->link) {
 		struct scsi_device *sdev;
 
 		if (!ata_dev_enabled(dev) || dev->sdev)
 			continue;
 
-		sdev = __scsi_add_device(ap->host, 0, i, 0, NULL);
+		sdev = __scsi_add_device(ap->host, 0, dev->devno, 0, NULL);
 		if (!IS_ERR(sdev)) {
 			dev->sdev = sdev;
 			scsi_device_put(sdev);
@@ -2911,7 +2910,8 @@ static int ata_scsi_user_scan(struct Scs
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
 	if (id == SCAN_WILD_CARD) {
-		ap->link.eh_info.probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
+		ap->link.eh_info.probe_mask |=
+			(1 << ata_link_max_devices(&ap->link)) - 1;
 		ap->link.eh_info.action |= ATA_EH_SOFTRESET;
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, id);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fbb3f4c..c7c904f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -861,6 +861,9 @@ static inline unsigned int ata_tag_inter
 	return tag == ATA_MAX_QUEUE - 1;
 }
 
+/*
+ * device helpers
+ */
 static inline unsigned int ata_class_enabled(unsigned int class)
 {
 	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI;
@@ -891,6 +894,25 @@ static inline unsigned int ata_dev_absen
 	return ata_class_absent(dev->class);
 }
 
+/*
+ * link helpers
+ */
+static inline int ata_link_max_devices(const struct ata_link *link)
+{
+	if (link->ap->flags & ATA_FLAG_SLAVE_POSS)
+		return 2;
+	return 1;
+}
+
+#define ata_port_for_each_link(lk, ap) \
+	for ((lk) = &(ap)->link; (lk); (lk) = NULL)
+
+#define ata_link_for_each_dev(dev, link) \
+	for ((dev) = (link)->device; \
+	     (dev) - (link)->device < ata_link_max_devices(link) || (dev = NULL); \
+	     (dev)++)
+
+
 static inline u8 ata_chk_status(struct ata_port *ap)
 {
 	return ap->ops->check_status(ap);
-- 
1.2.4


