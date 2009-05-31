From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] partitions: warn about the partition exceeding device capacity
Date: Sun, 31 May 2009 16:39:18 +0200
Message-ID: <20090531143918.7164.14969.sendpatchset@localhost.localdomain>
References: <20090531143911.7164.26834.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:49478 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914AbZEaOeA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 May 2009 10:34:00 -0400
In-Reply-To: <20090531143911.7164.26834.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Frans Pop <elendil@planet.nl>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] partitions: warn about the partition exceeding device capacity

The current warning message says only about the kernel's action taken
without mentioning the underlying reason behind it.

Noticed-by: Robert Hancock <hancockrwd@gmail.com>
Cc: Frans Pop <elendil@planet.nl>
Cc: "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 fs/partitions/check.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/fs/partitions/check.c
===================================================================
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -574,7 +574,8 @@ int rescan_partitions(struct gendisk *di
 			 * creating invalid block devices
 			 */
 			printk(KERN_WARNING
-			       "%s: p%d size %llu limited to end of disk\n",
+			       "%s: p%d size %llu exceeds device capacity, "
+			       "limited to end of disk\n",
 			       disk->disk_name, p, (unsigned long long) size);
 			size = get_capacity(disk) - from;
 		}
