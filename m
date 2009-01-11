From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/8] ide-acpi: no need to zero ->acpidata for devices
Date: Sun, 11 Jan 2009 20:11:26 +0100
Message-ID: <20090111191126.17361.86227.sendpatchset@localhost.localdomain>
References: <20090111191120.17361.69981.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:36460 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbZAKTKd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 14:10:33 -0500
In-Reply-To: <20090111191120.17361.69981.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-acpi: no need to zero ->acpidata for devices

ide_acpi_init() takes care of it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -718,8 +718,6 @@ void ide_acpi_port_init_devices(ide_hwif
 	 * Send IDENTIFY for each drive
 	 */
 	ide_port_for_each_dev(i, drive, hwif) {
-		memset(drive->acpidata, 0, sizeof(*drive->acpidata));
-
 		if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0)
 			continue;
 
