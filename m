From: scott.lawson@intel.com
Subject: [RFC] AHCI: Remove conflicting Intel Lewisburg 3rd-party SATA RAID device IDs
Date: Fri, 26 Feb 2016 10:09:29 -0800
Message-ID: <1456510169-27138-1-git-send-email-scott.lawson@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17808 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbcB0CIj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Feb 2016 21:08:39 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Scott Lawson <scott.lawson@intel.com>

From: Scott Lawson <scott.lawson@intel.com>

These PCI device IDs in the AHCI driver conflict with proprietary drivers,
preventing them from loading.

Signed-off-by: Scott Lawson <scott.lawson@intel.com>
---
 drivers/ata/ahci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 546a369..3394492 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -370,11 +370,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
 	{ PCI_VDEVICE(INTEL, 0xa184), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa18e), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa202), board_ahci }, /* Lewisburg AHCI*/
 	{ PCI_VDEVICE(INTEL, 0xa204), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa20e), board_ahci }, /* Lewisburg RAID*/
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
-- 
1.9.1

