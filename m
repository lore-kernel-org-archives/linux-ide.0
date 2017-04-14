From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] ide: don't call memcpy with the same source and
 destination
Date: Fri, 14 Apr 2017 14:35:33 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1704141433280.10706@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbdDNSff (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 14 Apr 2017 14:35:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, John David Anglin <dave.anglin@bell.net>, linux-parisc@vger.kernel.org

The parisc architecture recently reimplemented the memcpy function and
their reimplementation crashed when source and destination overlapped.

The crash happened in the function ide_complete_cmd where memcpy is called
with the same source and destination pointer. According to the C
specification, memcpy behavior is undefined if the source and destination
range overlaps. This patches fixes the undefined behavior.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/ide/ide-io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-4.11-rc6/drivers/ide/ide-io.c
===================================================================
--- linux-4.11-rc6.orig/drivers/ide/ide-io.c
+++ linux-4.11-rc6/drivers/ide/ide-io.c
@@ -107,7 +107,7 @@ void ide_complete_cmd(ide_drive_t *drive
 
 		if (cmd->tf_flags & IDE_TFLAG_DYN)
 			kfree(orig_cmd);
-		else
+		else if (cmd != orig_cmd)
 			memcpy(orig_cmd, cmd, sizeof(*cmd));
 	}
 }
