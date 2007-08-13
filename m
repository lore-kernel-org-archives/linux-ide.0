From: joe@perches.com
Subject: [PATCH] [240/2many] MAINTAINERS - IDE SUBSYSTEM
Date: Sun, 12 Aug 2007 23:29:20 -0700
Message-ID: <46bffa40.kQmog5mspruumip5%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:4662 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966811AbXHMG3e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Aug 2007 02:29:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 99e4822..d22e45a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2276,6 +2276,9 @@ M:	bzolnier@gmail.com
 L:	linux-ide@vger.kernel.org
 T:	quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/
 S:	Maintained
+F:	Documentation/ide.txt
+F:	drivers/ide/
+F:	include/linux/ide.h
 
 IDE/ATAPI CDROM DRIVER
 P:	Alan Cox
