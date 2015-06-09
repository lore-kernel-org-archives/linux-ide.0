From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] libata: finally use __initconst in ata_parse_force_one()
Date: Tue,  9 Jun 2015 15:33:19 +0200
Message-ID: <1433856799-24825-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33967 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbFINdc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jun 2015 09:33:32 -0400
Received: by laew7 with SMTP id w7so12391121lae.1
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2015 06:33:30 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Just six days after this FIXME was added seven years ago, Sam Ravnborg
added the missing feature (37c514e3dfc8 "Add missing init section
definitions"), though it ended up being called __initconst.

Let's use it; better late than never.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/ata/libata-core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 577849c6611a..9581e6f6cd0e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6456,12 +6456,7 @@ static int __init ata_parse_force_one(char **cur,
 				      struct ata_force_ent *force_ent,
 				      const char **reason)
 {
-	/* FIXME: Currently, there's no way to tag init const data and
-	 * using __initdata causes build failure on some versions of
-	 * gcc.  Once __initdataconst is implemented, add const to the
-	 * following structure.
-	 */
-	static struct ata_force_param force_tbl[] __initdata = {
+	static const struct ata_force_param force_tbl[] __initconst = {
 		{ "40c",	.cbl		= ATA_CBL_PATA40 },
 		{ "80c",	.cbl		= ATA_CBL_PATA80 },
 		{ "short40c",	.cbl		= ATA_CBL_PATA40_SHORT },
-- 
2.1.3

