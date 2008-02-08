From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/18] ide-generic: set hwif->chipset
Date: Fri, 08 Feb 2008 01:44:27 +0100
Message-ID: <20080208004427.17746.14159.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:1223 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbYBHAaT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 19:30:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so88984wah.23
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 16:30:16 -0800 (PST)
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

This hwif->chipset fixup is already present in ide_device_add_all()
but for warm-plug support we also need to reserve not currently present
interfaces.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -23,7 +23,9 @@ static int __init ide_generic_init(void)
 	for (i = 0; i < MAX_HWIFS; i++) {
 		ide_hwif_t *hwif = &ide_hwifs[i];
 
-		if (hwif->io_ports[IDE_DATA_OFFSET] && !hwif->present)
+		if (hwif->io_ports[IDE_DATA_OFFSET] &&
+		    (hwif->chipset == ide_unknown ||
+		     hwif->chipset == ide_forced))
 			idx[i] = i;
 		else
 			idx[i] = 0xff;
