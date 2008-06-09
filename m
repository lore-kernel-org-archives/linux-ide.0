From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] fix BLK_DEV_HD_ONLY on ARM dependencies
Date: Tue, 10 Jun 2008 01:21:55 +0300
Message-ID: <20080609222155.GA1987@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:53857 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbYFIWWt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Jun 2008 18:22:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk

This patch limits BLK_DEV_HD_ONLY to the ARM platforms offering 
IRQ_HARDDISK, fixing the following compile error on others:

<--  snip  -->

...
  CC      drivers/ide/legacy/hd.o
...
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c: In function 'hd_times_out':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:542: error: 'IRQ_HARDDISK' undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:542: error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:542: error: for each function it appears in.)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c: In function 'do_hd_request':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:661: error: 'IRQ_HARDDISK' undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c: In function 'hd_init':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/legacy/hd.c:765: error: 'IRQ_HARDDISK' undeclared (first use in this function)
make[3]: *** [drivers/ide/legacy/hd.o] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
f3602f8b3005bec996d53f36cdeb9c894e257003 diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index b4f3aef..1607536 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -1028,6 +1028,7 @@ endif
 
 config BLK_DEV_HD_ONLY
 	bool "Old hard disk (MFM/RLL/IDE) driver"
+	depends on !ARM || ARCH_RPC || ARCH_SHARK || BROKEN
 	help
 	  There are two drivers for MFM/RLL/IDE hard disks. Most people use
 	  the newer enhanced driver, but this old one is still around for two

