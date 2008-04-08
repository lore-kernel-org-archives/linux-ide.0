From: Benjamin Herrenschmidt <benh@ozlabs.org>
Subject: [PATCH] ata: Fix pata SIL680 build on arch/ppc
Date: Wed, 09 Apr 2008 07:51:07 +1000
Message-ID: <20080408215204.73730DE0A8@ozlabs.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:60320 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326AbYDHVwG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Apr 2008 17:52:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linuxppc-dev@ozlabs.org, Linux IDE <linux-ide@vger.kernel.org>

Commit 0f436eff54f90419ac1b8accfb3e6e17c4b49a4e breaks build on
arch/ppc as it doesn't implement the machine_is() macro.

This fixes it by using CONFIG_PPC_MERGE instead which represents
arch/powerpc only, while CONFIG_PPC is set for both.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 Index: linux-work/drivers/ata/pata_sil680.c
===================================================================
 drivers/ata/pata_sil680.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/drivers/ata/pata_sil680.c	2008-04-09 07:47:23.000000000 +1000
+++ linux-work/drivers/ata/pata_sil680.c	2008-04-09 07:47:29.000000000 +1000
@@ -270,7 +270,7 @@ static u8 sil680_init_chip(struct pci_de
 		tmpbyte & 1, tmpbyte & 0x30);
 
 	*try_mmio = 0;
-#ifdef CONFIG_PPC
+#ifdef CONFIG_PPC_MERGE
 	if (machine_is(cell))
 		*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
 #endif
