From: Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] pci: use pci_ioremap_bar() in drivers/ide
Date: Mon, 20 Oct 2008 21:48:30 -0700
Message-ID: <20081020214830.1586704c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35277 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbYJUEsQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Oct 2008 00:48:16 -0400
Received: from c-71-193-193-226.hsd1.or.comcast.net ([71.193.193.226] helo=localhost.localdomain)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1Ks9AE-0001uS-My
	for linux-ide@vger.kernel.org; Tue, 21 Oct 2008 04:48:15 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>From 9233d7e38207749586c47410b400afcf3e7e59fb Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Sun, 28 Sep 2008 16:14:10 -0700
Subject: [PATCH] pci: use pci_ioremap_bar() in drivers/ide

Use the newly introduced pci_ioremap_bar() function in drivers/ide.
pci_ioremap_bar() just takes a pci device and a bar number, with the goal
of making it really hard to get wrong, while also having a central place
to stick sanity checks.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/ide/pci/sgiioc4.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
index 8af9b23..9233217 100644
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -574,7 +574,7 @@ sgiioc4_ide_setup_pci_device(struct pci_dev *dev)
 
 	/*  Get the CmdBlk and CtrlBlk Base Registers */
 	bar0 = pci_resource_start(dev, 0);
-	virt_base = ioremap(bar0, pci_resource_len(dev, 0));
+	virt_base = pci_ioremap_bar(dev, 0);
 	if (virt_base == NULL) {
 		printk(KERN_ERR "%s: Unable to remap BAR 0 address: 0x%lx\n",
 				DRV_NAME, bar0);
-- 
1.5.5.1



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
