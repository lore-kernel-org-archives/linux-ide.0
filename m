From: james.d.ralston@intel.com
Subject: [PATCH 2/5] ata_piix: Add Device IDs for Intel Lynx Point-LP PCH
Date: Thu,  9 Aug 2012 09:34:20 -0700
Message-ID: <1344530060-2435-1-git-send-email-james.d.ralston@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65087 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757896Ab2HIQfA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Aug 2012 12:35:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Heasley <seth.heasley@intel.com>, James Ralston <james.d.ralston@intel.com>

From: James Ralston <james.d.ralston@intel.com>

This patch adds the IDE-mode SATA Device IDs for the Intel Lynx Point-LP PCH

Signed-off-by: James Ralston <james.d.ralston@intel.com>
---
 drivers/ata/ata_piix.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 3c809bf..ef773e1 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -329,6 +329,14 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x8c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (Lynx Point) */
 	{ 0x8086, 0x8c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (Lynx Point-LP) */
+	{ 0x8086, 0x9c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
+	/* SATA Controller IDE (Lynx Point-LP) */
+	{ 0x8086, 0x9c01, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
+	/* SATA Controller IDE (Lynx Point-LP) */
+	{ 0x8086, 0x9c08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (Lynx Point-LP) */
+	{ 0x8086, 0x9c09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	/* SATA Controller IDE (DH89xxCC) */
 	{ 0x8086, 0x2326, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
 	{ }	/* terminate list */
-- 
1.7.7.6

