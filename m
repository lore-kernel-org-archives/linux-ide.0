From: Devin Ryles <devin.ryles@intel.com>
Subject: [PATCH 2/3] AHCI: Add DeviceIDs for Sunrise Point-LP SATA controller
Date: Fri, 07 Nov 2014 17:59:05 -0500
Message-ID: <1415401145.1954.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2758 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbaKGW7L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Nov 2014 17:59:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, james.d.ralston@intel.com, frank.riegel@intel.com, devin.ryles@intel.com

>From f01919cca1259bb2eec1c6db00cf31055a5c481d Mon Sep 17 00:00:00 2001
From: Devin Ryles <devin.ryles@intel.com>
Date: Wed, 5 Nov 2014 17:41:22 -0500
Subject: [PATCH 2/3] AHCI: Add DeviceIDs for Sunrise Point-LP SATA
controller

This patch adds DeviceIDs for Sunrise Point-LP

Signed-off-by: Devin Ryles <devin.ryles@intel.com>
---
 drivers/ata/ahci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5f039f1..50d9de5 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -313,6 +313,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci }, /* 9 Series RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci }, /* 9 Series RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci }, /* Sunrise Point-LP AHCI*/
+	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci }, /* Sunrise Point-LP RAID*/
+	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci }, /* Sunrise Point-LP RAID*/
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
1.9.3



