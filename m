From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.x libata fixes
Date: Wed, 14 Jul 2004 16:33:33 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040714203333.GA31809@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:9952 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263448AbUGNUdg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jul 2004 16:33:36 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org


Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.6

This will update the following files:

 drivers/pci/quirks.c       |   31 ++++++++++++++++++++++++-------
 drivers/scsi/libata-core.c |    6 ++++--
 2 files changed, 28 insertions(+), 9 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/07/14 1.1880)
   [PCI, libata] Fix "combined mode" PCI quirk for ICH6
   
   The hardware vendor, in their infinite wisdom, make the combined
   mode configuration register different between ICH5 and ICH6.
   
   Take this into account.

<Sergio.Gelato@astro.su.se> (04/07/14 1.1879)
   [PATCH] libata: fix kunmap() of incorrect page, in PIO data xfer
   
   Obvious bug.  Fixes highmem oops.

diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-07-14 16:32:30 -04:00
+++ b/drivers/pci/quirks.c	2004-07-14 16:32:30 -04:00
@@ -817,6 +817,7 @@
 static void __init quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;
+	int ich = 0;
 
 	/*
 	 * Narrow down to Intel SATA PCI devices.
@@ -827,8 +828,12 @@
 	case 0x24df:
 	case 0x25a3:
 	case 0x25b0:
+		ich = 5;
+		break;
 	case 0x2651:
 	case 0x2652:
+	case 0x2653:
+		ich = 6;
 		break;
 	default:
 		/* we do not handle this PCI device */
@@ -839,13 +844,25 @@
 	 * Read combined mode register.
 	 */
 	pci_read_config_byte(pdev, 0x90, &tmp);	/* combined mode reg */
-	tmp &= 0x6;     /* interesting bits 2:1, PATA primary/secondary */
-	if (tmp == 0x4)		/* bits 10x */
-		comb = (1 << 0);		/* SATA port 0, PATA port 1 */
-	else if (tmp == 0x6)	/* bits 11x */
-		comb = (1 << 2);		/* PATA port 0, SATA port 1 */
-	else
-		return;				/* not in combined mode */
+
+	if (ich == 5) {
+		tmp &= 0x6;  /* interesting bits 2:1, PATA primary/secondary */
+		if (tmp == 0x4)		/* bits 10x */
+			comb = (1 << 0);	/* SATA port 0, PATA port 1 */
+		else if (tmp == 0x6)	/* bits 11x */
+			comb = (1 << 2);	/* PATA port 0, SATA port 1 */
+		else
+			return;			/* not in combined mode */
+	} else {
+		WARN_ON(ich != 6);
+		tmp &= 0x3;  /* interesting bits 1:0 */
+		if (tmp & (1 << 0))
+			comb = (1 << 2);	/* PATA port 0, SATA port 1 */
+		else if (tmp & (1 << 1))
+			comb = (1 << 0);	/* SATA port 0, PATA port 1 */
+		else
+			return;			/* not in combined mode */
+	}
 
 	/*
 	 * Read programming interface register.
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-07-14 16:32:30 -04:00
+++ b/drivers/scsi/libata-core.c	2004-07-14 16:32:30 -04:00
@@ -2029,6 +2029,7 @@
 {
 	struct ata_queued_cmd *qc;
 	struct scatterlist *sg;
+	struct page *page;
 	unsigned char *buf;
 	u8 status;
 
@@ -2065,7 +2066,8 @@
 	if (qc->cursect == (qc->nsect - 1))
 		ap->pio_task_state = PIO_ST_LAST;
 
-	buf = kmap(sg[qc->cursg].page) +
+	page = sg[qc->cursg].page;
+	buf = kmap(page) +
 	      sg[qc->cursg].offset + (qc->cursg_ofs * ATA_SECT_SIZE);
 
 	qc->cursect++;
@@ -2088,7 +2090,7 @@
 	else
 		insl(ap->ioaddr.data_addr, buf, ATA_SECT_DWORDS);
 
-	kunmap(sg[qc->cursg].page);
+	kunmap(page);
 }
 
 static void ata_pio_task(void *_data)
