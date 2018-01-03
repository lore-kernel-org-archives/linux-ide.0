From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ata_piix: constify pci_bits
Date: Wed,  3 Jan 2018 10:43:34 +0530
Message-ID: <b3ca2f147a9e0b52bfcaac891a7319bb2e039966.1514956322.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

pci_bits are not supposed to change at runtime. Functions
pci_test_config_bits() working with const 'struct pci_bits'.
So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/ata_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index b702c20..7ecb132 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -458,7 +458,7 @@ struct piix_host_priv {
 	[ich8_2port_sata_byt]	= &ich8_2port_map_db,
 };
 
-static struct pci_bits piix_enable_bits[] = {
+static const struct pci_bits piix_enable_bits[] = {
 	{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
 	{ 0x43U, 1U, 0x80UL, 0x80UL },	/* port 1 */
 };
-- 
1.9.1
