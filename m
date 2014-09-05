From: Murali Karicheri <m-karicheri2@ti.com>
Subject: [PATCH] ahci: add pcid for Marvel 0x9182 controller
Date: Fri, 5 Sep 2014 13:12:26 -0400
Message-ID: <1409937146-30450-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Murali Karicheri <m-karicheri2@ti.com>, Tejun Heo <tj@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

CC: Tejun Heo <tj@kernel.org>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/ata/ahci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a29f801..02a415e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -442,6 +442,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x917a),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9172),
+	  .driver_data = board_ahci_yes_fbs },			/* 88se9182 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9182),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9192),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 on some Gigabyte */
-- 
1.7.9.5
