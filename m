From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [patch 1/6] ide: add QUANTUM FIREBALLct20 30 with firmware APL.090 to ivb_list[]
Date: Tue, 23 Jun 2009 23:24:37 +0200
Message-ID: <200906232324.37615.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:35567 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbZFWVca (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 17:32:30 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add QUANTUM FIREBALLct20 30 with firmware APL.090 to ivb_list[]

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
This disk supports UDMA modes > 2.  According to the old bugreport it needs
forced cable detection when using 80-wire cable and id dump suggested that
ivb quirk should be used to fix the problem.  Unfortunately I never received
any feedback about the patch from the bugreporter.

 drivers/ide/ide-iops.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -210,6 +210,7 @@ EXPORT_SYMBOL_GPL(ide_in_drive_list);
  */
 static const struct drive_list_entry ivb_list[] = {
 	{ "QUANTUM FIREBALLlct10 05"	, "A03.0900"	},
+	{ "QUANTUM FIREBALLlct20 30"	, "APL.0900"	},
 	{ "TSSTcorp CDDVDW SH-S202J"	, "SB00"	},
 	{ "TSSTcorp CDDVDW SH-S202J"	, "SB01"	},
 	{ "TSSTcorp CDDVDW SH-S202N"	, "SB00"	},
