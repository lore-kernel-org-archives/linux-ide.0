From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V2 04/29] ata: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:48:59 -0500
Message-ID: <1511390964-9979-5-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, "open list:LIBATA PATA DRIVERS" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Use pci_get_domain_bus_and_slot() and extract the actual domain number
from the pdev passed in.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/ata/pata_ali.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index d19cd88..0b122f9 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -466,7 +466,8 @@ static void ali_init_chipset(struct pci_dev *pdev)
 			tmp |= 0x01;	/* CD_ROM enable for DMA */
 		pci_write_config_byte(pdev, 0x53, tmp);
 	}
-	north = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
+	north = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus), 0,
+					    PCI_DEVFN(0, 0));
 	if (north && north->vendor == PCI_VENDOR_ID_AL && ali_isa_bridge) {
 		/* Configure the ALi bridge logic. For non ALi rely on BIOS.
 		   Set the south bridge enable bit */
-- 
1.9.1
