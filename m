From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] dmi: fix date handling in dmi_get_year()
Date: Sun, 16 Aug 2009 21:01:22 +0900
Message-ID: <4A87F512.3080802@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48042 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728AbZHPMBr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Aug 2009 08:01:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sandor Bodo-Merle <sbodomerle@gmail.com>, "Huang, Shane" <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

Year parsing in dmi_get_year() had the following two bugs.

* "00" is treated as invalid instead of 2000 because zero return from
  simple_strtoul() is treated as error.

* "0N" where N >= 8 is treated as invalid of 200N because the leading
  0 is considered to specify octal.

Fix the above two bugs by using endptr to detect invalid number and
forcing decimal.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
While trying to implement dmi_get_date(), spotted two bugs in the
current dmi_get_year().  Tricky date strings.  ;-P

I think it would be safer to postpone this and the next patch for the
next merge window.  There's no reported case of these bugs causing
problems yet, so no reason to risk behavior change at this stage.  If
nobody objects, it would be easiest to push this through
libata-dev#upstream.

Thanks.

 drivers/firmware/dmi_scan.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: ata/drivers/firmware/dmi_scan.c
===================================================================
--- ata.orig/drivers/firmware/dmi_scan.c
+++ ata/drivers/firmware/dmi_scan.c
@@ -577,6 +577,7 @@ int dmi_get_year(int field)
 {
 	int year;
 	const char *s = dmi_get_system_info(field);
+	char *e;
 
 	if (!s)
 		return -1;
@@ -587,8 +588,8 @@ int dmi_get_year(int field)
 		return 0;
 
 	s += 1;
-	year = simple_strtoul(s, NULL, 0);
-	if (year && year < 100) {	/* 2-digit year */
+	year = simple_strtoul(s, &e, 10);
+	if (s != e && year < 100) {	/* 2-digit year */
 		year += 1900;
 		if (year < 1996)	/* no dates < spec 1.0 */
 			year += 100;
