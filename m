From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] pata_artop: Fix device ID parity check
Date: Mon, 30 Aug 2010 17:37:05 +0200
Message-ID: <201008301737.05459.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42656 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab0H3PhI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Aug 2010 11:37:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@linux.intel.com>

x % 1 always evaluates to 0, which clearly isn't the intent. The
author probably had "% 2" or "& 1" in mind, and mispelled it.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@linux.intel.com>
---
Notice: I don't have the hardware so this fix is untested, bug was
found by code inspection.

 drivers/ata/pata_artop.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.36-rc3.orig/drivers/ata/pata_artop.c	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.36-rc3/drivers/ata/pata_artop.c	2010-08-30 17:07:17.000000000 +0200
@@ -74,7 +74,8 @@ static int artop6260_pre_reset(struct at
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	/* Odd numbered device ids are the units with enable bits (the -R cards) */
-	if (pdev->device % 1 && !pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
+	if ((pdev->device & 1) &&
+	    !pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
 		return -ENOENT;
 
 	return ata_sff_prereset(link, deadline);

-- 
Jean Delvare
Suse L3
