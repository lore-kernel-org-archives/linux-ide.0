From: akpm@linux-foundation.org
Subject: [patch 1/1] pata_sil680: convert CONFIG_PPC_MERGE to CONFIG_PPC
Date: Mon, 22 Sep 2008 14:47:33 -0700
Message-ID: <200809222147.m8MLlXSa031665@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60867 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753347AbYIVVs4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 17:48:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, galak@kernel.crashing.org, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, paulus@samba.org

From: Kumar Gala <galak@kernel.crashing.org>

Now that arch/ppc is dead CONFIG_PPC_MERGE is always defined for all
powerpc platforms and we want to get rid of CONFIG_PPC_MERGE use
CONFIG_PPC instead.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_sil680.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/pata_sil680.c~pata_sil680-convert-config_ppc_merge-to-config_ppc drivers/ata/pata_sil680.c
--- a/drivers/ata/pata_sil680.c~pata_sil680-convert-config_ppc_merge-to-config_ppc
+++ a/drivers/ata/pata_sil680.c
@@ -230,7 +230,7 @@ static u8 sil680_init_chip(struct pci_de
 		tmpbyte & 1, tmpbyte & 0x30);
 
 	*try_mmio = 0;
-#ifdef CONFIG_PPC_MERGE
+#ifdef CONFIG_PPC
 	if (machine_is(cell))
 		*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
 #endif
_
