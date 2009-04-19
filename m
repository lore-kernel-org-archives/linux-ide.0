From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] mv-ahci: add other Marvell AHCI PCI IDs
Date: Sun, 19 Apr 2009 17:17:21 -0400
Message-ID: <20090419211721.GA22768@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:37462 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbZDSVRW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Apr 2009 17:17:22 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Another commit to 'libahci' branch...  this should be all the Marvell
AHCI-alikes.


commit 3ab5316b8d3999c84406f6617fbbe44a7a3dfa3d
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sun Apr 19 17:15:37 2009 -0400

    mv-ahci: add other Marvell AHCI-compatible PCI IDs
    
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

 drivers/ata/mv-ahci.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/mv-ahci.c b/drivers/ata/mv-ahci.c
index 02b35c5..223d2aa 100644
--- a/drivers/ata/mv-ahci.c
+++ b/drivers/ata/mv-ahci.c
@@ -243,8 +243,12 @@ static const struct ata_port_info mv_ahci_port_info[] = {
 };
 
 static const struct pci_device_id mv_ahci_pci_tbl[] = {
-	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
-	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
+	{ PCI_VDEVICE(MARVELL, 0x6101), board_ahci_mv },
+	{ PCI_VDEVICE(MARVELL, 0x6111), board_ahci_mv },
+	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },
+	{ PCI_VDEVICE(MARVELL, 0x6122), board_ahci_mv },
+	{ PCI_VDEVICE(MARVELL, 0x6141), board_ahci_mv },
+	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },
 
 	{ }	/* terminate list */
 };
@@ -1110,12 +1114,20 @@ static int mv_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *en
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
 
+	/* determine zero-based PATA port number, based on PCI device ID */
 	switch (pdev->device) {
+	case 0x6101:
+		mvp_port = 0;
+		break;
+	case 0x6111:
+		mvp_port = 1;
+		break;
 	case 0x6121:
-		mvp_port = 2;		/* count starts from zero */
+	case 0x6122:
+		mvp_port = 2;
 		break;
 	default:
-		mvp_port = 4;		/* count starts from zero */
+		mvp_port = 4;
 		break;
 	}
 
