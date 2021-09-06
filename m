Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177A1C43217
	for <linux-ide@archiver.kernel.org>; Mon,  6 Sep 2021 01:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32C660F45
	for <linux-ide@archiver.kernel.org>; Mon,  6 Sep 2021 01:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbhIFB15 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Sep 2021 21:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240488AbhIFBZk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 5 Sep 2021 21:25:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CD9761106;
        Mon,  6 Sep 2021 01:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891345;
        bh=E7xl6sl5aXICv+yvtADSMdwGsKCvfw4DCGPr4TIpfMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyIsmEZCA+0eWeV8C2pRx/OS4C26jjaVR0r3GrzXXg7MoFxZwF7jbN0lPKk24IUji
         WarlFifdmssB4digpjhnwZKmyaPKI+VkRdlg6WVb2Gs4ft1KQHdZPi7d5qyFOE8vRf
         5cf7ZtoyrsETR8jS6qOTio6S8syc30ttew9xLURDmidLFNHD16kXScN3x8TPgXjI7h
         7ri4CwqWZQ/6GZQHCElhsjPZGSX5Jgqw2SsBdX5qKM+UtxQt9j5TnuhaaRIUe5uuTJ
         agLvkd/bTKb3Emr4kVwZYHwp6aF35x7av2pced04fLkKYu8xvOjhc2wy2mbnls5w/d
         eMiOFV8FP8XSg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 26/39] libata: fix ata_host_start()
Date:   Sun,  5 Sep 2021 21:21:40 -0400
Message-Id: <20210906012153.929962-26-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012153.929962-1-sashal@kernel.org>
References: <20210906012153.929962-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

[ Upstream commit 355a8031dc174450ccad2a61c513ad7222d87a97 ]

The loop on entry of ata_host_start() may not initialize host->ops to a
non NULL value. The test on the host_stop field of host->ops must then
be preceded by a check that host->ops is not NULL.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20210816014456.2191776-3-damien.lemoal@wdc.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 61c762961ca8..44f434acfce0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5573,7 +5573,7 @@ int ata_host_start(struct ata_host *host)
 			have_stop = 1;
 	}
 
-	if (host->ops->host_stop)
+	if (host->ops && host->ops->host_stop)
 		have_stop = 1;
 
 	if (have_stop) {
-- 
2.30.2

