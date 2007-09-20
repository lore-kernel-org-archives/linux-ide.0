From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ide-cd is unmaintained
Date: Thu, 20 Sep 2007 15:21:21 +0100
Message-ID: <20070920152121.053fc9d4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38443 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754307AbXITOOK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 10:14:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

I simply don't have any old IDE systems any more or time to really look
after this. Nobody responded to the previous linux-ide mail about
maintainers so...

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/MAINTAINERS linux-2.6.23rc6-mm1/MAINTAINERS
--- linux.vanilla-2.6.23rc6-mm1/MAINTAINERS	2007-09-18 15:32:50.000000000 +0100
+++ linux-2.6.23rc6-mm1/MAINTAINERS	2007-09-18 16:02:28.000000000 +0100
@@ -1895,10 +1895,8 @@
 S:	Maintained
 
 IDE/ATAPI CDROM DRIVER
-P:	Alan Cox
-M:	alan@lxorguk.ukuu.org.uk
 L:	linux-ide@vger.kernel.org
-S:	Maintained
+S:	Unmaintained
 
 IDE/ATAPI FLOPPY DRIVERS
 P:	Paul Bristow
