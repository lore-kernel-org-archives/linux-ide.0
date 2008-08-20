From: akpm@linux-foundation.org
Subject: [patch 3/3] ahci: RAID mode SATA patch for Intel Ibex Peak DeviceIDs
Date: Wed, 20 Aug 2008 16:48:35 -0700
Message-ID: <200808202348.m7KNmZMP005820@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36238 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756032AbYHTXuk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Aug 2008 19:50:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, seth.heasley@intel.com

From: Seth Heasley <seth.heasley@intel.com>

Add the Intel Ibex Peak (PCH) SATA RAID Controllers DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/ahci.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN drivers/ata/ahci.c~ahci-raid-mode-sata-patch-for-intel-ibex-peak-deviceids drivers/ata/ahci.c
--- a/drivers/ata/ahci.c~ahci-raid-mode-sata-patch-for-intel-ibex-peak-deviceids
+++ a/drivers/ata/ahci.c
@@ -486,6 +486,8 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
 	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
+	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
_
