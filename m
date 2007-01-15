From: Tejun Heo <htejun@gmail.com>
Subject: PATA ATAPI detection debug
Date: Mon, 15 Jan 2007 17:09:20 +0900
Message-ID: <45AB36B0.2050702@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080008050203000304040807"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:27325 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbXAOIJ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jan 2007 03:09:29 -0500
Received: by wr-out-0506.google.com with SMTP id 70so1069154wra
        for <linux-ide@vger.kernel.org>; Mon, 15 Jan 2007 00:09:28 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ahaas@airmail.net, fragabr@gmail.com, j.taimr@chello.nl, ben@atomnet.co.uk, acb@h2h.de, tkrah@fachschaft.imn.htwk-leipzig.de, sero4linux@freenet.de
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080008050203000304040807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello, all.

Many people have been reporting libata PATA ATAPI detection problem.  In
many but not all cases, the ATAPI device was occupying the slave slot
while a disk drive occupies the master slot.  Based on that and J.
Taimr's nullify freeze on via fix, I made a cocktail patch which
contained four different fixes and it seemed to have fixed the problem
for (at least) several people, but the reports are not all consistent.

The attached patches contain the same four fixes but has a selector
parameter to enable each fix separately.  Both are equivalent but using
2.6.20-rc5 is recommended to rule out detection problems fixed by
polling IDENTIFY.

If your libata driver is compiled into the kernel, add
'libata.debug_cocktail=N' to your kernel parameter.  If you compile
libata.ko as module, add 'debug_cocktail=N' module parameter to the
module parameter.  e.g. 'modprobe libata.ko debug_cocktail=1'.

Please test

0: nothing
1: common PIO mask between devices sharing a channel
2: force PIO0 (DMA mode is unaffected)
4: clear NIEN on both devices
8: make ata_bmdma_freeze() nill

If none of above works, try 5, 9, then 6, 10.

Please test each option and report the result.  It's best if you can
include dmesg's for each value but if you can't get the dmesg because
boot doesn't complete, just reporting the option doesn't work suffices.
 Also, please don't forget to attach the result of 'lspci -nnvvv'.

Thanks for your patience.

-- 
tejun

--------------080008050203000304040807
Content-Type: text/x-patch;
 name="which-cocktail-2.6.19.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="which-cocktail-2.6.19.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 915a55a..0eea6bd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -90,6 +90,9 @@ static int ata_probe_timeout = ATA_TMOUT_INTERNAL / HZ;
 module_param(ata_probe_timeout, int, 0444);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
+int ata_debug_cocktail = 0;
+module_param_named(debug_cocktail, ata_debug_cocktail, int, 0444);
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -2227,6 +2230,10 @@ int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
 		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
 		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
+		if (dev->pio_mode && ata_debug_cocktail & (1 << 1)) {
+			ata_port_printk(ap, KERN_INFO, "XXX force PIO0\n");
+			dev->pio_mode = XFER_PIO_0;
+		}
 		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
 
 		found = 1;
@@ -3124,6 +3131,29 @@ static void ata_dev_xfermask(struct ata_device *dev)
 				       dev->mwdma_mask, dev->udma_mask);
 	xfer_mask &= ata_id_xfermask(dev->id);
 
+	if (ata_debug_cocktail & (1 << 0)) {
+		int i;
+
+		/* PIO xfermask limits are shared by all devices on the same
+		 * channel to avoid violating device selection timing.
+		 */
+		ata_dev_printk(dev, KERN_INFO, "XXX common PIO mode: pre: %lx\n",
+			       xfer_mask);
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			struct ata_device *d = &ap->device[i];
+			unsigned int pio_mask;
+
+			if (ata_dev_absent(d))
+				continue;
+
+			ata_unpack_xfermask(ata_id_xfermask(d->id),
+					    &pio_mask, NULL, NULL);
+			pio_mask &= d->pio_mask;
+			xfer_mask &= ata_pack_xfermask(pio_mask, UINT_MAX, UINT_MAX);
+		}
+		ata_dev_printk(dev, KERN_INFO, "XXX common PIO mode: post: %lx\n",
+			       xfer_mask);
+	}
 	/*
 	 *	CFA Advanced TrueIDE timings are not allowed on a shared
 	 *	cable
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7645f2b..5bb5bd4 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -39,6 +39,51 @@
 #include "libata.h"
 
 /**
+ *	ata_irq_on - Enable interrupts on a port.
+ *	@ap: Port on which interrupts are enabled.
+ *
+ *	Enable interrupts on a legacy IDE device using MMIO or PIO,
+ *	wait for idle, clear any pending interrupts.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
+u8 ata_irq_on(struct ata_port *ap)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 tmp;
+
+	ap->ctl &= ~ATA_NIEN;
+	ap->last_ctl = ap->ctl;
+
+	if (ata_debug_cocktail & (1 << 2)) {
+		ata_port_printk(ap, KERN_INFO, "XXX clear NIEN on both devices\n");
+		ap->ops->dev_select(ap, 1);
+	}
+	if (ap->flags & ATA_FLAG_MMIO)
+		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
+	else
+		outb(ap->ctl, ioaddr->ctl_addr);
+	tmp = ata_wait_idle(ap);
+
+	if (ata_debug_cocktail & (1 << 2)) {
+		ap->ops->dev_select(ap, 0);
+		if (ap->flags & ATA_FLAG_MMIO)
+			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
+		else
+			outb(ap->ctl, ioaddr->ctl_addr);
+		tmp = ata_wait_idle(ap);
+	}
+
+	ap->ops->irq_clear(ap);
+
+	return tmp;
+}
+
+
+
+/**
  *	ata_tf_load_pio - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
@@ -664,6 +709,10 @@ void ata_bmdma_freeze(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
+	if (ata_debug_cocktail & (1 << 3)) {
+		ata_port_printk(ap, KERN_INFO, "XXX skipping BMDMA freeze\n");
+		return;
+	}
 	ap->ctl |= ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0ed263b..9868965 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -43,6 +43,7 @@ extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
+extern int ata_debug_cocktail;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_dev_disable(struct ata_device *dev);
@@ -120,4 +121,7 @@ extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
 
+/* libata-sff.c */
+extern u8 ata_irq_on(struct ata_port *ap);
+
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index abd2deb..bc36068 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1148,37 +1148,6 @@ static inline void ata_qc_reinit(struct ata_queued_cmd *qc)
 }
 
 /**
- *	ata_irq_on - Enable interrupts on a port.
- *	@ap: Port on which interrupts are enabled.
- *
- *	Enable interrupts on a legacy IDE device using MMIO or PIO,
- *	wait for idle, clear any pending interrupts.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static inline u8 ata_irq_on(struct ata_port *ap)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
-
-	ap->ctl &= ~ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	if (ap->flags & ATA_FLAG_MMIO)
-		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-	else
-		outb(ap->ctl, ioaddr->ctl_addr);
-	tmp = ata_wait_idle(ap);
-
-	ap->ops->irq_clear(ap);
-
-	return tmp;
-}
-
-
-/**
  *	ata_irq_ack - Acknowledge a device interrupt.
  *	@ap: Port on which interrupts are enabled.
  *

--------------080008050203000304040807
Content-Type: text/x-patch;
 name="which-cocktail-2.6.20-rc5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="which-cocktail-2.6.20-rc5.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0d51d13..c8a9197 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -90,6 +90,9 @@ static int ata_probe_timeout = ATA_TMOUT_INTERNAL / HZ;
 module_param(ata_probe_timeout, int, 0444);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
+int ata_debug_cocktail = 0;
+module_param_named(debug_cocktail, ata_debug_cocktail, int, 0444);
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
@@ -2458,6 +2461,10 @@ int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
 		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
 		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
 		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
+		if (dev->pio_mode && ata_debug_cocktail & (1 << 1)) {
+			ata_port_printk(ap, KERN_INFO, "XXX force PIO0\n");
+			dev->pio_mode = XFER_PIO_0;
+		}
 		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
 
 		found = 1;
@@ -3422,6 +3429,29 @@ static void ata_dev_xfermask(struct ata_device *dev)
 				       dev->mwdma_mask, dev->udma_mask);
 	xfer_mask &= ata_id_xfermask(dev->id);
 
+	if (ata_debug_cocktail & (1 << 0)) {
+		int i;
+
+		/* PIO xfermask limits are shared by all devices on the same
+		 * channel to avoid violating device selection timing.
+		 */
+		ata_dev_printk(dev, KERN_INFO, "XXX common PIO mode: pre: %lx\n",
+			       xfer_mask);
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			struct ata_device *d = &ap->device[i];
+			unsigned int pio_mask;
+
+			if (ata_dev_absent(d))
+				continue;
+
+			ata_unpack_xfermask(ata_id_xfermask(d->id),
+					    &pio_mask, NULL, NULL);
+			pio_mask &= d->pio_mask;
+			xfer_mask &= ata_pack_xfermask(pio_mask, UINT_MAX, UINT_MAX);
+		}
+		ata_dev_printk(dev, KERN_INFO, "XXX common PIO mode: post: %lx\n",
+			       xfer_mask);
+	}
 	/*
 	 *	CFA Advanced TrueIDE timings are not allowed on a shared
 	 *	cable
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 623cec9..4711755 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -56,12 +56,25 @@ u8 ata_irq_on(struct ata_port *ap)
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
+	if (ata_debug_cocktail & (1 << 2)) {
+		ata_port_printk(ap, KERN_INFO, "XXX clear NIEN on both devices\n");
+		ap->ops->dev_select(ap, 1);
+	}
 	if (ap->flags & ATA_FLAG_MMIO)
 		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 	else
 		outb(ap->ctl, ioaddr->ctl_addr);
 	tmp = ata_wait_idle(ap);
 
+	if (ata_debug_cocktail & (1 << 2)) {
+		ap->ops->dev_select(ap, 0);
+		if (ap->flags & ATA_FLAG_MMIO)
+			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
+		else
+			outb(ap->ctl, ioaddr->ctl_addr);
+		tmp = ata_wait_idle(ap);
+	}
+
 	ap->ops->irq_clear(ap);
 
 	return tmp;
@@ -693,6 +706,10 @@ void ata_bmdma_freeze(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
+	if (ata_debug_cocktail & (1 << 3)) {
+		ata_port_printk(ap, KERN_INFO, "XXX skipping BMDMA freeze\n");
+		return;
+	}
 	ap->ctl |= ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 81ae41d..3930b8e 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -48,6 +48,7 @@ extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
+extern int ata_debug_cocktail;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,

--------------080008050203000304040807--
