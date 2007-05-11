From: akpm@linux-foundation.org
Subject: [patch 10/20] add the ATI  SB700 SATA controller device id  to AHCI pci table
Date: Thu, 10 May 2007 22:48:51 -0700
Message-ID: <200705110548.l4B5mpwH007642@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:55908 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758052AbXEKFtM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 01:49:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, henry.su@amd.com, htejun@gmail.com

From: "Henry Su" <henry.su@amd.com>

Add the device ID to AHCI pci table for ATI SB700 SATA controller, the
subsequent chipset of SB600.

Signed-off-by: henry su<henry.su@amd.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/ahci.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/ata/ahci.c~add-the-ati-sb700-sata-controller-device-id-to-ahci-pci-table drivers/ata/ahci.c
--- a/drivers/ata/ahci.c~add-the-ati-sb700-sata-controller-device-id-to-ahci-pci-table
+++ a/drivers/ata/ahci.c
@@ -409,6 +409,7 @@ static const struct pci_device_id ahci_p
 
 	/* ATI */
 	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
+	{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb600 }, /* ATI SB700 */
 
 	/* VIA */
 	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
_
