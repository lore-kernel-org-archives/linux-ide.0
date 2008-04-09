From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] siimage: do clocking register posting earlier in setup_mmio_siimage()
Date: Wed, 9 Apr 2008 20:51:01 +0200
Message-ID: <200804092051.01552.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:16404 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbYDISia (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Apr 2008 14:38:30 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2429684fgb.17
        for <linux-ide@vger.kernel.org>; Wed, 09 Apr 2008 11:38:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Do clocking register posting earlier in setup_mmio_siimage()
to match code in init_chipset_siimage().

This is a preparation for the next patch which merges PCI and MMIO
code paths together.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/siimage.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -521,7 +521,9 @@ static unsigned int setup_mmio_siimage (
 			writeb(tmpbyte & ~0x20, ioaddr + 0x4A);
 			break;
 	}
-	
+
+	tmpbyte = readb(ioaddr + 0x4A);
+
 	writeb(      0x72, ioaddr + 0xA1);
 	writew(    0x328A, ioaddr + 0xA2);
 	writel(0x62DD62DD, ioaddr + 0xA4);
@@ -540,8 +542,6 @@ static unsigned int setup_mmio_siimage (
 		writel(0x00680000, ioaddr + 0x1C8);
 	}
 
-	tmpbyte = readb(ioaddr + 0x4A);
-
 	proc_reports_siimage(dev, (tmpbyte>>4), name);
 	return 1;
 }
