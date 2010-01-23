From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] hdparm: Fix error in sector offset reporting
Date: Sat, 23 Jan 2010 14:18:11 -0500
Message-ID: <yq1fx5wwryk.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:44928 "EHLO
	rcsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab0AWTTo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jan 2010 14:19:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org


The sector offset reporting is off by a factor of two...

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff -urN -X /home/mkp/bin/dontdiff hdparm-9.27.orig/identify.c hdparm-9.27/identify.c
--- hdparm-9.27.orig/identify.c	2009-08-20 10:31:01.000000000 -0400
+++ hdparm-9.27/identify.c	2010-01-23 14:07:43.000000000 -0500
@@ -938,7 +938,7 @@
 			printf("\t%-31s %11u bytes\n","Physical Sector size:", sector_bytes * pfactor);
 			if ((val[209] & 0xc000) == 0x4000) {
 				unsigned int offset = val[209] & 0x1fff;
-				printf("\t%-31s %11u bytes\n", "Logical Sector-0 offset:", offset * lsize);
+				printf("\t%-31s %11u bytes\n", "Logical Sector-0 offset:", offset * sector_bytes);
 			}
 		}
 		if (!bbbig) bbbig = (__u64)(ll>mm ? ll : mm); /* # 512 byte blocks */
