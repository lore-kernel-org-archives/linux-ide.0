From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: [PATCH] AMD SB700/SB800 SATA support 64bit DMA
Date: Fri, 22 Feb 2008 12:55:20 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E502C6961@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:13069 "EHLO
	outbound5-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757458AbYBVE4u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Feb 2008 23:56:50 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, "Su, Henry" <Henry.Su@amd.com>, "Huang, Shane" <Shane.Huang@amd.com>

Jeff:

SB700 SATA controller can support 64 bit DMA, the previous commit
badc2341579511a247f5993865aa68379e283c5c was added with
careless reference to SB600, which should be modified by this patch.


Signed-off-by: Shane Huang <shane.huang@amd.com>


diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c	2008-02-22 18:17:03.000000000 +0800
+++ b/drivers/ata/ahci.c	2008-02-22 18:16:54.000000000 +0800
@@ -85,6 +85,7 @@
 	board_ahci_ign_iferr	= 2,
 	board_ahci_sb600	= 3,
 	board_ahci_mv		= 4,
+	board_ahci_sb700	= 5,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -442,6 +443,16 @@
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	/* board_ahci_sb700 */
+	{
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
+				 AHCI_HFLAG_NO_PMP),
+		.flags		= AHCI_FLAG_COMMON,
+		.link_flags	= AHCI_LFLAG_COMMON,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 };
 
 static const struct pci_device_id ahci_pci_tbl[] = {
@@ -484,12 +495,12 @@
 
 	/* ATI */
 	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
-	{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb600 }, /* ATI SB700/800
*/
-	{ PCI_VDEVICE(ATI, 0x4391), board_ahci_sb600 }, /* ATI SB700/800
*/
-	{ PCI_VDEVICE(ATI, 0x4392), board_ahci_sb600 }, /* ATI SB700/800
*/
-	{ PCI_VDEVICE(ATI, 0x4393), board_ahci_sb600 }, /* ATI SB700/800
*/
-	{ PCI_VDEVICE(ATI, 0x4394), board_ahci_sb600 }, /* ATI SB700/800
*/
-	{ PCI_VDEVICE(ATI, 0x4395), board_ahci_sb600 }, /* ATI SB700/800
*/
+	{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700 }, /* ATI SB700/800
*/
+	{ PCI_VDEVICE(ATI, 0x4391), board_ahci_sb700 }, /* ATI SB700/800
*/
+	{ PCI_VDEVICE(ATI, 0x4392), board_ahci_sb700 }, /* ATI SB700/800
*/
+	{ PCI_VDEVICE(ATI, 0x4393), board_ahci_sb700 }, /* ATI SB700/800
*/
+	{ PCI_VDEVICE(ATI, 0x4394), board_ahci_sb700 }, /* ATI SB700/800
*/
+	{ PCI_VDEVICE(ATI, 0x4395), board_ahci_sb700 }, /* ATI SB700/800
*/
 
 	/* VIA */
 	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251
*/



