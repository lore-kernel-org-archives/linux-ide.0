From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: make ULi M5288 ignore interface fatal error bit
Date: Tue, 23 Jan 2007 15:13:39 +0900
Message-ID: <20070123061339.GA8673@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:1288 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933036AbXAWGNp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jan 2007 01:13:45 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1128820nze
        for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 22:13:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

As with JMicron controllers, ULi M5288 sets interface fatal error bit
on device error including ATAPI CC.  This makes libata hardreset the
port on ATAPI CC thus making it impossible to use.  Ignore interface
fatal error bit on ULi M5288.  This fixes bugzilla bug #7837.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, this is a regression.  Please commit to both #upstream and
#upstream-fixes.  Thanks.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5998f74..4fb41a1 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -361,7 +361,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */
 	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci }, /* ICH7M */
 	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci }, /* ICH7R */
-	{ PCI_VDEVICE(AL, 0x5288), board_ahci }, /* ULi M5288 */
+	{ PCI_VDEVICE(AL, 0x5288), board_ahci_ign_iferr }, /* ULi M5288 */
 	{ PCI_VDEVICE(INTEL, 0x2681), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
