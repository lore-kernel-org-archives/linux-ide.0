From: scott.lawson@intel.com
Subject: [PATCH] AHCI: Remove obsolete Intel Lewisburg SATA RAID device IDs
Date: Fri, 26 Feb 2016 10:09:52 -0800
Message-ID: <1456510192-27184-1-git-send-email-scott.lawson@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44401 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755218AbcB0CJE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Feb 2016 21:09:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Scott Lawson <scott.lawson@intel.com>

From: Scott Lawson <scott.lawson@intel.com>

These PCI device IDs have been removed from the Intel Lewisburg design
specification. They are no longer needed.

Signed-off-by: Scott Lawson <scott.lawson@intel.com>
---
 drivers/ata/ahci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 546a369..97c41b3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -369,13 +369,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0xa184), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa18e), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa202), board_ahci }, /* Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0xa204), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa20e), board_ahci }, /* Lewisburg RAID*/
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
1.9.1

