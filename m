From: Jeff Garzik <jeff@garzik.org>
Subject: [git patches] libata fixes
Date: Sat, 13 Sep 2008 16:59:53 -0400
Message-ID: <20080913205953.GA4199@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:50757 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbYIMU7y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Sep 2008 16:59:54 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


The off-by-one bug fix is notable; see extended commit description.
Verified by several people as fixing their problem here.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/ata_piix.c      |    2 +-
 drivers/ata/sata_inic162x.c |    3 ++-
 include/linux/ata.h         |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

Bob Stewart (1):
      sata_inic162x: enable LED blinking

Stephen Hemminger (1):
      ata: duplicate variable sparse warning

Taisuke Yamada (1):
      [libata] LBA28/LBA48 off-by-one bug in ata.h

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index b1d08a8..e6b4606 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1499,7 +1499,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	 * off.
 	 */
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL && pdev->device == 0x2652) {
-		int rc = piix_disable_ahci(pdev);
+		rc = piix_disable_ahci(pdev);
 		if (rc)
 			return rc;
 	}
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 3ead02f..5032c32 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -96,6 +96,7 @@ enum {
 	PORT_SCR		= 0x20,
 
 	/* HOST_CTL bits */
+	HCTL_LEDEN		= (1 << 3),  /* enable LED operation */
 	HCTL_IRQOFF		= (1 << 8),  /* global IRQ off */
 	HCTL_FTHD0		= (1 << 10), /* fifo threshold 0 */
 	HCTL_FTHD1		= (1 << 11), /* fifo threshold 1*/
@@ -540,7 +541,7 @@ static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
 	void __iomem *port_base = inic_port_base(ap);
 
 	/* fire up the ADMA engine */
-	writew(HCTL_FTHD0, port_base + HOST_CTL);
+	writew(HCTL_FTHD0 | HCTL_LEDEN, port_base + HOST_CTL);
 	writew(IDMA_CTL_GO, port_base + PORT_IDMA_CTL);
 	writeb(0, port_base + PORT_CPB_PTQFIFO);
 
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 1ce19c1..8a12d71 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -745,7 +745,7 @@ static inline int ata_ok(u8 status)
 static inline int lba_28_ok(u64 block, u32 n_block)
 {
 	/* check the ending block number */
-	return ((block + n_block - 1) < ((u64)1 << 28)) && (n_block <= 256);
+	return ((block + n_block) < ((u64)1 << 28)) && (n_block <= 256);
 }
 
 static inline int lba_48_ok(u64 block, u32 n_block)
