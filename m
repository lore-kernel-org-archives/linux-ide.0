From: Mark Lord <mlord@pobox.com>
Subject: [PATCH] fix blk-exec.c compile error: always define
 'sysctl_hung_task_timeout_secs' (resend)
Date: Fri, 24 Sep 2010 17:46:37 -0400
Message-ID: <1285364797.12723.1.camel@corey>
References: <1285271646-2768-1-git-send-email-vgoyal@redhat.com>
 <4C9CEFD6.3000106@kernel.dk>  <20100924202106.GC7145@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab0IXVsO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2010 17:48:14 -0400
In-Reply-To: <20100924202106.GC7145@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vivek Goyal <vgoyal@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, IDE/ATA development list <linux-ide@vger.kernel.org>

Ensure that 'sysctl_hung_task_timeout_secs' is defined
even when CONFIG_DETECT_HUNG_TASK is not set.
This way we can safely reference it without need for
ifdefs in the code elsewhere.  eg. in block/blk-exec.c

Signed-off-by: Mark Lord <mlord@pobox.com>

(Resending from a repaired email client.)
Jens: my apologies for not catching this this earlier.

--- a/include/linux/sched.h	2010-09-20 19:56:53.000000000 -0400
+++ b/include/linux/sched.h	2010-09-24 17:22:01.707291995 -0400
@@ -336,6 +336,9 @@
 extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 					 void __user *buffer,
 					 size_t *lenp, loff_t *ppos);
+#else
+/* Avoid need for ifdefs elsewhere in the code */
+enum { sysctl_hung_task_timeout_secs = 0 };
 #endif
 
 /* Attach to any functions which should be ignored in wchan output. */



