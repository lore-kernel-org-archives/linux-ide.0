From: Matti Linnanvuori <mattilinnanvuori@yahoo.com>
Subject: [PATCH] ide: fix Kconfig IDEPCI_SHARE_IRQ and IDEDISK_MULTI_MODE
Date: Mon, 22 Oct 2007 08:57:04 -0700 (PDT)
Message-ID: <573412.17797.qm@web52001.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52001.mail.re2.yahoo.com ([206.190.49.248]:43659 "HELO
	web52001.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751128AbXJVP5G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 11:57:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, sshtylyov@ru.mvista.com
Cc: linux-ide@vger.kernel.org

From: Matti Linnanvuori <mattilinnanvuori@yahoo.com>

Correct IDEPCI_SHARE_IRQ description to keeping interrupts enabled
when calling the PCI IDE action handler. CONFIG_IDEPCI_SHARE_IRQ does not
affect the setting of IRQF_SHARED for PCI chipsets in function init_irq, 
file drivers/ide/ide-probe.c but only the setting of IRQF_DISABLED.
Add IDEPCI_SHARE_IRQ and IDEDISK_MULTI_MODE help text from hdparm
manual page.

Signed-off-by: Matti Linnanvuori <mattilinnanvuori@yahoo.com>
---

Changing mention of multi-mode to affecting only some systems. Improving text.

--- a/drivers/ide/Kconfig	2007-10-21 08:53:11.826349500 +0300
+++ b/drivers/ide/Kconfig	2007-10-22 18:45:58.715425500 +0300
@@ -154,7 +154,19 @@ config BLK_DEV_IDEDISK
 config IDEDISK_MULTI_MODE
 	bool "Use multi-mode by default"
 	help
-	  If you get this error, try to say Y here:
+	  Multiple sector mode is a feature of most modern
+	  IDE drives, permitting the transfer of multiple sectors per I/O
+	  interrupt, rather than the usual one sector per interrupt.
+	  When this feature is enabled, it can reduce operating
+	  system overhead for disk I/O by 30 - 50%. On some systems, it
+	  also provides increased data throughput of anywhere from 5%
+	  to 50%. Some drives, however (most notably the WD Caviar
+	  series), seem to run slower with multiple mode enabled. Some
+	  drives claim to support multiple mode, but lose data at some
+	  settings. Under rare circumstances, such failures can result
+	  in massive filesystem corruption.
+
+	  If you get the following error, try to say Y here:
 
 	  hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
 	  hda: set_multmode: error=0x04 { DriveStatusError }
@@ -367,11 +379,16 @@ config BLK_DEV_IDEPCI
 	bool
 
 config IDEPCI_SHARE_IRQ
-	bool "Sharing PCI IDE interrupts support"
+	bool "Keeping interrupts enabled when calling the PCI IDE action handler"
 	depends on BLK_DEV_IDEPCI
 	help
-	  Some ATA/IDE chipsets have hardware support which allows for
-	  sharing a single IRQ with other cards. To enable support for
+	  A setting of Y permits the driver to enable other interrupts
+	  during processing of a disk interrupt, which greatly improves
+ 	  Linux's responsiveness and eliminates "serial port overrun"
+	  and buffer errors. Use this feature with caution: some
+	  drive/controller combinations do not tolerate the increased I/O
+	  latencies possible when this feature is enabled, resulting in massive
+	  filesystem corruption. To enable support for
 	  this in the ATA/IDE driver, say Y here.
 
 	  It is safe to say Y to this question, in most cases.





      Machen Sie Yahoo! zu Ihrer Startseite. Los geht's: 
http://de.yahoo.com/set
