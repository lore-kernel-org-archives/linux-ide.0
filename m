From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] sx8: fix gcc format warning
Date: Mon, 10 Jan 2005 15:02:07 -0800
Message-ID: <20050110150207.7973e07d.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:56500 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262597AbVAJXOV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2005 18:14:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


Linux 2.6.10-bk13

Fix gcc format warning:
drivers/block/sx8.c:1506: warning: unsigned int format, different type arg (arg 3)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/block/sx8.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -Naurp ./drivers/block/sx8.c~sx8_types ./drivers/block/sx8.c
--- ./drivers/block/sx8.c~sx8_types	2005-01-10 10:38:39.511498632 -0800
+++ ./drivers/block/sx8.c	2005-01-10 11:53:27.684192672 -0800
@@ -1503,7 +1503,8 @@ static int carm_init_disks(struct carm_h
 		}
 
 		port->disk = disk;
-		sprintf(disk->disk_name, DRV_NAME "/%u", (host->id * CARM_MAX_PORTS) + i);
+		sprintf(disk->disk_name, DRV_NAME "/%u",
+				(unsigned int)(host->id * CARM_MAX_PORTS) + i);
 		sprintf(disk->devfs_name, DRV_NAME "/%u_%u", host->id, i);
 		disk->major = host->major;
 		disk->first_minor = i * CARM_MINORS_PER_MAJOR;

---
