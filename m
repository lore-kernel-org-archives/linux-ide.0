From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] libata: fix spelling mistake: 'ambigious' -> 'ambiguous'
Date: Sat, 28 Oct 2017 23:51:47 +0530
Message-ID: <b0c04473d8a7be32a06b6ba23de134491f71f40a.1509214774.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45759 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdJ1SWI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 28 Oct 2017 14:22:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Trivial fix to spelling mistakes in ata_parse_force_one().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1945a8e..b38df2db 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6904,7 +6904,7 @@ static int __init ata_parse_force_one(char **cur,
 		return -EINVAL;
 	}
 	if (nr_matches > 1) {
-		*reason = "ambigious value";
+		*reason = "ambiguous value";
 		return -EINVAL;
 	}
 
-- 
2.7.4

