From: Jeff Garzik <jeff@garzik.org>
Subject: [git patches] libata fixes
Date: Sat, 12 Apr 2008 01:28:55 -0400
Message-ID: <20080412052855.GA16140@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:48207 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958AbYDLF2z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 01:28:55 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/pata_ali.c |    2 +-
 drivers/ata/sata_svw.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Adrian Bunk (1):
      [libata] make ali_atapi_dma static

Jeff Garzik (1):
      [libata] sata_svw: fix reversed port count

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index ce830fe..511a830 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -36,7 +36,7 @@
 #define DRV_NAME "pata_ali"
 #define DRV_VERSION "0.7.5"
 
-int ali_atapi_dma = 0;
+static int ali_atapi_dma = 0;
 module_param_named(atapi_dma, ali_atapi_dma, int, 0644);
 MODULE_PARM_DESC(atapi_dma, "Enable ATAPI DMA (0=disable, 1=enable)");
 
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 840d1c4..019e367 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -531,8 +531,8 @@ static int k2_sata_init_one(struct pci_dev *pdev, const struct pci_device_id *en
  * */
 static const struct pci_device_id k2_sata_pci_tbl[] = {
 	{ PCI_VDEVICE(SERVERWORKS, 0x0240), chip_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0242), chip_svw8 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw8 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0242), chip_svw4 },
 	{ PCI_VDEVICE(SERVERWORKS, 0x024a), chip_svw4 },
 	{ PCI_VDEVICE(SERVERWORKS, 0x024b), chip_svw4 },
 	{ PCI_VDEVICE(SERVERWORKS, 0x0410), chip_svw42 },
