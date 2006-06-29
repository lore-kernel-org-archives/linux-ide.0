From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 1/9] libata: change debugging macros/adjust dbg levels
Date: Thu, 29 Jun 2006 18:09:27 +0200
Message-ID: <20060629160926.GB23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp104.plus.mail.re2.yahoo.com ([206.190.53.29]:58705 "HELO
	smtp104.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750822AbWF2QLS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:11:18 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

change debugging macros ata_(port|dev)_printk and adjust debugging levels

Signed-off-by: <petkov@math.uni-muenster.de>


--- libata-dev/include/linux/libata.h	2006-06-29 17:17:50.000000000 +0200
+++ libata-dev/include/linux/libata.h.new	2006-06-28 17:23:30.000000000 +0200
@@ -67,24 +67,26 @@
 #define HAVE_LIBATA_MSG 1
 
 enum {
-	ATA_MSG_DRV	= 0x0001,
-	ATA_MSG_INFO	= 0x0002,
-	ATA_MSG_PROBE	= 0x0004,
-	ATA_MSG_WARN	= 0x0008,
-	ATA_MSG_MALLOC	= 0x0010,
-	ATA_MSG_CTL	= 0x0020,
-	ATA_MSG_INTR	= 0x0040,
-	ATA_MSG_ERR	= 0x0080,
-};
-
-#define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
-#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
-#define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
-#define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
-#define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
-#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
-#define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
-#define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
+	ATA_MSG_ERR	= 0x0001,
+	ATA_MSG_WARN	= 0x0002,
+	ATA_MSG_DRV	= 0x0004,
+	ATA_MSG_INFO	= 0x0008, /* revalidation messages, EH progress */
+	ATA_MSG_VDEBUG	= 0x0010, /* verbose hot path */
+	ATA_MSG_CMD	= 0x0020, /* issue / completion */
+	ATA_MSG_SG	= 0x0040, /* SG map/unmap handling */
+	ATA_MSG_TRACE	= 0x0080, /* function tracing, e.g. enter/exit */
+};
+
+const char *__ata_msg_lvs[] = {
+	[ATA_MSG_ERR]	 = KERN_ERR,
+	[ATA_MSG_WARN]	 = KERN_WARNING,
+	[ATA_MSG_DRV]	 = KERN_INFO,
+	[ATA_MSG_INFO]	 = KERN_INFO,
+	[ATA_MSG_VDEBUG] = KERN_DEBUG,
+	[ATA_MSG_CMD]	 = KERN_DEBUG,
+	[ATA_MSG_SG]	 = KERN_DEBUG,
+	[ATA_MSG_TRACE]	 = KERN_DEBUG
+};
 
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
@@ -805,11 +807,16 @@ extern void ata_do_eh(struct ata_port *a
 /*
  * printk helpers
  */
-#define ata_port_printk(ap, lv, fmt, args...) \
-	printk(lv"ata%u: "fmt, (ap)->id , ##args)
+#define ata_port_printk(ap, lv, fmt, args...) do { \
+	if (unlikely((ap)->msg_enable & (0xFF & (lv)))) \
+		printk("%sata%u: "fmt, __ata_msg_lvs[lv], (ap)->id , ##args); \
+} while (0)
 
-#define ata_dev_printk(dev, lv, fmt, args...) \
-	printk(lv"ata%u.%02u: "fmt, (dev)->ap->id, (dev)->devno , ##args)
+#define ata_dev_printk(dev, lv, fmt, args...) do { \
+	if (unlikely((dev->ap)->msg_enable & (0xFF & (lv)))) \
+		printk("%sata%u.%02u: "fmt, __ata_msg_lvs[lv], \
+				(dev)->ap->id, (dev)->devno , ##args); \
+} while (0)
 
 /*
  * ata_eh_info helpers
@@ -997,9 +1004,8 @@ static inline u8 ata_wait_idle(struct at
 
 	if (status & (ATA_BUSY | ATA_DRQ)) {
 		unsigned long l = ap->ioaddr.status_addr;
-		if (ata_msg_warn(ap))
-			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
-				status, l);
+		ata_port_printk(ap, ATA_MSG_WARN, 
+			"ATA: abnormal status 0x%X on port 0x%lX\n", status, l);
 	}
 
 	return status;
@@ -1109,8 +1115,7 @@ static inline u8 ata_irq_ack(struct ata_
 
 	status = ata_busy_wait(ap, bits, 1000);
 	if (status & bits)
-		if (ata_msg_err(ap))
-			printk(KERN_ERR "abnormal status 0x%X\n", status);
+		ata_port_printk(ap, ATA_MSG_ERR, "abnormal status 0x%X\n", status);
 
 	/* get controller status; clear intr, err bits */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -1128,10 +1133,10 @@ static inline u8 ata_irq_ack(struct ata_
 		post_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	}
 
-	if (ata_msg_intr(ap))
-		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
-			__FUNCTION__,
-			host_stat, post_stat, status);
+	ata_port_printk(ap, ATA_MSG_VDEBUG, 
+			"%s: irq ack: host_stat 0x%X, new host_stat 0x%X,"
+			"drv_stat 0x%X\n",
+			__FUNCTION__, host_stat, post_stat, status);
 
 	return status;
 }

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

