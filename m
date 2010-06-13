From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/12] irq: misc preparations for further changes
Date: Sun, 13 Jun 2010 17:31:31 +0200
Message-ID: <1276443098-20653-6-git-send-email-tj__41689.1314358965$1276443317$gmane$org@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37723 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073Ab0FMPcK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Jun 2010 11:32:10 -0400
In-Reply-To: <1276443098-20653-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.orglinux
Cc: Tejun Heo <tj@kernel.org>

* properly indent irqaction fields.

* factor out print_irq_handler()

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/interrupt.h |   20 ++++++++++----------
 kernel/irq/spurious.c     |   28 ++++++++++++++++------------
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 61857f1..b20bd65 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -102,16 +102,16 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  * @thread_flags:	flags related to @thread
  */
 struct irqaction {
-	irq_handler_t handler;
-	unsigned long flags;
-	const char *name;
-	void *dev_id;
-	struct irqaction *next;
-	int irq;
-	struct proc_dir_entry *dir;
-	irq_handler_t thread_fn;
-	struct task_struct *thread;
-	unsigned long thread_flags;
+	irq_handler_t		handler;
+	unsigned long		flags;
+	const char		*name;
+	void			*dev_id;
+	struct irqaction	*next;
+	int			irq;
+	struct proc_dir_entry	*dir;
+	irq_handler_t		thread_fn;
+	struct task_struct	*thread;
+	unsigned long		thread_flags;
 };
 
 extern irqreturn_t no_action(int cpl, void *dev_id);
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index fc18a13..0bce0e3 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -28,6 +28,21 @@ enum {
 int noirqdebug __read_mostly;
 static int irqfixup __read_mostly = IRQFIXUP_SPURIOUS;
 
+static void print_irq_handlers(struct irq_desc *desc)
+{
+	struct irqaction *action;
+
+	printk(KERN_ERR "handlers:\n");
+
+	action = desc->action;
+	while (action) {
+		printk(KERN_ERR "[<%p>]", action->handler);
+		print_symbol(" (%s)", (unsigned long)action->handler);
+		printk("\n");
+		action = action->next;
+	}
+}
+
 /*
  * Recovery handler for misrouted interrupts.
  */
@@ -126,8 +141,6 @@ static void
 __report_bad_irq(unsigned int irq, struct irq_desc *desc,
 		 irqreturn_t action_ret)
 {
-	struct irqaction *action;
-
 	if (action_ret != IRQ_HANDLED && action_ret != IRQ_NONE) {
 		printk(KERN_ERR "irq event %d: bogus return value %x\n",
 				irq, action_ret);
@@ -136,16 +149,7 @@ __report_bad_irq(unsigned int irq, struct irq_desc *desc,
 				"the \"irqpoll\" option)\n", irq);
 	}
 	dump_stack();
-	printk(KERN_ERR "handlers:\n");
-
-	action = desc->action;
-	while (action) {
-		printk(KERN_ERR "[<%p>]", action->handler);
-		print_symbol(" (%s)",
-			(unsigned long)action->handler);
-		printk("\n");
-		action = action->next;
-	}
+	print_irq_handlers(desc);
 }
 
 static void
-- 
1.6.4.2

