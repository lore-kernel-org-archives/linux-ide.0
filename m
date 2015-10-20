From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] ahci: Add Marvell 88se91a2 device id
Date: Tue, 20 Oct 2015 09:31:22 +0200
Message-ID: <1445326282-90339-1-git-send-email-jthumshirn@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60518 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbbJTHb2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Oct 2015 03:31:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>

Add device id for Marvell 88se91a2

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a466602..ff343c4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -489,6 +489,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 on some Gigabyte */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a2), 	/* 88se91a2 */
+	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
-- 
1.8.5.6

