From: Doug Maxey <dwm@austin.ibm.com>
Subject: [RFC/PATCH 3/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 12:16:28 -0600
Message-ID: <200501281816.j0SIGSxq021094@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.133]:65433 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262726AbVA1SQc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 13:16:32 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0SIGVZ7450532
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 13:16:31 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0SIGUqw318644
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:16:30 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0SIGUir012041
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:16:30 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


    - Add documentation for the use of the Kbuild variable
      BLK_DEV_HDWC.

 drivers/ide/Kconfig |   11 +++++++++++
 1 files changed, 11 insertions(+)

diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/drivers/ide/Kconfig lk-2.6.11-rc2-bk5.b/drivers/ide/Kconfig
--- lk-2.6.11-rc2-bk5.a/drivers/ide/Kconfig	2004-12-24 15:34:44.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/drivers/ide/Kconfig	2005-01-28 11:24:11.224547208 -0600
@@ -148,6 +148,17 @@ config BLK_DEV_IDEDISK
 
 	  If unsure, say Y.
 
+config BLK_DEV_HDWC
+       bool "Use cache settings of the disk"
+       depends on BLK_DEV_IDEDISK
+       ---help---
+       Normally the IDE disk driver forces the use of the drive cache.
+       This setting allows the kernel to detect and use the write
+       cache default from the drive.  If you want the kernel to honor
+       the drive setting for the use of cache, say Y here.
+
+       If unsure, say N.
+
 config IDEDISK_MULTI_MODE
 	bool "Use multi-mode by default"
 	depends on BLK_DEV_IDEDISK


