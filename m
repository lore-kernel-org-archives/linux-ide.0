From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata-core More robust parsing for multi_count(v4)
Date: Thu, 19 Mar 2009 13:30:27 -0400
Message-ID: <49C28133.8050401@rtr.ca>
References: <49C1047D.4000008@rtr.ca> <49C11A0C.3070502@rtr.ca> <49C11ED4.2030307@rtr.ca> <49C19087.5000307@gmail.com> <49C190F1.7010202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:48236 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454AbZCSRae (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Mar 2009 13:30:34 -0400
In-Reply-To: <49C190F1.7010202@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Make libata more robust when parsing the multi_count
field from a drive's identify data.  This prevents us from
attempting to use dubious multi_count values ad infinitum.

Reset dev->multi_count to zero and reprobe it each time
through this routine, as it can change on device reset.

Also ensure that the reported "maximum" value is valid
and is a power of two, and that the reported "count" value
is valid and also a power of two.  And that the "count"
value is not greater than the "maximum" value.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Updated to use is_power_of_2() as suggested by Tejun.

Make libata more robust when parsing the multi_count
field from a drive's identify data.  This prevents us from
attempting to use dubious multi_count values ad infinitum.

Reset dev->multi_count to zero and reprobe it each time
through this routine, as it can change on device reset.

Also ensure that the reported "maximum" value is valid
and is a power of two, and that the reported "count" value
is valid and also a power of two.  And that the "count"
value is not greater than the "maximum" value.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Updated to use is_power_of_2() as suggested by Tejun.

--- upstream/drivers/ata/libata-core.c	2009-03-18 11:08:27.000000000 -0400
+++ new/drivers/ata/libata-core.c	2009-03-19 13:21:46.000000000 -0400
@@ -2389,6 +2389,7 @@
 	dev->cylinders = 0;
 	dev->heads = 0;
 	dev->sectors = 0;
+	dev->multi_count = 0;
 
 	/*
 	 * common ATA, ATAPI feature tests
@@ -2426,8 +2427,15 @@
 
 		dev->n_sectors = ata_id_n_sectors(id);
 
-		if (dev->id[59] & 0x100)
-			dev->multi_count = dev->id[59] & 0xff;
+		/* get current R/W Multiple count setting */
+		if ((dev->id[47] >> 8) == 0x80 && (dev->id[59] & 0x100)) {
+			unsigned int max = dev->id[47] & 0xff;
+			unsigned int cnt = dev->id[59] & 0xff;
+			/* only recognize/allow powers of two here */
+			if (is_power_of_2(max) && is_power_of_2(cnt))
+				if (cnt <= max)
+					dev->multi_count = cnt;
+		}
 
 		if (ata_id_has_lba(id)) {
 			const char *lba_desc;
--- libata-dev/drivers/ata/libata-core.c.orig	2009-03-18 11:08:27.000000000 -0400
+++ libata-dev/drivers/ata/libata-core.c	2009-03-19 13:26:37.000000000 -0400
@@ -57,6 +57,7 @@
 #include <linux/scatterlist.h>
 #include <linux/io.h>
 #include <linux/async.h>
+#include <linux/log2.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -2389,6 +2390,7 @@
 	dev->cylinders = 0;
 	dev->heads = 0;
 	dev->sectors = 0;
+	dev->multi_count = 0;
 
 	/*
 	 * common ATA, ATAPI feature tests
@@ -2426,8 +2428,15 @@
 
 		dev->n_sectors = ata_id_n_sectors(id);
 
-		if (dev->id[59] & 0x100)
-			dev->multi_count = dev->id[59] & 0xff;
+		/* get current R/W Multiple count setting */
+		if ((dev->id[47] >> 8) == 0x80 && (dev->id[59] & 0x100)) {
+			unsigned int max = dev->id[47] & 0xff;
+			unsigned int cnt = dev->id[59] & 0xff;
+			/* only recognize/allow powers of two here */
+			if (is_power_of_2(max) && is_power_of_2(cnt))
+				if (cnt <= max)
+					dev->multi_count = cnt;
+		}
 
 		if (ata_id_has_lba(id)) {
 			const char *lba_desc;
