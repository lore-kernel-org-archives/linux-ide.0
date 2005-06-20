From: domen@coderock.org
Subject: [patch 5/6] drivers/ide/* - compile warning cleanup
Date: Mon, 20 Jun 2005 23:52:21 +0200
Message-ID: <20050620215221.448736000@nd47.coderock.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coderock.org ([193.77.147.115]:37017 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261760AbVFTV4Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2005 17:56:24 -0400
Content-Disposition: inline; filename=return_code-drivers_ide.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, Stephen Biggs <yrgrknmxpzlk@gawab.com>, domen@coderock.org

From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>


compile warning cleanup - handle copy_to/from_user error returns

Signed-off-by: Stephen Biggs <yrgrknmxpzlk@gawab.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 ide-tape.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

Index: quilt/drivers/ide/ide-tape.c
===================================================================
--- quilt.orig/drivers/ide/ide-tape.c
+++ quilt/drivers/ide/ide-tape.c
@@ -2656,7 +2656,13 @@ static void idetape_copy_stage_from_user
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
-		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
+		if (copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count)) {
+#if IDETAPE_DEBUG_BUGS
+			printk(KERN_ERR "ide-tape/%s: copy_from_user failed!\n",
+					__FUNCTION__);
+#endif /* IDETAPE_DEBUG_BUGS */
+			return;
+		}
 		n -= count;
 		atomic_add(count, &bh->b_count);
 		buf += count;
@@ -2683,7 +2689,12 @@ static void idetape_copy_stage_to_user (
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min(tape->b_count, n);
-		copy_to_user(buf, tape->b_data, count);
+		if (copy_to_user(buf, tape->b_data, count)) {
+#if IDETAPE_DEBUG_BUGS
+			printk(KERN_ERR "ide-tape/%s: copy_to_user failed!\n",__FUNCTION__);
+#endif /* IDETAPE_DEBUG_BUGS */
+			return;
+		}
 		n -= count;
 		tape->b_data += count;
 		tape->b_count -= count;

--
