From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 04/18] ide-acpi: add missing drive->acpidata zeroing
Date: Fri, 08 Feb 2008 01:44:48 +0100
Message-ID: <20080208004448.17746.71220.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:45194 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762352AbYBHAag (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 19:30:36 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3446190wra.23
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 16:30:36 -0800 (PST)
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -710,6 +710,8 @@ void ide_acpi_port_init_devices(ide_hwif
 	for (i = 0; i < MAX_DRIVES; i++) {
 		drive = &hwif->drives[i];
 
+		memset(drive->acpidata, 0, sizeof(*drive->acpidata));
+
 		if (!drive->present)
 			continue;
 
