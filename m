From: Anton Blanchard <anton@samba.org>
Subject: [PATCH] ide: Use linux/mutex.h
Date: Mon, 9 May 2011 09:30:17 +1000
Message-ID: <20110509093017.20f00c35@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:36071 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163Ab1EHXaV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 May 2011 19:30:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org


The IDE code is still including asm/mutex.h instead of linux/mutex.h

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6-work/include/linux/ide.h
===================================================================
--- linux-2.6-work.orig/include/linux/ide.h	2011-04-22 14:53:07.079941198 +1000
+++ linux-2.6-work/include/linux/ide.h	2011-05-04 14:53:32.215007829 +1000
@@ -18,13 +18,13 @@
 #include <linux/pci.h>
 #include <linux/completion.h>
 #include <linux/pm.h>
+#include <linux/mutex.h>
 #ifdef CONFIG_BLK_DEV_IDEACPI
 #include <acpi/acpi.h>
 #endif
 #include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/mutex.h>
 
 /* for request_sense */
 #include <linux/cdrom.h>
