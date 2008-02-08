From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/18] ide: fix ide_find_port()
Date: Fri, 08 Feb 2008 01:44:34 +0100
Message-ID: <20080208004434.17746.33986.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:45438 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759222AbYBHAa0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 19:30:26 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3446189wra.23
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 16:30:23 -0800 (PST)
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Instead of checking for '->io_ports[IDE_DATA_OFFSET] == 0' check for
  '->chipset == ide_unknown' when looking for an empty ide_hwifs[] slot.

* Do ide-pnp initialization after ide-generic when IDE is built-in
  (ide-pnp is the only user of ide_find_port() which needs such fixup).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Makefile |    2 +-
 drivers/ide/ide.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/Makefile
===================================================================
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -36,9 +36,9 @@ ifeq ($(CONFIG_BLK_DEV_CMD640), y)
 endif
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= cris/ ppc/
-obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 obj-$(CONFIG_IDE_H8300)			+= h8300/
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
+obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 
 ide-cd_mod-y += ide-cd.o ide-cd_ioctl.o ide-cd_verbose.o
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -259,7 +259,7 @@ ide_hwif_t * ide_find_port(unsigned long
 
 	for (i = 0; i < MAX_HWIFS; i++) {
 		hwif = &ide_hwifs[i];
-		if (hwif->io_ports[IDE_DATA_OFFSET] == 0)
+		if (hwif->chipset == ide_unknown)
 			goto found;
 	}
 
