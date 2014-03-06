From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] libata: end the r-word
Date: Wed, 05 Mar 2014 19:33:04 -0800
Message-ID: <20140306032706.9641.99151.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62129 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbaCFDdF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Mar 2014 22:33:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

We want our contributors to spend their anger, resentment, and
frustration emotional resources on finding and fixing broken code.  We
do not want those valuable resources wasted on unfortunately worded
comments.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Tejun,

Today is "Spread the Word to End the Word" day, so I thought it would be
an interesting exercise to see how often the r-word is used in kernel
code comments.  Suprisingly, to me at least, it's rare.  In fact it
seems only libata uses it in code commentary.

Please consider applying this patch to call slow-to-reset devices
outliers.

Regards,
Dan

 drivers/ata/libata-eh.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b4d0596f30a8..6760fc4e85b8 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -95,12 +95,13 @@ enum {
  * represents timeout for that try.  The first try can be soft or
  * hardreset.  All others are hardreset if available.  In most cases
  * the first reset w/ 10sec timeout should succeed.  Following entries
- * are mostly for error handling, hotplug and retarded devices.
+ * are mostly for error handling, hotplug and those outlier devices that
+ * take an exceptionally long time to recover from reset.
  */
 static const unsigned long ata_eh_reset_timeouts[] = {
 	10000,	/* most drives spin up by 10sec */
 	10000,	/* > 99% working drives spin up before 20sec */
-	35000,	/* give > 30 secs of idleness for retarded devices */
+	35000,	/* give > 30 secs of idleness for outlier devices */
 	 5000,	/* and sweet one last chance */
 	ULONG_MAX, /* > 1 min has elapsed, give up */
 };

