From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream 1/3] libata: beef up iterators
Date: Mon, 03 Nov 2008 20:03:17 +0900
Message-ID: <490EDA75.5060703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40174 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649AbYKCLDo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 06:03:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik l <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Elias Oltmanns <eo@nebensachen.de>

There currently are the following looping constructs.

* __ata_port_for_each_link() for all available links
* ata_port_for_each_link() for edge links
* ata_link_for_each_dev() for all devices
* ata_link_for_each_dev_reverse() for all devices in reverse order

Now there's a need for looping construct which is similar to
__ata_port_for_each_link() but iterates over PMP links before the host
link.  Instead of adding another one with long name, do the following
cleanup.

* Implement and export ata_link_next() and ata_dev_next() which take
  @mode parameter and can be used to build custom loop.
* Implement ata_for_each_link() and ata_for_each_dev() which take
  looping mode explicitly.

The following iteration modes are implemented.

* ATA_LITER_EDGE		: loop over edge links
* ATA_LITER_HOST_FIRST		: loop over all links, host link first
* ATA_LITER_PMP_FIRST		: loop over all links, PMP links first

* ATA_DITER_ENABLED		: loop over enabled devices
* ATA_DITER_ENABLED_REVERSE	: loop over enabled devices in reverse order
* ATA_DITER_ALL			: loop over all devices
* ATA_DITER_ALL_REVERSE		: loop over all devices in reverse order

This change removes exlicit device enabledness checks from many loops
and makes it clear which ones are iterated over in which direction.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Comments added and retargeted for #upstream.

This patchset is on top of

#upstream-fixes (9ce8e3073d9cfd6f859c22a25441db41b85cbf6e)
+ [1] patches-which-fell-off-the-crack-during-maintainership-handover patchset
+ [2] mask-off-DET-when-restoring-SControl-for-detach

[1] http://thread.gmane.org/gmane.linux.ide/35783
[2] http://article.gmane.org/gmane.linux.ide/35792

 drivers/ata/ahci.c           |    8 +-
 drivers/ata/ata_generic.c    |    5 +-
 drivers/ata/libata-acpi.c    |   19 ++---
 drivers/ata/libata-core.c    |  183 ++++++++++++++++++++++++++++--------------
 drivers/ata/libata-eh.c      |   84 +++++++++-----------
 drivers/ata/libata-pmp.c     |   22 +++---
 drivers/ata/libata-scsi.c    |   22 +++---
 drivers/ata/pata_it821x.c    |   34 ++++----
 drivers/ata/pata_ixp4xx_cf.c |   14 ++--
 drivers/ata/pata_legacy.c    |   17 ++---
 drivers/ata/pata_pdc2027x.c  |   31 +++----
 drivers/ata/pata_platform.c  |   14 ++--
 drivers/ata/pata_rz1000.c    |   16 ++--
 drivers/ata/sata_sil.c       |    2 +-
 include/linux/libata.h       |   76 +++++++++++++-----
 15 files changed, 307 insertions(+), 240 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8e8790b..4e84c5c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1119,14 +1119,14 @@ static void ahci_start_port(struct ata_port *ap)
 
 	/* turn on LEDs */
 	if (ap->flags & ATA_FLAG_EM) {
-		ata_port_for_each_link(link, ap) {
+		ata_for_each_link(link, ap, EDGE) {
 			emp = &pp->em_priv[link->pmp];
 			ahci_transmit_led_message(ap, emp->led_state, 4);
 		}
 	}
 
 	if (ap->flags & ATA_FLAG_SW_ACTIVITY)
-		ata_port_for_each_link(link, ap)
+		ata_for_each_link(link, ap, EDGE)
 			ahci_init_sw_activity(link);
 
 }
@@ -1361,7 +1361,7 @@ static ssize_t ahci_led_show(struct ata_port *ap, char *buf)
 	struct ahci_em_priv *emp;
 	int rc = 0;
 
-	ata_port_for_each_link(link, ap) {
+	ata_for_each_link(link, ap, EDGE) {
 		emp = &pp->em_priv[link->pmp];
 		rc += sprintf(buf, "%lx\n", emp->led_state);
 	}
@@ -1941,7 +1941,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	u32 serror;
 
 	/* determine active link */
-	ata_port_for_each_link(link, ap)
+	ata_for_each_link(link, ap, EDGE)
 		if (ata_link_active(link))
 			break;
 	if (!link)
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 5c33767..dc48a63 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -57,10 +57,7 @@ static int generic_set_mode(struct ata_link *link, struct ata_device **unused)
 	if (pdev->vendor == PCI_VENDOR_ID_CENATEK)
 		dma_enabled = 0xFF;
 
-	ata_link_for_each_dev(dev, link) {
-		if (!ata_dev_enabled(dev))
-			continue;
-
+	ata_for_each_dev(dev, link, ENABLED) {
 		/* We don't really care */
 		dev->pio_mode = XFER_PIO_0;
 		dev->dma_mode = XFER_MW_DMA_0;
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index c012307..ef02e48 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -89,7 +89,7 @@ void ata_acpi_associate_sata_port(struct ata_port *ap)
 
 		ap->link.device->acpi_handle = NULL;
 
-		ata_port_for_each_link(link, ap) {
+		ata_for_each_link(link, ap, EDGE) {
 			acpi_integer adr = SATA_ADR(ap->port_no, link->pmp);
 
 			link->device->acpi_handle =
@@ -129,8 +129,8 @@ static void ata_acpi_detach_device(struct ata_port *ap, struct ata_device *dev)
 		struct ata_link *tlink;
 		struct ata_device *tdev;
 
-		ata_port_for_each_link(tlink, ap)
-			ata_link_for_each_dev(tdev, tlink)
+		ata_for_each_link(tlink, ap, EDGE)
+			ata_for_each_dev(tdev, tlink, ALL)
 				tdev->flags |= ATA_DFLAG_DETACH;
 	}
 
@@ -588,12 +588,9 @@ int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
 {
 	struct ata_device *dev;
 
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_for_each_dev(dev, &ap->link, ENABLED) {
 		unsigned long xfer_mask, udma_mask;
 
-		if (!ata_dev_enabled(dev))
-			continue;
-
 		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
 		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
 
@@ -893,7 +890,7 @@ void ata_acpi_on_resume(struct ata_port *ap)
 		 * use values set by _STM.  Cache _GTF result and
 		 * schedule _GTF.
 		 */
-		ata_link_for_each_dev(dev, &ap->link) {
+		ata_for_each_dev(dev, &ap->link, ALL) {
 			ata_acpi_clear_gtf(dev);
 			if (ata_dev_enabled(dev) &&
 			    ata_dev_get_GTF(dev, NULL) >= 0)
@@ -904,7 +901,7 @@ void ata_acpi_on_resume(struct ata_port *ap)
 		 * there's no reason to evaluate IDE _GTF early
 		 * without _STM.  Clear cache and schedule _GTF.
 		 */
-		ata_link_for_each_dev(dev, &ap->link) {
+		ata_for_each_dev(dev, &ap->link, ALL) {
 			ata_acpi_clear_gtf(dev);
 			if (ata_dev_enabled(dev))
 				dev->flags |= ATA_DFLAG_ACPI_PENDING;
@@ -932,8 +929,8 @@ void ata_acpi_set_state(struct ata_port *ap, pm_message_t state)
 	if (state.event == PM_EVENT_ON)
 		acpi_bus_set_power(ap->acpi_handle, ACPI_STATE_D0);
 
-	ata_link_for_each_dev(dev, &ap->link) {
-		if (dev->acpi_handle && ata_dev_enabled(dev))
+	ata_for_each_dev(dev, &ap->link, ENABLED) {
+		if (dev->acpi_handle)
 			acpi_bus_set_power(dev->acpi_handle,
 				state.event == PM_EVENT_ON ?
 					ACPI_STATE_D0 : ACPI_STATE_D3);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 622350d..f527c30 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -163,43 +163,119 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 
-/*
- * Iterator helpers.  Don't use directly.
+/**
+ *	ata_link_next - link iteration helper
+ *	@link: the previous link, NULL to start
+ *	@ap: ATA port containing links to iterate
+ *	@mode: iteration mode, one of ATA_LITER_*
+ *
+ *	LOCKING:
+ *	Host lock or EH context.
  *
- * LOCKING:
- * Host lock or EH context.
+ *	RETURNS:
+ *	Pointer to the next link.
  */
-struct ata_link *__ata_port_next_link(struct ata_port *ap,
-				      struct ata_link *link, bool dev_only)
+struct ata_link *ata_link_next(struct ata_link *link, struct ata_port *ap,
+			       enum ata_link_iter_mode mode)
 {
+	BUG_ON(mode != ATA_LITER_EDGE &&
+	       mode != ATA_LITER_PMP_FIRST && mode != ATA_LITER_HOST_FIRST);
+
 	/* NULL link indicates start of iteration */
-	if (!link) {
-		if (dev_only && sata_pmp_attached(ap))
-			return ap->pmp_link;
-		return &ap->link;
-	}
+	if (!link)
+		switch (mode) {
+		case ATA_LITER_EDGE:
+		case ATA_LITER_PMP_FIRST:
+			if (sata_pmp_attached(ap))
+				return ap->pmp_link;
+			/* fall through */
+		case ATA_LITER_HOST_FIRST:
+			return &ap->link;
+		}
 
-	/* we just iterated over the host master link, what's next? */
-	if (link == &ap->link) {
-		if (!sata_pmp_attached(ap)) {
-			if (unlikely(ap->slave_link) && !dev_only)
+	/* we just iterated over the host link, what's next? */
+	if (link == &ap->link)
+		switch (mode) {
+		case ATA_LITER_HOST_FIRST:
+			if (sata_pmp_attached(ap))
+				return ap->pmp_link;
+			/* fall through */
+		case ATA_LITER_PMP_FIRST:
+			if (unlikely(ap->slave_link))
 				return ap->slave_link;
+			/* fall through */
+		case ATA_LITER_EDGE:
 			return NULL;
 		}
-		return ap->pmp_link;
-	}
 
 	/* slave_link excludes PMP */
 	if (unlikely(link == ap->slave_link))
 		return NULL;
 
-	/* iterate to the next PMP link */
+	/* we were over a PMP link */
 	if (++link < ap->pmp_link + ap->nr_pmp_links)
 		return link;
+
+	if (mode == ATA_LITER_PMP_FIRST)
+		return &ap->link;
+
 	return NULL;
 }
 
 /**
+ *	ata_dev_next - device iteration helper
+ *	@dev: the previous device, NULL to start
+ *	@link: ATA link containing devices to iterate
+ *	@mode: iteration mode, one of ATA_DITER_*
+ *
+ *	LOCKING:
+ *	Host lock or EH context.
+ *
+ *	RETURNS:
+ *	Pointer to the next device.
+ */
+struct ata_device *ata_dev_next(struct ata_device *dev, struct ata_link *link,
+				enum ata_dev_iter_mode mode)
+{
+	BUG_ON(mode != ATA_DITER_ENABLED && mode != ATA_DITER_ENABLED_REVERSE &&
+	       mode != ATA_DITER_ALL && mode != ATA_DITER_ALL_REVERSE);
+
+	/* NULL dev indicates start of iteration */
+	if (!dev)
+		switch (mode) {
+		case ATA_DITER_ENABLED:
+		case ATA_DITER_ALL:
+			dev = link->device;
+			goto check;
+		case ATA_DITER_ENABLED_REVERSE:
+		case ATA_DITER_ALL_REVERSE:
+			dev = link->device + ata_link_max_devices(link) - 1;
+			goto check;
+		}
+
+ next:
+	/* move to the next one */
+	switch (mode) {
+	case ATA_DITER_ENABLED:
+	case ATA_DITER_ALL:
+		if (++dev < link->device + ata_link_max_devices(link))
+			goto check;
+		return NULL;
+	case ATA_DITER_ENABLED_REVERSE:
+	case ATA_DITER_ALL_REVERSE:
+		if (--dev >= link->device)
+			goto check;
+		return NULL;
+	}
+
+ check:
+	if ((mode == ATA_DITER_ENABLED || mode == ATA_DITER_ENABLED_REVERSE) &&
+	    !ata_dev_enabled(dev))
+		goto next;
+	return dev;
+}
+
+/**
  *	ata_dev_phys_link - find physical link for a device
  *	@dev: ATA device to look up physical link for
  *
@@ -1107,8 +1183,8 @@ static void ata_lpm_enable(struct ata_host *host)
 
 	for (i = 0; i < host->n_ports; i++) {
 		ap = host->ports[i];
-		ata_port_for_each_link(link, ap) {
-			ata_link_for_each_dev(dev, link)
+		ata_for_each_link(link, ap, EDGE) {
+			ata_for_each_dev(dev, link, ALL)
 				ata_dev_disable_pm(dev);
 		}
 	}
@@ -2585,11 +2661,11 @@ int ata_bus_probe(struct ata_port *ap)
 
 	ata_port_probe(ap);
 
-	ata_link_for_each_dev(dev, &ap->link)
+	ata_for_each_dev(dev, &ap->link, ALL)
 		tries[dev->devno] = ATA_PROBE_MAX_TRIES;
 
  retry:
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_for_each_dev(dev, &ap->link, ALL) {
 		/* If we issue an SRST then an ATA drive (not ATAPI)
 		 * may change configuration and be in PIO0 timing. If
 		 * we do a hard reset (or are coming from power on)
@@ -2611,7 +2687,7 @@ int ata_bus_probe(struct ata_port *ap)
 	/* reset and determine device classes */
 	ap->ops->phy_reset(ap);
 
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_for_each_dev(dev, &ap->link, ALL) {
 		if (!(ap->flags & ATA_FLAG_DISABLED) &&
 		    dev->class != ATA_DEV_UNKNOWN)
 			classes[dev->devno] = dev->class;
@@ -2627,7 +2703,7 @@ int ata_bus_probe(struct ata_port *ap)
 	   specific sequence bass-ackwards so that PDIAG- is released by
 	   the slave device */
 
-	ata_link_for_each_dev_reverse(dev, &ap->link) {
+	ata_for_each_dev(dev, &ap->link, ALL_REVERSE) {
 		if (tries[dev->devno])
 			dev->class = classes[dev->devno];
 
@@ -2644,24 +2720,19 @@ int ata_bus_probe(struct ata_port *ap)
 	if (ap->ops->cable_detect)
 		ap->cbl = ap->ops->cable_detect(ap);
 
-	/* We may have SATA bridge glue hiding here irrespective of the
-	   reported cable types and sensed types */
-	ata_link_for_each_dev(dev, &ap->link) {
-		if (!ata_dev_enabled(dev))
-			continue;
-		/* SATA drives indicate we have a bridge. We don't know which
-		   end of the link the bridge is which is a problem */
+	/* We may have SATA bridge glue hiding here irrespective of
+	 * the reported cable types and sensed types.  When SATA
+	 * drives indicate we have a bridge, we don't know which end
+	 * of the link the bridge is which is a problem.
+	 */
+	ata_for_each_dev(dev, &ap->link, ENABLED)
 		if (ata_id_is_sata(dev->id))
 			ap->cbl = ATA_CBL_SATA;
-	}
 
 	/* After the identify sequence we can now set up the devices. We do
 	   this in the normal order so that the user doesn't get confused */
 
-	ata_link_for_each_dev(dev, &ap->link) {
-		if (!ata_dev_enabled(dev))
-			continue;
-
+	ata_for_each_dev(dev, &ap->link, ENABLED) {
 		ap->link.eh_context.i.flags |= ATA_EHI_PRINTINFO;
 		rc = ata_dev_configure(dev);
 		ap->link.eh_context.i.flags &= ~ATA_EHI_PRINTINFO;
@@ -2674,9 +2745,8 @@ int ata_bus_probe(struct ata_port *ap)
 	if (rc)
 		goto fail;
 
-	ata_link_for_each_dev(dev, &ap->link)
-		if (ata_dev_enabled(dev))
-			return 0;
+	ata_for_each_dev(dev, &ap->link, ENABLED)
+		return 0;
 
 	/* no device present, disable port */
 	ata_port_disable(ap);
@@ -3322,13 +3392,10 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 	int rc = 0, used_dma = 0, found = 0;
 
 	/* step 1: calculate xfer_mask */
-	ata_link_for_each_dev(dev, link) {
+	ata_for_each_dev(dev, link, ENABLED) {
 		unsigned long pio_mask, dma_mask;
 		unsigned int mode_mask;
 
-		if (!ata_dev_enabled(dev))
-			continue;
-
 		mode_mask = ATA_DMA_MASK_ATA;
 		if (dev->class == ATA_DEV_ATAPI)
 			mode_mask = ATA_DMA_MASK_ATAPI;
@@ -3357,10 +3424,7 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 		goto out;
 
 	/* step 2: always set host PIO timings */
-	ata_link_for_each_dev(dev, link) {
-		if (!ata_dev_enabled(dev))
-			continue;
-
+	ata_for_each_dev(dev, link, ENABLED) {
 		if (dev->pio_mode == 0xff) {
 			ata_dev_printk(dev, KERN_WARNING, "no PIO support\n");
 			rc = -EINVAL;
@@ -3374,8 +3438,8 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 	}
 
 	/* step 3: set host DMA timings */
-	ata_link_for_each_dev(dev, link) {
-		if (!ata_dev_enabled(dev) || !ata_dma_enabled(dev))
+	ata_for_each_dev(dev, link, ENABLED) {
+		if (!ata_dma_enabled(dev))
 			continue;
 
 		dev->xfer_mode = dev->dma_mode;
@@ -3385,11 +3449,7 @@ int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 	}
 
 	/* step 4: update devices' xfer mode */
-	ata_link_for_each_dev(dev, link) {
-		/* don't update suspended devices' xfer mode */
-		if (!ata_dev_enabled(dev))
-			continue;
-
+	ata_for_each_dev(dev, link, ENABLED) {
 		rc = ata_dev_set_mode(dev);
 		if (rc)
 			goto out;
@@ -4187,9 +4247,9 @@ static int cable_is_40wire(struct ata_port *ap)
 	 * - if you have a non detect capable drive you don't want it
 	 *   to colour the choice
 	 */
-	ata_port_for_each_link(link, ap) {
-		ata_link_for_each_dev(dev, link) {
-			if (ata_dev_enabled(dev) && !ata_is_40wire(dev))
+	ata_for_each_link(link, ap, EDGE) {
+		ata_for_each_dev(dev, link, ENABLED) {
+			if (!ata_is_40wire(dev))
 				return 0;
 		}
 	}
@@ -5090,7 +5150,7 @@ static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 		}
 
 		ap->pflags |= ATA_PFLAG_PM_PENDING;
-		__ata_port_for_each_link(link, ap) {
+		ata_for_each_link(link, ap, HOST_FIRST) {
 			link->eh_info.action |= action;
 			link->eh_info.flags |= ehi_flags;
 		}
@@ -5935,9 +5995,9 @@ static void ata_port_detach(struct ata_port *ap)
 	/* EH is now guaranteed to see UNLOADING - EH context belongs
 	 * to us.  Restore SControl and disable all existing devices.
 	 */
-	__ata_port_for_each_link(link, ap) {
+	ata_for_each_link(link, ap, HOST_FIRST) {
 		sata_scr_write(link, SCR_CONTROL, link->saved_scontrol & 0xff0);
-		ata_link_for_each_dev(dev, link)
+		ata_for_each_dev(dev, link, ALL)
 			ata_dev_disable(dev);
 	}
 
@@ -6400,7 +6460,8 @@ EXPORT_SYMBOL_GPL(ata_base_port_ops);
 EXPORT_SYMBOL_GPL(sata_port_ops);
 EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_dummy_port_info);
-EXPORT_SYMBOL_GPL(__ata_port_next_link);
+EXPORT_SYMBOL_GPL(ata_link_next);
+EXPORT_SYMBOL_GPL(ata_dev_next);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_host_alloc);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8077bdf..82f4be3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -422,7 +422,7 @@ static void ata_eh_clear_action(struct ata_link *link, struct ata_device *dev,
 
 	if (!dev) {
 		ehi->action &= ~action;
-		ata_link_for_each_dev(tdev, link)
+		ata_for_each_dev(tdev, link, ALL)
 			ehi->dev_action[tdev->devno] &= ~action;
 	} else {
 		/* doesn't make sense for port-wide EH actions */
@@ -430,7 +430,7 @@ static void ata_eh_clear_action(struct ata_link *link, struct ata_device *dev,
 
 		/* break ehi->action into ehi->dev_action */
 		if (ehi->action & action) {
-			ata_link_for_each_dev(tdev, link)
+			ata_for_each_dev(tdev, link, ALL)
 				ehi->dev_action[tdev->devno] |=
 					ehi->action & action;
 			ehi->action &= ~action;
@@ -592,7 +592,7 @@ void ata_scsi_error(struct Scsi_Host *host)
 		/* fetch & clear EH info */
 		spin_lock_irqsave(ap->lock, flags);
 
-		__ata_port_for_each_link(link, ap) {
+		ata_for_each_link(link, ap, HOST_FIRST) {
 			struct ata_eh_context *ehc = &link->eh_context;
 			struct ata_device *dev;
 
@@ -600,12 +600,9 @@ void ata_scsi_error(struct Scsi_Host *host)
 			link->eh_context.i = link->eh_info;
 			memset(&link->eh_info, 0, sizeof(link->eh_info));
 
-			ata_link_for_each_dev(dev, link) {
+			ata_for_each_dev(dev, link, ENABLED) {
 				int devno = dev->devno;
 
-				if (!ata_dev_enabled(dev))
-					continue;
-
 				ehc->saved_xfer_mode[devno] = dev->xfer_mode;
 				if (ata_ncq_enabled(dev))
 					ehc->saved_ncq_enabled |= 1 << devno;
@@ -647,7 +644,7 @@ void ata_scsi_error(struct Scsi_Host *host)
 		}
 
 		/* this run is complete, make sure EH info is clear */
-		__ata_port_for_each_link(link, ap)
+		ata_for_each_link(link, ap, HOST_FIRST)
 			memset(&link->eh_info, 0, sizeof(link->eh_info));
 
 		/* Clear host_eh_scheduled while holding ap->lock such
@@ -1028,7 +1025,7 @@ int sata_async_notification(struct ata_port *ap)
 		struct ata_link *link;
 
 		/* check and notify ATAPI AN */
-		ata_port_for_each_link(link, ap) {
+		ata_for_each_link(link, ap, EDGE) {
 			if (!(sntf & (1 << link->pmp)))
 				continue;
 
@@ -2008,7 +2005,7 @@ void ata_eh_autopsy(struct ata_port *ap)
 {
 	struct ata_link *link;
 
-	ata_port_for_each_link(link, ap)
+	ata_for_each_link(link, ap, EDGE)
 		ata_eh_link_autopsy(link);
 
 	/* Handle the frigging slave link.  Autopsy is done similarly
@@ -2222,7 +2219,7 @@ void ata_eh_report(struct ata_port *ap)
 {
 	struct ata_link *link;
 
-	__ata_port_for_each_link(link, ap)
+	ata_for_each_link(link, ap, HOST_FIRST)
 		ata_eh_link_report(link);
 }
 
@@ -2233,7 +2230,7 @@ static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 	struct ata_device *dev;
 
 	if (clear_classes)
-		ata_link_for_each_dev(dev, link)
+		ata_for_each_dev(dev, link, ALL)
 			classes[dev->devno] = ATA_DEV_UNKNOWN;
 
 	return reset(link, classes, deadline);
@@ -2293,7 +2290,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
 	ehc->last_reset = jiffies;
 
-	ata_link_for_each_dev(dev, link) {
+	ata_for_each_dev(dev, link, ALL) {
 		/* If we issue an SRST then an ATA drive (not ATAPI)
 		 * may change configuration and be in PIO0 timing. If
 		 * we do a hard reset (or are coming from power on)
@@ -2354,7 +2351,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 						"port disabled. ignoring.\n");
 				ehc->i.action &= ~ATA_EH_RESET;
 
-				ata_link_for_each_dev(dev, link)
+				ata_for_each_dev(dev, link, ALL)
 					classes[dev->devno] = ATA_DEV_NONE;
 
 				rc = 0;
@@ -2368,7 +2365,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		 * bang classes and return.
 		 */
 		if (reset && !(ehc->i.action & ATA_EH_RESET)) {
-			ata_link_for_each_dev(dev, link)
+			ata_for_each_dev(dev, link, ALL)
 				classes[dev->devno] = ATA_DEV_NONE;
 			rc = 0;
 			goto out;
@@ -2453,7 +2450,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/*
 	 * Post-reset processing
 	 */
-	ata_link_for_each_dev(dev, link) {
+	ata_for_each_dev(dev, link, ALL) {
 		/* After the reset, the device state is PIO 0 and the
 		 * controller state is undefined.  Reset also wakes up
 		 * drives from sleeping mode.
@@ -2509,7 +2506,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	 * can be reliably detected and retried.
 	 */
 	nr_unknown = 0;
-	ata_link_for_each_dev(dev, link) {
+	ata_for_each_dev(dev, link, ALL) {
 		/* convert all ATA_DEV_UNKNOWN to ATA_DEV_NONE */
 		if (classes[dev->devno] == ATA_DEV_UNKNOWN) {
 			classes[dev->devno] = ATA_DEV_NONE;
@@ -2618,8 +2615,8 @@ static inline void ata_eh_pull_park_action(struct ata_port *ap)
 
 	spin_lock_irqsave(ap->lock, flags);
 	INIT_COMPLETION(ap->park_req_pending);
-	ata_port_for_each_link(link, ap) {
-		ata_link_for_each_dev(dev, link) {
+	ata_for_each_link(link, ap, EDGE) {
+		ata_for_each_dev(dev, link, ALL) {
 			struct ata_eh_info *ehi = &link->eh_info;
 
 			link->eh_context.i.dev_action[dev->devno] |=
@@ -2674,7 +2671,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	 * be done backwards such that PDIAG- is released by the slave
 	 * device before the master device is identified.
 	 */
-	ata_link_for_each_dev_reverse(dev, link) {
+	ata_for_each_dev(dev, link, ALL_REVERSE) {
 		unsigned int action = ata_eh_dev_action(dev);
 		unsigned int readid_flags = 0;
 
@@ -2743,7 +2740,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 	/* Configure new devices forward such that user doesn't see
 	 * device detection messages backwards.
 	 */
-	ata_link_for_each_dev(dev, link) {
+	ata_for_each_dev(dev, link, ALL) {
 		if (!(new_mask & (1 << dev->devno)) ||
 		    dev->class == ATA_DEV_PMP)
 			continue;
@@ -2792,10 +2789,7 @@ int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 	int rc;
 
 	/* if data transfer is verified, clear DUBIOUS_XFER on ering top */
-	ata_link_for_each_dev(dev, link) {
-		if (!ata_dev_enabled(dev))
-			continue;
-
+	ata_for_each_dev(dev, link, ENABLED) {
 		if (!(dev->flags & ATA_DFLAG_DUBIOUS_XFER)) {
 			struct ata_ering_entry *ent;
 
@@ -2812,14 +2806,11 @@ int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
 		rc = ata_do_set_mode(link, r_failed_dev);
 
 	/* if transfer mode has changed, set DUBIOUS_XFER on device */
-	ata_link_for_each_dev(dev, link) {
+	ata_for_each_dev(dev, link, ENABLED) {
 		struct ata_eh_context *ehc = &link->eh_context;
 		u8 saved_xfer_mode = ehc->saved_xfer_mode[dev->devno];
 		u8 saved_ncq = !!(ehc->saved_ncq_enabled & (1 << dev->devno));
 
-		if (!ata_dev_enabled(dev))
-			continue;
-
 		if (dev->xfer_mode != saved_xfer_mode ||
 		    ata_ncq_enabled(dev) != saved_ncq)
 			dev->flags |= ATA_DFLAG_DUBIOUS_XFER;
@@ -2880,9 +2871,8 @@ static int ata_link_nr_enabled(struct ata_link *link)
 	struct ata_device *dev;
 	int cnt = 0;
 
-	ata_link_for_each_dev(dev, link)
-		if (ata_dev_enabled(dev))
-			cnt++;
+	ata_for_each_dev(dev, link, ENABLED)
+		cnt++;
 	return cnt;
 }
 
@@ -2891,7 +2881,7 @@ static int ata_link_nr_vacant(struct ata_link *link)
 	struct ata_device *dev;
 	int cnt = 0;
 
-	ata_link_for_each_dev(dev, link)
+	ata_for_each_dev(dev, link, ALL)
 		if (dev->class == ATA_DEV_UNKNOWN)
 			cnt++;
 	return cnt;
@@ -2917,7 +2907,7 @@ static int ata_eh_skip_recovery(struct ata_link *link)
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
-	ata_link_for_each_dev(dev, link) {
+	ata_for_each_dev(dev, link, ALL) {
 		if (dev->class == ATA_DEV_UNKNOWN &&
 		    ehc->classes[dev->devno] != ATA_DEV_NONE)
 			return 0;
@@ -3025,7 +3015,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	DPRINTK("ENTER\n");
 
 	/* prep for recovery */
-	ata_port_for_each_link(link, ap) {
+	ata_for_each_link(link, ap, EDGE) {
 		struct ata_eh_context *ehc = &link->eh_context;
 
 		/* re-enable link? */
@@ -3037,7 +3027,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			ata_eh_done(link, NULL, ATA_EH_ENABLE_LINK);
 		}
 
-		ata_link_for_each_dev(dev, link) {
+		ata_for_each_dev(dev, link, ALL) {
 			if (link->flags & ATA_LFLAG_NO_RETRY)
 				ehc->tries[dev->devno] = 1;
 			else
@@ -3067,19 +3057,19 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		goto out;
 
 	/* prep for EH */
-	ata_port_for_each_link(link, ap) {
+	ata_for_each_link(link, ap, EDGE) {
 		struct ata_eh_context *ehc = &link->eh_context;
 
 		/* skip EH if possible. */
 		if (ata_eh_skip_recovery(link))
 			ehc->i.action = 0;
 
-		ata_link_for_each_dev(dev, link)
+		ata_for_each_dev(dev, link, ALL)
 			ehc->classes[dev->devno] = ATA_DEV_UNKNOWN;
 	}
 
 	/* reset */
-	ata_port_for_each_link(link, ap) {
+	ata_for_each_link(link, ap, EDGE) {
 		struct ata_eh_context *ehc = &link->eh_context;
 
 		if (!(ehc->i.action & ATA_EH_RESET))
@@ -3104,8 +3094,8 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		ata_eh_pull_park_action(ap);
 
 		deadline = jiffies;
-		ata_port_for_each_link(link, ap) {
-			ata_link_for_each_dev(dev, link) {
+		ata_for_each_link(link, ap, EDGE) {
+			ata_for_each_dev(dev, link, ALL) {
 				struct ata_eh_context *ehc = &link->eh_context;
 				unsigned long tmp;
 
@@ -3133,8 +3123,8 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		deadline = wait_for_completion_timeout(&ap->park_req_pending,
 						       deadline - now);
 	} while (deadline);
-	ata_port_for_each_link(link, ap) {
-		ata_link_for_each_dev(dev, link) {
+	ata_for_each_link(link, ap, EDGE) {
+		ata_for_each_dev(dev, link, ALL) {
 			if (!(link->eh_context.unloaded_mask &
 			      (1 << dev->devno)))
 				continue;
@@ -3145,7 +3135,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	}
 
 	/* the rest */
-	ata_port_for_each_link(link, ap) {
+	ata_for_each_link(link, ap, EDGE) {
 		struct ata_eh_context *ehc = &link->eh_context;
 
 		/* revalidate existing devices and attach new ones */
@@ -3171,7 +3161,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		 * disrupting the current users of the device.
 		 */
 		if (ehc->i.flags & ATA_EHI_DID_RESET) {
-			ata_link_for_each_dev(dev, link) {
+			ata_for_each_dev(dev, link, ALL) {
 				if (dev->class != ATA_DEV_ATAPI)
 					continue;
 				rc = atapi_eh_clear_ua(dev);
@@ -3182,7 +3172,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 		/* configure link power saving */
 		if (ehc->i.action & ATA_EH_LPM)
-			ata_link_for_each_dev(dev, link)
+			ata_for_each_dev(dev, link, ALL)
 				ata_dev_enable_pm(dev, ap->pm_policy);
 
 		/* this link is okay now */
@@ -3287,7 +3277,7 @@ void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 	rc = ata_eh_recover(ap, prereset, softreset, hardreset, postreset,
 			    NULL);
 	if (rc) {
-		ata_link_for_each_dev(dev, &ap->link)
+		ata_for_each_dev(dev, &ap->link, ALL)
 			ata_dev_disable(dev);
 	}
 
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index b65db30..98ca07a 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -321,7 +321,7 @@ static void sata_pmp_quirks(struct ata_port *ap)
 
 	if (vendor == 0x1095 && devid == 0x3726) {
 		/* sil3726 quirks */
-		ata_port_for_each_link(link, ap) {
+		ata_for_each_link(link, ap, EDGE) {
 			/* Class code report is unreliable and SRST
 			 * times out under certain configurations.
 			 */
@@ -336,7 +336,7 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		}
 	} else if (vendor == 0x1095 && devid == 0x4723) {
 		/* sil4723 quirks */
-		ata_port_for_each_link(link, ap) {
+		ata_for_each_link(link, ap, EDGE) {
 			/* class code report is unreliable */
 			if (link->pmp < 2)
 				link->flags |= ATA_LFLAG_ASSUME_ATA;
@@ -348,7 +348,7 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		}
 	} else if (vendor == 0x1095 && devid == 0x4726) {
 		/* sil4726 quirks */
-		ata_port_for_each_link(link, ap) {
+		ata_for_each_link(link, ap, EDGE) {
 			/* Class code report is unreliable and SRST
 			 * times out under certain configurations.
 			 * Config device can be at port 0 or 5 and
@@ -450,7 +450,7 @@ int sata_pmp_attach(struct ata_device *dev)
 	if (ap->ops->pmp_attach)
 		ap->ops->pmp_attach(ap);
 
-	ata_port_for_each_link(tlink, ap)
+	ata_for_each_link(tlink, ap, EDGE)
 		sata_link_init_spd(tlink);
 
 	ata_acpi_associate_sata_port(ap);
@@ -487,7 +487,7 @@ static void sata_pmp_detach(struct ata_device *dev)
 	if (ap->ops->pmp_detach)
 		ap->ops->pmp_detach(ap);
 
-	ata_port_for_each_link(tlink, ap)
+	ata_for_each_link(tlink, ap, EDGE)
 		ata_eh_detach_dev(tlink->device);
 
 	spin_lock_irqsave(ap->lock, flags);
@@ -700,7 +700,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 		}
 
 		/* PMP is reset, SErrors cannot be trusted, scan all */
-		ata_port_for_each_link(tlink, ap) {
+		ata_for_each_link(tlink, ap, EDGE) {
 			struct ata_eh_context *ehc = &tlink->eh_context;
 
 			ehc->i.probe_mask |= ATA_ALL_DEVICES;
@@ -768,7 +768,7 @@ static int sata_pmp_eh_handle_disabled_links(struct ata_port *ap)
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ata_port_for_each_link(link, ap) {
+	ata_for_each_link(link, ap, EDGE) {
 		if (!(link->flags & ATA_LFLAG_DISABLED))
 			continue;
 
@@ -852,7 +852,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 	int cnt, rc;
 
 	pmp_tries = ATA_EH_PMP_TRIES;
-	ata_port_for_each_link(link, ap)
+	ata_for_each_link(link, ap, EDGE)
 		link_tries[link->pmp] = ATA_EH_PMP_LINK_TRIES;
 
  retry:
@@ -861,7 +861,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 		rc = ata_eh_recover(ap, ops->prereset, ops->softreset,
 				    ops->hardreset, ops->postreset, NULL);
 		if (rc) {
-			ata_link_for_each_dev(dev, &ap->link)
+			ata_for_each_dev(dev, &ap->link, ALL)
 				ata_dev_disable(dev);
 			return rc;
 		}
@@ -870,7 +870,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 			return 0;
 
 		/* new PMP online */
-		ata_port_for_each_link(link, ap)
+		ata_for_each_link(link, ap, EDGE)
 			link_tries[link->pmp] = ATA_EH_PMP_LINK_TRIES;
 
 		/* fall through */
@@ -942,7 +942,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 	}
 
 	cnt = 0;
-	ata_port_for_each_link(link, ap) {
+	ata_for_each_link(link, ap, EDGE) {
 		if (!(gscr_error & (1 << link->pmp)))
 			continue;
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d12f84f..96163f8 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3262,12 +3262,12 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 		return;
 
  repeat:
-	ata_port_for_each_link(link, ap) {
-		ata_link_for_each_dev(dev, link) {
+	ata_for_each_link(link, ap, EDGE) {
+		ata_for_each_dev(dev, link, ENABLED) {
 			struct scsi_device *sdev;
 			int channel = 0, id = 0;
 
-			if (!ata_dev_enabled(dev) || dev->sdev)
+			if (dev->sdev)
 				continue;
 
 			if (ata_is_host_link(link))
@@ -3288,9 +3288,9 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 	 * failure occurred, scan would have failed silently.  Check
 	 * whether all devices are attached.
 	 */
-	ata_port_for_each_link(link, ap) {
-		ata_link_for_each_dev(dev, link) {
-			if (ata_dev_enabled(dev) && !dev->sdev)
+	ata_for_each_link(link, ap, EDGE) {
+		ata_for_each_dev(dev, link, ENABLED) {
+			if (!dev->sdev)
 				goto exit_loop;
 		}
 	}
@@ -3414,7 +3414,7 @@ static void ata_scsi_handle_link_detach(struct ata_link *link)
 	struct ata_port *ap = link->ap;
 	struct ata_device *dev;
 
-	ata_link_for_each_dev(dev, link) {
+	ata_for_each_dev(dev, link, ALL) {
 		unsigned long flags;
 
 		if (!(dev->flags & ATA_DFLAG_DETACHED))
@@ -3529,7 +3529,7 @@ static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 	if (devno == SCAN_WILD_CARD) {
 		struct ata_link *link;
 
-		ata_port_for_each_link(link, ap) {
+		ata_for_each_link(link, ap, EDGE) {
 			struct ata_eh_info *ehi = &link->eh_info;
 			ehi->probe_mask |= ATA_ALL_DEVICES;
 			ehi->action |= ATA_EH_RESET;
@@ -3577,11 +3577,11 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ata_port_for_each_link(link, ap) {
-		ata_link_for_each_dev(dev, link) {
+	ata_for_each_link(link, ap, EDGE) {
+		ata_for_each_dev(dev, link, ENABLED) {
 			struct scsi_device *sdev = dev->sdev;
 
-			if (!ata_dev_enabled(dev) || !sdev)
+			if (!sdev)
 				continue;
 			if (scsi_device_get(sdev))
 				continue;
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 860ede5..f828a29 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -465,24 +465,22 @@ static int it821x_smart_set_mode(struct ata_link *link, struct ata_device **unus
 {
 	struct ata_device *dev;
 
-	ata_link_for_each_dev(dev, link) {
-		if (ata_dev_enabled(dev)) {
-			/* We don't really care */
-			dev->pio_mode = XFER_PIO_0;
-			dev->dma_mode = XFER_MW_DMA_0;
-			/* We do need the right mode information for DMA or PIO
-			   and this comes from the current configuration flags */
-			if (ata_id_has_dma(dev->id)) {
-				ata_dev_printk(dev, KERN_INFO, "configured for DMA\n");
-				dev->xfer_mode = XFER_MW_DMA_0;
-				dev->xfer_shift = ATA_SHIFT_MWDMA;
-				dev->flags &= ~ATA_DFLAG_PIO;
-			} else {
-				ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
-				dev->xfer_mode = XFER_PIO_0;
-				dev->xfer_shift = ATA_SHIFT_PIO;
-				dev->flags |= ATA_DFLAG_PIO;
-			}
+	ata_for_each_dev(dev, link, ENABLED) {
+		/* We don't really care */
+		dev->pio_mode = XFER_PIO_0;
+		dev->dma_mode = XFER_MW_DMA_0;
+		/* We do need the right mode information for DMA or PIO
+		   and this comes from the current configuration flags */
+		if (ata_id_has_dma(dev->id)) {
+			ata_dev_printk(dev, KERN_INFO, "configured for DMA\n");
+			dev->xfer_mode = XFER_MW_DMA_0;
+			dev->xfer_shift = ATA_SHIFT_MWDMA;
+			dev->flags &= ~ATA_DFLAG_PIO;
+		} else {
+			ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
+			dev->xfer_mode = XFER_PIO_0;
+			dev->xfer_shift = ATA_SHIFT_PIO;
+			dev->flags |= ATA_DFLAG_PIO;
 		}
 	}
 	return 0;
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 2014253..b173c15 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -30,14 +30,12 @@ static int ixp4xx_set_mode(struct ata_link *link, struct ata_device **error)
 {
 	struct ata_device *dev;
 
-	ata_link_for_each_dev(dev, link) {
-		if (ata_dev_enabled(dev)) {
-			ata_dev_printk(dev, KERN_INFO, "configured for PIO0\n");
-			dev->pio_mode = XFER_PIO_0;
-			dev->xfer_mode = XFER_PIO_0;
-			dev->xfer_shift = ATA_SHIFT_PIO;
-			dev->flags |= ATA_DFLAG_PIO;
-		}
+	ata_for_each_dev(dev, link, ENABLED) {
+		ata_dev_printk(dev, KERN_INFO, "configured for PIO0\n");
+		dev->pio_mode = XFER_PIO_0;
+		dev->xfer_mode = XFER_PIO_0;
+		dev->xfer_shift = ATA_SHIFT_PIO;
+		dev->flags |= ATA_DFLAG_PIO;
 	}
 	return 0;
 }
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 930c220..cbd98c1 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -194,15 +194,12 @@ static int legacy_set_mode(struct ata_link *link, struct ata_device **unused)
 {
 	struct ata_device *dev;
 
-	ata_link_for_each_dev(dev, link) {
-		if (ata_dev_enabled(dev)) {
-			ata_dev_printk(dev, KERN_INFO,
-						"configured for PIO\n");
-			dev->pio_mode = XFER_PIO_0;
-			dev->xfer_mode = XFER_PIO_0;
-			dev->xfer_shift = ATA_SHIFT_PIO;
-			dev->flags |= ATA_DFLAG_PIO;
-		}
+	ata_for_each_dev(dev, link, ENABLED) {
+		ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
+		dev->pio_mode = XFER_PIO_0;
+		dev->xfer_mode = XFER_PIO_0;
+		dev->xfer_shift = ATA_SHIFT_PIO;
+		dev->flags |= ATA_DFLAG_PIO;
 	}
 	return 0;
 }
@@ -1028,7 +1025,7 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 	/* Nothing found means we drop the port as its probably not there */
 
 	ret = -ENODEV;
-	ata_link_for_each_dev(dev, &ap->link) {
+	ata_for_each_dev(dev, &ap->link, ALL) {
 		if (!ata_dev_absent(dev)) {
 			legacy_host[probe->slot] = host;
 			ld->platform_dev = pdev;
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 0e1c2c1..d43e8be 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -406,23 +406,20 @@ static int pdc2027x_set_mode(struct ata_link *link, struct ata_device **r_failed
 	if (rc < 0)
 		return rc;
 
-	ata_link_for_each_dev(dev, link) {
-		if (ata_dev_enabled(dev)) {
-
-			pdc2027x_set_piomode(ap, dev);
-
-			/*
-			 * Enable prefetch if the device support PIO only.
-			 */
-			if (dev->xfer_shift == ATA_SHIFT_PIO) {
-				u32 ctcr1 = ioread32(dev_mmio(ap, dev, PDC_CTCR1));
-				ctcr1 |= (1 << 25);
-				iowrite32(ctcr1, dev_mmio(ap, dev, PDC_CTCR1));
-
-				PDPRINTK("Turn on prefetch\n");
-			} else {
-				pdc2027x_set_dmamode(ap, dev);
-			}
+	ata_for_each_dev(dev, link, ENABLED) {
+		pdc2027x_set_piomode(ap, dev);
+
+		/*
+		 * Enable prefetch if the device support PIO only.
+		 */
+		if (dev->xfer_shift == ATA_SHIFT_PIO) {
+			u32 ctcr1 = ioread32(dev_mmio(ap, dev, PDC_CTCR1));
+			ctcr1 |= (1 << 25);
+			iowrite32(ctcr1, dev_mmio(ap, dev, PDC_CTCR1));
+
+			PDPRINTK("Turn on prefetch\n");
+		} else {
+			pdc2027x_set_dmamode(ap, dev);
 		}
 	}
 	return 0;
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 77e4e3b..6afa07a 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -34,14 +34,12 @@ static int pata_platform_set_mode(struct ata_link *link, struct ata_device **unu
 {
 	struct ata_device *dev;
 
-	ata_link_for_each_dev(dev, link) {
-		if (ata_dev_enabled(dev)) {
-			/* We don't really care */
-			dev->pio_mode = dev->xfer_mode = XFER_PIO_0;
-			dev->xfer_shift = ATA_SHIFT_PIO;
-			dev->flags |= ATA_DFLAG_PIO;
-			ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
-		}
+	ata_for_each_dev(dev, link, ENABLED) {
+		/* We don't really care */
+		dev->pio_mode = dev->xfer_mode = XFER_PIO_0;
+		dev->xfer_shift = ATA_SHIFT_PIO;
+		dev->flags |= ATA_DFLAG_PIO;
+		ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
 	}
 	return 0;
 }
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 7dfd1f3..46d6bc1 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -38,15 +38,13 @@ static int rz1000_set_mode(struct ata_link *link, struct ata_device **unused)
 {
 	struct ata_device *dev;
 
-	ata_link_for_each_dev(dev, link) {
-		if (ata_dev_enabled(dev)) {
-			/* We don't really care */
-			dev->pio_mode = XFER_PIO_0;
-			dev->xfer_mode = XFER_PIO_0;
-			dev->xfer_shift = ATA_SHIFT_PIO;
-			dev->flags |= ATA_DFLAG_PIO;
-			ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
-		}
+	ata_for_each_dev(dev, link, ENABLED) {
+		/* We don't really care */
+		dev->pio_mode = XFER_PIO_0;
+		dev->xfer_mode = XFER_PIO_0;
+		dev->xfer_shift = ATA_SHIFT_PIO;
+		dev->flags |= ATA_DFLAG_PIO;
+		ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
 	}
 	return 0;
 }
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index f1dd478..06c13de 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -278,7 +278,7 @@ static int sil_set_mode(struct ata_link *link, struct ata_device **r_failed)
 	if (rc)
 		return rc;
 
-	ata_link_for_each_dev(dev, link) {
+	ata_for_each_dev(dev, link, ALL) {
 		if (!ata_dev_enabled(dev))
 			dev_mode[dev->devno] = 0;	/* PIO0/1/2 */
 		else if (dev->flags & ATA_DFLAG_PIO)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a2eb8f2..49cca60 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1285,26 +1285,62 @@ static inline int ata_link_active(struct ata_link *link)
 	return ata_tag_valid(link->active_tag) || link->sactive;
 }
 
-extern struct ata_link *__ata_port_next_link(struct ata_port *ap,
-					     struct ata_link *link,
-					     bool dev_only);
-
-#define __ata_port_for_each_link(link, ap) \
-	for ((link) = __ata_port_next_link((ap), NULL, false); (link); \
-	     (link) = __ata_port_next_link((ap), (link), false))
-
-#define ata_port_for_each_link(link, ap) \
-	for ((link) = __ata_port_next_link((ap), NULL, true); (link); \
-	     (link) = __ata_port_next_link((ap), (link), true))
-
-#define ata_link_for_each_dev(dev, link) \
-	for ((dev) = (link)->device; \
-	     (dev) < (link)->device + ata_link_max_devices(link) || ((dev) = NULL); \
-	     (dev)++)
-
-#define ata_link_for_each_dev_reverse(dev, link) \
-	for ((dev) = (link)->device + ata_link_max_devices(link) - 1; \
-	     (dev) >= (link)->device || ((dev) = NULL); (dev)--)
+/*
+ * Iterators
+ *
+ * ATA_LITER_* constants are used to select link iteration mode and
+ * ATA_DITER_* device iteration mode.
+ *
+ * For a custom iteration directly using ata_{link|dev}_next(), if
+ * @link or @dev, respectively, is NULL, the first element is
+ * returned.  @dev and @link can be any valid device or link and the
+ * next element according to the iteration mode will be returned.
+ * After the last element, NULL is returned.
+ */
+enum ata_link_iter_mode {
+	ATA_LITER_EDGE,		/* if present, PMP links only; otherwise,
+				 * host link.  no slave link */
+	ATA_LITER_HOST_FIRST,	/* host link followed by PMP or slave links */
+	ATA_LITER_PMP_FIRST,	/* PMP links followed by host link,
+				 * slave link still comes after host link */
+};
+
+enum ata_dev_iter_mode {
+	ATA_DITER_ENABLED,
+	ATA_DITER_ENABLED_REVERSE,
+	ATA_DITER_ALL,
+	ATA_DITER_ALL_REVERSE,
+};
+
+extern struct ata_link *ata_link_next(struct ata_link *link,
+				      struct ata_port *ap,
+				      enum ata_link_iter_mode mode);
+
+extern struct ata_device *ata_dev_next(struct ata_device *dev,
+				       struct ata_link *link,
+				       enum ata_dev_iter_mode mode);
+
+/*
+ * Shortcut notation for iterations
+ *
+ * ata_for_each_link() iterates over each link of @ap according to
+ * @mode.  @link points to the current link in the loop.  @link is
+ * NULL after loop termination.  ata_for_each_dev() works the same way
+ * except that it iterates over each device of @link.
+ *
+ * Note that the mode prefixes ATA_{L|D}ITER_ shouldn't need to be
+ * specified when using the following shorthand notations.  Only the
+ * mode itself (EDGE, HOST_FIRST, ENABLED, etc...) should be
+ * specified.  This not only increases brevity but also makes it
+ * impossible to use ATA_LITER_* for device iteration or vice-versa.
+ */
+#define ata_for_each_link(link, ap, mode) \
+	for ((link) = ata_link_next(NULL, (ap), ATA_LITER_##mode); (link); \
+	     (link) = ata_link_next((link), (ap), ATA_LITER_##mode))
+
+#define ata_for_each_dev(dev, link, mode) \
+	for ((dev) = ata_dev_next(NULL, (link), ATA_DITER_##mode); (dev); \
+	     (dev) = ata_dev_next((dev), (link), ATA_DITER_##mode))
 
 /**
  *	ata_ncq_enabled - Test whether NCQ is enabled
-- 
1.5.4.5

