From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] ahci: disable MSI on SAMSUNG 0xa800 SSD
Date: Thu, 4 Dec 2014 13:19:59 -0500
Message-ID: <20141204181959.GB4080@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:40452 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbaLDSUE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2014 13:20:04 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so12358225qae.13
        for <linux-ide@vger.kernel.org>; Thu, 04 Dec 2014 10:20:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Dominik Mierzejewski <dominik@greysector.net>

>From 2b21ef0aae65f22f5ba86b13c4588f6f0c2dbefb Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 4 Dec 2014 13:13:28 -0500

Just like 0x1600 which got blacklisted by 66a7cbc303f4 ("ahci: disable
MSI instead of NCQ on Samsung pci-e SSDs on macbooks"), 0xa800 chokes
on NCQ commands if MSI is enabled.  Disable MSI.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Dominik Mierzejewski <dominik@greysector.net>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=89171
Cc: stable@vger.kernel.org
---
Applied to libata/for-3.18-fixes.

Thanks.

 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0ef0e39..49f1e68 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -495,6 +495,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	 * enabled.  https://bugzilla.kernel.org/show_bug.cgi?id=60731
 	 */
 	{ PCI_VDEVICE(SAMSUNG, 0x1600), board_ahci_nomsi },
+	{ PCI_VDEVICE(SAMSUNG, 0xa800), board_ahci_nomsi },
 
 	/* Enmotus */
 	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
-- 
2.1.0

