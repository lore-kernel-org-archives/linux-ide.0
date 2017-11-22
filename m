From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V2 11/29] Drivers: ide: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:06 -0500
Message-ID: <1511390964-9979-12-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, "open list:IDE SUBSYSTEM" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Replace pci_get_bus_and_slot() with pci_get_domain_bus_and_slot()
and extract the domain number from struct pci_dev.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/ide/sl82c105.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/sl82c105.c b/drivers/ide/sl82c105.c
index 8755df3..3300dac 100644
--- a/drivers/ide/sl82c105.c
+++ b/drivers/ide/sl82c105.c
@@ -239,8 +239,9 @@ static u8 sl82c105_bridge_revision(struct pci_dev *dev)
 	/*
 	 * The bridge should be part of the same device, but function 0.
 	 */
-	bridge = pci_get_bus_and_slot(dev->bus->number,
-			       PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	bridge = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
+					dev->bus->number,
+					PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	if (!bridge)
 		return -1;
 
-- 
1.9.1
