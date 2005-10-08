From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] libata-core cleanups
Date: Sat, 8 Oct 2005 12:17:00 -0700
Message-ID: <20051008121700.698e7092.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:32399 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751096AbVJHTRC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Oct 2005 15:17:02 -0400
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Sat, 8 Oct 2005 12:17:01 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <rdunlap@xenotime.net>

libata cleanups:
- fix some function coments;
- use kzalloc() instead of kmalloc() + memset();
- reduce exit paths in ata_device_add(); 

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/scsi/libata-core.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff -Naurp linux-2614-rc3-g7/drivers/scsi/libata-core.c~sata_clean linux-2614-rc3-g7/drivers/scsi/libata-core.c
--- linux-2614-rc3-g7/drivers/scsi/libata-core.c~sata_clean	2005-10-08 11:44:13.000000000 -0700
+++ linux-2614-rc3-g7/drivers/scsi/libata-core.c	2005-10-08 11:59:48.000000000 -0700
@@ -85,7 +85,7 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 /**
- *	ata_tf_load - send taskfile registers to host controller
+ *	ata_tf_load_pio - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
  *
@@ -2819,7 +2819,7 @@ err_out:
 }
 
 /**
- *	ata_pio_sector -
+ *	ata_pio_block -
  *	@ap:
  *
  *	LOCKING:
@@ -2832,7 +2832,7 @@ static void ata_pio_block(struct ata_por
 	u8 status;
 
 	/*
-	 * This is purely hueristic.  This is a fast path.
+	 * This is purely heuristic.  This is a fast path.
 	 * Sometimes when we enter, BSY will be cleared in
 	 * a chk-status or two.  If not, the drive is probably seeking
 	 * or something.  Snooze for a couple msecs, then
@@ -4021,11 +4021,10 @@ int ata_device_add(struct ata_probe_ent 
 
 	DPRINTK("ENTER\n");
 	/* alloc a container for our list of ATA ports (buses) */
-	host_set = kmalloc(sizeof(struct ata_host_set) +
+	host_set = kzalloc(sizeof(struct ata_host_set) +
 			   (ent->n_ports * sizeof(void *)), GFP_KERNEL);
 	if (!host_set)
 		return 0;
-	memset(host_set, 0, sizeof(struct ata_host_set) + (ent->n_ports * sizeof(void *)));
 	spin_lock_init(&host_set->lock);
 
 	host_set->dev = dev;
@@ -4065,10 +4064,8 @@ int ata_device_add(struct ata_probe_ent 
 		count++;
 	}
 
-	if (!count) {
-		kfree(host_set);
-		return 0;
-	}
+	if (!count)
+		goto err_free_ret;
 
 	/* obtain irq, that is shared between channels */
 	if (request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
@@ -4126,6 +4123,7 @@ err_out:
 		ata_host_remove(host_set->ports[i], 1);
 		scsi_host_put(host_set->ports[i]->host);
 	}
+err_free_ret:
 	kfree(host_set);
 	VPRINTK("EXIT, returning 0\n");
 	return 0;
@@ -4236,15 +4234,13 @@ ata_probe_ent_alloc(struct device *dev, 
 {
 	struct ata_probe_ent *probe_ent;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       kobject_name(&(dev->kobj)));
 		return NULL;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
-
 	INIT_LIST_HEAD(&probe_ent->node);
 	probe_ent->dev = dev;
 
@@ -4505,7 +4501,7 @@ err_out:
  *	@pdev: PCI device that was removed
  *
  *	PCI layer indicates to libata via this hook that
- *	hot-unplug or module unload event has occured.
+ *	hot-unplug or module unload event has occurred.
  *	Handle this by unregistering all objects associated
  *	with this PCI device.  Free those objects.  Then finally
  *	release PCI resources and disable device.

---
