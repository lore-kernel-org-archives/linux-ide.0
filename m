Return-Path: <SRS0=vZIR=4C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D767C3B19F
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA6224684
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699020;
	bh=fwizeftwlR9izkeLredXixUH0zyGGLB15OEPZL7soIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AlQWKpAg52dqtH/3HeUbqyECEEhGsA3Zjz4lhFsiGrRZGT65V/ZD4BIm2a9afPKEo
	 j80vGlQV/X2JkvCwFRxOnKhJODGtU7OCyLgn1SvKVTG1cDFDT2qZccu1vLr3v2+Rl4
	 9l+5zEMDUCido7QxMaCRWn0b5rWIdsh5ii22OYJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394184AbgBNQuT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405171AbgBNQUQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 14 Feb 2020 11:20:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D4924717;
        Fri, 14 Feb 2020 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697216;
        bh=fwizeftwlR9izkeLredXixUH0zyGGLB15OEPZL7soIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ec3dFwerOmwiCnCHfbVV4NSXqJG0FK3Uj4pZiAgPycUGZrGb0tElrSLiDpkZsgK0
         O/BQhWYsJiXR9O9wHhU6P/XE4k1MVkiCw9fAtMlSSten+RVwvZjuIoTzpaFlPw767v
         I0Wu0DWf3CRuo69XvFZdKQunbjLQE3hy4X68D9sg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wang Hai <wanghai38@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 140/186] ide: remove set but not used variable 'hwif'
Date:   Fri, 14 Feb 2020 11:16:29 -0500
Message-Id: <20200214161715.18113-140-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
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
index 203ed4adc04ae..7db083ec5ee06 100644
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

