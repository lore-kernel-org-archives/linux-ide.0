From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/5] ide: remove commented out entries from ide_pio_blacklist[]
Date: Tue, 11 Mar 2008 00:46:23 +0100
Message-ID: <200803110046.23245.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:13123 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbYCJXeg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 19:34:36 -0400
Received: by ug-out-1314.google.com with SMTP id z38so5009592ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 16:34:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c |   10 ----------
 1 file changed, 10 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -122,7 +122,6 @@ static struct ide_pio_info {
 	const char	*name;
 	int		pio;
 } ide_pio_blacklist [] = {
-/*	{ "Conner Peripherals 1275MB - CFS1275A", 4 }, */
 	{ "Conner Peripherals 540MB - CFS540A", 3 },
 
 	{ "WDC AC2700",  3 },
@@ -138,10 +137,8 @@ static struct ide_pio_info {
 	{ "WDC AC1170",  1 },
 	{ "WDC AC1210",  1 },
 	{ "WDC AC280",   0 },
-/*	{ "WDC AC21000", 4 }, */
 	{ "WDC AC31000", 3 },
 	{ "WDC AC31200", 3 },
-/*	{ "WDC AC31600", 4 }, */
 
 	{ "Maxtor 7131 AT", 1 },
 	{ "Maxtor 7171 AT", 1 },
@@ -155,13 +152,6 @@ static struct ide_pio_info {
 	{ "SAMSUNG SHD-3122A", 1 },
 	{ "SAMSUNG SHD-3172A", 1 },
 
-/*	{ "ST51080A", 4 },
- *	{ "ST51270A", 4 },
- *	{ "ST31220A", 4 },
- *	{ "ST31640A", 4 },
- *	{ "ST32140A", 4 },
- *	{ "ST3780A",  4 },
- */
 	{ "ST5660A",  3 },
 	{ "ST3660A",  3 },
 	{ "ST3630A",  3 },
