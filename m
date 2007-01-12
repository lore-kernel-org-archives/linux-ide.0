From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/19] ide: update MAINTAINERS entry
Date: Fri, 12 Jan 2007 05:17:26 +0100
Message-ID: <20070112041726.28755.11371.sendpatchset@localhost.localdomain>
References: <20070112041720.28755.49663.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:26473 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbXALENu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 23:13:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so688775uga
        for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 20:13:49 -0800 (PST)
In-Reply-To: <20070112041720.28755.49663.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

[PATCH] ide: update MAINTAINERS entry

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 MAINTAINERS |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: my-2.6/MAINTAINERS
===================================================================
--- my-2.6.orig/MAINTAINERS
+++ my-2.6/MAINTAINERS
@@ -1585,12 +1585,11 @@ M:	ipslinux@adaptec.com
 W:	http://www.developer.ibm.com/welcome/netfinity/serveraid.html
 S:	Supported 
 
-IDE DRIVER [GENERAL]
+IDE SUBSYSTEM
 P:	Bartlomiej Zolnierkiewicz
-M:	B.Zolnierkiewicz@elka.pw.edu.pl
-L:	linux-kernel@vger.kernel.org
+M:	bzolnier@gmail.com
 L:	linux-ide@vger.kernel.org
-T:	git kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git
+T:	quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/
 S:	Maintained
 
 IDE/ATAPI CDROM DRIVER
