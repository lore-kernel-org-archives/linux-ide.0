Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2752C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbhLJHdA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34972 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbhLJHcz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A651B21112;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/QiUpmNfk4Ym5cyM+gFLcpfSPQCZdbtS+RLFput2/o=;
        b=zRjhDkwgzlKCOBJvMA537fjGucRcKXAIHFkrMl9QQoN1KnmpBpwqyWAXVDZJfTPRbmlCnI
        zLbv9LnziN4GmRi90DyiSKlLXzlkdGniEUAg0P2/vgnM4ABASCn2uhUSh3/zSvhFA2/2CG
        7R89/6r00cBIIj5UlDaukX6BqyGF8TI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/QiUpmNfk4Ym5cyM+gFLcpfSPQCZdbtS+RLFput2/o=;
        b=B5hvGSNcdgKcG8W4C3hn9/En5yKaIRZjVrkPZPR55pe9NhB2ZT4EypNaJwrSlo1N9M/hP0
        lbq5sfsoHUAN1mDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9D23AA3BA6;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 95EA3519203F; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/68] sata_mv: kill 'port' argument in mv_dump_all_regs()
Date:   Fri, 10 Dec 2021 08:28:12 +0100
Message-Id: <20211210072905.15666-16-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Always '-1', so drop it and simplify the function.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_mv.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index cae4c1eab102..c5b3d45a7c39 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1280,24 +1280,17 @@ static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
 #endif
 }
 #endif
-static void mv_dump_all_regs(void __iomem *mmio_base, int port,
+static void mv_dump_all_regs(void __iomem *mmio_base,
 			     struct pci_dev *pdev)
 {
 #ifdef ATA_DEBUG
-	void __iomem *hc_base = mv_hc_base(mmio_base,
-					   port >> MV_PORT_HC_SHIFT);
+	void __iomem *hc_base;
 	void __iomem *port_base;
 	int start_port, num_ports, p, start_hc, num_hcs, hc;
 
-	if (0 > port) {
-		start_hc = start_port = 0;
-		num_ports = 8;		/* shld be benign for 4 port devs */
-		num_hcs = 2;
-	} else {
-		start_hc = port >> MV_PORT_HC_SHIFT;
-		start_port = port;
-		num_ports = num_hcs = 1;
-	}
+	start_hc = start_port = 0;
+	num_ports = 8;		/* should be benign for 4 port devs */
+	num_hcs = 2;
 	DPRINTK("All registers for port(s) %u-%u:\n", start_port,
 		num_ports > 1 ? num_ports - 1 : start_port);
 
@@ -2963,7 +2956,7 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
 	dev_err(host->dev, "PCI ERROR; PCI IRQ cause=0x%08x\n", err_cause);
 
 	DPRINTK("All regs @ PCI error\n");
-	mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
+	mv_dump_all_regs(mmio, to_pci_dev(host->dev));
 
 	writelfl(0, mmio + hpriv->irq_cause_offset);
 
-- 
2.29.2

