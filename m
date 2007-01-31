From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] iomap: iomap should be in obj-y not in lib-y
Date: Wed, 31 Jan 2007 22:48:06 +0900
Message-ID: <20070131134806.GJ8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:47681 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933275AbXAaNsM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 08:48:12 -0500
Received: by an-out-0708.google.com with SMTP id b33so92943ana
        for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 05:48:11 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

devres change moved iomap.o from obj-$(CONFIG_GENERIC_IOMAP) to lib-y
making it not linked if no in-kernel driver uses it.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/lib/Makefile b/lib/Makefile
index 29b2e99..3b605da 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,14 +5,14 @@
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o irq_regs.o reciprocal_div.o iomap.o
+	 sha1.o irq_regs.o reciprocal_div.o
 
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
-obj-y += sort.o parser.o halfmd4.o debug_locks.o random32.o
+obj-y += sort.o parser.o halfmd4.o debug_locks.o random32.o iomap.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
