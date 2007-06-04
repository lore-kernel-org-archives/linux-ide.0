From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Add support to Marvell 6121 in the mv-ahci-pata branch
Date: Mon, 4 Jun 2007 20:52:25 +0200
Message-ID: <200706042052.25583.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p9FZG0Vp3dGBHJU"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.telefonica.net ([213.4.149.66]:15229 "EHLO
	ctsmtpout4.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756358AbXFDSwb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2007 14:52:31 -0400
Received: from jar.dominio (80.25.230.35) by ctsmtpout4.frontal.correo (7.2.056.6) (authenticated as jareguero$telefonica.net)
        id 46643EC200006970 for linux-ide@vger.kernel.org; Mon, 4 Jun 2007 20:52:29 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_p9FZG0Vp3dGBHJU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch add support to Marvell 6121.

Looking at the code I think that AHCI_FLAG_MV_PATA flag must be assigned to 
the PATA port.

Signed-off-by: Jose Alberto Reguero <jareguero@telefonica.net>

Jose Alberto

--Boundary-00=_p9FZG0Vp3dGBHJU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ahci_6121.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ahci_6121.diff"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 21df81e..8a2a56c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -528,6 +528,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 
 	/* Marvell */
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
+	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
 
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
@@ -2104,7 +2105,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	switch(ent->driver_data) {
 	case board_ahci_mv:
-		mvp_port = 4;		/* count starts from zero */
+		if (pdev->device == 0x6121)
+			mvp_port = 2;		/* count starts from zero */
+		else
+			mvp_port = 4;		/* count starts from zero */
 		break;
 
 	default:

--Boundary-00=_p9FZG0Vp3dGBHJU--
