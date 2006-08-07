From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: [patch] IDE <-> CPU-HLT performance problem on VIA
Date: Mon, 7 Aug 2006 20:20:50 +0200
Message-ID: <200608072020.50728.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CS41Et8R3jaKP1g"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:35765 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S932282AbWHGSWI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Aug 2006 14:22:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by toplitzer.net (SX Mail) with ESMTP id E69A5BD13
	for <linux-ide@vger.kernel.org>; Mon,  7 Aug 2006 20:19:55 +0200 (CEST)
Received: from [10.0.0.140] (pc057-adsl.adsl.uni-klu.ac.at [143.205.236.57])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by toplitzer.net (SX Mail) with ESMTP id 97CC9BCF7
	for <linux-ide@vger.kernel.org>; Mon,  7 Aug 2006 20:19:54 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_CS41Et8R3jaKP1g
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello!

I reported earlier (2.6.15) that there is a performance
problem with USB subsystems and IDE controllers
with current kernels on some VIA chipsets (at least 
one of VT82C586A/B/VT82C686/A/B/VT823x/A/C).

The performance-degradation - which still exists -
is more than 1/3 and so you can get 150% IDE performance 
with a simple patch.
(See before.txt and after.txt for test-cases)

Is it possible that this or a simmilar patch gets
applied to mainline? It might be a good idea to 
implement this with something like a "online detection"
if the kernel notices this degradation but I've no idea
how to do this. Maybe someone can help.

Helmut


-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656

--Boundary-00=_CS41Et8R3jaKP1g
Content-Type: text/plain;
  charset="iso-8859-15";
  name="after.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="after.txt"

# dd if=/dev/zero of=/tmp/test.txt bs=512
2214962+0 records in
2214961+0 records out
1134060032 bytes transferred in 32.199046 seconds (35220299 bytes/sec)

# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  162 MB in  3.00 seconds =  53.92 MB/sec

--Boundary-00=_CS41Et8R3jaKP1g
Content-Type: text/plain;
  charset="iso-8859-15";
  name="before.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="before.txt"

$ sync
$ dd if=/dev/zero of=/tmp/test.txt bs=512
1469919+0 Datensätze ein
1469918+0 Datensätze aus
752598016 bytes transferred in 36,126547 seconds (20832271 bytes/sec)

$ rm /tmp/test.txt 
$ sync
$ burnK7 &
[1] 6535
$ dd if=/dev/zero of=/tmp/test.txt bs=512
1966168+0 Datensätze ein
1966167+0 Datensätze aus
1006677504 bytes transferred in 35,200795 seconds (28598147 bytes/sec)
# killall burnK7
# sync
# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:   76 MB in  3.01 seconds =  25.25 MB/sec
# burnK7 &
[1] 6547
# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  166 MB in  3.01 seconds =  55.18 MB/sec

--Boundary-00=_CS41Et8R3jaKP1g
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="01_viahltpatch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="01_viahltpatch.diff"

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

--Boundary-00=_CS41Et8R3jaKP1g--
