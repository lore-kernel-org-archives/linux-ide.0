From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] Withdraw IGN_SERR_INTERNAL for SB800 SATA
Date: Tue, 30 Dec 2008 10:53:41 +0800
Message-ID: <1230605621.5519.7.camel@chunhao-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:40531 "EHLO
	SG2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbYL3CyD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 21:54:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, htejun@gmail.com
Cc: linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Re-sending this patch as Tejun suggested in case Jeff lost it. 

=== CUT HERE ===
There is an issue in ATI SB600/SB700 SATA that PxSERR.E should not be
set on some conditions, which will lead to many SATA ODD error messages.
commit 55a61604cd1354e1783364e1c901034f2f474b7d is the workaround.
Since SB800 fixed this HW issue, IGN_SERR_INTERNAL should be withdrawn
for SB800.

Signed-off-by: Shane Huang <shane.huang@amd.com>

diff -ruN c/drivers/ata/ahci.c d/drivers/ata/ahci.c
--- c/drivers/ata/ahci.c	2008-11-07 11:23:24.000000000 +0800
+++ d/drivers/ata/ahci.c	2008-11-07 11:23:28.000000000 +0800
@@ -105,7 +105,7 @@
 	board_ahci_ign_iferr	= 2,
 	board_ahci_sb600	= 3,
 	board_ahci_mv		= 4,
-	board_ahci_sb700	= 5,
+	board_ahci_sb700	= 5, /* for SB700 and SB800 */
 	board_ahci_mcp65	= 6,
 	board_ahci_nopmp	= 7,
 
@@ -439,7 +439,7 @@
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	/* board_ahci_sb700 */
+	/* board_ahci_sb700, for SB700 and SB800 */
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
 		.flags		= AHCI_FLAG_COMMON,
@@ -2610,6 +2610,10 @@
 	    (pdev->revision == 0xa1 || pdev->revision == 0xa2))
 		hpriv->flags |= AHCI_HFLAG_NO_MSI;
 
+	/* SB800 does NOT need the workaround to ignore SERR_INTERNAL */
+	if (board_id == board_ahci_sb700 && pdev->revision >= 0x40)
+		hpriv->flags &= ~AHCI_HFLAG_IGN_SERR_INTERNAL;
+
 	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
 		pci_intx(pdev, 1);
 


