From: Matti Linnanvuori <mattilinnanvuori@yahoo.com>
Subject: [PATCH] drivers/ide/Kconfig IDEPCI_SHARE_IRQ and IDEDISK_MULTI_MODE
Date: Sat, 20 Oct 2007 23:46:47 -0700 (PDT)
Message-ID: <604640.68715.qm@web52004.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52004.mail.re2.yahoo.com ([206.190.49.251]:28715 "HELO
	web52004.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750857AbXJUGx3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Oct 2007 02:53:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

From: Matti Linnanvuori <mattilinnanvuori@yahoo.com>

Correct IDEPCI_SHARE_IRQ description to keeping interrupts enabled
when calling the PCI IDE action handler.
Add IDEPCI_SHARE_IRQ and IDEDISK_MULTI_MODE help text from hdparm
manual page.

Signed-off-by: Matti Linnanvuori <mattilinnanvuori@yahoo.com>
---

--- a/drivers/ide/Kconfig	2007-10-21 08:53:11.826349500 +0300
+++ b/drivers/ide/Kconfig	2007-10-21 09:21:48.295590000 +0300
@@ -154,6 +154,18 @@ config BLK_DEV_IDEDISK
 config IDEDISK_MULTI_MODE
 	bool "Use multi-mode by default"
 	help
+	  Multiple sector mode is a feature of most modern IDE hard
+ 	  drives, permitting the transfer of multiple sectors per I/O
+	  interrupt, rather than the usual one sector per interrupt.
+	  When this feature is enabled, it typically reduces operating
+	  system overhead for disk I/O by 30-50%. On many systems, it
+	  also provides increased data throughput of anywhere from 5%
+	  to 50%. Some drives, however (most notably the WD Caviar
+	  series), seem to run slower with multiple mode enabled. Some
+	  drives claim to support multiple mode, but lose data at some
+	  settings. Under rare circumstances, such failures can result
+	  in massive filesystem corruption.
+
 	  If you get this error, try to say Y here:
 
 	  hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
@@ -367,11 +379,16 @@ config BLK_DEV_IDEPCI
 	bool
 
 config IDEPCI_SHARE_IRQ
-	bool "Sharing PCI IDE interrupts support"
+	bool "Keeping interrupts enabled when calling the PCI IDE action handler support"
 	depends on BLK_DEV_IDEPCI
 	help
-	  Some ATA/IDE chipsets have hardware support which allows for
-	  sharing a single IRQ with other cards. To enable support for
+	  A setting of Y permits the driver to unmask other interrupts
+	  during processing of a disk interrupt, which greatly improves
+ 	  Linux's responsiveness and eliminates "serial port overrun"
+	  errors. Use this feature with caution: some drive/controller
+	  combinations do not tolerate the increased I/O latencies
+	  possible when this feature is enabled, resulting in massive
+	  filesystem corruption. To enable support for
 	  this in the ATA/IDE driver, say Y here.
 
 	  It is safe to say Y to this question, in most cases.




        __________________________________  Ihr erstes Baby? Holen Sie sich Tipps von anderen Eltern.  www.yahoo.de/clever
