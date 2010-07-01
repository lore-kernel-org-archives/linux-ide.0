From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH 1/3] libata: glob_match for ata_device_blacklist
Date: Thu, 01 Jul 2010 17:56:21 -0400
Message-ID: <4C2D0F05.6040706@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000604000403020502010703"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:18580 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759478Ab0GAV4Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 17:56:25 -0400
In-Reply-To: <4C2CEB70.3090209@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------000604000403020502010703
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/10 03:24 PM, Jeff Garzik wrote:
> On 07/01/2010 11:30 AM, Mark Lord wrote:
>
> hmmm, can you resend this series as an attachment?

Sure thing.  I suspect my old mailer solution is no longer working correctly.

Here, try these (attached).
They are against 2.6.34, though -- I don't have a current Linus tree at the moment.
If they still don't apply, let me know and I'll get a tree and rediff them.

Thanks Jeff!

--------------000604000403020502010703
Content-Type: text/x-diff;
 name="51_libata_glob_match.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="51_libata_glob_match.patch"

Replace rudimentry pattern matching with more capable shell-style globbing.
This will enable shrinking ata_device_blacklist[] table in subsequent patches,
and helps with future editions to the table, such as matching only the end
of a firmware revision string etc..

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Eventually, this function should move out of libata into lib/string.c or similar (?).
But since following patches in this series require it for libata,
let's start with it there, and move things later on.

--- 2.6.34/drivers/ata/libata-core.c	2010-05-16 17:17:36.000000000 -0400
+++ linux/drivers/ata/libata-core.c	2010-07-01 11:08:10.509159666 -0400
@@ -4413,29 +4413,65 @@
 	{ }
 };
 
-static int strn_pattern_cmp(const char *patt, const char *name, int wildchar)
+/**
+ *	glob_match - match a text string against a glob-style pattern
+ *	@text: the string to be examined
+ *	@pattern: the glob-style pattern to be matched against
+ *
+ *	Either/both of text and pattern can be empty strings.
+ *
+ *	Match text against a glob-style pattern, with wildcards and simple sets:
+ *
+ *		?	matches any single character.
+ *		*	matches any run of characters.
+ *		[xyz]	matches a single character from the set: x, y, or z.
+ *
+ *	Note: hyphenated ranges [0-9] are _not_ supported here.
+ *	The special characters ?, [, or *, can be matched using a set, eg. [*]
+ *
+ *	Example patterns:  "SD1?",  "SD1[012345]",  "*R0",  SD*1?[012]*xx"
+ *
+ *	This function uses one level of recursion per '*' in pattern.
+ *	Since it calls _nothing_ else, and has _no_ explicit local variables,
+ *	this will not cause stack problems for any reasonable use here.
+ *
+ *	RETURNS:
+ *	0 on match, 1 otherwise.
+ */
+static int glob_match (const char *text, const char *pattern)
 {
-	const char *p;
-	int len;
+	do {
+		/* Match single character or a '?' wildcard */
+		if (*text == *pattern || *pattern == '?') {
+			if (!*pattern++)
+				return 0;  /* End of both strings: match */
+		} else {
+			/* Match single char against a '[' bracketed ']' pattern set */
+			if (!*text || *pattern != '[')
+				break;  /* Not a pattern set */
+			while (*++pattern && *pattern != ']' && *text != *pattern);
+			if (!*pattern || *pattern == ']')
+				return 1;  /* No match */
+			while (*pattern && *pattern++ != ']');
+		}
+	} while (*++text && *pattern);
 
-	/*
-	 * check for trailing wildcard: *\0
-	 */
-	p = strchr(patt, wildchar);
-	if (p && ((*(p + 1)) == 0))
-		len = p - patt;
-	else {
-		len = strlen(name);
-		if (!len) {
-			if (!*patt)
-				return 0;
-			return -1;
+	/* Match any run of chars against a '*' wildcard */
+	if (*pattern == '*') {
+		if (!*++pattern)
+			return 0;  /* Match: avoid recursion at end of pattern */
+		/* Loop to handle additional pattern chars after the wildcard */
+		while (*text) {
+			if (glob_match(text, pattern) == 0)
+				return 0;  /* Remainder matched */
+			++text;  /* Absorb (match) this char and try again */
 		}
 	}
-
-	return strncmp(patt, name, len);
+	if (!*text && !*pattern)
+		return 0;  /* End of both strings: match */
+	return 1;  /* No match */
 }
-
+ 
 static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
@@ -4446,10 +4482,10 @@
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
 
 	while (ad->model_num) {
-		if (!strn_pattern_cmp(ad->model_num, model_num, '*')) {
+		if (!glob_match(model_num, ad->model_num)) {
 			if (ad->model_rev == NULL)
 				return ad->horkage;
-			if (!strn_pattern_cmp(ad->model_rev, model_rev, '*'))
+			if (!glob_match(model_rev, ad->model_rev))
 				return ad->horkage;
 		}
 		ad++;

--------------000604000403020502010703
Content-Type: text/x-diff;
 name="52_libata_blacklist_reduction.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="52_libata_blacklist_reduction.patch"

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

--------------000604000403020502010703
Content-Type: text/x-diff;
 name="53_libata_more_blacklist_reduction.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="53_libata_more_blacklist_reduction.patch"

Take further advantage of the new glob_match() function to reduce the blacklist size.
There are even more savings possible, but how far do we want to go with this?

Signed-off-by: Mark Lord <mlord@pobox.com>

--- 2.6.34/drivers/ata/libata-core.c	2010-07-01 11:27:32.549052000 -0400
+++ linux/drivers/ata/libata-core.c	2010-07-01 11:15:38.555802000 -0400
@@ -4254,15 +4254,13 @@
 	{ "WDC AC23200L",	"21.10N21",	ATA_HORKAGE_NODMA },
 	{ "Compaq CRD-8241B", 	NULL,		ATA_HORKAGE_NODMA },
 	{ "CRD-8400B",		NULL, 		ATA_HORKAGE_NODMA },
-	{ "CRD-8480B",		NULL,		ATA_HORKAGE_NODMA },
-	{ "CRD-8482B",		NULL,		ATA_HORKAGE_NODMA },
+	{ "CRD-848[02]B",	NULL,		ATA_HORKAGE_NODMA },
 	{ "CRD-84",		NULL,		ATA_HORKAGE_NODMA },
 	{ "SanDisk SDP3B",	NULL,		ATA_HORKAGE_NODMA },
 	{ "SanDisk SDP3B-64",	NULL,		ATA_HORKAGE_NODMA },
 	{ "SANYO CD-ROM CRD",	NULL,		ATA_HORKAGE_NODMA },
 	{ "HITACHI CDR-8",	NULL,		ATA_HORKAGE_NODMA },
-	{ "HITACHI CDR-8335",	NULL,		ATA_HORKAGE_NODMA },
-	{ "HITACHI CDR-8435",	NULL,		ATA_HORKAGE_NODMA },
+	{ "HITACHI CDR-8[34]35",NULL,		ATA_HORKAGE_NODMA },
 	{ "Toshiba CD-ROM XM-6202B", NULL,	ATA_HORKAGE_NODMA },
 	{ "TOSHIBA CD-ROM XM-1702BC", NULL,	ATA_HORKAGE_NODMA },
 	{ "CD-532E-A", 		NULL,		ATA_HORKAGE_NODMA },
@@ -4342,12 +4340,7 @@
 	/* Devices which get the IVB wrong */
 	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB, },
 	/* Maybe we should just blacklist TSSTcorp... */
-	{ "TSSTcorp CDDVDW SH-S202H", "SB00",	  ATA_HORKAGE_IVB, },
-	{ "TSSTcorp CDDVDW SH-S202H", "SB01",	  ATA_HORKAGE_IVB, },
-	{ "TSSTcorp CDDVDW SH-S202J", "SB00",	  ATA_HORKAGE_IVB, },
-	{ "TSSTcorp CDDVDW SH-S202J", "SB01",	  ATA_HORKAGE_IVB, },
-	{ "TSSTcorp CDDVDW SH-S202N", "SB00",	  ATA_HORKAGE_IVB, },
-	{ "TSSTcorp CDDVDW SH-S202N", "SB01",	  ATA_HORKAGE_IVB, },
+	{ "TSSTcorp CDDVDW SH-S202[HJN]", "SB0[01]",  ATA_HORKAGE_IVB, },
 
 	/* Devices that do not need bridging limits applied */
 	{ "MTRON MSP-SATA*",		NULL,	ATA_HORKAGE_BRIDGE_OK, },

--------------000604000403020502010703--
