From: James Ralston <james.d.ralston@intel.com>
Subject: [PATCH 2/3] ata_piix: Add Device IDs for Intel 9 Series PCH
Date: Wed, 27 Aug 2014 14:31:58 -0700
Message-ID: <1409175118-4766-1-git-send-email-james.d.ralston@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: James Ralston <james.d.ralston@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This patch adds the IDE mode SATA Device IDs for the Intel 9 Series PCH.

Signed-off-by: James Ralston <james.d.ralston@intel.com>
---
 drivers/ata/ata_piix.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 893e30e..ffbe625 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -340,6 +340,14 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x0F21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_byt },
 	/* SATA Controller IDE (Coleto Creek) */
 	{ 0x8086, 0x23a6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (9 Series) */
+	{ 0x8086, 0x8c88, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_snb },
+	/* SATA Controller IDE (9 Series) */
+	{ 0x8086, 0x8c89, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_snb },
+	/* SATA Controller IDE (9 Series) */
+	{ 0x8086, 0x8c80, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
+	/* SATA Controller IDE (9 Series) */
+	{ 0x8086, 0x8c81, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
 
 	{ }	/* terminate list */
 };
-- 
1.8.3.1
