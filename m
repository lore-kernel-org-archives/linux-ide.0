From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata-core More robust parsing for multi_count(v3)
Date: Wed, 18 Mar 2009 12:18:28 -0400
Message-ID: <49C11ED4.2030307@rtr.ca>
References: <49C1047D.4000008@rtr.ca> <49C11A0C.3070502@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:51732 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203AbZCRQSe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 12:18:34 -0400
In-Reply-To: <49C11A0C.3070502@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Make libata more robust when parsing the multi_count
fields from a drive's identify data.  This prevents us from
attempting to use dubious multi_count values ad infinitum.

Reset dev->multi_count to zero and reprobe it each time
through this routine, as it can change on device reset.

Also ensure that the reported "maximum" value is valid
and is a power of two, and that the reported "count" value
is valid and also a power of two.  And that the "count"
value is not greater than the "maximum" value.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- upstream/drivers/ata/libata-core.c.orig	2009-03-18 11:08:27.000000000 -0400
+++ new/drivers/ata/libata-core.c	2009-03-18 12:09:31.000000000 -0400
@@ -2389,6 +2389,7 @@
 	dev->cylinders = 0;
 	dev->heads = 0;
 	dev->sectors = 0;
+	dev->multi_count = 0;
 
 	/*
 	 * common ATA, ATAPI feature tests
@@ -2426,8 +2427,16 @@
 
 		dev->n_sectors = ata_id_n_sectors(id);
 
-		if (dev->id[59] & 0x100)
-			dev->multi_count = dev->id[59] & 0xff;
+		/* get/validate current R/W Multiple count setting */
+		if ((dev->id[47] >> 8) == 0x80 && (dev->id[59] & 0x100)) {
+			unsigned int max = dev->id[47] & 0xff;
+			unsigned int cnt = dev->id[59] & 0xff;
+			/* only recognize/allow powers of two here */
+			if (cnt && cnt <= max && (max & (max - 1)) == 0) {
+				if ((cnt & (cnt - 1)) == 0)
+					dev->multi_count = cnt;
+			}
+		}
 
 		if (ata_id_has_lba(id)) {
 			const char *lba_desc;
