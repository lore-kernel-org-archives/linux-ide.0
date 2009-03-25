From: Elias Oltmanns <eo@nebensachen.de>
Subject: ide: Fix code dealing with sleeping devices in do_ide_request()
Date: Wed, 25 Mar 2009 20:39:15 +0100
Message-ID: <8763hxs87w.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:41557 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbZCYUTt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Mar 2009 16:19:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Unfortunately, I missed a catch when reviewing the patch committed as
201bffa4. Here is the fix to the currently broken handling of sleeping
devices. In particular, this is required to get the disk shock
protection code working again.

Reported-by: Christian Thaeter <ct@pipapo.org>
Cc: stable@kernel.org
Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---
Applies to v2.6.29.

 drivers/ide/ide-io.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index a9a6c20..af70777 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -736,11 +736,10 @@ repeat:
 		prev_port = hwif->host->cur_port;
 		hwif->rq = NULL;
 
-		if (drive->dev_flags & IDE_DFLAG_SLEEPING) {
-			if (time_before(drive->sleep, jiffies)) {
-				ide_unlock_port(hwif);
-				goto plug_device;
-			}
+		if (drive->dev_flags & IDE_DFLAG_SLEEPING &&
+		    time_after(drive->sleep, jiffies)) {
+			ide_unlock_port(hwif);
+			goto plug_device;
 		}
 
 		if ((hwif->host->host_flags & IDE_HFLAG_SERIALIZE) &&
