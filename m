From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] libata: Add atapi_dmadir force flag
Date: Wed, 22 May 2013 08:35:18 +0900
Message-ID: <20130521233518.GC6985@mtj.dyndns.org>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
 <201305202243.15125.plr.vincent@gmail.com>
 <20130520220238.GA30556@mtj.dyndns.org>
 <201305212237.26212.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:46166 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab3EUXf2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 May 2013 19:35:28 -0400
Received: by mail-da0-f52.google.com with SMTP id o9so744692dan.11
        for <linux-ide@vger.kernel.org>; Tue, 21 May 2013 16:35:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201305212237.26212.plr.vincent@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Pelletier <plr.vincent@gmail.com>
Cc: linux-ide@vger.kernel.org, Csaba =?iso-8859-1?Q?Hal=E1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to libata/for-3.11.  Thanks a lot!

>From 966fbe193f47c68e70a80ec9991098e88e7959cb Mon Sep 17 00:00:00 2001
From: Vincent Pelletier <plr.vincent@gmail.com>
Date: Tue, 21 May 2013 22:30:58 +0200

Some device require DMADIR to be enabled, but are not detected as such
by atapi_id_dmadir.  One such example is "Asus Serillel 2"
SATA-host-to-PATA-device bridge: the bridge itself requires DMADIR,
even if the bridged device does not.

As atapi_dmadir module parameter can cause problems with some devices
(as per Tejun Heo's memory), enabling it globally may not be possible
depending on the hardware.

This patch adds atapi_dmadir in the form of a "force" horkage value,
allowing global, per-bus and per-device control.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/kernel-parameters.txt | 2 ++
 drivers/ata/libata-core.c           | 3 ++-
 include/linux/libata.h              | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index c3bfacb..489815e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1456,6 +1456,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 			* dump_id: dump IDENTIFY data.
 
+			* atapi_dmadir: Enable ATAPI DMADIR bridge support
+
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5f7d5f9..c97a244 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2395,7 +2395,7 @@ int ata_dev_configure(struct ata_device *dev)
 			cdb_intr_string = ", CDB intr";
 		}
 
-		if (atapi_dmadir || atapi_id_dmadir(dev->id)) {
+		if (atapi_dmadir || (dev->horkage & ATA_HORKAGE_ATAPI_DMADIR) || atapi_id_dmadir(dev->id)) {
 			dev->flags |= ATA_DFLAG_DMADIR;
 			dma_dir_string = ", DMADIR";
 		}
@@ -6496,6 +6496,7 @@ static int __init ata_parse_force_one(char **cur,
 		{ "nosrst",	.lflags		= ATA_LFLAG_NO_SRST },
 		{ "norst",	.lflags		= ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST },
 		{ "rstonce",	.lflags		= ATA_LFLAG_RST_ONCE },
+		{ "atapi_dmadir", .horkage_on	= ATA_HORKAGE_ATAPI_DMADIR },
 	};
 	char *start = *cur, *p = *cur;
 	char *id, *val, *endp;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 47e0292..c886dc87 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -399,6 +399,7 @@ enum {
 	ATA_HORKAGE_BROKEN_FPDMA_AA	= (1 << 15),	/* skip AA */
 	ATA_HORKAGE_DUMP_ID	= (1 << 16),	/* dump IDENTIFY data */
 	ATA_HORKAGE_MAX_SEC_LBA48 = (1 << 17),	/* Set max sects to 65535 */
+	ATA_HORKAGE_ATAPI_DMADIR = (1 << 18),	/* device requires dmadir */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
1.8.1.4

