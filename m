From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata atapi work #2
Date: Thu, 13 May 2004 21:34:16 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A42218.5040905@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040107090502050706090501"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62417 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264311AbUENBe3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 May 2004 21:34:29 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Pat LaVarre <p.lavarre@ieee.org>

This is a multi-part message in MIME format.
--------------040107090502050706090501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040107090502050706090501
Content-Type: text/plain;
 name="patch.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.2"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/13 21:15:42-04:00 jgarzik@redhat.com 
#   [libata] use new ->bmdma_{start,setup} method to properly support ATAPI
# 
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Thu May 13 21:28:17 2004
+++ b/drivers/scsi/libata-core.c	Thu May 13 21:28:17 2004
@@ -2445,7 +2445,7 @@
 
 	case ATA_PROT_DMA:
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
-		ap->ops->bmdma_setup(qc);	    /* initiate bmdma */
+		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 		break;
 
@@ -2457,6 +2457,13 @@
 		queue_work(ata_wq, &ap->pio_task);
 		break;
 
+	case ATA_PROT_ATAPI:
+	case ATA_PROT_ATAPI_DMA:
+		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+		queue_work(ata_wq, &ap->packet_task);
+		break;
+
 	default:
 		WARN_ON(1);
 		return -1;
@@ -2843,7 +2850,7 @@
 
 	/* if we are DMA'ing, irq handler takes over from here */
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
-		/* FIXME: start DMA here */
+		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 	} else {
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);

--------------040107090502050706090501--

