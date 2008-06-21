From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/4] ide: filter out invalid transfer mode values in set_xfer_rate()
Date: Sat, 21 Jun 2008 21:20:41 +0200
Message-ID: <200806212120.41514.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:54980 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbYFUTW3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Jun 2008 15:22:29 -0400
Received: by an-out-0708.google.com with SMTP id d40so410882and.103
        for <linux-ide@vger.kernel.org>; Sat, 21 Jun 2008 12:22:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Filter out invalid transfer mode values (0x02-0x07) in write handler
for obsoleted /proc/ide/hd?/settings:current_speed setting.

While at it:

* Use XFER_UDMA_6 define.

Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Sergei, IIRC that it is what you were suggesting some time ago.

drivers/ide/ide-proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -345,7 +345,7 @@ static int set_xfer_rate (ide_drive_t *d
 	ide_task_t task;
 	int err;
 
-	if (arg < 0 || arg > 70)
+	if (arg < 0 || (arg > 1 && arg < XFER_PIO_0) || arg > XFER_UDMA_6)
 		return -EINVAL;
 
 	memset(&task, 0, sizeof(task));
