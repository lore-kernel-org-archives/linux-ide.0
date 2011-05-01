From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] ide/ide-scan-pci.c: Use for_each_pci_dev().
Date: Sun,  1 May 2011 19:10:25 -0300
Message-ID: <1304287825-8023-1-git-send-email-tfransosi@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48391 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab1EAWKc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 May 2011 18:10:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org

Use for_each_pci_dev() to simplify the code.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 drivers/ide/ide-scan-pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-scan-pci.c b/drivers/ide/ide-scan-pci.c
index 0e79eff..c3da53e 100644
--- a/drivers/ide/ide-scan-pci.c
+++ b/drivers/ide/ide-scan-pci.c
@@ -88,7 +88,7 @@ static int __init ide_scan_pcibus(void)
 	struct list_head *l, *n;
 
 	pre_init = 0;
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)))
+	for_each_pci_dev(dev)
 		ide_scan_pcidev(dev);
 
 	/*
-- 
1.7.5.rc2.5.g60e19

