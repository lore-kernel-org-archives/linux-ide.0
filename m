From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: handle 0xff status properly
Date: Mon, 9 Oct 2006 18:32:15 +0900
Message-ID: <20061009093215.GF10832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:59707 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751725AbWJIJcf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Oct 2006 05:32:35 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1913025nfb
        for <linux-ide@vger.kernel.org>; Mon, 09 Oct 2006 02:32:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
Cc: Joe Jin <lkmaillist@gmail.com>

libata waits for !BSY even when the status register reports 0xff.
This causes long boot delays when D8 isn't pulled down properly.  This
patch does the followings.

* don't wait if status register is 0xff in all wait functions

* make ata_busy_sleep() return 0 on success and -errno on failure.
  -ENODEV is returned on 0xff status and -EBUSY on other failures.

* make ata_bus_softreset() succeed on 0xff status.  0xff status is not
  reset failure.  It indicates no device.  This removes unnecessary
  retries on such ports.  Note that the code change assumes unoccupied
  port reporting 0xff status does not produce valid device signature.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Joe Jin <lkmaillist@gmail.com>

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7ab45f4..68e9d0a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2321,11 +2321,14 @@ static inline void ata_tf_to_host(struct
  *	Sleep until ATA Status register bit BSY clears,
  *	or a timeout occurs.
  *
- *	LOCKING: None.
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
  */
-
-unsigned int ata_busy_sleep (struct ata_port *ap,
-			     unsigned long tmout_pat, unsigned long tmout)
+int ata_busy_sleep(struct ata_port *ap,
+		   unsigned long tmout_pat, unsigned long tmout)
 {
 	unsigned long timer_start, timeout;
 	u8 status;
@@ -2333,27 +2336,32 @@ unsigned int ata_busy_sleep (struct ata_
 	status = ata_busy_wait(ap, ATA_BUSY, 300);
 	timer_start = jiffies;
 	timeout = timer_start + tmout_pat;
-	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
+	while (status != 0xff && (status & ATA_BUSY) &&
+	       time_before(jiffies, timeout)) {
 		msleep(50);
 		status = ata_busy_wait(ap, ATA_BUSY, 3);
 	}
 
-	if (status & ATA_BUSY)
+	if (status != 0xff && (status & ATA_BUSY))
 		ata_port_printk(ap, KERN_WARNING,
 				"port is slow to respond, please be patient "
 				"(Status 0x%x)\n", status);
 
 	timeout = timer_start + tmout;
-	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
+	while (status != 0xff && (status & ATA_BUSY) &&
+	       time_before(jiffies, timeout)) {
 		msleep(50);
 		status = ata_chk_status(ap);
 	}
 
+	if (status == 0xff)
+		return -ENODEV;
+
 	if (status & ATA_BUSY) {
 		ata_port_printk(ap, KERN_ERR, "port failed to respond "
 				"(%lu secs, Status 0x%x)\n",
 				tmout / HZ, status);
-		return 1;
+		return -EBUSY;
 	}
 
 	return 0;
@@ -2444,10 +2452,8 @@ static unsigned int ata_bus_softreset(st
 	 * the bus shows 0xFF because the odd clown forgets the D7
 	 * pulldown resistor.
 	 */
-	if (ata_check_status(ap) == 0xFF) {
-		ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
-		return AC_ERR_OTHER;
-	}
+	if (ata_check_status(ap) == 0xFF)
+		return 0;
 
 	ata_bus_post_reset(ap, devmask);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index df44b09..2306cb8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -744,9 +744,8 @@ extern int ata_scsi_device_suspend(struc
 extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
 extern void ata_host_resume(struct ata_host *host);
 extern int ata_ratelimit(void);
-extern unsigned int ata_busy_sleep(struct ata_port *ap,
-				   unsigned long timeout_pat,
-				   unsigned long timeout);
+extern int ata_busy_sleep(struct ata_port *ap,
+			  unsigned long timeout_pat, unsigned long timeout);
 extern void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *),
 				void *data, unsigned long delay);
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
@@ -1061,7 +1060,7 @@ static inline u8 ata_busy_wait(struct at
 		udelay(10);
 		status = ata_chk_status(ap);
 		max--;
-	} while ((status & bits) && (max > 0));
+	} while (status != 0xff && (status & bits) && (max > 0));
 
 	return status;
 }
@@ -1082,7 +1081,7 @@ static inline u8 ata_wait_idle(struct at
 {
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-	if (status & (ATA_BUSY | ATA_DRQ)) {
+	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ))) {
 		unsigned long l = ap->ioaddr.status_addr;
 		if (ata_msg_warn(ap))
 			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
