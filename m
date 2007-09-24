From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/9] au1xxx-ide: set ->autotune and ->no_io_32bit also for the slave device
Date: Mon, 24 Sep 2007 22:38:44 +0200
Message-ID: <200709242238.44482.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:29636 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbXIXUqL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:46:11 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1485942nfb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 13:46:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -707,8 +707,10 @@ static int au_ide_probe(struct device *d
 	hwif->config_data               = 0;    /* no chipset-specific code */
 
 	hwif->drives[0].autotune        = 1;    /* 1=autotune, 2=noautotune, 0=default */
+	hwif->drives[1].autotune	= 1;
 #endif
-	hwif->drives[0].no_io_32bit     = 1;   
+	hwif->drives[0].no_io_32bit	= 1;
+	hwif->drives[1].no_io_32bit	= 1;
 
 	auide_hwif.hwif                 = hwif;
 	hwif->hwif_data                 = &auide_hwif;
