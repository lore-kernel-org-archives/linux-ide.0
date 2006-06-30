From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 1/9] libata: change debugging macros/adjust dbg levels
Date: Fri, 30 Jun 2006 08:45:25 +0200
Message-ID: <20060630064525.GA17176@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:24230 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751206AbWF3GqH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 02:46:07 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

change debugging macros ata_(port|dev)_printk and adjust debugging levels

Signed-off-by: <petkov@math.uni-muenster.de>

diff --git a/include/linux/libata.h b/include/linux/libata.h
index f4284bf..8c67f1e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -67,24 +67,17 @@ #define BPRINTK(fmt, args...) if (ap->fl
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
+	ATA_MSG_ERR	= 0,
+	ATA_MSG_WARN	= 1,
+	ATA_MSG_INFO	= 2, /* revalidation messages, EH progress */
+	ATA_MSG_DEBUG	= 3, /* non-frequent debug messages */
+	ATA_MSG_VDEBUG	= 4, /* verbose hot path */
+	ATA_MSG_CMD	= 5, /* issue / completion */
+	ATA_MSG_SG	= 6, /* SG map/unmap handling */
+	ATA_MSG_TRACE	= 7, /* function tracing, e.g. enter/exit */
 };
 
-#define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
-#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
-#define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
-#define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
-#define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
-#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
-#define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
-#define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
+const char *__ata_msg_lvs[8];
 
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
@@ -805,11 +798,16 @@ extern void ata_do_eh(struct ata_port *a
 /*
  * printk helpers
  */
-#define ata_port_printk(ap, lv, fmt, args...) \
-	printk(lv"ata%u: "fmt, (ap)->id , ##args)
+#define ata_port_printk(ap, lv, fmt, args...) do { \
+	if (unlikely((ap)->msg_enable & (1 << (lv)))) \
+		printk("%sata%u: "fmt, __ata_msg_lvs[lv], (ap)->id , ##args); \
+} while (0)
 
-#define ata_dev_printk(dev, lv, fmt, args...) \
-	printk(lv"ata%u.%02u: "fmt, (dev)->ap->id, (dev)->devno , ##args)
+#define ata_dev_printk(dev, lv, fmt, args...) do { \
+	if (unlikely((dev->ap)->msg_enable & (1 << (lv)))) \
+		printk("%sata%u.%02u: "fmt, __ata_msg_lvs[lv], \
+				(dev)->ap->id, (dev)->devno , ##args); \
+} while (0)
 
 /*
  * ata_eh_info helpers
@@ -997,9 +995,8 @@ static inline u8 ata_wait_idle(struct at
 
 	if (status & (ATA_BUSY | ATA_DRQ)) {
 		unsigned long l = ap->ioaddr.status_addr;
-		if (ata_msg_warn(ap))
-			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
-				status, l);
+		ata_port_printk(ap, ATA_MSG_WARN, 
+			"abnormal status 0x%X on port 0x%lX\n", status, l);
 	}
 
 	return status;
@@ -1109,8 +1106,7 @@ static inline u8 ata_irq_ack(struct ata_
 
 	status = ata_busy_wait(ap, bits, 1000);
 	if (status & bits)
-		if (ata_msg_err(ap))
-			printk(KERN_ERR "abnormal status 0x%X\n", status);
+		ata_port_printk(ap, ATA_MSG_ERR, "abnormal status 0x%X\n", status);
 
 	/* get controller status; clear intr, err bits */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -1128,10 +1124,10 @@ static inline u8 ata_irq_ack(struct ata_
 		post_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	}
 
-	if (ata_msg_intr(ap))
-		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
-			__FUNCTION__,
-			host_stat, post_stat, status);
+	ata_port_printk(ap, ATA_MSG_DEBUG, 
+			"%s: irq ack: host_stat 0x%X, new host_stat 0x%X,"
+			"drv_stat 0x%X\n",
+			__FUNCTION__, host_stat, post_stat, status);
 
 	return status;
 }

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

