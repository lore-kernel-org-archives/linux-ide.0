From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata atapi work #2.2
Date: Sun, 16 May 2004 18:56:28 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A7F19C.3000602@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030400030709000707080807"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:235 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264838AbUEPW4l
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 18:56:41 -0400
Received: from rdu74-153-143.nc.rr.com ([24.74.153.143] helo=pobox.com)
	by www.linux.org.uk with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.33)
	id 1BPUYi-0000t7-UW
	for linux-ide@vger.kernel.org; Sun, 16 May 2004 23:56:41 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030400030709000707080807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

attached.

--------------030400030709000707080807
Content-Type: text/plain;
 name="patch.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.2"

# ChangeSet
#   2004/05/16 18:35:15-04:00 jgarzik@redhat.com 
#   [libata] DMADIR support
#   
#   DMADIR bit is necessary for some PATA->SATA bridges.  These
#   bridges require the OS driver to specify the data xfer direction,
#   for PACKET (a.k.a. scsi) commands.
#   
#   A reliable DMADIR detection method hasn't yet been developed,
#   and ATAPI is still a WIP, so DMADIR is enabled with an ifdef for
#   now.
# 
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	Sun May 16 18:54:41 2004
+++ b/drivers/scsi/libata-scsi.c	Sun May 16 18:54:41 2004
@@ -927,6 +927,12 @@
 		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
+
+#ifdef ATAPI_ENABLE_DMADIR
+		/* some SATA bridges need us to indicate data xfer direction */
+		if (cmd->sc_data_direction != SCSI_DATA_WRITE)
+			qc->tf.feature |= ATAPI_DMADIR;
+#endif
 	}
 
 	return 0;
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	Sun May 16 18:54:41 2004
+++ b/include/linux/ata.h	Sun May 16 18:54:41 2004
@@ -134,6 +134,8 @@
 
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
+	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
+						   0=to device, 1=to host */
 
 	/* cable types */
 	ATA_CBL_NONE		= 0,
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	Sun May 16 18:54:41 2004
+++ b/include/linux/libata.h	Sun May 16 18:54:41 2004
@@ -40,6 +40,7 @@
 #undef ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
 #undef ATA_ENABLE_PATA		/* define to enable PATA support in some
 				 * low-level drivers */
+#undef ATAPI_ENABLE_DMADIR	/* enables ATAPI DMADIR bridge support */
 
 
 /* note: prints function name for you */

--------------030400030709000707080807--

