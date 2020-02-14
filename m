Return-Path: <SRS0=vZIR=4C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A822C3B19F
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 16:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4F224696
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697937;
	bh=4k+ho5QLHJ6mzZIRpRhlRG0+MoYWWWT4SJQzFWXJBPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yDnjxtxJPi5jx7c7mdtOKwT0/J4sXbSZtEQlrrafjmM7+xaC5dc5IJcu2ZJzqqxLu
	 2z8eEGoiImTkVVSKA8hVw79p8b6f7Smg4i+5ZE85EJ6w62Y/we9QvWGpMsunPk0Dzb
	 GOkgyyZ2mH1+nk3ntF3FrJ6PGU6uPH4NnuTSnweY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389756AbgBNQcJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:32:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406255AbgBNQZ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 14 Feb 2020 11:25:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A1C9247CF;
        Fri, 14 Feb 2020 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697557;
        bh=4k+ho5QLHJ6mzZIRpRhlRG0+MoYWWWT4SJQzFWXJBPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsUaz+ya0e7wvbbkYIYyut2z18+PGKDLee6ihdQqqqVn1kZ6MmX7Nk1Lhz0ePYuXw
         zHl+qo3R2c9rGvHhsU8QK40mRLcoIVAyflDABaQMUT5C1S86VGIrH7L7hfD3os/S2G
         WuFu6fP0ebY+0+djHQbV/Lt+bSYpDU/cYjxsRb2I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wang Hai <wanghai38@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 074/100] ide: remove set but not used variable 'hwif'
Date:   Fri, 14 Feb 2020 11:23:58 -0500
Message-Id: <20200214162425.21071-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit 98949a1946d70771789def0c9dbc239497f9f138 ]

Fix the following gcc warning:

drivers/ide/pmac.c: In function pmac_ide_setup_device:
drivers/ide/pmac.c:1027:14: warning: variable hwif set but not used
[-Wunused-but-set-variable]

Fixes: d58b0c39e32f ("powerpc/macio: Rework hotplug media bay support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ide/pmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 0add5bb3cee85..fbfe5761328fc 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1024,7 +1024,6 @@ static int pmac_ide_setup_device(pmac_ide_hwif_t *pmif, struct ide_hw *hw)
 	struct device_node *np = pmif->node;
 	const int *bidp;
 	struct ide_host *host;
-	ide_hwif_t *hwif;
 	struct ide_hw *hws[] = { hw };
 	struct ide_port_info d = pmac_port_info;
 	int rc;
@@ -1080,7 +1079,7 @@ static int pmac_ide_setup_device(pmac_ide_hwif_t *pmif, struct ide_hw *hw)
 		rc = -ENOMEM;
 		goto bail;
 	}
-	hwif = pmif->hwif = host->ports[0];
+	pmif->hwif = host->ports[0];
 
 	if (on_media_bay(pmif)) {
 		/* Fixup bus ID for media bay */
-- 
2.20.1

