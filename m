From: akpm@linux-foundation.org
Subject: [patch 2/3] ata_piix: IDE mode SATA patch for Intel Ibex Peak DeviceIDs
Date: Wed, 20 Aug 2008 16:48:34 -0700
Message-ID: <200808202348.m7KNmZel005817@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53837 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754272AbYHTXtj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Aug 2008 19:49:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, seth.heasley@intel.com

From: Seth Heasley <seth.heasley@intel.com>

Add the Intel Ibex Peak (PCH) IDE mode SATA Controller DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/ata_piix.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/ata/ata_piix.c~ata_piix-ide-mode-sata-patch-for-intel-ibex-peak-deviceids drivers/ata/ata_piix.c
--- a/drivers/ata/ata_piix.c~ata_piix-ide-mode-sata-patch-for-intel-ibex-peak-deviceids
+++ a/drivers/ata/ata_piix.c
@@ -275,6 +275,14 @@ static const struct pci_device_id piix_p
 	{ 0x8086, 0x3a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (ICH10) */
 	{ 0x8086, 0x3a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (PCH) */
+	{ 0x8086, 0x3b20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
+	/* SATA Controller IDE (PCH) */
+	{ 0x8086, 0x3b26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (PCH) */
+	{ 0x8086, 0x3b2d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	/* SATA Controller IDE (PCH) */
+	{ 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 
 	{ }	/* terminate list */
 };
_
