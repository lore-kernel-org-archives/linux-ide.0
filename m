From: "George Spelvin" <linux@horizon.com>
Subject: [urgent regression PATCH v2] libata: Un-break ATA blacklist
Date: 7 Oct 2014 13:25:36 -0400
Message-ID: <20141007172536.5745.qmail@ns.horizon.com>
References: <CABz95_CR8cKY-s2a3wrFshZpxuZ-P4iTtCYnB8_On7X9gsK-6g@mail.gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.horizon.com ([71.41.210.147]:58155 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753459AbaJGRZh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Oct 2014 13:25:37 -0400
In-Reply-To: <CABz95_CR8cKY-s2a3wrFshZpxuZ-P4iTtCYnB8_On7X9gsK-6g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com, stevenhoneyman@gmail.com, tj@kernel.org

lib/glob.c provides a new glob_match() function, with arguments in
(pattern, string) order.  It replaced a private function with arguments
in (string, pattern) order, but I didn't swap the call site...

The result was the entire ATA blacklist was effectively disabled.
Anyone have a brown paper bag to spare?

The lesson for today is "I f***ed up *how* badly *how* many months ago?",
er, I mean "RC Kernels Get Lousy Test Coverage".

This was not a subtle break, but it made it through an entire RC
cycle unreported, presumably because all the people doing testing
have shiny bug-free hardware.

(BTW, the original reason for the argument swap was to match fnmatch(3),
as for a while implementing a full fnmatch() was being considered.)

Fixes: 428ac5fc056e0 (libata: Use glob_match from lib/glob.c)
Reported-by: Steven Honeyman <stevenhoneyman@gmail.com>
Signed-off-by: George Spelvin <linux@horizon.com>
Tested-by: Steven Honeyman <stevenhoneyman@gmail.com>
Cc: <stable@vger.kernel.org> # 3.17
---
No code changes for v2, just added Tested-by: and a stronger Subject line.

I hope Linus' slow merging this week doesn't stop this getting into
3.17.1 PDQ, since I expect a lot of well-deserved ire from people
trying 3.17.0.

 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dbdc5d3..8729a2c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4261,10 +4261,10 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
 
 	while (ad->model_num) {
-		if (glob_match(model_num, ad->model_num)) {
+		if (glob_match(ad->model_num, model_num)) {
 			if (ad->model_rev == NULL)
 				return ad->horkage;
-			if (glob_match(model_rev, ad->model_rev))
+			if (glob_match(ad->model_rev, model_rev))
 				return ad->horkage;
 		}
 		ad++;
-- 
2.1.1

