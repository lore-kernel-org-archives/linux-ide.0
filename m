From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH] Intel DNV device IDs SATA
Date: Fri,  5 Feb 2016 15:27:49 -0800
Message-ID: <1454714869-12223-1-git-send-email-alexandra.yates@linux.intel.com>
References: <Intel DNV device IDs SATA>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31555 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbcBEXXw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Feb 2016 18:23:52 -0500
In-Reply-To: <Intel DNV device IDs SATA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Adding Intel codename DNV platform device IDs for SATA.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 drivers/ata/ahci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 594fcab..546a369 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -264,6 +264,26 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19b2), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19b3), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19b4), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19b5), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19b6), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19b7), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19bE), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19bF), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19c0), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19c1), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19c2), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19c3), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19c4), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19c5), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19c6), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19c7), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci }, /* DNV AHCI */
+	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci }, /* CPT AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
-- 
1.9.1

