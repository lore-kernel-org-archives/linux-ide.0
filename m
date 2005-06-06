From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/4] odd length data handling for __atapi_pio_bytes()
Date: Mon, 06 Jun 2005 16:01:09 +0800
Message-ID: <42A402C5.3050704@tw.ibm.com>
References: <42A3FF7B.3040201@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090000000906000109030906"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:14310 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261206AbVFFIBf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 04:01:35 -0400
In-Reply-To: <42A3FF7B.3040201@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------090000000906000109030906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Problem:
- When odd length data is transfered, the last byte of data is lost.

Changes:
- When an odd length data transfer is seen, round it to the next even length.
   (The same as atapi_input_bytes() does in the ide-iops.)

Attached please find the patch against the linux-2.6.git tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------090000000906000109030906
Content-Type: text/plain;
 name="04_odd_data.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04_odd_data.diff"

--- 13_atapi_pio_trailing_data_handling/drivers/scsi/libata-core.c	2005-06-06 13:57:18.000000000 +0800
+++ 14_atapi_pio_odd_handling/drivers/scsi/libata-core.c	2005-06-06 14:54:36.000000000 +0800
@@ -2607,6 +2607,13 @@
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
+	/* handle the odd condition */
+	if (unlikely(count & 0x01)) {
+		DPRINTK("ata%u: odd count %u rounded: qc->nbytes %u, bytes %u\n",
+			ap->id, count, qc->nbytes, bytes);
+		count++;
+	}
+
 	buf = kmap(page) + offset;
 
 	qc->curbytes += count;

--------------090000000906000109030906--


