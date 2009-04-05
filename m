From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 1/2] ide: remove unused #include <linux/version.h>
Date: Sun,  5 Apr 2009 09:53:10 +0800
Message-ID: <1238896390-2828-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:6563 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbZDEBxT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Apr 2009 21:53:19 -0400
Received: by ti-out-0910.google.com with SMTP id i7so1505238tid.23
        for <linux-ide@vger.kernel.org>; Sat, 04 Apr 2009 18:53:17 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

Remove unused #include <linux/version.h> in drivers/ide/at91_ide.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 drivers/ide/at91_ide.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
index 8eda552..97f6f17 100644
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -20,7 +20,6 @@
  *
  */
 
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/clk.h>
-- 
1.6.1.3

