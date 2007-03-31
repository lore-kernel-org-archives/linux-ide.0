From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/4] libata: Clear tf before doing request sense (revised)
Date: Sat, 31 Mar 2007 16:07:36 +0800
Message-ID: <460E16C8.1070402@tw.ibm.com>
References: <460E1586.2000603@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:59602 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbXCaIHq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 04:07:46 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2V87jan017729
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 04:07:45 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2V87jtm150606
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 02:07:45 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2V87iEe017803
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 02:07:45 -0600
In-Reply-To: <460E1586.2000603@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, Linux IDE <linux-ide@vger.kernel.org>

patch 2/4:
  Clear tf before doing request sense.

This fixes the AOpen 56X/AKH timeout problem.
(http://bugzilla.kernel.org/show_bug.cgi?id=8244)

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Revised per Tejun's advice to use result_tf instead.
Patch against libata-dev tree, for your review, thanks.

diff -Nrup 01_hsm_st/drivers/ata/libata-eh.c 02_aopen_rs/drivers/ata/libata-eh.c
--- 01_hsm_st/drivers/ata/libata-eh.c	2007-03-23 16:56:13.000000000 +0800
+++ 02_aopen_rs/drivers/ata/libata-eh.c	2007-03-31 15:55:30.000000000 +0800
@@ -982,26 +982,27 @@ static int ata_eh_read_log_10h(struct at
  *	RETURNS:
  *	0 on success, AC_ERR_* mask on failure
  */
-static unsigned int atapi_eh_request_sense(struct ata_device *dev,
-					   unsigned char *sense_buf)
+static unsigned int atapi_eh_request_sense(struct ata_queued_cmd *qc)
 {
+	struct ata_device *dev = qc->dev;
+	unsigned char *sense_buf = qc->scsicmd->sense_buffer;
 	struct ata_port *ap = dev->ap;
 	struct ata_taskfile tf;
 	u8 cdb[ATAPI_CDB_LEN];
 
 	DPRINTK("ATAPI request sense\n");
 
-	ata_tf_init(dev, &tf);
-
 	/* FIXME: is this needed? */
 	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
 
-	/* XXX: why tf_read here? */
-	ap->ops->tf_read(ap, &tf);
-
-	/* fill these in, for the case where they are -not- overwritten */
+	/* initialize sense_buf with error register,
+	 * for the case where they are -not- overwritten
+	 */
 	sense_buf[0] = 0x70;
-	sense_buf[2] = tf.feature >> 4;
+	sense_buf[2] = qc->result_tf.feature >> 4;
+
+	/* some devices time out if garbage left in tf */ 
+	ata_tf_init(dev, &tf);
 
 	memset(cdb, 0, ATAPI_CDB_LEN);
 	cdb[0] = REQUEST_SENSE;
@@ -1165,8 +1166,7 @@ static unsigned int ata_eh_analyze_tf(st
 
 	case ATA_DEV_ATAPI:
 		if (!(qc->ap->pflags & ATA_PFLAG_FROZEN)) {
-			tmp = atapi_eh_request_sense(qc->dev,
-						     qc->scsicmd->sense_buffer);
+			tmp = atapi_eh_request_sense(qc);
 			if (!tmp) {
 				/* ATA_QCFLAG_SENSE_VALID is used to
 				 * tell atapi_qc_complete() that sense


