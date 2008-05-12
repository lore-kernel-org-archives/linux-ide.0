From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 03/12] ide: use the common ascii hex helpers
Date: Mon, 12 May 2008 12:05:36 -0700
Message-ID: <1210619136.24092.54.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:39389 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756855AbYELTFn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 May 2008 15:05:43 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1379070ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 12 May 2008 12:05:39 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ide/ide.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index c758dcb..916a3e6 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -789,7 +789,6 @@ static int __init stridx (const char *s, char c)
 static int __init match_parm (char *s, const char *keywords[], int vals[], int max_vals)
 {
 	static const char *decimal = "0123456789";
-	static const char *hex = "0123456789abcdef";
 	int i, n;
 
 	if (*s++ == '=') {
@@ -814,7 +813,7 @@ static int __init match_parm (char *s, const char *keywords[], int vals[], int m
 			while ((i = stridx(decimal, *++s)) >= 0)
 				vals[n] = (vals[n] * 10) + i;
 			if (*s == 'x' && !vals[n]) {
-				while ((i = stridx(hex, *++s)) >= 0)
+				while ((i = stridx(hex_asc, *++s)) >= 0)
 					vals[n] = (vals[n] * 0x10) + i;
 			}
 			if (++n == max_vals)
-- 
1.5.5.1.404.g981f6


