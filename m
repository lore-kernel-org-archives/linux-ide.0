From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 16/22] ide-tape: include proper headers
Date: Mon,  4 Feb 2008 14:40:34 +0100
Message-ID: <1202132440-26648-17-git-send-email-petkovbb@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:3574 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbYBDNm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:42:56 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1148560ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:42:55 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 342ec50..24f048f 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -39,9 +39,9 @@
 #include <scsi/scsi.h>
 
 #include <asm/byteorder.h>
-#include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
+#include <linux/irq.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
 #include <asm/unaligned.h>
 #include <linux/mtio.h>
 
-- 
1.5.3.7

