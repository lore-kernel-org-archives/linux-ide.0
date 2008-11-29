From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ata_piix: add borked Tecra M4 to broken suspend
 list
Date: Sat, 29 Nov 2008 22:37:21 +0900
Message-ID: <49314591.7060404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44349 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbYK2NhD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Nov 2008 08:37:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, a_romanescu@yahoo.co.uk

Tecra M4 sometimes forget what it is and reports bogus data via DMI
which makes the machine evade broken suspend matching and thus fail
suspend/resume.  This patch updates piix_broken_suspend() such that it
can match such case.  As the borked DMI data is a bit generic,
matching many entries to make the match more specific is necessary.
As the usual DMI matching is limited to four entries, this patch uses
hard coded manual matching.

This is reported by Alexandru Romanescu.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Alexandru Romanescu <a_romanescu@yahoo.co.uk>
---
 drivers/ata/ata_piix.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 8e37be1..d6d97d8 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1066,6 +1066,21 @@ static int piix_broken_suspend(void)
 		if (dmi_find_device(DMI_DEV_TYPE_OEM_STRING, oemstrs[i], NULL))
 			return 1;
 
+	/* TECRA M4 sometimes forgets its identify and reports bogus
+	 * DMI information.  As the bogus information is a bit
+	 * generic, match as many entries as possible.  This manual
+	 * matching is necessary because dmi_system_id.matches is
+	 * limited to four entries.
+	 */
+	if (!strcmp(dmi_get_system_info(DMI_SYS_VENDOR), "TOSHIBA") &&
+	    !strcmp(dmi_get_system_info(DMI_PRODUCT_NAME), "000000") &&
+	    !strcmp(dmi_get_system_info(DMI_PRODUCT_VERSION), "000000") &&
+	    !strcmp(dmi_get_system_info(DMI_PRODUCT_SERIAL), "000000") &&
+	    !strcmp(dmi_get_system_info(DMI_BOARD_VENDOR), "TOSHIBA") &&
+	    !strcmp(dmi_get_system_info(DMI_BOARD_NAME), "Portable PC") &&
+	    !strcmp(dmi_get_system_info(DMI_BOARD_VERSION), "Version A0"))
+		return 1;
+
 	return 0;
 }
 
