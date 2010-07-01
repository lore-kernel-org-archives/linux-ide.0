From: Mark Lord <kernel@teksavvy.com>
Subject: [PATCH 1/3] libata: glob_match for ata_device_blacklist (v2)
Date: Thu, 01 Jul 2010 18:16:14 -0400
Message-ID: <4C2D13AE.6090701@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com> <4C2D0F05.6040706@teksavvy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050709000701000300050503"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:61977 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759842Ab0GAWQR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 18:16:17 -0400
In-Reply-To: <4C2D0F05.6040706@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------050709000701000300050503
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Replace rudimentry pattern matching with more capable shell-style globbing.
This will enable shrinking ata_device_blacklist[] table in subsequent patches,
and helps with future editions to the table, such as matching only the end
of a firmware revision string etc..

Signed-off-by: Mark Lord <mlord@pobox.com>
---

(re-diff'd against latest -git, and also attached to bypass mailer issues)

Eventually, this function should move out of libata into lib/string.c or similar (?).
But since following patches in this series require it for libata,
let's start with it there, and move things later on.

--- linux-2.6.35-rc3/drivers/ata/libata-core.c	2010-06-11 22:14:04.000000000 -0400
+++ linux/drivers/ata/libata-core.c	2010-07-01 18:11:25.801348855 -0400
@@ -4326,29 +4326,65 @@
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
@@ -4359,10 +4395,10 @@
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

--------------050709000701000300050503
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

--- linux-2.6.35-rc3/drivers/ata/libata-core.c	2010-06-11 22:14:04.000000000 -0400
+++ linux/drivers/ata/libata-core.c	2010-07-01 18:11:25.801348855 -0400
@@ -4326,29 +4326,65 @@
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
@@ -4359,10 +4395,10 @@
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

--------------050709000701000300050503--
