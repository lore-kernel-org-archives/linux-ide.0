From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata questions
Date: Tue, 26 Jun 2007 12:37:28 +0900
Message-ID: <468089F8.2020208@gmail.com>
References: <BAY141-F4034066ACC5E6081F22872D7140@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090501090108040601060706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:31200 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbXFZDhf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 23:37:35 -0400
Received: by qb-out-0506.google.com with SMTP id z8so1923788qbc
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 20:37:34 -0700 (PDT)
In-Reply-To: <BAY141-F4034066ACC5E6081F22872D7140@phx.gbl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Armsdon <parmsdon@hotmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501090108040601060706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Phil Armsdon wrote:
> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 18
> ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 18
> ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 18
> scsi0 : ata_piix
> ata1.00: ATA-7, max UDMA/133, 78125000 sectors: LBA48
> ata1.00: ata1: dev 0 multi count 8
> ata1.00: configured for UDMA/133
> scsi1 : ata_piix
> ata2: port is slow to respond, please be patient (Status 0xff)
> ata2: port failed to respond (30 secs, Status 0xff)
> ata2: SRST failed (status 0xFF)
> ata2: SRST failed (err_mask=0x100)
> ata2: softreset failed, retrying in 5 secs
> ata2: SRST failed (status 0xFF)
> ata2: SRST failed (err_mask=0x100)
> ata2: softreset failed, retrying in 5 secs
> ata2: SRST failed (status 0xFF)
> ata2: SRST failed (err_mask=0x100)

* Me still confused.  You said something about PMP, right?  In the long,
there's no PMP related and ata_piix doesn't support PMP at all to begin
with, so how is your harddrive actually connected?

* ata1 is being detected alright.

* The error you're seeing on ata2 is fixed early this year.  Let me see.
 Hmmm.. It's commit d1adc1bbd6dde3e05a91e2d3e6ab42d202ea61d5.  I'm
attaching formatted patch for you.  That patch might not apply directly
but you should be able to get the idea.

-- 
tejun

--------------090501090108040601060706
Content-Type: text/x-patch;
 name="0001-libata-handle-0xff-status-properly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-libata-handle-0xff-status-properly.patch"

>From d1adc1bbd6dde3e05a91e2d3e6ab42d202ea61d5 Mon Sep 17 00:00:00 2001
From: Tejun Heo <htejun@gmail.com>
Date: Mon, 9 Oct 2006 18:32:15 +0900
Subject: [PATCH] [PATCH] libata: handle 0xff status properly

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
Signed-off-by: Jeff Garzik <jeff@garzik.org>
---
 drivers/ata/libata-core.c |   30 ++++++++++++++++++------------
 include/linux/libata.h    |    9 ++++-----
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b4fbfeb..d233667 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2328,11 +2328,14 @@ static inline void ata_tf_to_host(struct ata_port *ap,
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
@@ -2340,27 +2343,32 @@ unsigned int ata_busy_sleep (struct ata_port *ap,
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
@@ -2451,10 +2459,8 @@ static unsigned int ata_bus_softreset(struct ata_port *ap,
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
index 2300fcc..6c003d8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -746,9 +746,8 @@ extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t mesg);
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
@@ -1064,7 +1063,7 @@ static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
 		udelay(10);
 		status = ata_chk_status(ap);
 		max--;
-	} while ((status & bits) && (max > 0));
+	} while (status != 0xff && (status & bits) && (max > 0));
 
 	return status;
 }
@@ -1085,7 +1084,7 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
 {
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-	if (status & (ATA_BUSY | ATA_DRQ)) {
+	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ))) {
 		unsigned long l = ap->ioaddr.status_addr;
 		if (ata_msg_warn(ap))
 			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
-- 
1.5.0.3


--------------090501090108040601060706--
