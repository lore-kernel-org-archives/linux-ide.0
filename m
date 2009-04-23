From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] MAINTAINERS: update IDE entry
Date: Thu, 23 Apr 2009 22:48:31 +0200
Message-ID: <200904232248.31735.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:31787 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998AbZDWUo2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Apr 2009 16:44:28 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


By a popular demand quilt tree was replaced by a git one.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/MAINTAINERS
===================================================================
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2743,7 +2743,7 @@ IDE SUBSYSTEM
 P:	Bartlomiej Zolnierkiewicz
 M:	bzolnier@gmail.com
 L:	linux-ide@vger.kernel.org
-T:	quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6.git
 S:	Maintained
 F:	Documentation/ide/
 F:	drivers/ide/
