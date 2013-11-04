From: James Ralston <james.d.ralston@intel.com>
Subject: [PATCH 1/4] ahci: Add Device IDs for Intel Wildcat Point-LP
Date: Mon,  4 Nov 2013 09:24:58 -0800
Message-ID: <1383585898-4587-1-git-send-email-james.d.ralston@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63019 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab3KDRZa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Nov 2013 12:25:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Heasley <seth.heasley@intel.com>, James Ralston <james.d.ralston@intel.com>

This patch adds the AHCI-mode SATA Device IDs for the Intel Wildcat Point-LP PCH.

Signed-off-by: James Ralston <james.d.ralston@intel.com>
---
 drivers/ata/ahci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8e28f92..e2903d0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -292,6 +292,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci }, /* Wildcat Point-LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci }, /* Wildcat Point-LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci }, /* Wildcat Point-LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci }, /* Wildcat Point-LP RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
1.8.3.1

