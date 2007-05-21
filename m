From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Allow a controller specific post bus reset method
Date: Mon, 21 May 2007 15:28:43 +0100
Message-ID: <20070521152843.0f202d6b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48267 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755798AbXEUOYm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 10:24:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

The IT821x firmware mode isn't smart enough to pass the post bus reset
checks that libata does so allow it to be over-ridden. Not sure this is
the best long term solution but it'll do for now.

Possibly a better option would be a libata-eh set of methods for
controllers where we don't want to reset and re-identify devices.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/drivers/ata/libata-core.c linux-2.6.22-rc1-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.22-rc1-mm1/drivers/ata/libata-core.c	2007-05-18 16:22:53.000000000 +0100
+++ linux-2.6.22-rc1-mm1/drivers/ata/libata-core.c	2007-05-18 16:40:23.000000000 +0100
@@ -3128,7 +3135,10 @@
 	if (ata_check_status(ap) == 0xFF)
 		return -ENODEV;
 
-	return ata_bus_post_reset(ap, devmask, deadline);
+	if (ap->ops->bus_post_reset)
+		return ap->ops->bus_post_reset(ap, devmask, deadline);
+	else
+		return ata_bus_post_reset(ap, devmask, deadline);
 }
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/include/linux/libata.h linux-2.6.22-rc1-mm1/include/linux/libata.h
--- linux.vanilla-2.6.22-rc1-mm1/include/linux/libata.h	2007-05-18 16:22:56.000000000 +0100
+++ linux-2.6.22-rc1-mm1/include/linux/libata.h	2007-05-18 16:38:16.000000000 +0100
@@ -618,6 +616,9 @@
 
 	void (*bmdma_stop) (struct ata_queued_cmd *qc);
 	u8   (*bmdma_status) (struct ata_port *ap);
+	
+	int  (*bus_post_reset) (struct ata_port *ap, unsigned int mask, 
+				unsigned long deadline);
 };
 
 struct ata_port_info {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/drivers/ata/pata_it821x.c linux-2.6.22-rc1-mm1/drivers/ata/pata_it821x.c
--- linux.vanilla-2.6.22-rc1-mm1/drivers/ata/pata_it821x.c	2007-05-18 16:21:46.000000000 +0100
+++ linux-2.6.22-rc1-mm1/drivers/ata/pata_it821x.c	2007-05-18 16:34:05.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * ata-it821x.c 	- IT821x PATA for new ATA layer
+ * pata_it821x.c 	- IT821x PATA for new ATA layer
  *			  (C) 2005 Red Hat Inc
  *			  Alan Cox <alan@redhat.com>
  *
@@ -65,7 +65,6 @@
  *
  *  TODO
  *	-	ATAPI and other speed filtering
- *	-	Command filter in smart mode
  *	-	RAID configuration ioctls
  */
 
@@ -80,7 +79,7 @@
 
 
 #define DRV_NAME "pata_it821x"
-#define DRV_VERSION "0.3.6"
+#define DRV_VERSION "0.3.8"
 
 struct it821x_dev
 {
@@ -494,6 +493,49 @@
 }
 
 /**
+ *	it821x_bus_post_reset	-	reset completion handler
+ *	@ap: Port being reset
+ *	@devmask: Mask of devices present
+ *	@deadline: Timeout
+ *
+ *	After a bus reset we must recover the device state. The IT821x doesn't
+ *	fully emulate the reset sequence in smart mode and will get stuck if
+ *	a slave is present. Use a simpler reset sequence.
+ */
+
+static int it821x_bus_post_reset(struct ata_port *ap, unsigned int devmask,
+			      unsigned long deadline)
+{
+	int rc, ret = 0;
+	int i;
+
+	for (i = 0; i < 2; i++)
+	{
+		/* if device was found in ata_devchk, wait for its
+		 * BSY bit to clear
+		 */
+		if (devmask && (1 << i)) {
+			rc = ata_wait_ready(ap, deadline);
+			if (rc) {
+				if (rc != -ENODEV)
+					return rc;
+				ret = rc;
+			}
+		}
+		if (i)
+			ap->ops->dev_select(ap, 1);
+	}
+
+	/* is all this really necessary? */
+	ap->ops->dev_select(ap, 0);
+	if (devmask && (1 << 1))
+		ap->ops->dev_select(ap, 1);
+	if (devmask && (1 << 0))
+		ap->ops->dev_select(ap, 0);
+	return ret;
+}
+
+/**
  *	it821x_dev_config	-	Called each device identify
  *	@adev: Device that has just been identified
  *
@@ -657,6 +699,8 @@
 	.irq_ack	= ata_irq_ack,
 
 	.port_start	= it821x_port_start,
+	
+	.bus_post_reset = it821x_bus_post_reset
 };
 
 static struct ata_port_operations it821x_passthru_port_ops = {
