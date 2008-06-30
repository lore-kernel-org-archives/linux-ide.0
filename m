From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix /proc/ide/ide?/mate reporting
Date: Mon, 30 Jun 2008 20:02:45 +0200
Message-ID: <200806302002.46667.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:22045 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762857AbYF3SBP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jun 2008 14:01:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so801425ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2008 11:00:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Now that we support warm-plug mate port will be registered
even if there are no devices attached to it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -76,7 +76,7 @@ static int proc_ide_read_mate
 	ide_hwif_t	*hwif = (ide_hwif_t *) data;
 	int		len;
 
-	if (hwif && hwif->mate && hwif->mate->present)
+	if (hwif && hwif->mate)
 		len = sprintf(page, "%s\n", hwif->mate->name);
 	else
 		len = sprintf(page, "(none)\n");
