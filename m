From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] ahci: Add Intel Cannon Lake PCH-H PCI ID
Date: Thu, 11 Jan 2018 15:55:50 +0300
Message-ID: <20180111125551.61877-1-mika.westerberg@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44729 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933571AbeAKM4y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 11 Jan 2018 07:56:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-ide@vger.kernel.org

Add Intel Cannon Lake PCH-H PCI ID to the list of supported controllers.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5443cb71d7ba..a3131107136f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -386,6 +386,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
2.15.1

