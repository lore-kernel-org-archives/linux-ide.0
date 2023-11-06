Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2C3C4332F
	for <linux-ide@archiver.kernel.org>; Mon,  6 Nov 2023 04:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjKFERE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Nov 2023 23:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFERD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Nov 2023 23:17:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F881BF
        for <linux-ide@vger.kernel.org>; Sun,  5 Nov 2023 20:17:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62368C433C7
        for <linux-ide@vger.kernel.org>; Mon,  6 Nov 2023 04:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699244220;
        bh=BcQYe/H+wZ1ap9ah9bqAsNwHD5JpKesfaoHJH4hWnss=;
        h=From:To:Subject:Date:From;
        b=K/DabkR9G71FGx7Q1ELCv1XpX/aTmXa4YSKCLWS3KBwzG4JUwOFceKfMoCprtiMdw
         o6QCM3eVq+aOMh28HuHpcx0DSGqf8SjI8djygJjM0jCt8XzJnJFfmNYEnWgxnAOJYs
         pU+lIExfQ95chrgkTZ0u20K+cIivd7GxNphC5Wv0nnTWEKK8Wm5YIeUxlwgxZC+uHk
         0rEbIv9HhUS0Ra0SgUw0wPSaPaiXb4/C3779BYgFuzqvLXy/sB36OThnsxNO40+eO/
         PRSuki4vMCdRbsBPXAbMKPXYyjOwihR+U1BRc84D2VPhoD7O7RZh7PNnLJPZ3zrm+N
         xypOK/zuRPn3A==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Fix ata_pci_shutdown_one()
Date:   Mon,  6 Nov 2023 13:16:58 +0900
Message-ID: <20231106041658.85522-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Commit 5b6fba546da2 ("ata: libata-core: Detach a port devices on
shutdown") modified the function ata_pci_shutdown_one() to stop
(suspend) devices attached to the ports of a PCI AHCI adapter to ensure
that drives are spun down before shutting down a system. However, this
is done only for PCI adapters and not for other types of adapters. This
limitation was addressed with commit 24eca2dce0f8 ("scsi: sd: Introduce
manage_shutdown device flag"). With this, all ATA disks are spun down on
system shutdown.

This reverts commit 5b6fba546da2 as the change introduced is now
useless.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6fb4e8dc8c3c..09ed67772fae 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6180,24 +6180,10 @@ EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 void ata_pci_shutdown_one(struct pci_dev *pdev)
 {
 	struct ata_host *host = pci_get_drvdata(pdev);
-	struct ata_port *ap;
-	unsigned long flags;
 	int i;
 
-	/* Tell EH to disable all devices */
-	for (i = 0; i < host->n_ports; i++) {
-		ap = host->ports[i];
-		spin_lock_irqsave(ap->lock, flags);
-		ap->pflags |= ATA_PFLAG_UNLOADING;
-		ata_port_schedule_eh(ap);
-		spin_unlock_irqrestore(ap->lock, flags);
-	}
-
 	for (i = 0; i < host->n_ports; i++) {
-		ap = host->ports[i];
-
-		/* Wait for EH to complete before freezing the port */
-		ata_port_wait_eh(ap);
+		struct ata_port *ap = host->ports[i];
 
 		ap->pflags |= ATA_PFLAG_FROZEN;
 
-- 
2.41.0

