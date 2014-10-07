From: "George Spelvin" <linux@horizon.com>
Subject: [PATCH] libata: Un-break ATA blacklist
Date: 7 Oct 2014 07:26:38 -0400
Message-ID: <20141007112638.20944.qmail@ns.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.horizon.com ([71.41.210.147]:26722 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753152AbaJGL0k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Oct 2014 07:26:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com, stevenhoneyman@gmail.com, tj@kernel.org

lib/glob.c provides a new glob_match() function, with arguments in
(pattern, string) order.  It replaced a private function with arguments
in (string, pattern) order, but I didn't swap the call site...

The result was the entire ATA blacklist was effectively disabled.

The lesson for today is "I f***ed up *how* badly *how* many months ago?",
er, I mean "Nobody Tests RC Kernels On Legacy Hardware".

This was not a subtle break, but it made it through an entire RC
cycle unreported, presumably because all the people doing testing
have full-featured hardware.

(FWIW, the reason for the argument swap was because fnmatch() does it that
way, and for a while implementing a full fnmatch() was being considered.)

Fixes: 428ac5fc056e0 (libata: Use glob_match from lib/glob.c)
Reported-by: Steven Honeyman <stevenhoneyman@gmail.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=71371#c21
Signed-off-by: George Spelvin <linux@horizon.com>
Cc: <stable@vger.kernel.org> # 3.17
---
I'd like to wait to add a Tested-by, but it's also important enough
I want to publicly post a fix ASAP.  Mea maxima culpa.

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
