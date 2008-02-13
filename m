From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] printk: keep log level on multiline messages
Date: Wed, 13 Feb 2008 18:09:29 +0900
Message-ID: <12028937733464-git-send-email-htejun@gmail.com>
References: <12028937731333-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:60823 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYBMJJv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 04:09:51 -0500
Received: by wx-out-0506.google.com with SMTP id h31so5432310wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 01:09:50 -0800 (PST)
In-Reply-To: <12028937731333-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, jengelh@computergmbh.de, matthew@wil.cx, randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, linux-kernel@vger.kernel.org, akpm@linux-f
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
 kernel/printk.c |   50 +++++++++++++++++++++++---------------------------
 1 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 419cd47..2317ec8 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -614,6 +614,11 @@ asmlinkage int printk(const char *fmt, ...)
 	return r;
 }
 
+static int is_loglevel(const char *p)
+{
+	return p[0] == '<' && p[1] >= '0' && p[1] <= '7' && p[2] == '>';
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 	/* cpu currently holding logbuf_lock */
@@ -625,10 +630,11 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	static int log_level_unknown = 1;
 	static char printk_buf[PRINTK_BUF_LEN + sizeof(overflow_tag) - 1];
 
+	int last_lv = default_message_loglevel;
 	unsigned long flags;
 	int printed_len = 0;
 	int this_cpu;
-	char *p;
+	const char *p;
 
 	boot_delay_msec();
 
@@ -682,47 +688,37 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	for (p = printk_buf; *p; p++) {
 		if (log_level_unknown) {
                         /* log_level_unknown signals the start of a new line */
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
 				t = cpu_clock(printk_cpu);
 				nanosec_rem = do_div(t, 1000000000);
-				tlen = sprintf(tbuf,
-						"<%c>[%5lu.%06lu] ",
-						loglev_char,
+				tlen = sprintf(tbuf, "[%5lu.%06lu] ",
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

