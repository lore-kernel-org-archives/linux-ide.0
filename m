From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/18] [PATCH] libata-link: implement and use link/device iterators
Date: Mon, 16 Oct 2006 07:54:40 +0900
Message-ID: <1160952880233-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:3765 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422933AbWJOWyz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:55 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626625nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:54 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
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
 drivers/ata/ata_generic.c   |    7 +-
 drivers/ata/ata_piix.c      |    9 ++-
 drivers/ata/libata-core.c   |   74 ++++++++++------------
 drivers/ata/libata-eh.c     |  142 ++++++++++++++++++++-----------------------
 drivers/ata/libata-scsi.c   |   26 +++-----
 drivers/ata/pata_it821x.c   |    7 +-
 drivers/ata/pata_legacy.c   |    5 +-
 drivers/ata/pata_pdc2027x.c |    6 +-
 drivers/ata/pata_rz1000.c   |    5 +-
 include/linux/libata.h      |   14 +++-
 10 files changed, 137 insertions(+), 158 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index eac2c16..e060fee 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -74,21 +74,20 @@ static void generic_error_handler(struct
 static void generic_set_mode(struct ata_port *ap)
 {
 	int dma_enabled = 0;
-	int i;
+	struct ata_device *dev;
 
 	/* Bits 5 and 6 indicate if DMA is active on master/slave */
 	if (ap->ioaddr.bmdma_addr)
 		dma_enabled = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
 			dev->dma_mode = XFER_MW_DMA_0;
 			/* We do need the right mode information for DMA or PIO
 			   and this comes from the current configuration flags */
-			if (dma_enabled & (1 << (5 + i))) {
+			if (dma_enabled & (1 << (5 + dev->devno))) {
 				dev->xfer_mode = XFER_MW_DMA_0;
 				dev->xfer_shift = ATA_SHIFT_MWDMA;
 				dev->flags &= ~ATA_DFLAG_PIO;
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 245a671..ffeaf65 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -774,7 +774,8 @@ static unsigned int piix_sata_present_ma
 static int piix_sata_softreset(struct ata_port *ap, unsigned int *classes)
 {
 	unsigned int present_mask;
-	int i, rc;
+	struct ata_device *dev;
+	int rc;
 
 	present_mask = piix_sata_present_mask(ap);
 
@@ -782,9 +783,9 @@ static int piix_sata_softreset(struct at
 	if (rc)
 		return rc;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		if (!(present_mask & (1 << i)))
-			classes[i] = ATA_DEV_NONE;
+	ata_link_for_each_dev(dev, &ap->link) {
+		if (!(present_mask & (1 << dev->devno)))
+			classes[dev->devno] = ATA_DEV_NONE;
 	}
 
 	return 0;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 68333d8..580317c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1361,13 +1361,12 @@ static void ata_dev_config_ncq(struct at
 
 static void ata_set_port_max_cmd_len(struct ata_port *ap)
 {
-	int i;
-
 	if (ap->scsi_host) {
 		unsigned int len = 0;
+		struct ata_device *dev;
 
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			len = max(len, ap->link.device[i].cdb_len);
+		ata_link_for_each_dev(dev, &ap->link)
+			len = max(len, dev->cdb_len);
 
 		ap->scsi_host->max_cmd_len = len;
 	}
@@ -1589,13 +1588,13 @@ int ata_bus_probe(struct ata_port *ap)
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
@@ -1603,9 +1602,7 @@ int ata_bus_probe(struct ata_port *ap)
 	/* reset and determine device classes */
 	ap->ops->phy_reset(ap);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (!(ap->flags & ATA_FLAG_DISABLED) &&
 		    dev->class != ATA_DEV_UNKNOWN)
 			classes[dev->devno] = dev->class;
@@ -1620,15 +1617,13 @@ int ata_bus_probe(struct ata_port *ap)
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
@@ -1649,9 +1644,10 @@ int ata_bus_probe(struct ata_port *ap)
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
@@ -2198,16 +2194,17 @@ static int ata_dev_set_mode(struct ata_d
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
@@ -2216,11 +2213,9 @@ int ata_set_mode(struct ata_port *ap, st
 	}
 
 	/* step 1: calculate xfer_mask */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+	ata_link_for_each_dev(dev, link) {
 		unsigned int pio_mask, dma_mask;
 
-		dev = &ap->link.device[i];
-
 		if (!ata_dev_enabled(dev))
 			continue;
 
@@ -2239,8 +2234,7 @@ int ata_set_mode(struct ata_port *ap, st
 		goto out;
 
 	/* step 2: always set host PIO timings */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, link) {
 		if (!ata_dev_enabled(dev))
 			continue;
 
@@ -2257,9 +2251,7 @@ int ata_set_mode(struct ata_port *ap, st
 	}
 
 	/* step 3: set host DMA timings */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, link) {
 		if (!ata_dev_enabled(dev) || !dev->dma_mode)
 			continue;
 
@@ -2270,9 +2262,7 @@ int ata_set_mode(struct ata_port *ap, st
 	}
 
 	/* step 4: update devices' xfer mode */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, link) {
 		/* don't udpate suspended devices' xfer mode */
 		if (!ata_dev_ready(dev))
 			continue;
@@ -5240,7 +5230,7 @@ static int ata_host_request_pm(struct at
  */
 int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
 {
-	int i, j, rc;
+	int i, rc;
 
 	rc = ata_host_request_pm(host, mesg, 0, ATA_EHI_QUIET, 1);
 	if (rc)
@@ -5252,10 +5242,9 @@ int ata_host_suspend(struct ata_host *ho
 	 */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
+		struct ata_device *dev;
 
-		for (j = 0; j < ATA_MAX_DEVICES; j++) {
-			struct ata_device *dev = &ap->link.device[j];
-
+		ata_link_for_each_dev(dev, &ap->link) {
 			if (ata_dev_ready(dev)) {
 				ata_port_printk(ap, KERN_WARNING,
 						"suspend failed, device %d "
@@ -5448,7 +5437,7 @@ #endif
 
 	ap->link.ap = ap;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+	for (i = 0; i < ata_link_max_devices(&ap->link); i++) {
 		struct ata_device *dev = &ap->link.device[i];
 		dev->link = &ap->link;
 		dev->devno = i;
@@ -5700,7 +5689,8 @@ int ata_device_add(const struct ata_prob
 			/* kick EH for boot probing */
 			spin_lock_irqsave(ap->lock, flags);
 
-			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
+			ehi->probe_mask =
+				(1 << ata_link_max_devices(&ap->link)) - 1;
 			ehi->action |= ATA_EH_SOFTRESET;
 			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
@@ -5770,7 +5760,7 @@ err_out:
 void ata_port_detach(struct ata_port *ap)
 {
 	unsigned long flags;
-	int i;
+	struct ata_device *dev;
 
 	if (!ap->ops->error_handler)
 		goto skip_eh;
@@ -5787,8 +5777,8 @@ void ata_port_detach(struct ata_port *ap
 	 */
 	spin_lock_irqsave(ap->lock, flags);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ata_dev_disable(&ap->link.device[i]);
+	ata_link_for_each_dev(dev, &ap->link)
+		ata_dev_disable(dev);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 46fca04..bfae7fa 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -109,23 +109,24 @@ static unsigned int ata_eh_dev_action(st
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
 
@@ -741,7 +742,8 @@ void ata_eh_qc_retry(struct ata_queued_c
  */
 static void ata_eh_detach_dev(struct ata_device *dev)
 {
-	struct ata_port *ap = dev->link->ap;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
 	unsigned long flags;
 
 	ata_dev_disable(dev);
@@ -756,8 +758,8 @@ static void ata_eh_detach_dev(struct ata
 	}
 
 	/* clear per-dev EH actions */
-	ata_eh_clear_action(dev, &dev->link->eh_info, ATA_EH_PERDEV_MASK);
-	ata_eh_clear_action(dev, &dev->link->eh_context.i, ATA_EH_PERDEV_MASK);
+	ata_eh_clear_action(link, dev, &link->eh_info, ATA_EH_PERDEV_MASK);
+	ata_eh_clear_action(link, dev, &link->eh_context.i, ATA_EH_PERDEV_MASK);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 }
@@ -797,7 +799,7 @@ static void ata_eh_about_to_do(struct at
 		ehi->flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
 	}
 
-	ata_eh_clear_action(dev, ehi, action);
+	ata_eh_clear_action(&ap->link, dev, ehi, action);
 
 	if (!(ehc->i.flags & ATA_EHI_QUIET))
 		ap->pflags |= ATA_PFLAG_RECOVERED;
@@ -828,7 +830,7 @@ static void ata_eh_done(struct ata_port 
 		ehc->i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
 	}
 
-	ata_eh_clear_action(dev, &ehc->i, action);
+	ata_eh_clear_action(&ap->link, dev, &ehc->i, action);
 }
 
 /**
@@ -1469,10 +1471,11 @@ static void ata_eh_report(struct ata_por
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
@@ -1482,14 +1485,16 @@ static int ata_do_reset(struct ata_port 
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
@@ -1514,9 +1519,10 @@ static int ata_eh_reset(struct ata_port 
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
+	struct ata_device *dev;
 	unsigned int action;
 	ata_reset_fn_t reset;
-	int i, did_followup_srst, rc;
+	int did_followup_srst, rc;
 
 	/* about to reset */
 	ata_eh_about_to_do(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
@@ -1552,8 +1558,8 @@ static int ata_eh_reset(struct ata_port 
 		reset = softreset;
 	else {
 		/* prereset told us not to reset, bang classes and return */
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			classes[i] = ATA_DEV_NONE;
+		ata_link_for_each_dev(dev, &ap->link)
+			classes[dev->devno] = ATA_DEV_NONE;
 		return 0;
 	}
 
@@ -1629,8 +1635,8 @@ static int ata_eh_reset(struct ata_port 
 		/* After the reset, the device state is PIO 0 and the
 		 * controller state is undefined.  Record the mode.
 		 */
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ap->link.device[i].pio_mode = XFER_PIO_0;
+		ata_link_for_each_dev(dev, &ap->link)
+			dev->pio_mode = XFER_PIO_0;
 
 		if (postreset)
 			postreset(ap, classes);
@@ -1649,15 +1655,12 @@ static int ata_eh_revalidate_and_attach(
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
@@ -1721,16 +1724,14 @@ static int ata_eh_revalidate_and_attach(
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
@@ -1785,15 +1786,11 @@ static void ata_eh_prep_resume(struct at
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
@@ -1823,15 +1820,13 @@ static void ata_eh_prep_resume(struct at
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
@@ -1862,20 +1857,22 @@ static int ata_eh_resume(struct ata_port
 
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
@@ -1883,17 +1880,15 @@ static int ata_port_nr_vacant(struct ata
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
 		if (!(dev->flags & ATA_DFLAG_SUSPENDED))
 			break;
 	}
 
-	if (i == ata_port_max_devices(ap))
+	if (dev == NULL)
 		return 1;
 
 	/* thaw frozen port, resume link and recover failed devices */
@@ -1902,9 +1897,7 @@ static int ata_eh_skip_recovery(struct a
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
-
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (dev->class == ATA_DEV_UNKNOWN &&
 		    ehc->classes[dev->devno] != ATA_DEV_NONE)
 			return 0;
@@ -1989,14 +1982,12 @@ static int ata_eh_recover(struct ata_por
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
@@ -2028,8 +2019,8 @@ static int ata_eh_recover(struct ata_por
 	if (ata_eh_skip_recovery(ap))
 		ehc->i.action = 0;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ehc->classes[i] = ATA_DEV_UNKNOWN;
+	ata_link_for_each_dev(dev, &ap->link)
+		ehc->classes[dev->devno] = ATA_DEV_UNKNOWN;
 
 	/* reset */
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
@@ -2091,8 +2082,8 @@ static int ata_eh_recover(struct ata_por
 		/* recovery failed, activate hp-poll */
 		ata_hp_poll_activate(ap);
 
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ata_dev_disable(&ap->link.device[i]);
+		ata_link_for_each_dev(dev, &ap->link);
+			ata_dev_disable(dev);
 	}
 
 	DPRINTK("EXIT, rc=%d\n", rc);
@@ -2235,7 +2226,7 @@ static void ata_eh_handle_port_resume(st
 {
 	unsigned long timeout;
 	unsigned long flags;
-	int i, rc = 0;
+	int rc = 0;
 
 	/* are we resuming? */
 	spin_lock_irqsave(ap->lock, flags);
@@ -2256,8 +2247,9 @@ static void ata_eh_handle_port_resume(st
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
@@ -2265,7 +2257,7 @@ static void ata_eh_handle_port_resume(st
 				break;
 		}
 
-		if (i == ATA_MAX_DEVICES || time_after(jiffies, timeout))
+		if (dev == NULL || time_after(jiffies, timeout))
 			break;
 		msleep(10);
 	}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a8d988e..771097d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -543,7 +543,7 @@ int ata_scsi_device_resume(struct scsi_d
 	/* We don't want autopsy and verbose EH messages.  Disable
 	 * those if we're the only device on this link.
 	 */
-	if (ata_port_max_devices(ap) == 1)
+	if (ata_link_max_devices(dev->link) == 1)
 		ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
 	ata_port_schedule_eh(ap);
@@ -2521,7 +2521,7 @@ static unsigned int atapi_xlat(struct at
 
 static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
 {
-	if (likely(id < ATA_MAX_DEVICES))
+	if (likely(id < ata_link_max_devices(&ap->link)))
 		return &ap->link.device[id];
 	return NULL;
 }
@@ -2975,19 +2975,18 @@ void ata_scsi_simulate(struct ata_device
 
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
 
-		sdev = __scsi_add_device(ap->scsi_host, 0, i, 0, NULL);
+		sdev = __scsi_add_device(ap->scsi_host, 0, dev->devno, 0, NULL);
 		if (!IS_ERR(sdev)) {
 			dev->sdev = sdev;
 			scsi_device_put(sdev);
@@ -3093,7 +3092,7 @@ static void ata_scsi_remove_dev(struct a
 void ata_scsi_hotplug(void *data)
 {
 	struct ata_port *ap = data;
-	int i;
+	struct ata_device *dev;
 
 	if (ap->pflags & ATA_PFLAG_UNLOADING) {
 		DPRINTK("ENTER/EXIT - unloading\n");
@@ -3103,8 +3102,7 @@ void ata_scsi_hotplug(void *data)
 	DPRINTK("ENTER\n");
 
 	/* unplug detached devices */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, &ap->link) {
 		unsigned long flags;
 
 		if (!(dev->flags & ATA_DFLAG_DETACHED))
@@ -3124,8 +3122,7 @@ void ata_scsi_hotplug(void *data)
 	 * failed silently.  Requeue if there are enabled but
 	 * unattached devices.
 	 */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (ata_dev_enabled(dev) && !dev->sdev) {
 			queue_delayed_work(ata_aux_wq, &ap->hotplug_task, HZ);
 			break;
@@ -3169,7 +3166,7 @@ static int ata_scsi_user_scan(struct Scs
 	spin_lock_irqsave(ap->lock, flags);
 
 	if (id == SCAN_WILD_CARD) {
-		ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
+		ehi->probe_mask |= (1 << ata_link_max_devices(&ap->link)) - 1;
 		ehi->action |= ATA_EH_SOFTRESET;
 	} else {
 		struct ata_device *dev = ata_find_dev(ap, id);
@@ -3206,11 +3203,8 @@ void ata_scsi_dev_rescan(void *data)
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
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index d883906..98fcd8a 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -486,22 +486,21 @@ static unsigned int it821x_passthru_qc_i
 static void it821x_smart_set_mode(struct ata_port *ap)
 {
 	int dma_enabled = 0;
-	int i;
+	struct ata_device *dev;
 
 	/* Bits 5 and 6 indicate if DMA is active on master/slave */
 	/* It is possible that BMDMA isn't allocated */
 	if (ap->ioaddr.bmdma_addr)
 		dma_enabled = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
 			dev->dma_mode = XFER_MW_DMA_0;
 			/* We do need the right mode information for DMA or PIO
 			   and this comes from the current configuration flags */
-			if (dma_enabled & (1 << (5 + i))) {
+			if (dma_enabled & (1 << (5 + dev->devno))) {
 				dev->xfer_mode = XFER_MW_DMA_0;
 				dev->xfer_shift = ATA_SHIFT_MWDMA;
 				dev->flags &= ~ATA_DFLAG_PIO;
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 10231ef..613c915 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -107,10 +107,9 @@ static int pio_mask = 0x1F;		/* PIO rang
 
 static void legacy_set_mode(struct ata_port *ap)
 {
-	int i;
+	struct ata_device *dev;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (ata_dev_enabled(dev)) {
 			dev->pio_mode = XFER_PIO_0;
 			dev->xfer_mode = XFER_PIO_0;
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 09c01ca..6d60dbe 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -453,11 +453,9 @@ static void pdc2027x_set_dmamode(struct 
  */
 static void pdc2027x_post_set_mode(struct ata_port *ap)
 {
-	int i;
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
+	struct ata_device *dev;
 
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (ata_dev_enabled(dev)) {
 
 			pdc2027x_set_piomode(ap, dev);
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index b59fafd..c231631 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -60,10 +60,9 @@ static void rz1000_error_handler(struct 
 
 static void rz1000_set_mode(struct ata_port *ap)
 {
-	int i;
+	struct ata_device *dev;
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->link.device[i];
+	ata_link_for_each_dev(dev, &ap->link) {
 		if (ata_dev_enabled(dev)) {
 			/* We don't really care */
 			dev->pio_mode = XFER_PIO_0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fb6d334..48503d4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1032,15 +1032,23 @@ static inline unsigned int ata_dev_ready
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
1.4.2.3


