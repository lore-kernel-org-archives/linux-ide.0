From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: convert ATAPI_ENABLE_DMADIR to module parameter
Date: Tue, 04 Apr 2006 10:57:18 +0800
Message-ID: <4431E08E.8040108@tw.ibm.com>
References: <1br232p2g092l611qrqvmvpuus2bqp7bc2@4ax.com> <4431CF4D.6000806@gmail.com> <4431D5F5.4010905@tw.ibm.com> <4431D6D1.9020206@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:31461 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964978AbWDDC5d
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Apr 2006 22:57:33 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k342vPjk032068
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 22:57:25 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3430aYa167948
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 21:00:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k342vOdt019238
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 20:57:24 -0600
In-Reply-To: <4431D6D1.9020206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Convert the ATAPI_ENABLE_DMADIR compile time option needed
by some SATA-PATA bridge to runtime module parameter.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Before we can detect the bridge chips which need the ATAPI DMADIR workaround
automatically, maybe using a module parameter is easier for the end users to
turn on this option.

Patch against upstream (af64371ada9452632c349563d688d30d94e918ba).
For your review, thanks.

--- upstream/drivers/scsi/libata-core.c	2006-04-03 13:15:20.000000000 +0800
+++ upstream_dmadir/drivers/scsi/libata-core.c	2006-04-04 10:40:39.000000000 +0800
@@ -76,6 +76,10 @@ int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
 
+int atapi_dmadir = 0;
+module_param(atapi_dmadir, int, 0444);
+MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off, 1=on)");
+
 int libata_fua = 0;
 module_param_named(fua, libata_fua, int, 0444);
 MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on)");
--- upstream/drivers/scsi/libata-scsi.c	2006-04-03 13:15:20.000000000 +0800
+++ upstream_dmadir/drivers/scsi/libata-scsi.c	2006-04-04 10:33:52.000000000 +0800
@@ -2163,11 +2163,9 @@ static unsigned int atapi_xlat(struct at
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 
-#ifdef ATAPI_ENABLE_DMADIR
-		/* some SATA bridges need us to indicate data xfer direction */
-		if (cmd->sc_data_direction != DMA_TO_DEVICE)
+		if (atapi_dmadir && (cmd->sc_data_direction != DMA_TO_DEVICE))
+			/* some SATA bridges need us to indicate data xfer direction */
 			qc->tf.feature |= ATAPI_DMADIR;
-#endif
 	}
 
 	qc->nbytes = cmd->bufflen;
--- upstream/drivers/scsi/libata.h	2006-04-03 13:15:20.000000000 +0800
+++ upstream_dmadir/drivers/scsi/libata.h	2006-04-04 10:39:14.000000000 +0800
@@ -41,6 +41,7 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
+extern int atapi_dmadir;
 extern int libata_fua;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
--- upstream/include/linux/libata.h	2006-04-03 13:15:27.000000000 +0800
+++ upstream_dmadir/include/linux/libata.h	2006-04-04 10:41:01.000000000 +0800
@@ -44,7 +44,6 @@
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
 #undef ATA_ENABLE_PATA		/* define to enable PATA support in some
 				 * low-level drivers */
-#undef ATAPI_ENABLE_DMADIR	/* enables ATAPI DMADIR bridge support */
 
 
 /* note: prints function name for you */


