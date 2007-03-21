From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 3/3] libata: handle AN interrupt
Date: Tue, 20 Mar 2007 17:52:42 -0700
Message-ID: <20070320175242.d4d26fea.kristen.c.accardi@intel.com>
References: <20070321004740.939006166@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__20_Mar_2007_17_52_42_-0700_say0VthTgM_ppiAo"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40671 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933947AbXCUAzJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Mar 2007 20:55:09 -0400
In-Reply-To: <20070321004740.939006166@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

This is a multi-part message in MIME format.

--Multipart=_Tue__20_Mar_2007_17_52_42_-0700_say0VthTgM_ppiAo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

When we get an SDB FIS with the 'N' bit set, we should send
an event to user space to indicate that there has been a
media change.  The ahci host controller will send the
event via KOBJ_CHANGE uevent.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Index: 2.6-git/drivers/ata/ahci.c
===================================================================
--- 2.6-git.orig/drivers/ata/ahci.c	2007-03-21 01:25:24.000000000 -0700
+++ 2.6-git/drivers/ata/ahci.c	2007-03-21 01:25:43.000000000 -0700
@@ -1126,6 +1126,26 @@
 		return;
 	}
 
+	if (status & PORT_IRQ_SDB_FIS) {
+		/*
+		 * if this is an ATAPI device with AN turned on,
+		 * then we should interrogate the device to
+		 * determine the cause of the interrupt
+		 *
+		 * for AN - this we should check the SDB FIS
+		 * and find the I and N bits set
+		 */
+		const u32 *f = pp->rx_fis + RX_FIS_SDB;
+
+		/* check the 'N' bit in word 0 of the FIS */
+		if (f[0] & (1 << 15)) {
+			int port_addr =  ((f[0] & 0x00000f00) >> 8);
+			struct ata_device *adev = &ap->device[port_addr];
+			ata_port_printk(ap, KERN_INFO, "N bit set on SDB FIS!\n");
+			if (adev->flags & ATA_DFLAG_AN)
+				ata_async_notify(adev);
+		}
+	}
 	if (ap->sactive)
 		qc_active = readl(port_mmio + PORT_SCR_ACT);
 	else
Index: 2.6-git/include/linux/libata.h
===================================================================
--- 2.6-git.orig/include/linux/libata.h	2007-03-21 01:25:24.000000000 -0700
+++ 2.6-git/include/linux/libata.h	2007-03-21 01:25:43.000000000 -0700
@@ -504,6 +504,7 @@
 	/* error history */
 	struct ata_ering	ering;
 	unsigned int		horkage;	/* List of broken features */
+	struct work_struct	async_notify;
 };
 
 /* Offset into struct ata_device.  Fields above it are maintained
@@ -827,6 +828,7 @@
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
+extern void ata_async_notify(struct ata_device *atadev);
 
 /*
  * Timing helpers
Index: 2.6-git/drivers/ata/libata-core.c
===================================================================
--- 2.6-git.orig/drivers/ata/libata-core.c	2007-03-21 01:25:24.000000000 -0700
+++ 2.6-git/drivers/ata/libata-core.c	2007-03-21 01:25:43.000000000 -0700
@@ -1589,6 +1589,26 @@
 	}
 }
 
+static void async_notify_thread(struct work_struct *work)
+{
+	struct ata_device *atadev =
+		container_of(work, struct ata_device, async_notify);
+
+	/*
+	 * TBD - who should send this event?  I couldn't find an
+	 * easy way to map an ata_device to a genhd device, so
+	 * decided maybe the ata host should send the event and
+	 * allow user space to figure out what happened?
+	 */
+	kobject_uevent(&atadev->ap->host->dev->kobj, KOBJ_CHANGE);
+}
+
+void ata_async_notify(struct ata_device *atadev)
+{
+	schedule_work(&atadev->async_notify);
+}
+
+
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@dev: Target device to configure
@@ -1755,6 +1775,7 @@
 				goto err_out_nosup;
 			}
 			dev->flags |= ATA_DFLAG_AN;
+			INIT_WORK(&dev->async_notify, async_notify_thread);
 		}
 
 		if (ata_id_cdb_intr(dev->id)) {
@@ -6545,3 +6566,4 @@
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
+EXPORT_SYMBOL_GPL(ata_async_notify);

-- 

--Multipart=_Tue__20_Mar_2007_17_52_42_-0700_say0VthTgM_ppiAo
Content-Type: text/plain;
 name="libata-send-async-event-on-media-change"
Content-Disposition: attachment;
 filename="libata-send-async-event-on-media-change"
Content-Transfer-Encoding: 7bit

When we get an SDB FIS with the 'N' bit set, we should send
an event to user space to indicate that there has been a
media change.  The ahci host controller will send the
event via KOBJ_CHANGE uevent.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Index: 2.6-git/drivers/ata/ahci.c
===================================================================
--- 2.6-git.orig/drivers/ata/ahci.c	2007-03-21 01:25:24.000000000 -0700
+++ 2.6-git/drivers/ata/ahci.c	2007-03-21 01:25:43.000000000 -0700
@@ -1126,6 +1126,26 @@
 		return;
 	}
 
+	if (status & PORT_IRQ_SDB_FIS) {
+		/*
+		 * if this is an ATAPI device with AN turned on,
+		 * then we should interrogate the device to
+		 * determine the cause of the interrupt
+		 *
+		 * for AN - this we should check the SDB FIS
+		 * and find the I and N bits set
+		 */
+		const u32 *f = pp->rx_fis + RX_FIS_SDB;
+
+		/* check the 'N' bit in word 0 of the FIS */
+		if (f[0] & (1 << 15)) {
+			int port_addr =  ((f[0] & 0x00000f00) >> 8);
+			struct ata_device *adev = &ap->device[port_addr];
+			ata_port_printk(ap, KERN_INFO, "N bit set on SDB FIS!\n");
+			if (adev->flags & ATA_DFLAG_AN)
+				ata_async_notify(adev);
+		}
+	}
 	if (ap->sactive)
 		qc_active = readl(port_mmio + PORT_SCR_ACT);
 	else
Index: 2.6-git/include/linux/libata.h
===================================================================
--- 2.6-git.orig/include/linux/libata.h	2007-03-21 01:25:24.000000000 -0700
+++ 2.6-git/include/linux/libata.h	2007-03-21 01:25:43.000000000 -0700
@@ -504,6 +504,7 @@
 	/* error history */
 	struct ata_ering	ering;
 	unsigned int		horkage;	/* List of broken features */
+	struct work_struct	async_notify;
 };
 
 /* Offset into struct ata_device.  Fields above it are maintained
@@ -827,6 +828,7 @@
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
+extern void ata_async_notify(struct ata_device *atadev);
 
 /*
  * Timing helpers
Index: 2.6-git/drivers/ata/libata-core.c
===================================================================
--- 2.6-git.orig/drivers/ata/libata-core.c	2007-03-21 01:25:24.000000000 -0700
+++ 2.6-git/drivers/ata/libata-core.c	2007-03-21 01:25:43.000000000 -0700
@@ -1589,6 +1589,26 @@
 	}
 }
 
+static void async_notify_thread(struct work_struct *work)
+{
+	struct ata_device *atadev =
+		container_of(work, struct ata_device, async_notify);
+
+	/*
+	 * TBD - who should send this event?  I couldn't find an
+	 * easy way to map an ata_device to a genhd device, so
+	 * decided maybe the ata host should send the event and
+	 * allow user space to figure out what happened?
+	 */
+	kobject_uevent(&atadev->ap->host->dev->kobj, KOBJ_CHANGE);
+}
+
+void ata_async_notify(struct ata_device *atadev)
+{
+	schedule_work(&atadev->async_notify);
+}
+
+
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@dev: Target device to configure
@@ -1755,6 +1775,7 @@
 				goto err_out_nosup;
 			}
 			dev->flags |= ATA_DFLAG_AN;
+			INIT_WORK(&dev->async_notify, async_notify_thread);
 		}
 
 		if (ata_id_cdb_intr(dev->id)) {
@@ -6545,3 +6566,4 @@
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
+EXPORT_SYMBOL_GPL(ata_async_notify);

-- 

--Multipart=_Tue__20_Mar_2007_17_52_42_-0700_say0VthTgM_ppiAo--
