From: "Art Haas" <ahaas@airmail.net>
Subject: [PATCH] Small initializer patch for ide-disk.c
Date: Tue, 21 Dec 2004 14:24:07 -0600
Message-ID: <20041221202407.GD2725@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 8f.7b.d1c4.cidr.airmail.net ([209.196.123.143]:3345 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261624AbULUUYL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Dec 2004 15:24:11 -0500
Received: from pppte02-175.ght.iadfw.net ([66.94.128.175] helo=pcdebian)
	by covert.iadfw.net with esmtp (Exim 4.24)
	id 1CgqZz-0003mZ-Fl
	for linux-ide@vger.kernel.org; Tue, 21 Dec 2004 14:26:00 -0600
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Hi.

This patch adds C99 initializers to the file. It can clearly wait until
after 2.6.10 is released if you want to send it to Linus.

Art Haas

===== drivers/ide/ide-disk.c 1.109 vs edited =====
--- 1.109/drivers/ide/ide-disk.c	2004-11-06 19:55:34 -06:00
+++ edited/drivers/ide/ide-disk.c	2004-12-20 17:24:38 -06:00
@@ -871,11 +871,27 @@
 }
 
 static ide_proc_entry_t idedisk_proc[] = {
-	{ "cache",		S_IFREG|S_IRUGO,	proc_idedisk_read_cache,		NULL },
-	{ "geometry",		S_IFREG|S_IRUGO,	proc_ide_read_geometry,			NULL },
-	{ "smart_values",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_values,		NULL },
-	{ "smart_thresholds",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_thresholds,	NULL },
-	{ NULL, 0, NULL, NULL }
+	{
+		.name		= "cache",
+		.mode		= S_IFREG|S_IRUGO,
+		.read_proc	= proc_idedisk_read_cache,
+	 },
+	{
+		.name		= "geometry",
+		.mode		= S_IFREG|S_IRUGO,
+		.read_proc	= proc_ide_read_geometry,
+	},
+	{
+		.name		= "smart_values",
+		.mode		= S_IFREG|S_IRUSR,
+		.read_proc	= proc_idedisk_read_smart_values,
+	},
+	{
+		.name		= "smart_thresholds",
+		.mode		= S_IFREG|S_IRUSR,
+		.read_proc	= proc_idedisk_read_smart_thresholds,
+	},
+	{ .mode =  0 }
 };
 
 #else
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
