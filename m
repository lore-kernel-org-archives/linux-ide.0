From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/15] qd65xx: fix deadlock on error handling
Date: Mon, 1 Oct 2007 23:33:02 +0200
Message-ID: <200710012333.02643.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:61479 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbXJAVjh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:37 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977012ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Stop abusing ide_lock lock (switch to a private locking).

Fixes same issue as fixed by Alan Cox in atiixp host driver with
commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/qd65xx.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -89,13 +89,15 @@
 
 static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */
 
+static DEFINE_SPINLOCK(qd65xx_lock);
+
 static void qd_write_reg (u8 content, unsigned long reg)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&qd65xx_lock, flags);
 	outb(content,reg);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&qd65xx_lock, flags);
 }
 
 static u8 __init qd_read_reg (unsigned long reg)
@@ -103,9 +105,9 @@ static u8 __init qd_read_reg (unsigned l
 	unsigned long flags;
 	u8 read;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&qd65xx_lock, flags);
 	read = inb(reg);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&qd65xx_lock, flags);
 	return read;
 }
 
@@ -301,16 +303,15 @@ static void qd6580_set_pio_mode(ide_driv
 
 static int __init qd_testreg(int port)
 {
-	u8 savereg;
-	u8 readreg;
 	unsigned long flags;
+	u8 savereg, readreg;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&qd65xx_lock, flags);
 	savereg = inb_p(port);
 	outb_p(QD_TESTVAL, port);	/* safe value */
 	readreg = inb_p(port);
 	outb(savereg, port);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&qd65xx_lock, flags);
 
 	if (savereg == QD_TESTVAL) {
 		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");
