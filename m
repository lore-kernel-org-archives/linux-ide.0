From: David Miller <davem@davemloft.net>
Subject: [PATCH 4/5]: [PCI]: Add MSI INTX_DISABLE quirks for ATI SB700/800
 SATA and IXP SB400 USB
Date: Thu, 25 Oct 2007 01:16:52 -0700 (PDT)
Message-ID: <20071025.011652.235276029.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57865
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1759363AbXJYIQu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 04:16:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/pci/quirks.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 9e8c7af..d8f2d89 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1731,4 +1731,24 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
 			PCI_DEVICE_ID_TIGON3_5715S,
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
1.5.2.5

