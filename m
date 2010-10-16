From: Tracey Dent <tdent48227@gmail.com>
Subject: [PATCH] Drivers: ata: Makefile: replace the use of <module>-objs with <module>-y
Date: Fri, 15 Oct 2010 23:41:33 -0400
Message-ID: <1287200493-2024-1-git-send-email-tdent48227@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57079 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab0JPDll (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Oct 2010 23:41:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, avorontsov@ru.mvista.com, linux-ide@vger.kernel.org, Tracey Dent <tdent48227@gmail.com>

Changed <module>-objs to <module>-y in Makefile.

Signed-off-by: Tracey Dent <tdent48227@gmail.com>
---
 drivers/ata/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index ccd461b..c501af5 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -99,7 +99,7 @@ obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o
 # Should be last libata driver
 obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
 
-libata-objs	:= libata-core.o libata-scsi.o libata-eh.o libata-transport.o
+libata-y	:= libata-core.o libata-scsi.o libata-eh.o libata-transport.o
 libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
 libata-$(CONFIG_SATA_PMP)	+= libata-pmp.o
 libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
-- 
1.7.3.1.104.gc752e

