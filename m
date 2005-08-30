From: Borislav Petkov <petkov@uni-muenster.de>
Subject: [RFC] [PATCH 1/2] libata debugging: libata.h debugging macros
Date: Tue, 30 Aug 2005 11:50:04 +0200
Message-ID: <200508301150.04323.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:62394 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S1750914AbVH3KAM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Aug 2005 06:00:12 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

libata new debugging macro definitions


Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- include/linux/libata.h.orig	2005-08-27 08:45:32.000000000 +0200
+++ include/linux/libata.h	2005-08-30 10:55:22.000000000 +0200
@@ -31,7 +31,8 @@
 #include <linux/workqueue.h>
 
 /*
- * compile-time options
+ * compile-time options: to be removed as soon as all the drivers are
+ * converted to the new debugging mechanism 
  */
 #undef ATA_DEBUG		/* debugging output */
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
@@ -66,6 +67,38 @@
         }
 #endif
 
+/* NEW: debug levels */
+#define HAVE_LIBATA_MSG 1
+
+enum {
+	ATA_MSG_DRV	= 0x0001,
+	ATA_MSG_INFO	= 0x0002,
+	ATA_MSG_PROBE	= 0x0004,
+	ATA_MSG_WARN	= 0x0008,
+	ATA_MSG_MALLOC	= 0x0010,
+	ATA_MSG_CTL	= 0x0020,
+	ATA_MSG_INTR	= 0x0040,
+	ATA_MSG_ERR	= 0x0080,
+};
+
+#define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
+#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
+#define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
+#define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
+#define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
+#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
+#define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
+#define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
+
+static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
+{
+	if (dval < 0 || dval >= (sizeof(u32) * 8))
+		return default_msg_enable_bits;		// should be 0x0001 - only driver info 
msgs
+	if (!dval)
+		return 0;
+	return (1 << dval) - 1;
+}
+
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
@@ -318,6 +351,8 @@ struct ata_port {
 	unsigned int		pio_task_state;
 	unsigned long		pio_task_timeout;
 
+	u32			msg_enable;
+
 	void			*private_data;
 };
 
@@ -528,9 +563,9 @@ static inline u8 ata_wait_idle(struct at
 
 	if (status & (ATA_BUSY | ATA_DRQ)) {
 		unsigned long l = ap->ioaddr.status_addr;
-		printk(KERN_WARNING
-		       "ATA: abnormal status 0x%X on port 0x%lX\n",
-		       status, l);
+		if (ata_msg_warn(ap))
+			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
+				status, l);
 	}
 
 	return status;
@@ -610,7 +645,8 @@ static inline u8 ata_irq_ack(struct ata_
 
 	status = ata_busy_wait(ap, bits, 1000);
 	if (status & bits)
-		DPRINTK("abnormal status 0x%X\n", status);
+		if (ata_msg_err(ap))
+			printk(KERN_ERR "abnormal status 0x%X\n", status);
 
 	/* get controller status; clear intr, err bits */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -628,8 +664,10 @@ static inline u8 ata_irq_ack(struct ata_
 		post_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	}
 
-	VPRINTK("irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
-		host_stat, post_stat, status);
+	if (ata_msg_intr(ap))
+		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 
0x%X\n",
+			__FUNCTION__,
+			host_stat, post_stat, status);
 
 	return status;
 }
