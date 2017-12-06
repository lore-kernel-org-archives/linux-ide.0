From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] ahci: Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI
Date: Wed,  6 Dec 2017 16:41:09 +0100
Message-ID: <20171206154110.11548-3-hdegoede@redhat.com>
References: <20171206154110.11548-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206154110.11548-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake AHCI
SATA controllers. This commit is a preparation patch for allowing a
different default sata link powermanagement policy for mobile chipsets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9d842ff6ec51..844f697bedbf 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -386,6 +386,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa206), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci }, /* Apollo Lake AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
2.14.3
