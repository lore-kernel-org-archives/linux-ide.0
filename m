Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB2CC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 21 Oct 2021 05:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C82E60724
	for <linux-ide@archiver.kernel.org>; Thu, 21 Oct 2021 05:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhJUF7p (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Oct 2021 01:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUF7o (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Oct 2021 01:59:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4D8C06161C;
        Wed, 20 Oct 2021 22:57:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id i5so11510288pla.5;
        Wed, 20 Oct 2021 22:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=xyYwIkMCk4rkTN8oiOVXDKTzc5USFAT81u5D/5zT+No=;
        b=KVpo3TXnbOpA6E6xP6EBAUnwirIjDDgMOD9PlvBw6coc8vgs+tZGRkbgtKi8lLWTFe
         mjcyHec1DRhWjLZbnTyrE6rzzjLos9YC2rCmko+kLa7f6pD+EahDCp6C+O7ap4fBxeqT
         cMJQMX6y2KX5esZZ4n4gHJaXR5hYL+lpw+LWFxRhz0YUh1Ie2rsWs98scD9mI83F2HC7
         l+bTa70aodAViLg0uamB0VfV/zJwteaycP4yuKkeoaTQpQTJLZMqA+jYgb6QF6Q+ku6e
         rfSKR52oHGR31P7//HyGDrXtUiJtH6FVqQNSXUmW3/w3o3Q5HhiTPXkrSIwrIRxUccYQ
         BRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xyYwIkMCk4rkTN8oiOVXDKTzc5USFAT81u5D/5zT+No=;
        b=1nFHCWwKW1WlcHNmNv0F5Af8eBLT3zzzTbTU+LohPHQ6t4vrshD8MLtmCmEUC7bDIj
         bbTcFjYwKRV0kDbtXh0VIjuvq1OtPnwfBbOKaA6aDWPNLj1Gh1K4o8t4LUOq/9RBd/6M
         P2QhkLhCz9JcSpLJllzcr7f+qVNVqANfqhTYs3dIEaJMfURu4fiyU9+2gRV5oGd7Jwlt
         YcVpANbOljMUh2+OmX40au321WPVndpgDY4eNGwSLTlMOC0GjGveto5RXeZWrdmr+hF+
         zwXvF1q25160ETXAKD5G+5PEuwUYUZ+dBwjb9jUw8KFgkH1wvxrXb8WtoAX9kUp5aEeB
         siRQ==
X-Gm-Message-State: AOAM533B3PcMwWbVDi/qnDPbDJF0czBjZrZX5nI2FzaBcRcQkEFsp/xl
        JSSlu3inDfbLSCBNxRE7Yg==
X-Google-Smtp-Source: ABdhPJwa2G/X4LJn/gZeJsEtWJxkObI6c7WOZa1Qs4fabxY56XihZLszGOc+3rDboz38/QWfMqxy+A==
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr4291321pjr.15.1634795848845;
        Wed, 20 Oct 2021 22:57:28 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id h14sm782467pfv.182.2021.10.20.22.57.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Oct 2021 22:57:28 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] ata: sata_mv: Fix the return value of the probe function
Date:   Thu, 21 Oct 2021 05:57:16 +0000
Message-Id: <1634795836-1803-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

mv_init_host() propagates the value returned by mv_chip_id() which in turn
gets propagated by mv_pci_init_one() and hits local_pci_probe().

During the process of driver probing, the probe function should return < 0
for failure, otherwise, the kernel will treat value > 0 as success.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/ata/sata_mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 9d86203e1e7a..7461fe078dd1 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3897,7 +3897,7 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 
 	default:
 		dev_err(host->dev, "BUG: invalid board index %u\n", board_idx);
-		return 1;
+		return -ENODEV;
 	}
 
 	hpriv->hp_flags = hp_flags;
-- 
2.17.6

