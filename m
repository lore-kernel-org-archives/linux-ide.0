From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: hpt366: kill unused variable
Date: Wed, 15 Oct 2008 23:47:24 +0400
Message-ID: <200810152347.24929.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:3509 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753052AbYJOTrk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 15:47:40 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fix the "unused variable" warning in init_hwif_hpt366() caused by the commit
1785192b5310ee25165768f5bb80f13146788e3e (hpt366: add hpt3xx_disable_fast_irq()
helper).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' kernel...

 drivers/ide/pci/hpt366.c |    1 -
 1 files changed, 1 deletion(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1289,7 +1289,6 @@ static u8 hpt3xx_cable_detect(ide_hwif_t
 
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 	int serialize		= HPT_SERIALIZE_IO;
 	u8  chip_type		= info->chip_type;

