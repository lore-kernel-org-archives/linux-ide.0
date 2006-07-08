From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/17] libata-link: implement and use link/device iterators
Date: Sat, 8 Jul 2006 14:45:36 +0900
Message-ID: <1152337536518-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:42863 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932518AbWGHFop (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:45 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484118wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:45 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
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

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   81 +++++++++++--------------
 drivers/scsi/libata-eh.c   |  142 +++++++++++++++++++++-----------------------
 drivers/scsi/libata-scsi.c |   24 +++----
 include/linux/libata.h     |   14 +++-
 4 files changed, 122 insertions(+), 139 deletions(-)

54cdc69a26dfa3426b384b04b357e0fa7903b559
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9e19d12..0dcd2ec 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1329,14 +1329,14 @@ static void ata_dev_config_ncq(struct at
 
 static void ata_set_port_max_cmd_len(struct ata_port *ap)
 {
-	int i;
+	struct ata_device *dev;
 
 	if (ap->host) {
 		ap->host->max_cmd_len = 0;
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
+		ata_link_for_each_dev(dev, &ap->link)
 			ap->host->max_cmd_len = max_t(unsigned int,
 						      ap->host->max_cmd_len,
-						      ap->link.device[i].cdb_len);
+						      dev->cdb_len);
 	}
 }
 
@@ -1534,13 +1534,13 @@ static int ata_bus_probe(struct ata_port
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
@@ -1548,9 +1548,7 @@ static int ata_bus_probe(struct ata_port
 	/* reset and determine device classes */
 	ap->ops->phy_reset(ap);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (!(ap->flags & ATA_FLAG_DISABLED) &&
 		    dev->class != ATA_DEV_UNKNOWN)
 			classes[dev->devno] = dev->class;
@@ -1565,15 +1563,13 @@ static int ata_bus_probe(struct ata_port
 	/* after the reset the device state is PIO 0 and the controller
 	   state is undefined. Record the mode */
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->link.device[i].pio_mode = XFER_PIO_0;
+	ata_link_for_each_dev(dev, &ap->link)
+		dev->pio_mode = XFER_PIO_0;
 
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
@@ -1594,9 +1590,10 @@ static int ata_bus_probe(struct ata_port
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
@@ -2139,16 +2136,17 @@ static int ata_dev_set_mode(struct ata_d
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
-			if (ata_dev_ready(&ap->link.device[i])) {
+		ata_link_for_each_dev(dev, link) {
+			if (ata_dev_ready(dev)) {
 				ap->ops->set_mode(ap);
 				break;
 			}
@@ -2157,11 +2155,9 @@ int ata_set_mode(struct ata_port *ap, st
 	}
 
 	/* step 1: calculate xfer_mask */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+	ata_link_for_each_dev(dev, link) {
 		unsigned int pio_mask, dma_mask;
 
-		dev = &ap->link.device[i];
-
 		if (!ata_dev_enabled(dev))
 			continue;
 
@@ -2180,8 +2176,7 @@ int ata_set_mode(struct ata_port *ap, st
 		goto out;
 
 	/* step 2: always set host PIO timings */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, link) {
 		if (!ata_dev_enabled(dev))
 			continue;
 
@@ -2198,9 +2193,7 @@ int ata_set_mode(struct ata_port *ap, st
 	}
 
 	/* step 3: set host DMA timings */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, link) {
 		if (!ata_dev_enabled(dev) || !dev->dma_mode)
 			continue;
 
@@ -2211,9 +2204,7 @@ int ata_set_mode(struct ata_port *ap, st
 	}
 
 	/* step 4: update devices' xfer mode */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, link) {
 		/* don't udpate suspended devices' xfer mode */
 		if (!ata_dev_ready(dev))
 			continue;
@@ -3125,8 +3116,8 @@ static void ata_dev_xfermask(struct ata_
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
 	struct ata_host_set *hs = ap->host_set;
+	struct ata_device *d;
 	unsigned long xfer_mask;
-	int i;
 
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
 				      ap->mwdma_mask, ap->udma_mask);
@@ -3137,10 +3128,8 @@ static void ata_dev_xfermask(struct ata_
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
 
@@ -5149,7 +5138,7 @@ static int ata_host_set_request_pm(struc
  */
 int ata_host_set_suspend(struct ata_host_set *host_set, pm_message_t mesg)
 {
-	int i, j, rc;
+	int i, rc;
 
 	rc = ata_host_set_request_pm(host_set, mesg, 0, ATA_EHI_QUIET, 1);
 	if (rc)
@@ -5161,10 +5150,9 @@ int ata_host_set_suspend(struct ata_host
 	 */
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
+		struct ata_device *dev;
 
-		for (j = 0; j < ATA_MAX_DEVICES; j++) {
-			struct ata_device *dev = &ap->link.device[j];
-
+		ata_link_for_each_dev(dev, &ap->link) {
 			if (ata_dev_ready(dev)) {
 				ata_port_printk(ap, KERN_WARNING,
 						"suspend failed, device %d "
@@ -5384,7 +5372,7 @@ #endif
 
 	ap->link.ap = ap;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+	for (i = 0; i < ata_link_max_devices(&ap->link); i++) {
 		struct ata_device *dev = &ap->link.device[i];
 		dev->link = &ap->link;
 		dev->devno = i;
@@ -5570,7 +5558,8 @@ int ata_device_add(const struct ata_prob
 			/* kick EH for boot probing */
 			spin_lock_irqsave(ap->lock, flags);
 
-			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
+			ehi->probe_mask =
+				(1 << ata_link_max_devices(&ap->link)) - 1;
 			ehi->action |= ATA_EH_SOFTRESET;
 			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
@@ -5635,7 +5624,7 @@ err_free_ret:
 void ata_port_detach(struct ata_port *ap)
 {
 	unsigned long flags;
-	int i;
+	struct ata_device *dev;
 
 	if (!ap->ops->error_handler)
 		return;
@@ -5652,8 +5641,8 @@ void ata_port_detach(struct ata_port *ap
 	 */
 	spin_lock_irqsave(ap->lock, flags);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ata_dev_disable(&ap->link.device[i]);
+	ata_link_for_each_dev(dev, &ap->link)
+		ata_dev_disable(dev);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 80cdfc2..fb6e3f8 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -115,23 +115,24 @@ static unsigned int ata_eh_dev_action(st
 	return ehc->i.action | ehc->i.dev_action[dev->devno];
 }
 
-static void ata_eh_clear_action(struct ata_device *dev,
+static void ata_eh_clear_action(struct ata_link *link, struct ata_device *dev,
 				struct ata_eh_info *ehi, unsigned int action)
 {
-	int i;
+	struct ata_device *tdev;
 
 	if (!dev) {
 		ehi->action &= ~action;
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ehi->dev_action[i] &= ~action;
+		ata_link_for_each_dev(tdev, link)
+			ehi->dev_action[tdev->devno] &= ~action;
 	} else {
 		/* doesn't make sense for port-wide EH actions */
 		WARN_ON(!(action & ATA_EH_PERDEV_MASK));
 
 		/* break ehi->action into ehi->dev_action */
 		if (ehi->action & action) {
-			for (i = 0; i < ATA_MAX_DEVICES; i++)
-				ehi->dev_action[i] |= ehi->action & action;
+			ata_link_for_each_dev(tdev, link)
+				ehi->dev_action[tdev->devno] |=
+					ehi->action & action;
 			ehi->action &= ~action;
 		}
 
@@ -747,7 +748,8 @@ void ata_eh_qc_retry(struct ata_queued_c
  */
 static void ata_eh_detach_dev(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->link->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 	unsigned long flags;
 
 	ata_dev_disable(dev);
@@ -762,8 +764,8 @@ static void ata_eh_detach_dev(struct ata
 	}
 
 	/* clear per-dev EH actions */
-	ata_eh_clear_action(dev, &dev->link->eh_info, ATA_EH_PERDEV_MASK);
-	ata_eh_clear_action(dev, &dev->link->eh_context.i, ATA_EH_PERDEV_MASK);
+	ata_eh_clear_action(link, dev, &link->eh_info, ATA_EH_PERDEV_MASK);
+	ata_eh_clear_action(link, dev, &link->eh_context.i, ATA_EH_PERDEV_MASK);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 }
@@ -788,7 +790,7 @@ static void ata_eh_about_to_do(struct at
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ata_eh_clear_action(dev, &ap->link.eh_info, action);
+	ata_eh_clear_action(&ap->link, dev, &ap->link.eh_info, action);
 
 	if (!(ap->link.eh_context.i.flags & ATA_EHI_QUIET))
 		ap->pflags |= ATA_PFLAG_RECOVERED;
@@ -811,7 +813,7 @@ static void ata_eh_about_to_do(struct at
 static void ata_eh_done(struct ata_port *ap, struct ata_device *dev,
 			unsigned int action)
 {
-	ata_eh_clear_action(dev, &ap->link.eh_context.i, action);
+	ata_eh_clear_action(&ap->link, dev, &ap->link.eh_context.i, action);
 }
 
 /**
@@ -1455,10 +1457,11 @@ static void ata_eh_report(struct ata_por
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
@@ -1468,14 +1471,16 @@ static int ata_do_reset(struct ata_port 
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
+	if (dev) {
+		ata_link_for_each_dev(dev, &ap->link) {
+			if (classes[dev->devno] == ATA_DEV_UNKNOWN)
+				classes[dev->devno] = ATA_DEV_NONE;
+		}
+	}
 
 	return 0;
 }
@@ -1500,9 +1505,10 @@ static int ata_eh_reset(struct ata_port 
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
+	struct ata_device *dev;
 	unsigned int action;
 	ata_reset_fn_t reset;
-	int i, did_followup_srst, rc;
+	int did_followup_srst, rc;
 
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
@@ -1531,8 +1537,8 @@ static int ata_eh_reset(struct ata_port 
 		reset = softreset;
 	else {
 		/* prereset told us not to reset, bang classes and return */
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			classes[i] = ATA_DEV_NONE;
+		ata_link_for_each_dev(dev, &ap->link)
+			classes[dev->devno] = ATA_DEV_NONE;
 		return 0;
 	}
 
@@ -1609,8 +1615,8 @@ static int ata_eh_reset(struct ata_port 
 		/* After the reset, the device state is PIO 0 and the
 		 * controller state is undefined.  Record the mode.
 		 */
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ap->link.device[i].pio_mode = XFER_PIO_0;
+		ata_link_for_each_dev(dev, &ap->link)
+			dev->pio_mode = XFER_PIO_0;
 
 		if (postreset)
 			postreset(ap, classes);
@@ -1629,15 +1635,12 @@ static int ata_eh_revalidate_and_attach(
 	struct ata_eh_context *ehc = &ap->link.eh_context;
 	struct ata_device *dev;
 	unsigned long flags;
-	int i, rc = 0;
+	int rc = 0;
 
 	DPRINTK("ENTER\n");
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		unsigned int action;
-
-		dev = &ap->link.device[i];
-		action = ata_eh_dev_action(dev);
+	ata_link_for_each_dev(dev, &ap->link) {
+		unsigned int action = ata_eh_dev_action(dev);
 
 		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
 			if (ata_port_offline(ap)) {
@@ -1701,16 +1704,14 @@ static int ata_eh_revalidate_and_attach(
 static int ata_eh_suspend(struct ata_port *ap, struct ata_device **r_failed_dev)
 {
 	struct ata_device *dev;
-	int i, rc = 0;
+	int rc = 0;
 
 	DPRINTK("ENTER\n");
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+	ata_link_for_each_dev(dev, &ap->link) {
+		unsigned int action = ata_eh_dev_action(dev);
+		unsigned int err_mask;
 		unsigned long flags;
-		unsigned int action, err_mask;
-
-		dev = &ap->link.device[i];
-		action = ata_eh_dev_action(dev);
 
 		if (!ata_dev_enabled(dev) || !(action & ATA_EH_SUSPEND))
 			continue;
@@ -1765,15 +1766,11 @@ static void ata_eh_prep_resume(struct at
 {
 	struct ata_device *dev;
 	unsigned long flags;
-	int i;
 
 	DPRINTK("ENTER\n");
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		unsigned int action;
-
-		dev = &ap->link.device[i];
-		action = ata_eh_dev_action(dev);
+	ata_link_for_each_dev(dev, &ap->link) {
+		unsigned int action = ata_eh_dev_action(dev);
 
 		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
 			continue;
@@ -1803,15 +1800,13 @@ static void ata_eh_prep_resume(struct at
 static int ata_eh_resume(struct ata_port *ap, struct ata_device **r_failed_dev)
 {
 	struct ata_device *dev;
-	int i, rc = 0;
+	int rc = 0;
 
 	DPRINTK("ENTER\n");
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		unsigned int action, err_mask;
-
-		dev = &ap->link.device[i];
-		action = ata_eh_dev_action(dev);
+	ata_link_for_each_dev(dev, &ap->link) {
+		unsigned int action = ata_eh_dev_action(dev);
+		unsigned int err_mask;
 
 		if (!ata_dev_enabled(dev) || !(action & ATA_EH_RESUME))
 			continue;
@@ -1842,20 +1837,22 @@ static int ata_eh_resume(struct ata_port
 
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
@@ -1863,17 +1860,15 @@ static int ata_port_nr_vacant(struct ata
 static int ata_eh_skip_recovery(struct ata_port *ap)
 {
 	struct ata_eh_context *ehc = &ap->link.eh_context;
-	int i;
+	struct ata_device *dev;
 
 	/* skip if all possible devices are suspended */
-	for (i = 0; i < ata_port_max_devices(ap); i++) {
-		struct ata_device *dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (ata_dev_absent(dev) || ata_dev_ready(dev))
 			break;
 	}
 
-	if (i == ata_port_max_devices(ap))
+	if (dev == NULL)
 		return 1;
 
 	/* always thaw frozen port and recover failed devices */
@@ -1881,9 +1876,7 @@ static int ata_eh_skip_recovery(struct a
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (dev->class == ATA_DEV_UNKNOWN &&
 		    ehc->classes[dev->devno] != ATA_DEV_NONE)
 			return 0;
@@ -1968,14 +1961,12 @@ static int ata_eh_recover(struct ata_por
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
@@ -2007,8 +1998,8 @@ static int ata_eh_recover(struct ata_por
 	if (ata_eh_skip_recovery(ap))
 		ehc->i.action = 0;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ehc->classes[i] = ATA_DEV_UNKNOWN;
+	ata_link_for_each_dev(dev, &ap->link)
+		ehc->classes[dev->devno] = ATA_DEV_UNKNOWN;
 
 	/* reset */
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
@@ -2070,8 +2061,8 @@ static int ata_eh_recover(struct ata_por
 		/* recovery failed, activate hp-poll */
 		ata_hp_poll_activate(ap);
 
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ata_dev_disable(&ap->link.device[i]);
+		ata_link_for_each_dev(dev, &ap->link);
+			ata_dev_disable(dev);
 	}
 
 	DPRINTK("EXIT, rc=%d\n", rc);
@@ -2214,7 +2205,7 @@ static void ata_eh_handle_port_resume(st
 {
 	unsigned long timeout;
 	unsigned long flags;
-	int i, rc = 0;
+	int rc = 0;
 
 	/* are we resuming? */
 	spin_lock_irqsave(ap->lock, flags);
@@ -2235,8 +2226,9 @@ static void ata_eh_handle_port_resume(st
 	/* give devices time to request EH */
 	timeout = jiffies + HZ; /* 1s max */
 	while (1) {
-		for (i = 0; i < ATA_MAX_DEVICES; i++) {
-			struct ata_device *dev = &ap->link.device[i];
+		struct ata_device *dev;
+
+		ata_link_for_each_dev(dev, &ap->link) {
 			unsigned int action = ata_eh_dev_action(dev);
 
 			if ((dev->flags & ATA_DFLAG_SUSPENDED) &&
@@ -2244,7 +2236,7 @@ static void ata_eh_handle_port_resume(st
 				break;
 		}
 
-		if (i == ATA_MAX_DEVICES || time_after(jiffies, timeout))
+		if (dev == NULL || time_after(jiffies, timeout))
 			break;
 		msleep(10);
 	}
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index c947da7..8c0229b 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -511,7 +511,7 @@ int ata_scsi_device_resume(struct scsi_d
 	/* We don't want autopsy and verbose EH messages.  Disable
 	 * those if we're the only device on this link.
 	 */
-	if (ata_port_max_devices(ap) == 1)
+	if (ata_link_max_devices(dev->link) == 1)
 		ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
 	ata_port_schedule_eh(ap);
@@ -2466,7 +2466,7 @@ static unsigned int atapi_xlat(struct at
 
 static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
 {
-	if (likely(id < ATA_MAX_DEVICES))
+	if (likely(id < ata_link_max_devices(&ap->link)))
 		return &ap->link.device[id];
 	return NULL;
 }
@@ -2920,19 +2920,18 @@ void ata_scsi_simulate(struct ata_device
 
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
@@ -3038,7 +3037,7 @@ static void ata_scsi_remove_dev(struct a
 void ata_scsi_hotplug(void *data)
 {
 	struct ata_port *ap = data;
-	int i;
+	struct ata_device *dev;
 
 	if (ap->pflags & ATA_PFLAG_UNLOADING) {
 		DPRINTK("ENTER/EXIT - unloading\n");
@@ -3048,8 +3047,7 @@ void ata_scsi_hotplug(void *data)
 	DPRINTK("ENTER\n");
 
 	/* unplug detached devices */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, &ap->link) {
 		unsigned long flags;
 
 		if (!(dev->flags & ATA_DFLAG_DETACHED))
@@ -3069,8 +3067,7 @@ void ata_scsi_hotplug(void *data)
 	 * failed silently.  Requeue if there are enabled but
 	 * unattached devices.
 	 */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (ata_dev_enabled(dev) && !dev->sdev) {
 			queue_delayed_work(ata_aux_wq, &ap->hotplug_task, HZ);
 			break;
@@ -3151,11 +3148,8 @@ void ata_scsi_dev_rescan(void *data)
 {
 	struct ata_port *ap = data;
 	struct ata_device *dev;
-	unsigned int i;
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
 
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (ata_dev_enabled(dev) && dev->sdev)
 			scsi_rescan_device(&(dev->sdev->sdev_gendev));
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0395e2f..990a555 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -986,15 +986,23 @@ static inline unsigned int ata_dev_ready
 }
 
 /*
- * port helpers
+ * link helpers
  */
-static inline int ata_port_max_devices(const struct ata_port *ap)
+static inline int ata_link_max_devices(const struct ata_link *link)
 {
-	if (ap->flags & ATA_FLAG_SLAVE_POSS)
+	if (link->ap->flags & ATA_FLAG_SLAVE_POSS)
 		return 2;
 	return 1;
 }
 
+#define ata_port_for_each_link(lk, ap) \
+	for ((lk) = &(ap)->link; (lk); (lk) = NULL)
+
+#define ata_link_for_each_dev(dev, link) \
+	for ((dev) = (link)->device; \
+	     (dev) - (link)->device < ata_link_max_devices(link) || (dev = NULL); \
+	     (dev)++)
+
 
 static inline u8 ata_chk_status(struct ata_port *ap)
 {
-- 
1.3.2


