From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] ahci: add an observed PCI ID for Marvell 88se9172 SATA
 controller
Date: Wed, 29 May 2013 10:22:31 +0900
Message-ID: <20130529012231.GB2874@mtj.dyndns.org>
References: <20130528223158.GA6149@mtj.dyndns.org>
 <20130528233221.26944.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:57639 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863Ab3E2BWf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 May 2013 21:22:35 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so8570674pbc.37
        for <linux-ide@vger.kernel.org>; Tue, 28 May 2013 18:22:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130528233221.26944.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-ide@vger.kernel.org

Applied to libata/for-3.10-fixes.  In the future, please base patches
on top of git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
for-XXX branches.

Thanks.

>From fcce9a35f8faaa1f52236c554ef1b15d99a7537e Mon Sep 17 00:00:00 2001
From: George Spelvin <linux@horizon.com>
Date: Wed, 29 May 2013 10:20:35 +0900

A third possible PCI ID, as personally observed, and found in the
pci.ids list.

Signed-off-by: George Spelvin <linux@horizon.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2180876..2b50dfd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -423,6 +423,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9125 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x917a),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9172),
+	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9192),
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9172 on some Gigabyte */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
-- 
1.8.1.4

