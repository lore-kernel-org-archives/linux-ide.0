From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Thu, 19 Jan 2006 20:59:39 +0100
Message-ID: <200601192059.40161.pvrusb2@toplitzer.net>
References: <200601131909.07981.pvrusb2@toplitzer.net> <58cb370e0601190419u36e2509bmf11ccc90ef244c0e@mail.gmail.com> <200601191431.05126.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_s++zDITcYVs702p"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:22700 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S1161359AbWAST77 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2006 14:59:59 -0500
In-Reply-To: <200601191431.05126.pvrusb2@toplitzer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Rene Herman <rene.herman@keyaccess.nl>

--Boundary-00=_s++zDITcYVs702p
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Is this adequate?
You need a VIA82xxx board, HLT and pass disableviahlt on boot.
Tested on my system with success. Please check for 
errors.

Helmut


-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656

--Boundary-00=_s++zDITcYVs702p
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="viahltpatch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="viahltpatch.diff"

--- linux-2.6.15/drivers/ide/ide-dma.c	2006-01-19 20:53:01.000000000 +0100
+++ linux-2.6.15.viahlt/drivers/ide/ide-dma.c	2006-01-19 20:50:45.000000000 +0100
@@ -90,6 +90,57 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
+
+
+#ifdef CONFIG_BLK_DEV_VIA82CXXX
+static DEFINE_SPINLOCK(ide_hlt_lock);
+static int hlt_disabled;
+static int disableviahlt;
+static void ide_disable_hlt(void)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&ide_hlt_lock, flags);
+	if(!hlt_disabled && disableviahlt) {
+		hlt_disabled = 1;
+#ifdef HAVE_DISABLE_HLT
+		disable_hlt();
+#endif
+	}
+	spin_unlock_irqrestore(&ide_hlt_lock, flags);
+}
+
+static void ide_enable_hlt(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_hlt_lock, flags);
+	if(hlt_disabled && disableviahlt){
+		hlt_disabled = 0;
+#ifdef HAVE_DISABLE_HLT
+		enable_hlt();
+#endif
+	}
+	spin_unlock_irqrestore(&ide_hlt_lock, flags);
+}
+
+static int __init disableviahlt(char *str)
+{
+    printk(KERN_WARNING "DISABLE VIA HLT  activated\n");
+    disableviahlt = 1;
+    return 1;
+}
+
+__setup("disableviahlt", disableviahlt);
+
+
+#else
+static void ide_disable_hlt(void)
+{}
+static void ide_enable_hlt(void)
+{}
+#endif
+
 static const struct drive_list_entry drive_whitelist [] = {
 
 	{ "Micropolis 2112A"	,       "ALL"		},
@@ -303,6 +354,9 @@
 	if (count) {
 		if (!is_trm290)
 			*--table |= cpu_to_le32(0x80000000);
+#ifdef CONFIG_BLK_DEV_VIA82CXXX
+		ide_disable_hlt();
+#endif
 		return count;
 	}
 	printk(KERN_ERR "%s: empty DMA table?\n", drive->name);
@@ -334,6 +388,9 @@
 	int nents = HWIF(drive)->sg_nents;
 
 	pci_unmap_sg(dev, sg, nents, HWIF(drive)->sg_dma_direction);
+#ifdef CONFIG_BLK_DEV_VIA82CXXX
+	ide_enable_hlt();
+#endif
 }
 
 EXPORT_SYMBOL_GPL(ide_destroy_dmatable);

--Boundary-00=_s++zDITcYVs702p--
