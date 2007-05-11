From: akpm@linux-foundation.org
Subject: [patch 09/20] Add the combined mode for ATI SB700
Date: Thu, 10 May 2007 22:48:50 -0700
Message-ID: <200705110548.l4B5mo0P007639@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:42130 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758091AbXEKFtP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 01:49:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, henry.su@amd.com, htejun@gmail.com, luugi.marsan@amd.com

From: "Henry Su" <henry.su@amd.com>

Besides those modes in ATI SB600 SATA controller, ATI SB700 supports one
more mode:the combined mode.

The combined mode is a Legacy IDE mode used for compatibility with some old
OS without AHCI driver, but now it is not necessary for Linux since the
kernel has supported AHCI.

Signed-off-by: Luugi Marsan <luugi.marsan@amd.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/pci/quirks.c    |    1 +
 include/linux/pci_ids.h |    1 +
 2 files changed, 2 insertions(+)

diff -puN drivers/pci/quirks.c~add-the-combined-mode-for-ati-sb700 drivers/pci/quirks.c
--- a/drivers/pci/quirks.c~add-the-combined-mode-for-ati-sb700
+++ a/drivers/pci/quirks.c
@@ -875,6 +875,7 @@ static void __devinit quirk_sb600_sata(s
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_sb600_sata);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_SATA, quirk_sb600_sata);
 
 /*
  *	Serverworks CSB5 IDE does not fully support native mode
diff -puN include/linux/pci_ids.h~add-the-combined-mode-for-ati-sb700 include/linux/pci_ids.h
--- a/include/linux/pci_ids.h~add-the-combined-mode-for-ati-sb700
+++ a/include/linux/pci_ids.h
@@ -370,6 +370,7 @@
 #define PCI_DEVICE_ID_ATI_IXP600_SATA	0x4380
 #define PCI_DEVICE_ID_ATI_IXP600_SMBUS	0x4385
 #define PCI_DEVICE_ID_ATI_IXP600_IDE	0x438c
+#define PCI_DEVICE_ID_ATI_IXP700_SATA	0x4390
 
 #define PCI_VENDOR_ID_VLSI		0x1004
 #define PCI_DEVICE_ID_VLSI_82C592	0x0005
_
