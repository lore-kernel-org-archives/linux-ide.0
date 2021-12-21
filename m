Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC936C433FE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhLUHXB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52676 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbhLUHWp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7753E2190B;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uP+gXpC5HaVClJlCuWXZCHsRhw3uxwrQFS4qVkZYYzE=;
        b=LgGtccmZD33l1Hb6iFVZUX0b0j22PYa4Uziz72HvVVKCYZH1kwVzAG9m+dz4fuWNHxPo/7
        h/rvJ3R5LPr95sXbnJqXQBI2fbXtlirNu7odFCagl0hAwTyqIcVXAt1rotHYWP/JpKvHkt
        XBpJWAhj9XHXHrUZnZG8zCPf8jnWcTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uP+gXpC5HaVClJlCuWXZCHsRhw3uxwrQFS4qVkZYYzE=;
        b=j4opaEyHzgN/IgHIItjTN4i/+UCSGaggem6DyEADpvw6S5rbTCDyU+kwN8nxtLL3sGj0oL
        zJy0613C5AUHGNDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 72C2AA3BB0;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 70A6951923CE; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 46/68] libata: remove debug compilation switches
Date:   Tue, 21 Dec 2021 08:21:09 +0100
Message-Id: <20211221072131.46673-47-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Unused now, so remove and drop any references to them.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-sff.c  |  1 -
 drivers/ata/pata_ep93xx.c |  1 -
 drivers/ata/sata_rcar.c   |  1 -
 include/linux/libata.h    | 16 ----------------
 4 files changed, 19 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 01f1673f3297..75217828dfe3 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2091,7 +2091,6 @@ void ata_sff_drain_fifo(struct ata_queued_cmd *qc)
 						&& count < 65536; count += 2)
 		ioread16(ap->ioaddr.data_addr);
 
-	/* Can become DEBUG later */
 	if (count)
 		ata_port_dbg(ap, "drained %d bytes to clear DRQ\n", count);
 
diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 46208ececbb6..b78f71c70f27 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -855,7 +855,6 @@ static void ep93xx_pata_drain_fifo(struct ata_queued_cmd *qc)
 		     && count < 65536; count += 2)
 		ep93xx_pata_read_reg(drv_data, IDECTRL_ADDR_DATA);
 
-	/* Can become DEBUG later */
 	if (count)
 		ata_port_dbg(ap, "drained %d bytes to clear DRQ.\n", count);
 
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 91b39a6aa9f7..3d96b6faa3f0 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -479,7 +479,6 @@ static void sata_rcar_drain_fifo(struct ata_queued_cmd *qc)
 			count < 65536; count += 2)
 		ioread32(ap->ioaddr.data_addr);
 
-	/* Can become DEBUG later */
 	if (count)
 		ata_port_dbg(ap, "drained %d bytes to clear DRQ\n", count);
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6bfbb419e141..ea3478d02cf5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -39,25 +39,9 @@
  * compile-time options: to be removed as soon as all the drivers are
  * converted to the new debugging mechanism
  */
-#undef ATA_DEBUG		/* debugging output */
-#undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
-#undef ATA_NDEBUG		/* define to disable quick runtime checks */
 
 
-/* note: prints function name for you */
-#ifdef ATA_DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#ifdef ATA_VERBOSE_DEBUG
-#define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define VPRINTK(fmt, args...)
-#endif	/* ATA_VERBOSE_DEBUG */
-#else
-#define DPRINTK(fmt, args...)
-#define VPRINTK(fmt, args...)
-#endif	/* ATA_DEBUG */
-
 #define ata_print_version_once(dev, version)			\
 ({								\
 	static bool __print_once;				\
-- 
2.29.2

