From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH libata-2.6 2/5] Fix sg increase problem in __atapi_pio_bytes()
Date: Fri, 18 Mar 2005 15:39:12 +0800
Message-ID: <423A85A0.4040206@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040402000404010907090301"
Received: from bluehawaii.tikira.net ([61.62.22.51]:56292 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261483AbVCRHj2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Mar 2005 02:39:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040402000404010907090301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Problem:
   In __atapi_pio_bytes(), after qc->cursg++ increased, if "goto next_page" is executed,
then sg is not updated and the old sg is overwritten with the new data.

Changes:
- Replace goto next_page by goto next_sg.

   Attached please find the patch against the libata-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---------------------------------------
--- libata-2.6-sgdma/drivers/scsi/libata-core.c	2005-03-17 17:23:42.000000000 +0800
+++ libata-2.6-atapi_pio_bytes/drivers/scsi/libata-core.c	2005-03-18 13:20:01.000000000 +0800
@@ -2340,7 +2340,6 @@
  next_sg:
  	sg = &qc->sg[qc->cursg];

-next_page:
  	page = sg->page;
  	offset = sg->offset + qc->cursg_ofs;

@@ -2348,6 +2347,7 @@
  	page = nth_page(page, (offset >> PAGE_SHIFT));
  	offset %= PAGE_SIZE;

+	/* don't overrun current sg */
  	count = min(sg->length - qc->cursg_ofs, bytes);

  	/* don't cross page boundaries */
@@ -2372,8 +2372,6 @@
  	kunmap(page);

  	if (bytes) {
-		if (qc->cursg_ofs < sg->length)
-			goto next_page;
  		goto next_sg;
  	}
  }


--------------040402000404010907090301
Content-Type: text/plain;
 name="cursg_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cursg_fix.diff"

--- libata-2.6-sgdma/drivers/scsi/libata-core.c	2005-03-17 17:23:42.000000000 +0800
+++ libata-2.6-atapi_pio_bytes/drivers/scsi/libata-core.c	2005-03-18 13:20:01.000000000 +0800
@@ -2340,7 +2340,6 @@
 next_sg:
 	sg = &qc->sg[qc->cursg];
 
-next_page:
 	page = sg->page;
 	offset = sg->offset + qc->cursg_ofs;
 
@@ -2348,6 +2347,7 @@
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
+	/* don't overrun current sg */
 	count = min(sg->length - qc->cursg_ofs, bytes);
 
 	/* don't cross page boundaries */
@@ -2372,8 +2372,6 @@
 	kunmap(page);
 
 	if (bytes) {
-		if (qc->cursg_ofs < sg->length)
-			goto next_page;
 		goto next_sg;
 	}
 }

--------------040402000404010907090301--


