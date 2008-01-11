From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 17/21] ide-floppy: include the proper headers
Date: Fri, 11 Jan 2008 14:19:32 +0100
Message-ID: <1200057572-29230-1-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp104.plus.mail.re1.yahoo.com ([69.147.102.67]:45608 "HELO
	smtp104.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759120AbYAKNWv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 08:22:51 -0500
In-Reply-To: 1200052699-28420-1-git-send-email-bbpetkov@yahoo.de
References: 1200052699-28420-1-git-send-email-bbpetkov@yahoo.de
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index c889c16..89b26ea 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -37,9 +37,9 @@
 #include <scsi/scsi_ioctl.h>
 
 #include <asm/byteorder.h>
-#include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
+#include <linux/irq.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
 #include <asm/unaligned.h>
 
 /* The following are used to debug the driver. */
-- 
1.5.3.7

