From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata atapi work #2.3
Date: Sun, 16 May 2004 18:56:43 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A7F1AB.5050500@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020802070008040202050804"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:747 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264842AbUEPW4z
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 18:56:55 -0400
Received: from rdu74-153-143.nc.rr.com ([24.74.153.143] helo=pobox.com)
	by www.linux.org.uk with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.33)
	id 1BPUYw-0000tF-Ox
	for linux-ide@vger.kernel.org; Sun, 16 May 2004 23:56:54 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020802070008040202050804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

attached.

--------------020802070008040202050804
Content-Type: text/plain;
 name="patch.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.3"

# ChangeSet
#   2004/05/16 18:48:08-04:00 jgarzik@redhat.com 
#   [libata] remove redundant use of ATA_QCFLAG_SG in ATAPI packet translation
#   
#   ata_scsi_translate() sets this flag for all ATA->SCSI translated
#   commands, so it need not be done in atapi_xlat().  The now-removed
#   use in atapi_xlat() was also inconsistent WRT PIO versus DMA.
# 
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	Sun May 16 18:55:09 2004
+++ b/drivers/scsi/libata-scsi.c	Sun May 16 18:55:09 2004
@@ -924,7 +924,6 @@
 
 	/* DMA data xfer - interrupt-driven */
 	} else {
-		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 

--------------020802070008040202050804--

