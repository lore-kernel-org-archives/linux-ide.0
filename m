From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/4] libata: Clear tf before doing request sense
Date: Sat, 31 Mar 2007 15:17:13 +0800
Message-ID: <460E0AF9.1090007@tw.ibm.com>
References: <460E08AF.8070900@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:59400 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750700AbXCaHRW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 03:17:22 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2V7HLoM007729
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 03:17:21 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2V7HLKp170686
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 01:17:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2V7HKxP016069
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 01:17:21 -0600
In-Reply-To: <460E08AF.8070900@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, IDE Linux <linux-ide@vger.kernel.org>

patch 2/4:
  Clear tf before doing request sense.

This fixes the AOpen 56X/AKH timeout problem.
(http://bugzilla.kernel.org/show_bug.cgi?id=8244)

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

Patch against libata-dev tree, for your review, thanks.

diff -Nrup 01_hsm_st/drivers/ata/libata-eh.c 02_aopen_rs/drivers/ata/libata-eh.c
--- 01_hsm_st/drivers/ata/libata-eh.c	2007-03-23 16:56:13.000000000 +0800
+++ 02_aopen_rs/drivers/ata/libata-eh.c	2007-03-31 01:11:01.000000000 +0800
@@ -991,18 +991,19 @@ static unsigned int atapi_eh_request_sen
 
 	DPRINTK("ATAPI request sense\n");
 
-	ata_tf_init(dev, &tf);
-
 	/* FIXME: is this needed? */
 	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
 
-	/* XXX: why tf_read here? */
+	/* read error register to initialize sense_buf */
 	ap->ops->tf_read(ap, &tf);
 
 	/* fill these in, for the case where they are -not- overwritten */
 	sense_buf[0] = 0x70;
 	sense_buf[2] = tf.feature >> 4;
 
+	/* some devices time out if garbage left in tf */ 
+	ata_tf_init(dev, &tf);
+
 	memset(cdb, 0, ATAPI_CDB_LEN);
 	cdb[0] = REQUEST_SENSE;
 	cdb[4] = SCSI_SENSE_BUFFERSIZE;





