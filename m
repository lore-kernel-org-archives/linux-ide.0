From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2/3] ahci: AHCI-mode SATA patch for Intel Avoton DeviceIDs
Date: Fri, 25 Jan 2013 12:01:05 -0800
Message-ID: <1359144065-3359-1-git-send-email-seth.heasley@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43466 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756547Ab3AYTC7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2013 14:02:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Seth Heasley <seth.heasley@intel.com>, James Ralston <james.d.ralston@intel.com>

This patch adds the AHCI and RAID-mode SATA DeviceIDs for the Intel Avoton SOC.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>
---
 drivers/ata/ahci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7862d17..2e6530e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -264,6 +264,22 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci }, /* Lynx Point-LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci }, /* Lynx Point-LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci }, /* Lynx Point-LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f25), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f26), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f27), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f2e), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f2f), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f32), board_ahci }, /* Avoton AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1f33), board_ahci }, /* Avoton AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1f34), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f35), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f36), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci }, /* Avoton RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
1.7.11.7

