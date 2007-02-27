From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: implement and use ata_wait_idle_quiet()
Date: Tue, 27 Feb 2007 23:26:06 +0900
Message-ID: <20070227142606.GI20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:30069 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbXB0O0H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 09:26:07 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1585780nze
        for <linux-ide@vger.kernel.org>; Tue, 27 Feb 2007 06:26:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

ata_wait_idle() complains when the device isn't idle 10ms wait.
However, this function sometimes is used on empty ports.  As SATA
controllers report arbitrary status on empty ports, this causes
spurious warning messages.

* separate ata_wait_idle_quiet() from ata_wait_idle()
* use _quiet version in ata_irq_on()
* fix warning message in ata_wait_idle() to use ata_port_printk()
  while at it

This makes spurious abnormal status messages seen in many sff
controllers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 2ffcca0..22cd6e1 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -57,7 +57,8 @@ u8 ata_irq_on(struct ata_port *ap)
 	ap->last_ctl = ap->ctl;
 
 	iowrite8(ap->ctl, ioaddr->ctl_addr);
-	tmp = ata_wait_idle(ap);
+	/* we might be called on empty port for thawing, wait quietly */
+	tmp = ata_wait_idle_quiet(ap);
 
 	ap->ops->irq_clear(ap);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0a87ba8..6de878d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1095,9 +1095,8 @@ static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
 	return status;
 }
 
-
 /**
- *	ata_wait_idle - Wait for a port to be idle.
+ *	ata_wait_idle_quiet - Wait for a port to be idle.
  *	@ap: Port to wait for.
  *
  *	Waits up to 10ms for port's BUSY and DRQ signals to clear.
@@ -1106,15 +1105,30 @@ static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
  *	LOCKING:
  *	Inherited from caller.
  */
+static inline u8 ata_wait_idle_quiet(struct ata_port *ap)
+{
+	return ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+}
 
+/**
+ *	ata_wait_idle - Wait for a port to be idle, whine on failure.
+ *	@ap: Port to wait for.
+ *
+ *	Waits up to 10ms for port's BUSY and DRQ signals to clear.
+ *	Returns final value of status register.  This function whines
+ *	if port doesn't become idle in 10ms.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 static inline u8 ata_wait_idle(struct ata_port *ap)
 {
-	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+	u8 status = ata_wait_idle_quiet(ap);
 
 	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ))) {
 		if (ata_msg_warn(ap))
-			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%p\n",
-				status, ap->ioaddr.status_addr);
+			ata_port_printk(ap, KERN_WARNING,
+					"abnormal status 0x%x\n", status);
 	}
 
 	return status;
