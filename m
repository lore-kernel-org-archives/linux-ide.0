From: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: (2.6.0-test9) Disabling IDE DMA removes ability to select chipsets
Date: Fri, 21 Nov 2003 09:57:17 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <16317.18125.869980.877589@wombat.disy.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:61906 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263142AbTKTW5a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Nov 2003 17:57:30 -0500
Received: From wombat.disy.cse.unsw.edu.au ([129.94.239.42])
	(for <B.Zolnierkiewicz@elka.pw.edu.pl>) (for <akpm@osld.org>)
	(for <linux-ide@vger.kernel.org>)
	(for <linux-kernel@vger.kernel.org>) By note With Smtp ;
	Fri, 21 Nov 2003 09:57:18 +1100
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osld.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,
	In drivers/ide/Kconfig at present, if you deselect
BLK_DEV_IDEDMA_PCI you can then *not* select any of the non-generic
chipsets.  Thus you lose the ability to auto-tune PIO modes, for
example.

This patch rearranges where the endif moves to disable just the config
options that depend on DMA.

===== Kconfig 1.32 vs edited =====
--- 1.32/drivers/ide/Kconfig	Wed Nov 19 18:40:45 2003
+++ edited/Kconfig	Thu Nov 20 14:32:13 2003
@@ -531,6 +531,8 @@
 	depends on PCI && BLK_DEV_IDEPCI
 	default BLK_DEV_IDEDMA_PCI
 
+endif
+
 config BLK_DEV_AEC62XX
 	tristate "AEC62XX chipset support"
 	help
@@ -800,7 +802,6 @@
 	  This allows the kernel to change PIO, DMA and UDMA speeds and to
 	  configure the chip to optimum performance.
 
-endif
 
 config BLK_DEV_IDE_PMAC
 	bool "Builtin PowerMac IDE support"
