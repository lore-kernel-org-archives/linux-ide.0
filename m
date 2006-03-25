From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/3] libata-dev: wait idle after reading the last data block
Date: Sat, 25 Mar 2006 18:18:15 +0800
Message-ID: <442518E7.8020607@tw.ibm.com>
References: <441FE605.8010202@tw.ibm.com> <44203953.3080803@pobox.com> <311601c90603210943v132a369aya443a073c11ee2bf@mail.gmail.com> <4422567C.5000008@tw.ibm.com> <44242C25.3020002@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:12257 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751152AbWCYKSV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Mar 2006 05:18:21 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k2PAIFWQ026157
	for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 05:18:15 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2PALI1r156364
	for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 03:21:18 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2PAIEFJ019208
	for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 03:18:14 -0700
In-Reply-To: <44242C25.3020002@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Some CD-ROM drives are slow to clear DRQ, after the last data block
is read by PIO. Use ata_wait_idle() after reading the last data block.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

--- c2/drivers/scsi/libata-core.c	2006-03-25 16:59:26.000000000 +0800
+++ c3/drivers/scsi/libata-core.c	2006-03-25 17:01:29.000000000 +0800
@@ -3710,7 +3710,7 @@ fsm_start:
 			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
 				/* all data read */
 				ata_altstatus(ap);
-				status = ata_chk_status(ap);
+				status = ata_wait_idle(ap);
 				goto fsm_start;
 			}
 		}


