From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.x libata minor updates
Date: Sat, 30 Oct 2004 09:36:50 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041030133650.GA5997@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:4785 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261166AbUJ3Ngv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Oct 2004 09:36:51 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ahci.c    |    9 +++------
 include/linux/libata.h |    5 ++---
 2 files changed, 5 insertions(+), 9 deletions(-)

through these ChangeSets:

<nacc@us.ibm.com> (04/10/30 1.2346)
   [PATCH] scsi/ahci: replace schedule_timeout() with msleep()/ssleep()
   
   Description: Uses msleep() / ssleep() [as appropriate] instead of
   schedule_timeout() to guarantee the task delays as expected.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<jgarzik@pobox.com> (04/10/27 1.2214.1.1)
   [libata] cosmetic libata.h changes to make merging with 2.4 easier

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2004-10-30 09:36:06 -04:00
+++ b/drivers/scsi/ahci.c	2004-10-30 09:36:06 -04:00
@@ -363,8 +363,7 @@
 	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
 	 * this is slightly incorrect.
 	 */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout((HZ / 2) + 1);
+	msleep(500);
 
 	ap->private_data = NULL;
 	pci_free_consistent(pdev, AHCI_PORT_PRIV_DMA_SZ,
@@ -719,8 +718,7 @@
 	/* reset must complete within 1 second, or
 	 * the hardware should be considered fried.
 	 */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ + 1);
+	ssleep(1);
 
 	tmp = readl(mmio + HOST_CTL);
 	if (tmp & HOST_RESET) {
@@ -798,8 +796,7 @@
 			/* spec says 500 msecs for each bit, so
 			 * this is slightly incorrect.
 			 */
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout((HZ / 2) + 1);
+			msleep(500);
 		}
 
 		writel(PORT_CMD_SPIN_UP, port_mmio + PORT_CMD);
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-10-30 09:36:06 -04:00
+++ b/include/linux/libata.h	2004-10-30 09:36:06 -04:00
@@ -417,13 +417,12 @@
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
 extern void ata_eng_timeout(struct ata_port *ap);
+extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
+			      void (*done)(struct scsi_cmnd *));
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
-extern void ata_scsi_simulate(u16 *id,
-			      struct scsi_cmnd *cmd,
-			      void (*done)(struct scsi_cmnd *));
 
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
