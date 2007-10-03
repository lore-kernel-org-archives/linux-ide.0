From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/15] qd65xx: fix deadlock on error handling
Date: Thu, 4 Oct 2007 00:41:39 +0200
Message-ID: <200710040041.40047.bzolnier@gmail.com>
References: <200710012333.02643.bzolnier@gmail.com> <200710030015.44586.bzolnier@gmail.com> <4702C3D9.6040606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:54001 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbXJCWht (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 18:37:49 -0400
Received: by mu-out-0910.google.com with SMTP id i10so7656641mue
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2007 15:37:47 -0700 (PDT)
In-Reply-To: <4702C3D9.6040606@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Wednesday 03 October 2007, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> ACK everything else (that I snipped)...
> 
> > @@ -303,6 +281,7 @@ static void qd6580_set_pio_mode(ide_driv
> >  
> >  static int __init qd_testreg(int port)
> >  {
> > +	static DEFINE_SPINLOCK(qd65xx_lock);
> >  	unsigned long flags;
> >  	u8 savereg, readreg;
> 
> At this point, the lock is largely pointless, isn't it?
> 
> Seems like you might as well use local_irq_save/restore.

Yeah.


[PATCH] qd65xx: remove pointless qd_{read,write}_reg() (take 2)

These functions are atomic so locking is pointless (noticed by Sergei).

v2:
We can now just use local_irq_save/restore() in qd_testreg() (noticed by Jeff).

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/qd65xx.c |   46 +++++++++++---------------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -89,28 +89,6 @@
 
 static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */
 
-static DEFINE_SPINLOCK(qd65xx_lock);
-
-static void qd_write_reg (u8 content, unsigned long reg)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&qd65xx_lock, flags);
-	outb(content,reg);
-	spin_unlock_irqrestore(&qd65xx_lock, flags);
-}
-
-static u8 __init qd_read_reg (unsigned long reg)
-{
-	unsigned long flags;
-	u8 read;
-
-	spin_lock_irqsave(&qd65xx_lock, flags);
-	read = inb(reg);
-	spin_unlock_irqrestore(&qd65xx_lock, flags);
-	return read;
-}
-
 /*
  * qd_select:
  *
@@ -123,7 +101,7 @@ static void qd_select (ide_drive_t *driv
 			(QD_TIMREG(drive) & 0x02);
 
 	if (timings[index] != QD_TIMING(drive))
-		qd_write_reg(timings[index] = QD_TIMING(drive), QD_TIMREG(drive));
+		outb(timings[index] = QD_TIMING(drive), QD_TIMREG(drive));
 }
 
 /*
@@ -286,7 +264,7 @@ static void qd6580_set_pio_mode(ide_driv
 	}
 
 	if (!HWIF(drive)->channel && drive->media != ide_disk) {
-		qd_write_reg(0x5f, QD_CONTROL_PORT);
+		outb(0x5f, QD_CONTROL_PORT);
 		printk(KERN_WARNING "%s: ATAPI: disabled read-ahead FIFO "
 			"and post-write buffer on %s.\n",
 			drive->name, HWIF(drive)->name);
@@ -306,12 +284,12 @@ static int __init qd_testreg(int port)
 	unsigned long flags;
 	u8 savereg, readreg;
 
-	spin_lock_irqsave(&qd65xx_lock, flags);
+	local_irq_save(flags);
 	savereg = inb_p(port);
 	outb_p(QD_TESTVAL, port);	/* safe value */
 	readreg = inb_p(port);
 	outb(savereg, port);
-	spin_unlock_irqrestore(&qd65xx_lock, flags);
+	local_irq_restore(flags);
 
 	if (savereg == QD_TESTVAL) {
 		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");
@@ -365,13 +343,13 @@ static void __exit qd_unsetup(ide_hwif_t
 
 	if (set_pio_mode == (void *)qd6500_set_pio_mode) {
 		// will do it for both
-		qd_write_reg(QD6500_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
+		outb(QD6500_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
 	} else if (set_pio_mode == (void *)qd6580_set_pio_mode) {
 		if (QD_CONTROL(hwif) & QD_CONTR_SEC_DISABLED) {
-			qd_write_reg(QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
-			qd_write_reg(QD6580_DEF_DATA2, QD_TIMREG(&hwif->drives[1]));
+			outb(QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
+			outb(QD6580_DEF_DATA2, QD_TIMREG(&hwif->drives[1]));
 		} else {
-			qd_write_reg(hwif->channel ? QD6580_DEF_DATA2 : QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
+			outb(hwif->channel ? QD6580_DEF_DATA2 : QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
 		}
 	} else {
 		printk(KERN_WARNING "Unknown qd65xx tuning fonction !\n");
@@ -394,7 +372,7 @@ static int __init qd_probe(int base)
 	u8 config;
 	u8 unit;
 
-	config = qd_read_reg(QD_CONFIG_PORT);
+	config = inb(QD_CONFIG_PORT);
 
 	if (! ((config & QD_CONFIG_BASEPORT) >> 1 == (base == 0xb0)) )
 		return 1;
@@ -438,7 +416,7 @@ static int __init qd_probe(int base)
 
 		/* qd6580 found */
 
-		control = qd_read_reg(QD_CONTROL_PORT);
+		control = inb(QD_CONTROL_PORT);
 
 		printk(KERN_NOTICE "qd6580 at %#x\n", base);
 		printk(KERN_DEBUG "qd6580: config=%#x, control=%#x, ID3=%u\n",
@@ -459,7 +437,7 @@ static int __init qd_probe(int base)
 
 			ide_device_add(idx);
 
-			qd_write_reg(QD_DEF_CONTR, QD_CONTROL_PORT);
+			outb(QD_DEF_CONTR, QD_CONTROL_PORT);
 
 			return 1;
 		} else {
@@ -486,7 +464,7 @@ static int __init qd_probe(int base)
 
 			ide_device_add(idx);
 
-			qd_write_reg(QD_DEF_CONTR, QD_CONTROL_PORT);
+			outb(QD_DEF_CONTR, QD_CONTROL_PORT);
 
 			return 0; /* no other qd65xx possible */
 		}
