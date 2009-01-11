From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/8] ide: remove superfluous check from ide_proc_port_register_devices()
Date: Sun, 11 Jan 2009 20:11:20 +0100
Message-ID: <20090111191120.17361.69981.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63185 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbZAKTK1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 14:10:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove superfluous check from ide_proc_port_register_devices()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
just few cleanup patches for pata-2.6 tree (mainly IDE ACPI related)

 drivers/ide/ide-proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -600,7 +600,7 @@ void ide_proc_port_register_devices(ide_
 	int i;
 
 	ide_port_for_each_dev(i, drive, hwif) {
-		if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0 || drive->proc)
+		if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0)
 			continue;
 
 		drive->proc = proc_mkdir(drive->name, parent);
