From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.11-rc6
Date: Wed, 12 Apr 2017 08:19:19 +0900
Message-ID: <20170411231919.GA3573@wtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34673 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdDKXTX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2017 19:19:23 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Two libata fixes.  One to disable hotplug on VT6420 which never worked
properly.  The other reverts an earlier patch which disabled the
second port on SB600/700.  There were some confusions due to earlier
datasheets which incorrectly indicated that the second port is not
implemented on both SB600 and 700.

Thanks.

The following changes since commit 6022c5cadf1a43ca30f431f128daa6163909ad60:

  ahci: qoriq: correct the sata ecc setting error (2017-03-09 11:55:23 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.11-fixes

for you to fetch changes up to 3cf864520e877505158f09075794a08abab11bbe:

  sata_via: Enable hotplug only on VT6421 (2017-04-11 09:12:18 +0900)

----------------------------------------------------------------
Ondrej Zary (1):
      sata_via: Enable hotplug only on VT6421

Tejun Heo (1):
      Revert "pata_atiixp: Don't use unconnected secondary port on SB600/SB700"

 drivers/ata/pata_atiixp.c |  5 -----
 drivers/ata/sata_via.c    | 18 ++++++++++--------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 6c9aa95..49d705c 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -278,11 +278,6 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	const struct ata_port_info *ppi[] = { &info, &info };
 
-	/* SB600/700 don't have secondary port wired */
-	if ((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE) ||
-		(pdev->device == PCI_DEVICE_ID_ATI_IXP700_IDE))
-		ppi[1] = &ata_dummy_port_info;
-
 	return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
 				      ATA_HOST_PARALLEL_SCAN);
 }
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 0636d84..f3f538e 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -644,14 +644,16 @@ static void svia_configure(struct pci_dev *pdev, int board_id,
 		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
 	}
 
-	/* enable IRQ on hotplug */
-	pci_read_config_byte(pdev, SVIA_MISC_3, &tmp8);
-	if ((tmp8 & SATA_HOTPLUG) != SATA_HOTPLUG) {
-		dev_dbg(&pdev->dev,
-			"enabling SATA hotplug (0x%x)\n",
-			(int) tmp8);
-		tmp8 |= SATA_HOTPLUG;
-		pci_write_config_byte(pdev, SVIA_MISC_3, tmp8);
+	if (board_id == vt6421) {
+		/* enable IRQ on hotplug */
+		pci_read_config_byte(pdev, SVIA_MISC_3, &tmp8);
+		if ((tmp8 & SATA_HOTPLUG) != SATA_HOTPLUG) {
+			dev_dbg(&pdev->dev,
+				"enabling SATA hotplug (0x%x)\n",
+				(int) tmp8);
+			tmp8 |= SATA_HOTPLUG;
+			pci_write_config_byte(pdev, SVIA_MISC_3, tmp8);
+		}
 	}
 
 	/*
