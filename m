From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ahci: SB600 ahci can't do MSI
Date: Tue, 29 Apr 2008 16:09:22 +0900
Message-ID: <4816C9A2.9000503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.248]:43108 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750771AbYD2HJ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Apr 2008 03:09:29 -0400
Received: by rv-out-0506.google.com with SMTP id k29so3140386rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 29 Apr 2008 00:09:28 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Shane Huang <Shane.Huang@amd.com>

SB600 ahci can't do MSI.  Blacklist it.

This fixes bz#10507.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Shane Huang <Shane.Huang@amd.com>
---
 drivers/ata/ahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tree0/drivers/ata/ahci.c
===================================================================
--- tree0.orig/drivers/ata/ahci.c
+++ tree0/drivers/ata/ahci.c
@@ -433,7 +433,7 @@ static const struct ata_port_info ahci_p
 	/* board_ahci_sb600 */
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
-				 AHCI_HFLAG_32BIT_ONLY |
+				 AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
 				 AHCI_HFLAG_SECT255 | AHCI_HFLAG_NO_PMP),
 		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= AHCI_LFLAG_COMMON,
