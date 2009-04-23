From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] palm_bk3710: palm_bk3710_udmatimings[] CodingStyle fixup
Date: Thu, 23 Apr 2009 22:48:29 +0200
Message-ID: <200904232248.29263.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:49338 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbZDWUo1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Apr 2009 16:44:27 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, David Brownell <dbrownell@users.sourceforge.net>


Remove superfluous commas and add missing whitespaces.

Noticed-by: Joe Perches <joe@perches.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/palm_bk3710.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: b/drivers/ide/palm_bk3710.c
===================================================================
--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -66,12 +66,12 @@ struct palm_bk3710_udmatiming {
 };
 
 static const struct palm_bk3710_udmatiming palm_bk3710_udmatimings[6] = {
-	{160, 240 / 2,},	/* UDMA Mode 0 */
-	{125, 160 / 2,},	/* UDMA Mode 1 */
-	{100, 120 / 2,},	/* UDMA Mode 2 */
-	{100, 90 / 2,},		/* UDMA Mode 3 */
-	{100, 60 / 2,},		/* UDMA Mode 4 */
-	{85,  40 / 2,},		/* UDMA Mode 5 */
+	{ 160, 240 / 2 },	/* UDMA Mode 0 */
+	{ 125, 160 / 2 },	/* UDMA Mode 1 */
+	{ 100, 120 / 2 },	/* UDMA Mode 2 */
+	{ 100,  90 / 2 },	/* UDMA Mode 3 */
+	{ 100,  60 / 2 },	/* UDMA Mode 4 */
+	{  85,  40 / 2 },	/* UDMA Mode 5 */
 };
 
 static void palm_bk3710_setudmamode(void __iomem *base, unsigned int dev,
