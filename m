From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH] at91_ide: remove headers specific for at91sam9263
Date: Sat, 15 Aug 2009 14:02:41 +0400
Message-ID: <1250330561-10975-1-git-send-email-geomatsi@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:49032 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbZHOKJg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Aug 2009 06:09:36 -0400
Received: by ey-out-2122.google.com with SMTP id 22so436297eye.37
        for <linux-ide@vger.kernel.org>; Sat, 15 Aug 2009 03:09:36 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Sergey Matyukevich <geomatsi@gmail.com>

This driver requires only static memory controller definitions and macroses
contained in generic header at91sam9_smc.h.

Those extra headers are misleading since this driver also works fine for
at91sam9260 SoC: tests were performed on afeb9260 board.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 drivers/ide/at91_ide.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
index dbfeda4..248219a 100644
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -29,9 +29,7 @@
 
 #include <mach/board.h>
 #include <mach/gpio.h>
-#include <mach/at91sam9263.h>
 #include <mach/at91sam9_smc.h>
-#include <mach/at91sam9263_matrix.h>
 
 #define DRV_NAME "at91_ide"
 
-- 
1.6.2.5

