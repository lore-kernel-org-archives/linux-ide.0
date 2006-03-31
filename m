From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: use AC_ERR_TIMEOUT err_mask for time out
Date: Fri, 31 Mar 2006 13:43:33 +0800
Message-ID: <442CC185.3060200@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:50592 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750792AbWCaFnd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Mar 2006 00:43:33 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k2V5hRvl007071
	for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 00:43:27 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2V5kaZr144134
	for <linux-ide@vger.kernel.org>; Thu, 30 Mar 2006 22:46:36 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2V5hR4G017282
	for <linux-ide@vger.kernel.org>; Thu, 30 Mar 2006 22:43:27 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

Use AC_ERR_TIMEOUT err_mask for time out,
instead of generating err_mask from drv_stat.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
This patch was accepted in irq-pio before.

Patch against upstream (8b316a3973f05e572b4edeeda9072987f6bbaa44).
For your review, thanks.

Albert

--- upstream0/drivers/scsi/libata-core.c	2006-03-31 13:33:15.000000000 +0800
+++ upstream1/drivers/scsi/libata-core.c	2006-03-31 13:34:59.000000000 +0800
@@ -3827,7 +3827,7 @@ static void ata_qc_timeout(struct ata_qu
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
-		qc->err_mask |= ac_err_mask(drv_stat);
+		qc->err_mask |= AC_ERR_TIMEOUT;
 		break;
 	}
 

