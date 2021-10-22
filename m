Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3721DC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 22 Oct 2021 09:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFE261108
	for <linux-ide@archiver.kernel.org>; Fri, 22 Oct 2021 09:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhJVJOy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 22 Oct 2021 05:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhJVJOy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 22 Oct 2021 05:14:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D378C061764;
        Fri, 22 Oct 2021 02:12:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id om14so2469654pjb.5;
        Fri, 22 Oct 2021 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ohjcvLd0YKjbb8x0mOvKlxzmjK7/DHilKibFOlBy1vo=;
        b=MYkLhtF/hXNyzCh2QN4e4kJrIJ+6GT2jJMpmOAAWUhJLgeFV6Pk4wiR//QmtIA1sOl
         l4m8Iwf2LG+BbTtn2ZagfBsOXHSCG7YKQwxLreXa38DFRm8k/uGD/lqVHRaFpqJ8Pcz5
         HAyfbZStSB29859318HXaK06hemKkfj5282M5X0BhA0xZkam4E/Vh1q2YzNbDmSGX9fS
         v9MTM8t0REtKWxXXSDlly5WZLJWpjK3s1rW2Z6dfMdoxpsnLHDrybhDaRQEdatXHTrxP
         kn1g12O3bK5vTQpfI7k1FvoHti9JHF8OSAot5e2URKmqDcSO8+XpnbCPAgCpHH/0S9wY
         QScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ohjcvLd0YKjbb8x0mOvKlxzmjK7/DHilKibFOlBy1vo=;
        b=q8xRwexyktU88Wm+kFuaQIjRCQLUkI2aIc8igrnT7vsRzvyWdBcG/gb/+ZiZsFj7vW
         kSOQuLKzJvJWVbDQV293vS6wVxEb7XmBppn01GNwMSFJAEC9Zzx08pXwXdbWJyYjlyX1
         4G4q25FTLX1ytfUWugxWjKX+x5S1VHQEXQHzWNclP7wcL5UtaRFeEOSdd67v6CbFfvd9
         GWNtvgvEiXIqq1HZ03MDp3R7AKWEvZz06C/M2nAEV/sBaT7trHngn3jjJwgnWvx/rxT+
         BhtEgfwL4FC92S3Je77OlC/c2yjsn65RX7tfPwGBNDl2+kf2GUHp41A6qoiCQ99FWtBW
         dwyg==
X-Gm-Message-State: AOAM532iQ1X02Vm3I0JWN/pCKWQu7+Z9nbLgOjPpAz/ijFeeKDzVxq4o
        kfvS+UmeW+3z/oEHlofzYw==
X-Google-Smtp-Source: ABdhPJyOnb/wGjw6CeI0NgyKkIYcW9CrpNzpQMCMtH/ovnGcsZoJ0Z+RNL+MioQlRlyXegMJruwpsA==
X-Received: by 2002:a17:902:e812:b0:13f:3be8:b15a with SMTP id u18-20020a170902e81200b0013f3be8b15amr9894795plg.49.1634893956569;
        Fri, 22 Oct 2021 02:12:36 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id k127sm9284926pfd.1.2021.10.22.02.12.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Oct 2021 02:12:36 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] ata: sata_mv: Fix the error handling of mv_chip_id()
Date:   Fri, 22 Oct 2021 09:12:26 +0000
Message-Id: <1634893946-16195-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

mv_init_host() propagates the value returned by mv_chip_id() which in turn
gets propagated by mv_pci_init_one() and hits local_pci_probe().

During the process of driver probing, the probe function should return < 0
for failure, otherwise, the kernel will treat value > 0 as success.

Since this is a bug rather than a recoverable runtime error we should
use dev_alert() instead of dev_err().

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Change the error code
    - Change the logging function
---
 drivers/ata/sata_mv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 9d86203e1e7a..c53633d47bfb 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3896,8 +3896,8 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 		break;
 
 	default:
-		dev_err(host->dev, "BUG: invalid board index %u\n", board_idx);
-		return 1;
+		dev_alert(host->dev, "BUG: invalid board index %u\n", board_idx);
+		return -EINVAL;
 	}
 
 	hpriv->hp_flags = hp_flags;
-- 
2.17.6

