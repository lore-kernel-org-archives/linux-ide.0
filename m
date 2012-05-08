From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] ata, Add " 2GB ATA Flash Disk"/"ADMA428M" to DMA blacklist
Date: Tue,  8 May 2012 09:08:02 -0400
Message-ID: <1336482482-3200-1-git-send-email-prarit@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35896 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754411Ab2EHNIr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 May 2012 09:08:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Jeff Garzik <jgarzik@pobox.com>

A user has several systems with a couple of models of flash disks with IDE
connectors.  These disks work fine in 2.6.18-ish kernels but corrupt data on
new kernels.

The difference appears to be with the default I/O method used by the IDE
controller driver between the kernels.  In the older kernels, the
configuration is very conservative and the driver stays in PIO mode.  With
new kernels, the ata driver (pata_serverworks) attempts to use UDMA/66
which the drive claims to support.  This mode, however, does not appear to
work in DMA mode.  The drive does work correctly and no corruption is
seen if the kernel parameter "libata.force=5:pio0,6:pio0" is used to force
the driver to use PIO instead of DMA mode.

Blacklist these drives.  Unfortunately the model name of the drive is very
generic, " 2GB ATA Flash Disk", but the revision is specific, "ADMA428M".

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
---
 drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 23763a1..0213a39 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4051,6 +4051,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "_NEC DV5800A", 	NULL,		ATA_HORKAGE_NODMA },
 	{ "SAMSUNG CD-ROM SN-124", "N001",	ATA_HORKAGE_NODMA },
 	{ "Seagate STT20000A", NULL,		ATA_HORKAGE_NODMA },
+	{ "2GB ATA Flash Disk", "ADMA428M",	ATA_HORKAGE_NODMA },
 	/* Odd clown on sil3726/4726 PMPs */
 	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },
 
-- 
1.7.1

