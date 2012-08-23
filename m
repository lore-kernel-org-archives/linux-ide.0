From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] libata: Add a space to " 2GB ATA Flash Disk" DMA blacklist entry
Date: Thu, 23 Aug 2012 15:11:52 -0400
Message-ID: <1345749112-24885-1-git-send-email-prarit@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50326 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab2HWTL6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2012 15:11:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Jeff Garzik <jgarzik@pobox.com>

commit d70e551c8e1ecb6f20422f8db6bfe6a0049edcb8, Add " 2GB ATA Flash
Disk"/"ADMA428M" to DMA blacklist, should have added a space before 2GB.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fadd586..6c524dd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4062,7 +4062,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "_NEC DV5800A", 	NULL,		ATA_HORKAGE_NODMA },
 	{ "SAMSUNG CD-ROM SN-124", "N001",	ATA_HORKAGE_NODMA },
 	{ "Seagate STT20000A", NULL,		ATA_HORKAGE_NODMA },
-	{ "2GB ATA Flash Disk", "ADMA428M",	ATA_HORKAGE_NODMA },
+	{ " 2GB ATA Flash Disk", "ADMA428M",	ATA_HORKAGE_NODMA },
 	/* Odd clown on sil3726/4726 PMPs */
 	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },
 
-- 
1.7.9.3

