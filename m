From: Dan Carpenter <error27@gmail.com>
Subject: [patch] move dereference after null check
Date: Tue, 10 Nov 2009 10:55:43 +0200 (SAST)
Message-ID: <alpine.DEB.2.00.0911081949070.11108@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60509 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbZKJIzu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Nov 2009 03:55:50 -0500
Received: by bwz27 with SMTP id 27so4301119bwz.21
        for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2009 00:55:55 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: davem@davemloft.net

I moved the ops->inherits dereference below the null check.  I moved the 
other assignment as well so that they would be together.

Found by smatch static checker.

regards,
dan carpenter

Signed-off-by: Dan Carpenter <error27@gmail.com>

--- orig/drivers/ata/libata-core.c	2009-11-08 19:40:18.000000000 +0200
+++ devel/drivers/ata/libata-core.c	2009-11-08 19:42:06.000000000 +0200
@@ -5938,13 +5938,14 @@
 {
 	static DEFINE_SPINLOCK(lock);
 	const struct ata_port_operations *cur;
-	void **begin = (void **)ops;
-	void **end = (void **)&ops->inherits;
-	void **pp;
+	void **begin, **end, **pp;
 
 	if (!ops || !ops->inherits)
 		return;
 
+	begin = (void **)ops;
+	end = (void **)&ops->inherits;
+
 	spin_lock(&lock);
 
 	for (cur = ops->inherits; cur; cur = cur->inherits) {
