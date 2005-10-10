From: Velu Erwan <erwan@seanodes.com>
Subject: [PATCH]: atiixp : Enabling UDMA5 on IXP200
Date: Mon, 10 Oct 2005 14:02:05 +0200
Message-ID: <434A583D.2030401@seanodes.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020200090707030309070405"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from seanodes.co.fr.clara.net ([212.43.220.11]:35231 "EHLO
	seanodes.co.fr.clara.net") by vger.kernel.org with ESMTP
	id S1750758AbVJJMCM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Oct 2005 08:02:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by seanodes.co.fr.clara.net (Postfix) with ESMTP id 0DBC24F932
	for <linux-ide@vger.kernel.org>; Mon, 10 Oct 2005 14:02:13 +0200 (CEST)
Received: from seanodes.co.fr.clara.net ([127.0.0.1])
	by localhost (seanodes [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 09974-06-2 for <linux-ide@vger.kernel.org>;
	Mon, 10 Oct 2005 14:02:12 +0200 (CEST)
Received: from [192.168.100.1] (unknown [81.80.43.77])
	by seanodes.co.fr.clara.net (Postfix) with ESMTP id 7F82C4F92C
	for <linux-ide@vger.kernel.org>; Mon, 10 Oct 2005 14:02:12 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020200090707030309070405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm an "Asus Pundit-R" owner, and like many of them I had troubles using 
the sata port (hdc).
hparm -t /dev/hdc gave me 15MB/sec and hdparm -I gave me udma2.

I've read atiixp.c and found that in the IXP200 case, the 
eighty_ninty_three() call fails so the slowest mode is selected.

        if (!eighty_ninty_three(drive))
                mode = min(mode, (u8)1);
       }

It sounds like on the IXP200 we must skip this test to reach the udma5. 
I've tried manually and it works.
I'm reaching 55MB/sec and hdparm -I give me udma5.

I've made a patch which match the IXP200 and "hdc" configuration.
In that case only, I'm skipping the eighty_ninty_three() call.
The patch works and apply to 2.6.10 -> 2.6.14-rc3.

I know that checking "hdc" is not very clean but I didn't find a more 
generic way to test if the "ide_drive_t *drive" is the sata port of the 
IXP200.
In the "Pundit-R" case, that's always hdc.

What do you think about that ?
Please found attached, my patch for atiixp.c

Regards,

--------------020200090707030309070405
Content-Type: text/x-patch;
 name="atiixp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atiixp.patch"

--- linux/drivers/ide/pci/atiixp.c.old	2005-10-09 18:02:16.136305632 +0200
+++ linux/drivers/ide/pci/atiixp.c	2005-10-09 19:38:37.917876664 +0200
@@ -1,6 +1,10 @@
 /*
+ *  linux/drivers/ide/pci/atiixp.c	Version 0.02		Oct. 09, 2005
  *  linux/drivers/ide/pci/atiixp.c	Version 0.01-bart2	Feb. 26, 2004
  *
+ *  Version 0.02		Workarounding 80pin cable detection
+ *  				on IXP200 sata's port : hdc (erwan.velu@free.fr)
+ *  Version 0.01-bart2		Initial Release
  *  Copyright (C) 2003 ATI Inc. <hyu@ati.com>
  *  Copyright (C) 2004 Bartlomiej Zolnierkiewicz
  *
@@ -56,10 +60,23 @@
 
 static u8 atiixp_ratemask(ide_drive_t *drive)
 {
+	struct pci_dev *dev     = HWIF(drive)->pci_dev;
 	u8 mode = 3;
 
+	switch (dev->device) {
+	case PCI_DEVICE_ID_ATI_IXP200_IDE:
+		/* Workarounding ATI IXP200 SATA BUG */
+		/* IXP200 always tell that hdc (the sata port) is not having a 80pin cable */
+		/* We must force to mode=3 (udma5) */
+		if (strncmp(drive->name,"hdc",strlen("hdc")) == 0) {
+			printk("ATIIXP: SATA drive detected (%s) on a IXP200 IDE controller,\
+			skipping cable detection, using ATA-100 transfert rate\n",drive->name);
+			break;
+		}
+	default:
 	if (!eighty_ninty_three(drive))
 		mode = min(mode, (u8)1);
+	}
 	return mode;
 }
 

--------------020200090707030309070405--
