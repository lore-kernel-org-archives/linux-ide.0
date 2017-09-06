From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [RESEND] ata: avoid gcc-7 warning in ata_timing_quantize
Date: Wed,  6 Sep 2017 23:45:34 +0200
Message-ID: <20170906214552.2111904-1-arnd@arndb.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:62372 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbdIFVp5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2017 17:45:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

gcc-7 warns about the result of a constant multiplication used as
a boolean:

drivers/ata/libata-core.c: In function 'ata_timing_quantize':
drivers/ata/libata-core.c:3164:30: warning: '*' in boolean context, suggest '&&' instead [-Wint-in-bool-context]

This slightly rearranges the macro to simplify the code and avoid
the warning at the same time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Hi Tejun,

I just noticed this patch among others I had previously sent
but that were not applied. It seems I forgot to reply to your
Ack after it had become clear that the serious would not
get merged in one chunk. Please apply this for 4.14.

Link: https://patchwork.kernel.org/patch/9840269/
---
 drivers/ata/libata-core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1945a8ea2099..ee4c1ec9dca0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3234,19 +3234,19 @@ static const struct ata_timing ata_timing[] = {
 };
 
 #define ENOUGH(v, unit)		(((v)-1)/(unit)+1)
-#define EZ(v, unit)		((v)?ENOUGH(v, unit):0)
+#define EZ(v, unit)		((v)?ENOUGH(((v) * 1000), unit):0)
 
 static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q, int T, int UT)
 {
-	q->setup	= EZ(t->setup      * 1000,  T);
-	q->act8b	= EZ(t->act8b      * 1000,  T);
-	q->rec8b	= EZ(t->rec8b      * 1000,  T);
-	q->cyc8b	= EZ(t->cyc8b      * 1000,  T);
-	q->active	= EZ(t->active     * 1000,  T);
-	q->recover	= EZ(t->recover    * 1000,  T);
-	q->dmack_hold	= EZ(t->dmack_hold * 1000,  T);
-	q->cycle	= EZ(t->cycle      * 1000,  T);
-	q->udma		= EZ(t->udma       * 1000, UT);
+	q->setup	= EZ(t->setup,       T);
+	q->act8b	= EZ(t->act8b,       T);
+	q->rec8b	= EZ(t->rec8b,       T);
+	q->cyc8b	= EZ(t->cyc8b,       T);
+	q->active	= EZ(t->active,      T);
+	q->recover	= EZ(t->recover,     T);
+	q->dmack_hold	= EZ(t->dmack_hold,  T);
+	q->cycle	= EZ(t->cycle,       T);
+	q->udma		= EZ(t->udma,       UT);
 }
 
 void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
-- 
2.9.0

