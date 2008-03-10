From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/5] ide: mark special "ide0=" kernel parameters as obsoleted
Date: Tue, 11 Mar 2008 00:46:37 +0100
Message-ID: <200803110046.37923.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:14687 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbYCJXeh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 19:34:37 -0400
Received: by ug-out-1314.google.com with SMTP id z38so5009594ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 16:34:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Mark "ide0=ali14xx|cmd640_vlb|dtc2278|ht6560b|qd65xx|umc8672" kernel
parameters as obsoleted (per host driver replacements have been available
for a long time).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1038,32 +1038,32 @@ static int __init ide_setup(char *s)
 #ifdef CONFIG_BLK_DEV_ALI14XX
 			case -17: /* "ali14xx" */
 				probe_ali14xx = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_UMC8672
 			case -16: /* "umc8672" */
 				probe_umc8672 = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_DTC2278
 			case -15: /* "dtc2278" */
 				probe_dtc2278 = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_CMD640
 			case -14: /* "cmd640_vlb" */
 				cmd640_vlb = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_HT6560B
 			case -13: /* "ht6560b" */
 				probe_ht6560b = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_QD65XX
 			case -12: /* "qd65xx" */
 				probe_qd65xx = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_4DRIVES
 			case -11: /* "four" drives on one set of ports */
