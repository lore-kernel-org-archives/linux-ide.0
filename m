From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] printk: keep log level on multiline messages
Date: Wed, 16 Jan 2008 10:00:07 +0900
Message-ID: <1200445211195-git-send-email-htejun@gmail.com>
References: <1200445210549-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:4286 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbYAPBAS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 20:00:18 -0500
Received: by rv-out-0910.google.com with SMTP id k20so49372rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 15 Jan 2008 17:00:17 -0800 (PST)
In-Reply-To: <1200445210549-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, daniel.ritz-ml@swissonline.ch, randy.dunlap@oracle.com, jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

When printing multiline messages, printk() resets log level to
default_message_loglevel after the first line.  This changes log level
unexpectedly when printing multiline messages.

For example, libata error messages are printed like the following.

<3>ata8.00: cmd 60/01:00:e0:71:02/00:00:00:00:00/40 tag 0 ncq 512 in
<4>         res 40/00:34:de:71:02/00:00:00:00:00/40 Emask 0x10 (ATA bus error)

This patch makes printk use the log level of the last line if the
current line doesn't specify log level explicitly.

While at it, separate out is_loglevel() test.  This will be used by
later changes.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 kernel/printk.c |   51 ++++++++++++++++++++++++---------------------------
 1 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 89011bf..6df1872 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -628,11 +628,17 @@ asmlinkage int printk(const char *fmt, ...)
 /* cpu currently holding logbuf_lock */
 static volatile unsigned int printk_cpu = UINT_MAX;
 
+static int is_loglevel(const char *p)
+{
+	return p[0] == '<' && p[1] >= '0' && p[1] <= '7' && p[2] == '>';
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
+	int last_lv = default_message_loglevel;
 	unsigned long flags;
 	int printed_len;
-	char *p;
+	const char *p;
 	static char printk_buf[1024];
 	static int log_level_unknown = 1;
 
@@ -659,48 +665,39 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 */
 	for (p = printk_buf; *p; p++) {
 		if (log_level_unknown) {
-                        /* log_level_unknown signals the start of a new line */
+			/* log_level_unknown signals the start of a new line */
+			int lv = last_lv;
+
+			if (is_loglevel(p)) {
+				lv = p[1] - '0';
+				p += 3;
+				printed_len -= 3;
+			}
+
+			emit_log_char('<');
+			emit_log_char(lv + '0');
+			emit_log_char('>');
+			printed_len += 3;
+
 			if (printk_time) {
-				int loglev_char;
 				char tbuf[50], *tp;
 				unsigned tlen;
 				unsigned long long t;
 				unsigned long nanosec_rem;
 
-				/*
-				 * force the log level token to be
-				 * before the time output.
-				 */
-				if (p[0] == '<' && p[1] >='0' &&
-				   p[1] <= '7' && p[2] == '>') {
-					loglev_char = p[1];
-					p += 3;
-					printed_len -= 3;
-				} else {
-					loglev_char = default_message_loglevel
-						+ '0';
-				}
 				t = printk_clock();
 				nanosec_rem = do_div(t, 1000000000);
 				tlen = sprintf(tbuf,
-						"<%c>[%5lu.%06lu] ",
-						loglev_char,
+						"[%5lu.%06lu] ",
 						(unsigned long)t,
 						nanosec_rem/1000);
 
 				for (tp = tbuf; tp < tbuf + tlen; tp++)
 					emit_log_char(*tp);
 				printed_len += tlen;
-			} else {
-				if (p[0] != '<' || p[1] < '0' ||
-				   p[1] > '7' || p[2] != '>') {
-					emit_log_char('<');
-					emit_log_char(default_message_loglevel
-						+ '0');
-					emit_log_char('>');
-					printed_len += 3;
-				}
 			}
+
+			last_lv = lv;
 			log_level_unknown = 0;
 			if (!*p)
 				break;
-- 
1.5.2.4

