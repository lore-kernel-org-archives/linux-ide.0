From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] IDE: remove WAIT_READY dependency on APM
Date: Tue, 1 Feb 2005 00:42:34 +0100
Message-ID: <20050131234234.GU21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5894 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261463AbVAaXmg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Jan 2005 18:42:36 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On the one hand APM isn't enabled on all laptops.
On the other hand, this also affects regular PCs with APM support (or
using a distribution kernel with APM support).

The time for the !APM case was already increased from 30msec in 2.4 .
Isn't there a timeout that is suitable for all cases?

Alan Cox answered:
> The five seconds should be just fine for all cases. The smaller value
> with no
> power manglement should help speed up recovery however. It probably
> doesn't belong CONFIG_APM now ACPI and friends are involved either.

Until someone has a real good solution (consider e.g. that most PC users 
might have ACPI support enabled), this patch unconditionally sets 
WAIT_READY to 5 seconds.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch as already sent on:
- 11 Dec 2004
- 17 Jan 2005

--- linux-2.6.10-rc2-mm4-full/include/linux/ide.h.old	2004-12-11 18:11:20.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/ide.h	2004-12-11 18:11:32.000000000 +0100
@@ -187,11 +187,7 @@
  * Timeouts for various operations:
  */
 #define WAIT_DRQ	(HZ/10)		/* 100msec - spec allows up to 20ms */
-#if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
 #define WAIT_READY	(5*HZ)		/* 5sec - some laptops are very slow */
-#else
-#define WAIT_READY	(HZ/10)		/* 100msec - should be instantaneous */
-#endif /* CONFIG_APM || CONFIG_APM_MODULE */
 #define WAIT_PIDENTIFY	(10*HZ)	/* 10sec  - should be less than 3ms (?), if all ATAPI CD is closed at boot */
 #define WAIT_WORSTCASE	(30*HZ)	/* 30sec  - worst case when spinning up */
 #define WAIT_CMD	(10*HZ)	/* 10sec  - maximum wait for an IRQ to happen */

