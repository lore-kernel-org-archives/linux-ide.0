From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata fix
Date: Sun, 12 Mar 2006 19:29:10 -0500
Message-ID: <20060313002910.GA1840@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:10467 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751940AbWCMA3O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 19:29:14 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/ahci.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

Tejun Heo:
      ahci: fix NULL pointer dereference detected by Coverity

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index a800fb5..559ff7a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -742,23 +742,17 @@ static irqreturn_t ahci_interrupt (int i
 			struct ata_queued_cmd *qc;
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (!ahci_host_intr(ap, qc))
-				if (ata_ratelimit()) {
-					struct pci_dev *pdev =
-						to_pci_dev(ap->host_set->dev);
-					dev_printk(KERN_WARNING, &pdev->dev,
+				if (ata_ratelimit())
+					dev_printk(KERN_WARNING, host_set->dev,
 					  "unhandled interrupt on port %u\n",
 					  i);
-				}
 
 			VPRINTK("port %u\n", i);
 		} else {
 			VPRINTK("port %u (no irq)\n", i);
-			if (ata_ratelimit()) {
-				struct pci_dev *pdev =
-					to_pci_dev(ap->host_set->dev);
-				dev_printk(KERN_WARNING, &pdev->dev,
+			if (ata_ratelimit())
+				dev_printk(KERN_WARNING, host_set->dev,
 					"interrupt on disabled port %u\n", i);
-			}
 		}
 
 		irq_ack |= (1 << i);
