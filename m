From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata atapi work #5
Date: Fri, 14 May 2004 14:26:47 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A50F67.5020601@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030108000602040300010509"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46005 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262019AbUENS1A
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 14:27:00 -0400
Received: from rdu74-153-143.nc.rr.com ([24.74.153.143] helo=pobox.com)
	by www.linux.org.uk with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.33)
	id 1BOhOd-0001a0-8h
	for linux-ide@vger.kernel.org; Fri, 14 May 2004 19:26:59 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030108000602040300010509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

attached.

--------------030108000602040300010509
Content-Type: text/plain;
 name="patch.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.5"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/13 22:46:01-04:00 jgarzik@redhat.com 
#   [libata] kill ATA_QCFLAG_POLL flag
#   
#   The standard ATA bit nIEN in the Device Control register serves as
#   the indicator for whether we are polling or not.  As it mirrors
#   ATA_QCFLAG_POLL completely, eliminate that in favor of testing
#   ATA_NIEN bit.
# 
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Fri May 14 14:24:25 2004
+++ b/drivers/scsi/libata-core.c	Fri May 14 14:24:25 2004
@@ -2733,7 +2733,7 @@
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
 				handled += ata_host_intr(ap, qc);
 		}
 	}
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	Fri May 14 14:24:25 2004
+++ b/drivers/scsi/sata_promise.c	Fri May 14 14:24:25 2004
@@ -421,7 +421,7 @@
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
 				handled += pdc_host_intr(ap, qc);
 		}
 	}
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	Fri May 14 14:24:25 2004
+++ b/drivers/scsi/sata_sx4.c	Fri May 14 14:24:25 2004
@@ -748,7 +748,7 @@
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
 				handled += pdc20621_host_intr(ap, qc, (i > 4),
 							      mmio_base);
 		}
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	Fri May 14 14:24:25 2004
+++ b/drivers/scsi/sata_vsc.c	Fri May 14 14:24:25 2004
@@ -175,7 +175,7 @@
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
+				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
 					handled += ata_host_intr(ap, qc);
 			}
 		}
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	Fri May 14 14:24:25 2004
+++ b/include/linux/libata.h	Fri May 14 14:24:25 2004
@@ -112,7 +112,6 @@
 	ATA_QCFLAG_DMA		= (1 << 2), /* data delivered via DMA */
 	ATA_QCFLAG_ATAPI	= (1 << 3), /* is ATAPI packet command? */
 	ATA_QCFLAG_SG		= (1 << 4), /* have s/g table? */
-	ATA_QCFLAG_POLL		= (1 << 5), /* polling, no interrupts */
 
 	/* various lengths of time */
 	ATA_TMOUT_EDD		= 5 * HZ,	/* hueristic */
@@ -483,7 +482,6 @@
 
 static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
 {
-	qc->flags |= ATA_QCFLAG_POLL;
 	qc->flags &= ~ATA_QCFLAG_DMA;
 	qc->tf.ctl |= ATA_NIEN;
 }

--------------030108000602040300010509--

