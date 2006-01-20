From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: Re: [linux-usb-devel] Re: BUG?: VIA IDE transfer-rate problem
Date: Fri, 20 Jan 2006 12:27:26 +0100
Message-ID: <200601201227.27000.pvrusb2@toplitzer.net>
References: <Pine.LNX.4.44L0.0601191623570.4622-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ekM0D9jaG2Rz3bU"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:6086 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S1750839AbWATL1a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2006 06:27:30 -0500
In-Reply-To: <Pine.LNX.4.44L0.0601191623570.4622-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Rene Herman <rene.herman@keyaccess.nl>

--Boundary-00=_ekM0D9jaG2Rz3bU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Some stylistic suggestions.  The new routines should be surrounded by
>
> #if defined(CONFIG_BLK_DEV_VIA82CXXX) and defined(HAVE_VIA_HALT)
>
> In the #else part, make ide_disable_hlt and ide_enable_hlt inline.
>
> You don't need the #ifdef protecting the calls to to ide_disable_hlt and
> ide_enable_hlt.

Ok. Tidy up done. Fixed an error (redeclaration) and 
a possible problem. Is it possible that 2 DMA transfers
are setup at the same time and executed each after another?
However. This should not be a problem now.

Rene: Could you please try this out?
I'm currently working with it and it looks good.
Transfer rate is at 57MB and cooler goes down after
booting.

Helmut

-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656

--Boundary-00=_ekM0D9jaG2Rz3bU
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="viahltpatch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="viahltpatch.diff"

--- linux-2.6.15/drivers/ide/ide-dma.c	2006-01-19 20:53:01.000000000 +0100
+++ linux-2.6.15viahlt/drivers/ide/ide-dma.c	2006-01-20 12:00:32.000000000 +0100
@@ -90,6 +90,57 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
+
+/* Some VIA boards show strange slowdown when HLT is eanbled  */
+/* So we disable the HLT during a IDE-DMA transfer.           */
+/* You need to pass disableviahlt at boottime to enable this  */
+/* workaround.                                                */
+#if defined(CONFIG_BLK_DEV_VIA82CXXX) && defined(HAVE_DISABLE_HLT)
+
+static DEFINE_SPINLOCK(ide_hlt_lock);
+static int hlt_disabled;
+static int disableviahlt;
+static void ide_disable_hlt(void)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&ide_hlt_lock, flags);
+	if(disableviahlt) {
+		hlt_disabled++ ;
+		disable_hlt();
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
+		hlt_disabled--;
+		enable_hlt();
+	}
+	spin_unlock_irqrestore(&ide_hlt_lock, flags);
+}
+
+static int __init disable_via_hlt(char *str)
+{
+    printk(KERN_WARNING "DISABLE VIA HLT  activated\n");
+    disableviahlt = 1;
+    return 1;
+}
+
+__setup("disableviahlt", disable_via_hlt);
+
+
+#else  /* CONFIG_BLK_DEV_VIA82CXXX && HAVE_DISABLE_HLT */
+inline static void ide_disable_hlt(void)
+{}
+inline static void ide_enable_hlt(void)
+{}
+#endif /* CONFIG_BLK_DEV_VIA82CXXX && HAVE_DISABLE_HLT */
+
 static const struct drive_list_entry drive_whitelist [] = {
 
 	{ "Micropolis 2112A"	,       "ALL"		},
@@ -303,6 +354,7 @@
 	if (count) {
 		if (!is_trm290)
 			*--table |= cpu_to_le32(0x80000000);
+		ide_disable_hlt();
 		return count;
 	}
 	printk(KERN_ERR "%s: empty DMA table?\n", drive->name);
@@ -334,6 +386,7 @@
 	int nents = HWIF(drive)->sg_nents;
 
 	pci_unmap_sg(dev, sg, nents, HWIF(drive)->sg_dma_direction);
+	ide_enable_hlt();
 }
 
 EXPORT_SYMBOL_GPL(ide_destroy_dmatable);

--Boundary-00=_ekM0D9jaG2Rz3bU--
