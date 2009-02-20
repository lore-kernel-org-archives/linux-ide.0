From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] remove stale comment from <linux/hdreg.h>
Date: Fri, 20 Feb 2009 18:36:02 +0100
Message-ID: <200902201836.02841.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:50384 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678AbZBTRes (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Feb 2009 12:34:48 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] remove stale comment from <linux/hdreg.h>

HDIO_GET_IDENTITY returns 256 words currently.

Noticed by Norman Diamond.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/hdreg.h |    1 -
 1 file changed, 1 deletion(-)

Index: b/include/linux/hdreg.h
===================================================================
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -511,7 +511,6 @@ struct hd_driveid {
 	unsigned short	words69_70[2];	/* reserved words 69-70
 					 * future command overlap and queuing
 					 */
-	/* HDIO_GET_IDENTITY currently returns only words 0 through 70 */
 	unsigned short	words71_74[4];	/* reserved words 71-74
 					 * for IDENTIFY PACKET DEVICE command
 					 */
