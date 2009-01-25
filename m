From: Kay Sievers <kay.sievers@vrfy.org>
Subject: ide: struct device - replace bus_id with dev_name(), dev_set_name()
Date: Sun, 25 Jan 2009 23:46:28 +0100
Message-ID: <1232923588.2924.10.camel@nga>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:50130 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZAYWrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jan 2009 17:47:20 -0500
Received: by fxm13 with SMTP id 13so1446381fxm.13
        for <linux-ide@vger.kernel.org>; Sun, 25 Jan 2009 14:47:18 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, gregkh <gregkh@suse.de>

From: Kay Sievers <kay.sievers@vrfy.org>
Subject: ide: struct device - replace bus_id with dev_name(), dev_set_name()

Cc: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---
 drivers/ide/ide-acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -282,7 +282,7 @@ static int do_drive_get_GTF(ide_drive_t
 	port = hwif->channel ? drive->dn - 2: drive->dn;
 
 	DEBPRINT("ENTER: %s at %s, port#: %d, hard_port#: %d\n",
-		 hwif->name, dev->bus_id, port, hwif->channel);
+		 hwif->name, dev_name(dev), port, hwif->channel);
 
 	if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0) {
 		DEBPRINT("%s drive %d:%d not present\n",

