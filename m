From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: use qc->result_tf for temp taskfile  storage
Date: Thu, 18 May 2006 17:51:10 +0800
Message-ID: <446C438E.8020708@tw.ibm.com>
References: <11473487911193-git-send-email-htejun@gmail.com> <446C20A4.7020204@tw.ibm.com> <446C21CF.3020900@gmail.com> <446C27FD.1000400@tw.ibm.com> <446C2C03.2010300@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:21961 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750778AbWERJvN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 05:51:13 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4I9pC7u030816
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 05:51:12 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4I9pCRI273582
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 03:51:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4I9pBhc004628
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 03:51:12 -0600
In-Reply-To: <446C2C03.2010300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Use qc->result_tf for temp taskfile storage.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Hopefully this can both preserve command TF and
doesn't increase kernel stack usage.

Patch against the upstream branch of libata-dev.

--- upstream0/drivers/scsi/libata-core.c	2006-05-16 11:08:49.000000000 +0800
+++ upstream3/drivers/scsi/libata-core.c	2006-05-18 17:42:49.000000000 +0800
@@ -3862,10 +3862,16 @@ static void atapi_pio_bytes(struct ata_q
 	unsigned int ireason, bc_lo, bc_hi, bytes;
 	int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
 
-	ap->ops->tf_read(ap, &qc->tf);
-	ireason = qc->tf.nsect;
-	bc_lo = qc->tf.lbam;
-	bc_hi = qc->tf.lbah;
+	/* Abuse qc->result_tf for temp storage of intermediate TF
+	 * here to save some kernel stack usage.
+	 * For normal completion, qc->result_tf is not relevant. For
+	 * error, qc->result_tf is later overwritten by ata_qc_complete().
+	 * So, the correctness of qc->result_tf is not affected.
+	 */
+	ap->ops->tf_read(ap, &qc->result_tf);
+	ireason = qc->result_tf.nsect;
+	bc_lo = qc->result_tf.lbam;
+	bc_hi = qc->result_tf.lbah;
 	bytes = (bc_hi << 8) | bc_lo;
 
 	/* shall be cleared to zero, indicating xfer of data */




