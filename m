From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.x libata fixes
Date: Tue, 7 Dec 2004 20:03:05 -0500
Message-ID: <20041208010305.GA24183@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:47488 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261973AbULHBDH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Dec 2004 20:03:07 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


The DMA map bug was pretty ugly.  Caused some "my device is gone"
problems, but no data corruption thankfully.  Please apply.

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ahci.c        |    3 ++-
 drivers/scsi/libata-core.c |   42 ++++++++++++++++++++++++++++++++++--------
 drivers/scsi/libata-scsi.c |    4 ++--
 include/linux/libata.h     |    1 +
 4 files changed, 39 insertions(+), 11 deletions(-)

through these ChangeSets:

<dougg@torque.net> (04/12/07 1.2150)
   [PATCH] off-by-1 libata-scsi INQUIRY VPD pages 0x80 and 0x83
   
   I have some code (in sginfo) that requests the first 4 bytes
   of SCSI INQUIRY VPD pages to get their length then asks for
   that exact length in a follow up request to fetch the payload.
   Just like I saw with 36 byte standard INQUIRYs (no fixed)
   I get a buffer  full or zeroes.
   
   BTW SCSI standards dictate that in situations where the allocation
   length (in the cdb) is less than what is needed that what can be
   sent shall be sent (i.e. truncated and without any error indication
   or modification to the part of the response returned).
   In other words it is up the the application client to take remedial
   action.
   
   Changelog:
      - fix off-by-1 allocation length issue with SCSI
        INQUIRY VPD pages 0x80 and 0x83
   
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<jgarzik@pobox.com> (04/12/07 1.2149)
   [libata] only DMA map data for DMA commands (fix >=4GB bug)
   
   libata made the assumption that (for PIO commands in this case)
   it could modify DMA memory at the kernel-virtual address, after
   mapping this.  This is incorrect, and fails on e.g. platforms that
   copy DMA memory back and forth (swiotlb on Intel EM64T and IA64).
   
   Remove this assumption by ensuring that we only call the DMA mapping
   routines if we really are going to use DMA for data xfer.
   
   Also:  remove a bogus WARN_ON() in ata_sg_init_one() which caused
   bug reports (but no problems).

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2004-12-07 20:01:34 -05:00
+++ b/drivers/scsi/ahci.c	2004-12-07 20:01:34 -05:00
@@ -229,7 +229,8 @@
 	{
 		.sht		= &ahci_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO,
+				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_DMA,
 		.pio_mask	= 0x03, /* pio3-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-12-07 20:01:34 -05:00
+++ b/drivers/scsi/libata-core.c	2004-12-07 20:01:34 -05:00
@@ -1950,8 +1950,6 @@
 	sg->page = virt_to_page(buf);
 	sg->offset = (unsigned long) buf & ~PAGE_MASK;
 	sg_dma_len(sg) = buflen;
-
-	WARN_ON(buflen > PAGE_SIZE);
 }
 
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
@@ -2693,6 +2691,30 @@
 	VPRINTK("EXIT\n");
 }
 
+static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+	case ATA_PROT_ATAPI_DMA:
+		return 1;
+
+	case ATA_PROT_ATAPI:
+	case ATA_PROT_PIO:
+	case ATA_PROT_PIO_MULT:
+		if (ap->flags & ATA_FLAG_PIO_DMA)
+			return 1;
+
+		/* fall through */
+	
+	default:
+		return 0;
+	}
+
+	/* never reached */
+}
+
 /**
  *	ata_qc_issue - issue taskfile to device
  *	@qc: command to issue to device
@@ -2713,12 +2735,16 @@
 {
 	struct ata_port *ap = qc->ap;
 
-	if (qc->flags & ATA_QCFLAG_SG) {
-		if (ata_sg_setup(qc))
-			goto err_out;
-	} else if (qc->flags & ATA_QCFLAG_SINGLE) {
-		if (ata_sg_setup_one(qc))
-			goto err_out;
+	if (ata_should_dma_map(qc)) {
+		if (qc->flags & ATA_QCFLAG_SG) {
+			if (ata_sg_setup(qc))
+				goto err_out;
+		} else if (qc->flags & ATA_QCFLAG_SINGLE) {
+			if (ata_sg_setup_one(qc))
+				goto err_out;
+		}
+	} else {
+		qc->flags &= ~ATA_QCFLAG_DMAMAP;
 	}
 
 	ap->ops->qc_prep(qc);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-12-07 20:01:34 -05:00
+++ b/drivers/scsi/libata-scsi.c	2004-12-07 20:01:34 -05:00
@@ -898,7 +898,7 @@
 	};
 	memcpy(rbuf, hdr, sizeof(hdr));
 
-	if (buflen > (ATA_SERNO_LEN + 4))
+	if (buflen > (ATA_SERNO_LEN + 4 - 1))
 		ata_dev_id_string(args->id, (unsigned char *) &rbuf[4],
 				  ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
 
@@ -927,7 +927,7 @@
 	rbuf[3] = 4 + strlen(inq_83_str);	/* page len */
 
 	/* our one and only identification descriptor (vendor-specific) */
-	if (buflen > (strlen(inq_83_str) + 4 + 4)) {
+	if (buflen > (strlen(inq_83_str) + 4 + 4 - 1)) {
 		rbuf[4 + 0] = 2;	/* code set: ASCII */
 		rbuf[4 + 3] = strlen(inq_83_str);
 		memcpy(rbuf + 4 + 4, inq_83_str, strlen(inq_83_str));
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-12-07 20:01:34 -05:00
+++ b/include/linux/libata.h	2004-12-07 20:01:34 -05:00
@@ -112,6 +112,7 @@
 	ATA_FLAG_SRST		= (1 << 5), /* use ATA SRST, not E.D.D. */
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
+	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
