From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH 2/2] ahci: only attach ICH6-M if it's in SATA mode
Date: Mon, 16 Dec 2013 11:34:57 +0100
Message-ID: <1387190097.9255.31.camel@x41.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Intel's ICH6-M can operate either in IDE mode or in SATA mode. Attaching
in IDE mode is pointless (and should fail, as long as BIOS has configured
it even remotely sane). So let's only attach in SATA mode.

Note that ata_piix does the opposite: only attach if ICH6-M is in IDE
mode, so we end up with just one driver attaching in either mode.

(And since we're touching this table update a minor typo too.)

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested on an ICH6-M that always runs in IDE mode. So I'm not certain
this does the right thing for a ICH6-M running in SATA mode. 

 drivers/ata/ahci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4ba3bde..12182fd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -191,8 +191,10 @@ static const struct ata_port_info ahci_port_info[] = {
 
 static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Intel */
-	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci }, /* ICH6 */
-	{ PCI_VDEVICE(INTEL, 0x2653), board_ahci }, /* ICH6M */
+	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci }, /* ICH6R */
+	/* ICH6M Attach iff the controller is in SATA mode. */
+	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_STORAGE_SATA << 8, 0xffff00, board_ahci },
 	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */
 	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci }, /* ICH7M */
 	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci }, /* ICH7R */
-- 
1.8.1.4
