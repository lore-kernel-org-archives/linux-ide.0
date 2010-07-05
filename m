From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH 4/4] libata: allow hyphenated pattern ranges
Date: Mon, 05 Jul 2010 10:25:45 -0400
Message-ID: <4C31EB69.5070903@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com> <4C2D0F05.6040706@teksavvy.com> <4C2D13AE.6090701@teksavvy.com> <4C2D13F1.9030408@teksavvy.com> <4C2D1424.4050407@teksavvy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040601030701090302060509"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:52619 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751387Ab0GEOZs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 10:25:48 -0400
In-Reply-To: <4C2D1424.4050407@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------040601030701090302060509
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Enable use of hyphenated pattern ranges in glob_match(), similar to how
shell globbing works, and how developers might expect things to work.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Patch also attached, to get around ongoing mailer issues here.
Eventually, glob_match() will move out of libata into lib/string.c or similar.

--- old/drivers/ata/libata-core.c	2010-07-01 18:12:52.471339000 -0400
+++ linux/drivers/ata/libata-core.c	2010-07-05 10:23:51.198204782 -0400
@@ -4283,11 +4283,13 @@
   *		?	matches any single character.
   *		*	matches any run of characters.
   *		[xyz]	matches a single character from the set: x, y, or z.
+ *		[a-d]	matches a single character from the range: a, b, c, or d.
+ *		[a-d0-9] matches a single character from either range.
   *
- *	Note: hyphenated ranges [0-9] are _not_ supported here.
- *	The special characters ?, [, or *, can be matched using a set, eg. [*]
+ *	The special characters ?, [, -, or *, can be matched using a set, eg. [*]
+ *	Behaviour with malformed patterns is undefined, though generally reasonable.
   *
- *	Example patterns:  "SD1?",  "SD1[012345]",  "*R0",  SD*1?[012]*xx"
+ *	Example patterns:  "SD1?",  "SD1[0-5]",  "*R0",  SD*1?[012]*xx"
   *
   *	This function uses one level of recursion per '*' in pattern.
   *	Since it calls _nothing_ else, and has _no_ explicit local variables,
@@ -4307,7 +4309,13 @@
  			/* Match single char against a '[' bracketed ']' pattern set */
  			if (!*text || *pattern != '[')
  				break;  /* Not a pattern set */
-			while (*++pattern && *pattern != ']' && *text != *pattern);
+			while (*++pattern && *pattern != ']' && *text != *pattern) {
+				if (*pattern == '-' && *(pattern - 1) != '[')
+					if (*text > *(pattern - 1) && *text < *(pattern + 1)) {
+						++pattern;
+						break;
+					}
+			}
  			if (!*pattern || *pattern == ']')
  				return 1;  /* No match */
  			while (*pattern && *pattern++ != ']');

--------------040601030701090302060509
Content-Type: text/x-diff;
 name="54_libata_hyphenated_globs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="54_libata_hyphenated_globs.patch"

Enable use of hyphenated pattern ranges in glob_match(), similar to how
shell globbing works, and how developers might expect things to work.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Patch also attached, to get around ongoing mailer issues here.
Eventually, glob_match() will move out of libata into lib/string.c or similar.

--- old/drivers/ata/libata-core.c	2010-07-01 18:12:52.471339000 -0400
+++ linux/drivers/ata/libata-core.c	2010-07-05 10:23:51.198204782 -0400
@@ -4283,11 +4283,13 @@
  *		?	matches any single character.
  *		*	matches any run of characters.
  *		[xyz]	matches a single character from the set: x, y, or z.
+ *		[a-d]	matches a single character from the range: a, b, c, or d.
+ *		[a-d0-9] matches a single character from either range.
  *
- *	Note: hyphenated ranges [0-9] are _not_ supported here.
- *	The special characters ?, [, or *, can be matched using a set, eg. [*]
+ *	The special characters ?, [, -, or *, can be matched using a set, eg. [*]
+ *	Behaviour with malformed patterns is undefined, though generally reasonable.
  *
- *	Example patterns:  "SD1?",  "SD1[012345]",  "*R0",  SD*1?[012]*xx"
+ *	Example patterns:  "SD1?",  "SD1[0-5]",  "*R0",  SD*1?[012]*xx"
  *
  *	This function uses one level of recursion per '*' in pattern.
  *	Since it calls _nothing_ else, and has _no_ explicit local variables,
@@ -4307,7 +4309,13 @@
 			/* Match single char against a '[' bracketed ']' pattern set */
 			if (!*text || *pattern != '[')
 				break;  /* Not a pattern set */
-			while (*++pattern && *pattern != ']' && *text != *pattern);
+			while (*++pattern && *pattern != ']' && *text != *pattern) {
+				if (*pattern == '-' && *(pattern - 1) != '[')
+					if (*text > *(pattern - 1) && *text < *(pattern + 1)) {
+						++pattern;
+						break;
+					}
+			}
 			if (!*pattern || *pattern == ']')
 				return 1;  /* No match */
 			while (*pattern && *pattern++ != ']');

--------------040601030701090302060509--
