From: Seiichi Ikarashi <ikarashi@miraclelinux.com>
Subject: [PATCH] libata on SATA only (non-combined) & legcy mode
Date: Fri, 15 Jul 2005 16:02:19 +0900
Message-ID: <20050715154003.B597.IKARASHI@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.miraclelinux.com ([219.118.163.66]:61314 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S263218AbVGOHCW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Jul 2005 03:02:22 -0400
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP id B89FC306687
	for <linux-ide@vger.kernel.org>; Fri, 15 Jul 2005 16:02:20 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

Hi Jeff,

The libata driver cannot be loaded if a system has a CD-ROM drive
connected via SATA instead of PATA because this is not combined
mode and reserved no ports in quirk_intel_ide_combined() function.
I think SATA only (non-combined) && legacy mode should be treated
as same as such combined mode. How about following patch?

----------------------- Original Message -----------------------
--- linux-2.6.11.7/drivers/pci/quirks.c.orig	2005-04-08 03:57:08.000000000 +0900
+++ linux-2.6.11.7/drivers/pci/quirks.c	2005-07-15 15:19:21.000000000 +0900
@@ -1195,7 +1195,7 @@ static void __devinit quirk_intel_ide_co
 		else if (tmp == 0x6)	/* bits 11x */
 			comb = (1 << 2);	/* PATA port 0, SATA port 1 */
 		else
-			return;			/* not in combined mode */
+			comb = 0;		/* not in combined mode */
 	} else {
 		WARN_ON((ich != 6) && (ich != 7));
 		tmp &= 0x3;  /* interesting bits 1:0 */
@@ -1204,7 +1204,7 @@ static void __devinit quirk_intel_ide_co
 		else if (tmp & (1 << 1))
 			comb = (1 << 0);	/* SATA port 0, PATA port 1 */
 		else
-			return;			/* not in combined mode */
+			comb = 0;		/* not in combined mode */
 	}
 
 	/*
@@ -1224,8 +1224,13 @@ static void __devinit quirk_intel_ide_co
 	 */
 	if (comb == (1 << 0))
 		request_region(0x1f0, 8, "libata");	/* port 0 */
-	else
+	else if (comb == (1 << 2))
 		request_region(0x170, 8, "libata");	/* port 1 */
+
+	if (comb == 0 && (prog & 0x5) == 0) {   /* Legacy but SATA only */
+		request_region(0x1f0, 8, "libata");     /* port 0 */
+		request_region(0x170, 8, "libata");     /* port 1 */
+	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,	  quirk_intel_ide_combined );
 #endif /* CONFIG_SCSI_SATA */
--------------------- Original Message Ends --------------------

-- 
Seiichi Ikarashi <ikarashi@miraclelinux.com>

