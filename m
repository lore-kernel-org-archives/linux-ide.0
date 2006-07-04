From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Move IDE to unmaintained, drop reference to old git tree
Date: Tue, 04 Jul 2006 12:59:32 +0100
Message-ID: <1152014372.28597.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6850 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932216AbWGDLmr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 07:42:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

Bart's git IDE tree ends at 2.6.15-rc5 and he doesn't appear to have
posted anything since April 7th.

Cc'd in case he's still around or someone knows where he is or has
gone ?

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.17/MAINTAINERS	2006-06-19 17:29:44.000000000 +0100
+++ linux-2.6.17/MAINTAINERS	2006-07-04 12:23:06.244268008 +0100
@@ -1286,8 +1286,7 @@
 M:	B.Zolnierkiewicz@elka.pw.edu.pl
 L:	linux-kernel@vger.kernel.org
 L:	linux-ide@vger.kernel.org
-T:	git kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git
-S:	Maintained
+S:	Unmaintained
 
 IDE/ATAPI CDROM DRIVER
 P:	Jens Axboe

