From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] hpt366: enable all quirks for devices on quirk_drives[] list
Date: Wed, 20 May 2009 17:33:58 +0200
Message-ID: <200905201733.58869.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:51711 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbZETPcN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 11:32:13 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Enable also quirks in do_reset1() and ide_config_drive_speed()
for devices on quirk_drives[] list.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/hpt366.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/hpt366.c
===================================================================
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -740,7 +740,7 @@ static void hpt3xx_quirkproc(ide_drive_t
 
 	while (*list)
 		if (strstr(m, *list++)) {
-			drive->quirk_list = 1;
+			drive->quirk_list = 2;
 			return;
 		}
 
