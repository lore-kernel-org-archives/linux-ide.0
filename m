From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata/pata_it821x: Improve handling of poorly compatible
 emulations
Date: Thu, 25 Oct 2007 14:21:16 +0100
Message-ID: <20071025142116.7e38ee86@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46183 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753480AbXJYNSh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 09:18:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

Some it821x RAID firmwares return 0 for the err return off both devices.
A similar issue occurs with the slave returning 0 not 1 if you plug a
gigabyte sata ramdisk into a controller that fakes two SATA ports as
master/slave on an SFF channel.

The patch does the following

- Allow the 'failed diagnostics' case on both master and slave
- Move the HORKAGE_DIAGNOSTIC check after ->dev_config

This second change also allows IT821x to fix up a problem where we report
drive diagnostic failures when in fact the drive is fine but the
microcontroller firmware doesn't appear to get it right. IT821x clears
the flag again to avoid giving the user bogus warnings about their disk.

The other IT821x change is a bit ugly, we slightly abuse the cable type
hook to fiddle with the identify data for the devices. We could add a new
hook for this but as we have only one offender and no more seeming likely
it seems better to keep libata-core clean.

Please let this sit in -mm briefly, just in case the relaxed checking
breaks some other emulated interface.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c linux-2.6.23-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:03:26.000000000 +0100
+++ linux-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-25 11:53:40.000000000 +0100
@@ -759,8 +763,8 @@
 	if (r_err)
 		*r_err = err;
 
-	/* see if device passed diags: if master then continue and warn later */
-	if (err == 0 && dev->devno == 0)
+	/* see if device passed diags: continue and warn later */
+	if (err == 0)
 		/* diagnostic fail : do nothing _YET_ */
 		dev->horkage |= ATA_HORKAGE_DIAGNOSTIC;
 	else if (err == 1)
@@ -2106,19 +2115,8 @@
 	if (dev->flags & ATA_DFLAG_LBA48)
 		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
 
-	if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
-		/* Let the user know. We don't want to disallow opens for
-		   rescue purposes, or in case the vendor is just a blithering
-		   idiot */
-                if (print_info) {
-			ata_dev_printk(dev, KERN_WARNING,
-"Drive reports diagnostics failure. This may indicate a drive\n");
-			ata_dev_printk(dev, KERN_WARNING,
-"fault or invalid emulation. Contact drive vendor for information.\n");
-		}
-	}
-
-	/* limit bridge transfers to udma5, 200 sectors */
+	/* Limit PATA drive on SATA cable bridge transfers to udma5, 
+	   200 sectors */
 	if (ata_dev_knobble(dev)) {
 		if (ata_msg_drv(ap) && print_info)
 			ata_dev_printk(dev, KERN_INFO,
@@ -2134,6 +2132,21 @@
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(dev);
 
+	if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
+		/* Let the user know. We don't want to disallow opens for
+		   rescue purposes, or in case the vendor is just a blithering
+		   idiot. Do this after the dev_config call as some controllers
+		   with buggy firmware may want to avoid reporting false device
+		   bugs */
+
+                if (print_info) {
+			ata_dev_printk(dev, KERN_WARNING,
+"Drive reports diagnostics failure. This may indicate a drive\n");
+			ata_dev_printk(dev, KERN_WARNING,
+"fault or invalid emulation. Contact drive vendor for information.\n");
+		}
+	}
+
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: EXIT, drv_stat = 0x%x\n",
 			__FUNCTION__, ata_chk_status(ap));
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/pata_it821x.c linux-2.6.23-mm1/drivers/ata/pata_it821x.c
--- linux.vanilla-2.6.23-mm1/drivers/ata/pata_it821x.c	2007-10-15 15:03:26.000000000 +0100
+++ linux-2.6.23-mm1/drivers/ata/pata_it821x.c	2007-10-25 12:04:50.000000000 +0100
@@ -430,7 +430,7 @@
 			return ata_qc_issue_prot(qc);
 	}
 	printk(KERN_DEBUG "it821x: can't process command 0x%02X\n", qc->tf.command);
-	return AC_ERR_INVALID;
+	return AC_ERR_DEV;
 }
 
 /**
@@ -516,6 +516,37 @@
 			printk("(%dK stripe)", adev->id[146]);
 		printk(".\n");
 	}
+	/* This is a controller firmware triggered funny, don't
+	   report the drive faulty! */
+	adev->horkage &= ~ATA_HORKAGE_DIAGNOSTIC;
+}
+
+/**
+ *	it821x_ident_hack	-	Hack identify data up
+ *	@ap: Port
+ *
+ *	Walk the devices on this firmware driven port and slightly
+ *	mash the identify data to stop us and common tools trying to
+ *	use features not firmware supported. The firmware itself does
+ *	some masking (eg SMART) but not enough.
+ *
+ *	This is a bit of an abuse of the cable method, but it is the
+ *	only method called at the right time. We could modify the libata
+ *	core specifically for ident hacking but while we have one offender
+ *	it seems better to keep the fallout localised.
+ */
+
+static int it821x_ident_hack(struct ata_port *ap)
+{
+	struct ata_device *adev;
+	ata_link_for_each_dev(adev, &ap->link) {
+		if (ata_dev_enabled(adev)) {
+			adev->id[84] &= ~(1 << 6);	/* No FUA */
+			adev->id[85] &= ~(1 << 10);	/* No HPA */
+			adev->id[76] = 0;		/* No NCQ/AN etc */
+		}
+	}
+	return ata_cable_unknown(ap);
 }
 
 
@@ -634,7 +665,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= ata_cable_unknown,
+	.cable_detect	= it821x_ident_hack,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
