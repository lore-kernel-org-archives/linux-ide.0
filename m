From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2/4] ahci: AHCI-mode SATA patch for Intel Coleto Creek DeviceIDs
Date: Wed, 19 Jun 2013 16:36:45 -0700
Message-ID: <1371685005-6424-1-git-send-email-seth.heasley@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4912 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934170Ab3FSXhz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Jun 2013 19:37:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: James Ralston <james.d.ralston@intel.com>, Seth Heasley <seth.heasley@intel.com>

This patch adds the AHCI-mode SATA DeviceIDs for the Intel Coleto Creek PCH.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>
---
 drivers/ata/ahci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2b50dfd..e381f36 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -291,6 +291,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x8d64), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
+	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
1.7.4.4

