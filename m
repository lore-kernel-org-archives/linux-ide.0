From: Romain Degez <romain.degez@gmail.com>
Subject: [PATCH 1/1] Add support for the Promise FastTrak TX8660 SATA HBA (ahci mode)
Date: Fri, 11 Jul 2014 18:08:13 +0200
Message-ID: <1405094893-9768-1-git-send-email-romain.degez@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:61995 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaGKQIt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2014 12:08:49 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so390604wes.23
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2014 09:08:42 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Romain Degez <romain.degez@gmail.com>

Add support of the Promise FastTrak TX8660 SATA HBA in ahci mode by registering the board in the ahci_pci_tbl[].

Note: this HBA also provide a hardware RAID mode when activated in BIOS but specific drivers from the manufacturer are required in this case.

Signed-off-by: Romain Degez <romain.degez@gmail.com>
Tested-by: Romain Degez <romain.degez@gmail.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index dae5607..4cd52a4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -456,6 +456,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 
 	/* Promise */
 	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
+	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
 
 	/* Asmedia */
 	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
-- 
2.0.1

