Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEDBC00140
	for <linux-ide@archiver.kernel.org>; Sun, 31 Jul 2022 20:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiGaUtx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 31 Jul 2022 16:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaUtw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 31 Jul 2022 16:49:52 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4391260A
        for <linux-ide@vger.kernel.org>; Sun, 31 Jul 2022 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
        Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Content-Disposition:In-Reply-To:References;
        bh=KvM/I72uOywfxOr+6ZI3QPklzbd+YKdsDcghg4Jto+w=; b=SzvRngKe55xl36J8iOwORrMC9t
        1U5kfTur6t3o8yYC6k2qVEUEW/iJ/g8RT2ELOm47ucKQq76G8kG9OnDffGgA6ticR3V+CIHztxtUz
        EFBhu1+VJZriAJRyiTACZAui0Q0sq2joUFOVBypg6f15qmJdJxA+/S7DpIbxNHbjCR58=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oIFsY-00C6eC-Og; Sun, 31 Jul 2022 22:49:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] ata: sata_mv: Fixes expected number of resources now IRQs are gone
Date:   Sun, 31 Jul 2022 22:49:06 +0200
Message-Id: <20220731204906.2885445-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The commit a1a2b7125e10 ("of/platform: Drop static setup of IRQ
resource from DT core") stopped IRQ resources being available as
platform resources. This broke the sanity check for the expected
number of resources in the Marvell SATA driver which expected two
resources, the IO memory and the interrupt.

Change the sanity check to only expect the IO memory.

Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---

v5.19-rc8 is broken. I guess there will not be a -rc9, so please could you
queue this up for 5.19.1.

drivers/ata/sata_mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index de5bd02cad44..e3cff01201b8 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4057,7 +4057,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 	/*
 	 * Simple resource validation ..
 	 */
-	if (unlikely(pdev->num_resources != 2)) {
+	if (unlikely(pdev->num_resources != 1)) {
 		dev_err(&pdev->dev, "invalid number of resources\n");
 		return -EINVAL;
 	}
-- 
2.36.1

