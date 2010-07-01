From: Mark Lord <kernel@teksavvy.com>
Subject: [PATCH 2/3] libata: reduce blacklist size
Date: Thu, 01 Jul 2010 11:31:16 -0400
Message-ID: <4C2CB4C4.6070806@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:39950 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752171Ab0GAPbS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 11:31:18 -0400
In-Reply-To: <4C2CB497.3000701@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>


Take advantage of the new glob_match() function to reduce the blacklist size somewhat.
There are further savings possible, but these are the most obvious biggies.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- 2.6.34/drivers/ata/libata-core.c	2010-07-01 11:08:10.509159000 -0400
+++ linux/drivers/ata/libata-core.c	2010-07-01 11:15:54.025797181 -0400
@@ -4298,70 +4298,22 @@
  	{ "OCZ CORE_SSD",	"02.10104",	ATA_HORKAGE_NONCQ },
  
  	/* Seagate NCQ + FLUSH CACHE firmware bug */
-	{ "ST31500341AS",	"SD15",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST31500341AS",	"SD16",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST31500341AS",	"SD17",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST31500341AS",	"SD18",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST31500341AS",	"SD19",		ATA_HORKAGE_NONCQ |
+	{ "ST31500341AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
  						ATA_HORKAGE_FIRMWARE_WARN },
  
-	{ "ST31000333AS",	"SD15",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST31000333AS",	"SD16",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST31000333AS",	"SD17",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST31000333AS",	"SD18",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST31000333AS",	"SD19",		ATA_HORKAGE_NONCQ |
+	{ "ST31000333AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
  						ATA_HORKAGE_FIRMWARE_WARN },
  
-	{ "ST3640623AS",	"SD15",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3640623AS",	"SD16",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3640623AS",	"SD17",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3640623AS",	"SD18",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3640623AS",	"SD19",		ATA_HORKAGE_NONCQ |
+	{ "ST3640623AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
  						ATA_HORKAGE_FIRMWARE_WARN },
  
-	{ "ST3640323AS",	"SD15",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3640323AS",	"SD16",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3640323AS",	"SD17",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3640323AS",	"SD18",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3640323AS",	"SD19",		ATA_HORKAGE_NONCQ |
+	{ "ST3640323AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
  						ATA_HORKAGE_FIRMWARE_WARN },
  
-	{ "ST3320813AS",	"SD15",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3320813AS",	"SD16",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3320813AS",	"SD17",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3320813AS",	"SD18",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3320813AS",	"SD19",		ATA_HORKAGE_NONCQ |
+	{ "ST3320813AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
  						ATA_HORKAGE_FIRMWARE_WARN },
  
-	{ "ST3320613AS",	"SD15",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3320613AS",	"SD16",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3320613AS",	"SD17",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3320613AS",	"SD18",		ATA_HORKAGE_NONCQ |
-						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3320613AS",	"SD19",		ATA_HORKAGE_NONCQ |
+	{ "ST3320613AS",	"SD1[56789]",	ATA_HORKAGE_NONCQ |
  						ATA_HORKAGE_FIRMWARE_WARN },
  
  	/* Blacklist entries taken from Silicon Image 3124/3132
