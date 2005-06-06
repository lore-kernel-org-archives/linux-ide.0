From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/4] sg traverse fix for __atapi_pio_bytes()
Date: Mon, 06 Jun 2005 15:56:03 +0800
Message-ID: <42A40193.3090500@tw.ibm.com>
References: <42A3FF7B.3040201@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000407050103080909070904"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:58362 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261198AbVFFH4Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 03:56:24 -0400
In-Reply-To: <42A3FF7B.3040201@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------000407050103080909070904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Problem:
   Incorrect md5sum when using ATAPI PIO mode to verify a distro CD.

Root cause:
   sg traverse problem.
In __atapi_pio_bytes(), if qc->cursg++ is increased and "goto next_page" is executed,
then sg is not updated to the new qc->cursg and the old sg is overwritten with the new data.

Changes:
- Replace "goto next_page" with "goto next_sg" to make sg updated.

   Attached please find the patch against the linux-2.6.git tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


--------------000407050103080909070904
Content-Type: text/plain;
 name="01_sg_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01_sg_fix.diff"

--- 10_atapi_pio_fix/drivers/scsi/libata-core.c	2005-06-06 13:37:50.000000000 +0800
+++ 11_atapi_pio_sg_fix/drivers/scsi/libata-core.c	2005-06-06 13:45:33.000000000 +0800
@@ -2577,7 +2577,6 @@
 next_sg:
 	sg = &qc->sg[qc->cursg];
 
-next_page:
 	page = sg->page;
 	offset = sg->offset + qc->cursg_ofs;
 
@@ -2585,6 +2584,7 @@
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
+	/* don't overrun current sg */
 	count = min(sg->length - qc->cursg_ofs, bytes);
 
 	/* don't cross page boundaries */
@@ -2609,8 +2609,6 @@
 	kunmap(page);
 
 	if (bytes) {
-		if (qc->cursg_ofs < sg->length)
-			goto next_page;
 		goto next_sg;
 	}
 }

--------------000407050103080909070904--


