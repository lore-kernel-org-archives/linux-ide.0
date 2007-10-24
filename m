From: David Miller <davem@davemloft.net>
Subject: [PATCH 4/4]: [PCI]: Add MSI INTX_DISABLE quirks for ATI SB700/800
 SATA and IXP SB400 USB
Date: Tue, 23 Oct 2007 19:53:43 -0700 (PDT)
Message-ID: <20071023.195343.35661973.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756848AbXJXCx2@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com
List-Id: linux-ide@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/pci/quirks.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 591eaa4..5795a3d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1725,4 +1725,24 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
 			PCI_DEVICE_ID_TIGON3_5714S,
 			quirk_msi_intx_disable_bug);
 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4390,
+			quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4391,
+			quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4392,
+			quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4393,
+			quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4394,
+			quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4395,
+			quirk_msi_intx_disable_bug);
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4373,
+			quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4374,
+			quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4375,
+			quirk_msi_intx_disable_bug);
+
 #endif /* CONFIG_PCI_MSI */
-- 
1.5.3.4
