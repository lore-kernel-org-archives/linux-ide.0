From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 01/11] ata: fix sparse warning in ata_piix.c
Date: Wed, 13 Feb 2008 21:14:05 -0800
Message-ID: <1202966045.2748.15.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:8020 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbYBNFOL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 00:14:11 -0500
Received: by rv-out-0910.google.com with SMTP id k20so160082rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 21:14:08 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

drivers/ata/ata_piix.c:1655:8: warning: symbol 'rc' shadows an earlier one
drivers/ata/ata_piix.c:1616:6: originally declared here

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/ata_piix.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 9c2515f..752e7d2 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1652,7 +1652,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 		u8 tmp;
 		pci_read_config_byte(pdev, PIIX_SCC, &tmp);
 		if (tmp == PIIX_AHCI_DEVICE) {
-			int rc = piix_disable_ahci(pdev);
+			rc = piix_disable_ahci(pdev);
 			if (rc)
 				return rc;
 		}
-- 
1.5.4.1.1278.gc75be


