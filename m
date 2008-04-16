From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] scc_pata: use ide_find_port()
Date: Thu, 17 Apr 2008 00:03:10 +0200
Message-ID: <200804170003.10503.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:15618 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbYDPW1q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:27:46 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3013115fkr.5
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:27:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kou Ishizaki <kou.ishizaki@toshiba.co.jp>, Akira Iguchi <akira2.iguchi@toshiba.co.jp>, Stephen Rothwell <sfr@canb.auug.org.au>


There should be no functional changes caused by this patch.

Cc: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Cc: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
goes after "sgiioc4: use ide_find_port()" patch into IDE tree

 drivers/ide/pci/scc_pata.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -534,12 +534,8 @@ static int scc_ide_setup_pci_device(stru
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	int i;
 
-	for (i = 0; i < MAX_HWIFS; i++) {
-		hwif = &ide_hwifs[i];
-		if (hwif->chipset == ide_unknown)
-			break; /* pick an unused entry */
-	}
-	if (i == MAX_HWIFS) {
+	hwif = ide_find_port();
+	if (hwif == NULL) {
 		printk(KERN_ERR "%s: too many IDE interfaces, "
 				"no room in table\n", SCC_PATA_NAME);
 		return -ENOMEM;
