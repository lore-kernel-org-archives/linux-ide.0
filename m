From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream] ahci/sata_vsc: drop intx manipulation on msi enable
Date: Fri, 23 Jan 2009 11:31:39 +0900
Message-ID: <49792C0B.6070602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56483 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747AbZAWCby (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 21:31:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

There's no need to turn off intx explicitly on msi enable.  This is
automatically handled by pci.  Drop it.

Note that, in sata_vsc's case, it was completely redundant; however,
for ahci, it might be needed on machines if the BIOS turns intx off
during boot.  However, there's no evidence of such behavior for ahci
and the only such case seems to be ICH5 PATA according to ata_piix.
Also, given the way ahci operates, it's highly unlikely BIOS ever
disables IRQ for the controller.  However, as this change has slight
possibility of introducing failure, please schedule it for #upstream.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
There are similar places in sata_sis and sata_uli.  I have no idea
whether they're there because they're needed or just copied over from
other drivers.  Eh...

Thanks.

 drivers/ata/ahci.c     |    4 ++--
 drivers/ata/sata_vsc.c |    3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7f701cb..18fac60 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2616,8 +2616,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (board_id == board_ahci_sb700 && pdev->revision >= 0x40)
 		hpriv->flags &= ~AHCI_HFLAG_IGN_SERR_INTERNAL;
 
-	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
-		pci_intx(pdev, 1);
+	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
+		pci_enable_msi(pdev);
 
 	/* save initial config */
 	ahci_save_initial_config(pdev, hpriv);
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index c57cdff..398328a 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -411,8 +411,7 @@ static int __devinit vsc_sata_init_one(struct pci_dev *pdev,
 	if (cls == 0x00)
 		pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
 
-	if (pci_enable_msi(pdev) == 0)
-		pci_intx(pdev, 0);
+	pci_enable_msi(pdev);
 
 	/*
 	 * Config offset 0x98 is "Extended Control and Status Register 0"
