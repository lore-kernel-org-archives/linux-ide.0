From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: sis controllers actually can do PMP
Date: Fri, 01 Aug 2008 12:51:43 +0900
Message-ID: <4892884F.5000805@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58861 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbYHADyO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 23:54:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, piterpunk@slackware.com

SIS controllers were blacklisted for PMP as enabling it made device
detection fail whether the device was PMP or not - the natural
conclusion was the controller chokes on SRST w/ pmp==15.  However, it
turned out that the controller just didn't like issuing SRST after
hardreset w/o clearing SError first.  Interestingly, the SRST itself
succeeds but the following commands fail.

If SError is cleared between hardreset and SRST, which is the default
behavior now, everything works fine and SIS controllers work with PMPs
happily.

Remove PMP blacklisting for SIS AHCIs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Piter PUNK <piterpunk@slackware.com>
---
 drivers/ata/ahci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ef3e552..2460370 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -575,9 +575,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(NVIDIA, 0x0bc7), board_ahci },		/* MCP7B */
 
 	/* SiS */
-	{ PCI_VDEVICE(SI, 0x1184), board_ahci_nopmp },		/* SiS 966 */
-	{ PCI_VDEVICE(SI, 0x1185), board_ahci_nopmp },		/* SiS 968 */
-	{ PCI_VDEVICE(SI, 0x0186), board_ahci_nopmp },		/* SiS 968 */
+	{ PCI_VDEVICE(SI, 0x1184), board_ahci },		/* SiS 966 */
+	{ PCI_VDEVICE(SI, 0x1185), board_ahci },		/* SiS 968 */
+	{ PCI_VDEVICE(SI, 0x0186), board_ahci },		/* SiS 968 */
 
 	/* Marvell */
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
