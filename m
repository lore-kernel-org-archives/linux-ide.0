Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E44C4321E
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbhLJHd1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34986 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbhLJHdG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:06 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B542212BA;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZcimAdZLh9Okqvvu4NAaObQdmU/a7tc5nQpq+b2WT8=;
        b=Oqi5I5nYe8uIek9WJI0M7wXfByTaxKRF6nAa4yqwNS7vikUVjlH9EuHAJiyhnv3QELVX3P
        KKr0hVKJesLvchm4TbzlUMouFWUniPUdfKD1YMcDPIcRuFuhlzW4jnAC/SR9EdMZijo2O1
        M+qWDpLP3NGNQ2SODxZhpKhffWyCra0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZcimAdZLh9Okqvvu4NAaObQdmU/a7tc5nQpq+b2WT8=;
        b=AeZB7vru64wPpNFILC14CE7u/W1WFKimV+WFAco6mEEClXMYftyjoqRMILlKuxxt04KqWh
        xUeRO2m+CNIf/GCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 16CA7A3BC3;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 13CDC519207D; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 46/68] libata: remove debug compilation switches
Date:   Fri, 10 Dec 2021 08:28:43 +0100
Message-Id: <20211210072905.15666-47-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Unused now, so remove them and any reference to it.

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

