From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: ide-disk: don't validate non LBA info when there is no
	geometry
Date: Fri, 05 Nov 2004 16:25:07 +0000
Message-ID: <1099671906.5556.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:7621 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262732AbUKER2B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:28:01 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/ide-disk.c linux-2.6.10rc1/drivers/ide/ide-disk.c
--- linux.vanilla-2.6.10rc1/drivers/ide/ide-disk.c	2004-11-05 15:42:15.000000000 +0000
+++ linux-2.6.10rc1/drivers/ide/ide-disk.c	2004-11-05 16:07:19.000000000 +0000
@@ -84,6 +84,10 @@
 {
 	unsigned long lba_sects, chs_sects, head, tail;
 
+	/* No non-LBA info .. so valid! */
+	if (id->cyls == 0)
+		return 1;
+		
 	/*
 	 * The ATA spec tells large drives to return
 	 * C/H/S = 16383/16/63 independent of their size.

