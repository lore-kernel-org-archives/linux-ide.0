From: Stephen Hemminger <shemminger@vyatta.com>
Subject: [PATCH] ata: duplicate variable sparse warning
Date: Mon, 8 Sep 2008 09:31:39 -0700
Message-ID: <20080908093139.3909a3ac@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vyatta.com ([216.93.170.194]:48506 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbYIHQbm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 12:31:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

drivers/ata/ata_piix.c:1502:7: warning: symbol 'rc' shadows an earlier one

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

--- a/drivers/ata/ata_piix.c	2008-09-08 09:29:22.000000000 -0700
+++ b/drivers/ata/ata_piix.c	2008-09-08 09:29:33.000000000 -0700
@@ -1499,7 +1499,7 @@ static int __devinit piix_init_one(struc
 	 * off.
 	 */
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL && pdev->device == 0x2652) {
-		int rc = piix_disable_ahci(pdev);
+		rc = piix_disable_ahci(pdev);
 		if (rc)
 			return rc;
 	}
