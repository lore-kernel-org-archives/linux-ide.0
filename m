From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 21/22] ide-tape: bump minor driver version
Date: Mon,  4 Feb 2008 14:40:39 +0100
Message-ID: <1202132440-26648-22-git-send-email-petkovbb@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:27420 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbYBDNm6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:42:58 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2951085wah.23
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:42:58 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 5c88885..2e6198f 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -15,7 +15,7 @@
  * Documentation/ide/ChangeLog.ide-tape.1995-2002
  */
 
-#define IDETAPE_VERSION "1.19"
+#define IDETAPE_VERSION "1.20"
 
 #include <linux/module.h>
 #include <linux/types.h>
-- 
1.5.3.7

