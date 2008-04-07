From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Mon, 7 Apr 2008 23:32:34 +0200
Message-ID: <200804072332.34811.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:20678 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbYDGVWc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 17:22:32 -0400
Received: by ug-out-1314.google.com with SMTP id z38so635596ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 07 Apr 2008 14:22:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


- make siimage driver work on PPC 44x
  (Sergei Shtylyov & Valentine Barshak)

Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/pci/siimage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


Sergei Shtylyov (1):
      siimage: fix kernel oops on PPC 44x


diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
index cc4be96..8d624af 100644
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -492,7 +492,7 @@ static void proc_reports_siimage (struct pci_dev *dev, u8 clocking, const char *
  
 static unsigned int setup_mmio_siimage (struct pci_dev *dev, const char *name)
 {
-	unsigned long bar5	= pci_resource_start(dev, 5);
+	resource_size_t bar5	= pci_resource_start(dev, 5);
 	unsigned long barsize	= pci_resource_len(dev, 5);
 	u8 tmpbyte	= 0;
 	void __iomem *ioaddr;
