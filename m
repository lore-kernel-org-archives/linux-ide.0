From: Alan Cox <alan@redhat.com>
Subject: PATCH: quieten some IDE diagnostics we will be using much more
Date: Sun, 15 Aug 2004 10:46:24 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040815144624.GA8168@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:13785 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266727AbUHOOrV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2004 10:47:21 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c linux-2.6.8-rc3/drivers/ide/ide-probe.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-14 21:03:03.000000000 +0100
@@ -635,12 +680,11 @@
 	device_register(&hwif->gendev);
 }
 
-#ifdef CONFIG_PPC
 static int wait_hwif_ready(ide_hwif_t *hwif)
 {
 	int rc;
 
-	printk(KERN_INFO "Probing IDE interface %s...\n", hwif->name);
+	printk(KERN_DEBUG "Probing IDE interface %s...\n", hwif->name);
 
 	/* Let HW settle down a bit from whatever init state we
 	 * come from */
@@ -671,7 +715,6 @@
 	
 	return rc;
 }
-#endif
 
 /*
  * This routine only knows how to look for drive units 0 and 1
@@ -717,7 +760,6 @@
 
 	local_irq_set(flags);
 
-#ifdef CONFIG_PPC
 	/* This is needed on some PPCs and a bunch of BIOS-less embedded
 	 * platforms. Typical cases are:
 	 * 
@@ -738,8 +780,7 @@
 	 *  BenH.
 	 */
 	if (wait_hwif_ready(hwif))
-		printk(KERN_WARNING "%s: Wait for ready failed before probe !\n", hwif->name);
-#endif /* CONFIG_PPC */
+		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
 
 	/*
 	 * Second drive should only exist if first drive was found,
