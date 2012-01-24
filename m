From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 3/6] ata_piix: IDE-mode SATA patch for Intel Lynx Point DeviceIDs
Date: Mon, 23 Jan 2012 16:29:50 -0800
Message-ID: <201201231629.50767.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26120 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363Ab2AXAbS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jan 2012 19:31:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, james.d.ralston@intel.com, seth.heasley@intel.com

This patch adds the IDE-mode SATA DeviceIDs for the Intel Lynx Point PCH.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>
---
 drivers/ata/ata_piix.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 69ac373..9554f94 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -321,6 +321,14 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x1e08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (Panther Point) */
 	{ 0x8086, 0x1e09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (Lynx Point) */
+	{ 0x8086, 0x8c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
+	/* SATA Controller IDE (Lynx Point) */
+	{ 0x8086, 0x8c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
+	/* SATA Controller IDE (Lynx Point) */
+	{ 0x8086, 0x8c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (Lynx Point) */
+	{ 0x8086, 0x8c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	{ }	/* terminate list */
 };
 
-- 
1.7.4.4

