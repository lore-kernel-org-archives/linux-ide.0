From: "George Spelvin" <linux@horizon.com>
Subject: [PATCH] Use observed PCI ID for Marvell 88se9172 SATA controller.
Date: 28 May 2013 19:32:21 -0400
Message-ID: <20130528233221.26944.qmail@science.horizon.com>
References: <20130528223158.GA6149@mtj.dyndns.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:54509 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759267Ab3E1XcX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 May 2013 19:32:23 -0400
In-Reply-To: <20130528223158.GA6149@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org

A third possible PCI ID, as personally observed, and found in the
pci.ids list.

Signed-off-by: George Spelvin <linux@horizon.com>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6a67b07..d41437a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -421,6 +421,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */
 	{ PCI_DEVICE(0x1b4b, 0x9125),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9125 */
+	{ PCI_DEVICE(0x1b4b, 0x9172),
+	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 */
 	{ PCI_DEVICE(0x1b4b, 0x917a),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 */
 	{ PCI_DEVICE(0x1b4b, 0x9192),
-- 
1.8.3.rc3
