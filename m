From: domen@coderock.org
Subject: [patch 5/6] drivers/ide/* - compile warning cleanup
Date: Sun, 06 Mar 2005 11:42:17 +0100
Message-ID: <20050306104217.8389C1F1F0@trashy.coderock.org>
Received: from coderock.org ([193.77.147.115]:33962 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261374AbVCFKmX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Mar 2005 05:42:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, domen@coderock.org, yrgrknmxpzlk@gawab.com


compile warning cleanup - handle copy_to/from_user error returns

Signed-off-by: Stephen Biggs <yrgrknmxpzlk@gawab.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/ide-tape.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff -puN drivers/ide/ide-tape.c~return_code-drivers_ide drivers/ide/ide-tape.c
--- kj/drivers/ide/ide-tape.c~return_code-drivers_ide	2005-03-05 16:13:05.000000000 +0100
+++ kj-domen/drivers/ide/ide-tape.c	2005-03-05 16:13:05.000000000 +0100
@@ -2610,7 +2610,13 @@ static void idetape_copy_stage_from_user
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
@@ -2637,7 +2643,12 @@ static void idetape_copy_stage_to_user (
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
_
