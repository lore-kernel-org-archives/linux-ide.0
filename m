From: Simon Guinot <simon.guinot@sequanux.org>
Subject: [PATCH] ahci: add PCI ID for Marvell 88SE9170 SATA controller
Date: Mon, 23 Dec 2013 13:24:35 +0100
Message-ID: <1387801475-32451-1-git-send-email-simon.guinot@sequanux.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vm1.sequanux.org ([188.165.36.56]:52908 "EHLO vm1.sequanux.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314Ab3LWMYq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Dec 2013 07:24:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Simon Guinot <sguinot@lacie.com>

From: Simon Guinot <sguinot@lacie.com>

This patch adds support for the PCI ID provided by the Marvell 88SE9170
SATA controller.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 drivers/ata/ahci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3d67f76..3f1794f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -427,6 +427,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9125),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9125 */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_MARVELL_EXT, 0x9178,
+			 PCI_VENDOR_ID_MARVELL_EXT, 0x9170),
+	  .driver_data = board_ahci_yes_fbs },			/* 88se9170 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x917a),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9172),
-- 
1.8.5.1

