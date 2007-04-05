From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] ATA: fix PCI must_checks
Date: Wed, 4 Apr 2007 21:37:11 -0700
Message-ID: <20070404213711.e4ce4c79.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:24915 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161151AbXDEEhR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Apr 2007 00:37:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>, akpm <akpm@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Check PCI interface functions results for PATA/SATA drivers.

Fixes these warnings:

drivers/ata/pata_cs5530.c:284: warning: ignoring return value of 'pci_set_mwi', declared with attribute warn_unused_result

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/pata_cs5530.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.21-rc5-mm4.orig/drivers/ata/pata_cs5530.c
+++ linux-2.6.21-rc5-mm4/drivers/ata/pata_cs5530.c
@@ -270,7 +270,9 @@ static int cs5530_init_chip(void)
 	}
 
 	pci_set_master(cs5530_0);
-	pci_set_mwi(cs5530_0);
+	if (pci_set_mwi(cs5530_0))
+		printk(KERN_WARNING DRV_NAME
+			": error enabling PCI MWI transactions\n");
 
 	/*
 	 * Set PCI CacheLineSize to 16-bytes:
