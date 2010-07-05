From: Mark Lord <kernel@teksavvy.com>
Subject: [PATCH 5/5] libata: allow hyphenated pattern ranges
Date: Mon, 05 Jul 2010 18:50:22 -0400
Message-ID: <4C3261AE.2070307@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com> <4C2D0F05.6040706@teksavvy.com> <4C2D13AE.6090701@teksavvy.com> <4C2D13F1.9030408@teksavvy.com> <4C2D1424.4050407@teksavvy.com> <4C31EB69.5070903@teksavvy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080000050208080308040303"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:2807 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754411Ab0GEWuY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 18:50:24 -0400
In-Reply-To: <4C31EB69.5070903@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------080000050208080308040303
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Take further advantage of the new glob_match() function to reduce the blacklist size,
this time making use of "character ranges" in the patterns.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

(also attached to bypass issues with my b0rked email client).

--- old/drivers/ata/libata-core.c	2010-07-05 10:23:51.198204000 -0400
+++ linux/drivers/ata/libata-core.c	2010-07-05 18:47:18.817518530 -0400
@@ -4209,22 +4209,16 @@
  	{ "OCZ CORE_SSD",	"02.10104",	ATA_HORKAGE_NONCQ },
  
  	/* Seagate NCQ + FLUSH CACHE firmware bug */
-	{ "ST31500341AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
+	{ "ST31500341AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
  						ATA_HORKAGE_FIRMWARE_WARN },
  
-	{ "ST31000333AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
+	{ "ST31000333AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
  						ATA_HORKAGE_FIRMWARE_WARN },
  
-	{ "ST3640623AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
+	{ "ST3640[36]23AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
  						ATA_HORKAGE_FIRMWARE_WARN },
  
-	{ "ST3640323AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-
-	{ "ST3320813AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-
-	{ "ST3320613AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
+	{ "ST3320[68]13AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
  						ATA_HORKAGE_FIRMWARE_WARN },
  
  	/* Blacklist entries taken from Silicon Image 3124/3132

--------------080000050208080308040303
Content-Type: text/x-diff;
 name="55_libata_even_more_blacklist_reduction.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="55_libata_even_more_blacklist_reduction.patch"

Take further advantage of the new glob_match() function to reduce the blacklist size,
this time making use of "character ranges" in the patterns.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

(also attached to bypass issues with my b0rked email client).

--- old/drivers/ata/libata-core.c	2010-07-05 10:23:51.198204000 -0400
+++ linux/drivers/ata/libata-core.c	2010-07-05 18:47:18.817518530 -0400
@@ -4209,22 +4209,16 @@
 	{ "OCZ CORE_SSD",	"02.10104",	ATA_HORKAGE_NONCQ },
 
 	/* Seagate NCQ + FLUSH CACHE firmware bug */
-	{ "ST31500341AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
+	{ "ST31500341AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
 
-	{ "ST31000333AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
+	{ "ST31000333AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
 
-	{ "ST3640623AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
+	{ "ST3640[36]23AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
 
-	{ "ST3640323AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-
-	{ "ST3320813AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-
-	{ "ST3320613AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
+	{ "ST3320[68]13AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
 
 	/* Blacklist entries taken from Silicon Image 3124/3132

--------------080000050208080308040303--
