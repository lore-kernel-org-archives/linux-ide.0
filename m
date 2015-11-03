From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V2] Intel device IDs SATA
Date: Tue,  3 Nov 2015 14:14:18 -0800
Message-ID: <1446588858-28167-1-git-send-email-alexandra.yates@linux.intel.com>
References: <[PATCH V2] Intel device IDs SATA>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36315 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbbKCWLw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Nov 2015 17:11:52 -0500
In-Reply-To: <[PATCH V2] Intel device IDs SATA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Adding Intel codename Lewisburg platform device IDs for SATA.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 drivers/ata/ahci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a466602..106e776 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -314,6 +314,16 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
+	{ PCI_VDEVICE(INTEL, 0xa202), board_ahci }, /* Lewisburg AHCI*/
+	{ PCI_VDEVICE(INTEL, 0xa184), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa204), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa18e), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0xa20e), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d02), board_ahci }, /* Wellsburg AHCI */
-- 
1.9.1

