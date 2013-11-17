From: Samir Benmendil <samir.benmendil@gmail.com>
Subject: [PATCH] ahci: add Marvell 9230 to the AHCI PCI device list
Date: Sun, 17 Nov 2013 23:56:17 +0100
Message-ID: <1384728977-25654-1-git-send-email-samir.benmendil@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:56501 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab3KQW5A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Nov 2013 17:57:00 -0500
Received: by mail-ea0-f174.google.com with SMTP id j14so863564eak.19
        for <linux-ide@vger.kernel.org>; Sun, 17 Nov 2013 14:56:59 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: levex@linux.com, Samir Benmendil <samir.benmendil@gmail.com>

Tested with a DAWICONTROL DC-624e on 3.10.10

Signed-off-by: Samir Benmendil <samir.benmendil@gmail.com>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e2903d0..14f1e95 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -435,6 +435,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 on some Gigabyte */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
+	  .driver_data = board_ahci_yes_fbs },
 
 	/* Promise */
 	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
-- 
1.8.3.3

