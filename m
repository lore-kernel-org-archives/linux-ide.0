From: joe@perches.com
Subject: [PATCH] [241/2many] MAINTAINERS - IDE/ATAPI CDROM DRIVER
Date: Sun, 12 Aug 2007 23:29:21 -0700
Message-ID: <46bffa41.8uNto66i1R9GDZK6%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:4669 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966828AbXHMG3h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Aug 2007 02:29:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index d22e45a..b77decd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2285,6 +2285,8 @@ P:	Alan Cox
 M:	alan@lxorguk.ukuu.org.uk
 L:	linux-ide@vger.kernel.org
 S:	Maintained
+F:	Documentation/cdrom/ide-cd
+F:	drivers/ide/ide-cd.*
 
 IDE/ATAPI FLOPPY DRIVERS
 P:	Paul Bristow
