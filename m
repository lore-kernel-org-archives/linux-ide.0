Return-Path: <SRS0=z20e=XV=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB9CC4360C
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 13:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F27222BE
	for <linux-ide@archiver.kernel.org>; Thu, 26 Sep 2019 13:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ/dHKIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfIZNNz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Sep 2019 09:13:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32948 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfIZNNz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Sep 2019 09:13:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id c4so1981040edl.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Sep 2019 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lz4TRWveE5+/FGsJV69NxXS9wfVhyyWmL8RgqyHbeII=;
        b=UQ/dHKIaF26wc59j0bI+Q/MPD87UCFtbgaOAixr8XWJF2QsD+0qZDCbBprJ0Hl6SGW
         2qdkOjx3VCt3P4WPaex3k6jHbkj/Nk8RFrnaD2iSsJWqRsc1fEPcpQhHo4nxHeqxU8fe
         lrKAcdCJANdk/TnFwRp4q+T1FRK2kYe7hFZG1NAgN5iKbHkdc3KF+lrIIfY/A35ur7Oz
         LzhSWws8THLfD3zsFCW6lAnblEt9TC6j+06fVfQ82f7DD6AtC0k9JaDzCMI4WfwtcITg
         edryvwUfym8U/NHO5Q9tPdxQ19dWbDwRfR2j3od1Ha66MZ/SLsLYfBVY1p1nAeBXyBG4
         Jmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lz4TRWveE5+/FGsJV69NxXS9wfVhyyWmL8RgqyHbeII=;
        b=AFEojFxU6um8bCs3CukVEtSjRxaGocwmgJt09hrdbJTs9racpdF+mcCOALbBBKphe9
         lA1rLEfrPnfLf4WOzGqiut10QLIss37jS9iph2LZQsVS033JIVTugCZdppahLMKFsELh
         K9qXDjHYFhad0NJIwPqE4QzHL2z5NvPdkqCsqVdalgm+5rdn6jVFKIDdCr9LDmYzybSM
         AYKCdmd0Ub5hcFGD5qRtDa8RAZfS019wXsKHBmnP4p3AvatBj2Tw/c49S+W7X0yb/Noa
         BhsRyp0EBPu4Sygo+HXJnMCP9nnNZ4WjODwd1S1w3kLNdsAoYTvVoxtxIrLEbZrdUNLC
         KkEw==
X-Gm-Message-State: APjAAAVCgVZyl2UnTnap63aaEQT4nPRNluI7ICTPXcIvNFbrT1lbWLvg
        ISgZaQrbF0GsJevWsa4tTbDJYDpm
X-Google-Smtp-Source: APXvYqxiFfjEfxiPGs5HFLSl2UsDhFDH1V1vGNJnG8cRb3YorWdC9xNXpps2F3kpu3oozJeflrBx0w==
X-Received: by 2002:a17:906:ce46:: with SMTP id se6mr3050509ejb.198.1569503633609;
        Thu, 26 Sep 2019 06:13:53 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:2141:7472:3ae9:5a75])
        by smtp.gmail.com with ESMTPSA id u27sm474864edb.48.2019.09.26.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 06:13:52 -0700 (PDT)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     davem@davemloft.net
Cc:     linux-ide@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] ide: remove unnecessary touch_softlockup_watchdog
Date:   Thu, 26 Sep 2019 15:13:44 +0200
Message-Id: <20190926131344.12709-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Call touch_softlockup_watchdog before touch_nmi_watchdog is not needed,
since touch_softlockup_watchdog is called inside touch_nmi_watchdog.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/ide/ide-iops.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index d1445d74e9c3..f2be127ee96e 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -530,7 +530,6 @@ int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
 		 */
 		if (stat == 0xff)
 			return -ENODEV;
-		touch_softlockup_watchdog();
 		touch_nmi_watchdog();
 	}
 	return -EBUSY;
-- 
2.17.1

