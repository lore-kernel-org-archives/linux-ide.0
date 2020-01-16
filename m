Return-Path: <SRS0=KJEs=3F=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19E0C33CAF
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jan 2020 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B94B214AF
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jan 2020 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197888;
	bh=KPGjdXEAIWa/tzOeY7sU6vy4h8YTgu68F93lD1zPqnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rsnyf4GtKD89khMCI5+4eKtBt/li71t7Tb/38j0DysQJGyDk9l28CSP2l0LqCa1OV
	 RWU8WOVKIOtKNAO8rvvaLt6Cx/bocU4jjl93/3L7BkXgEtaG1/Hq4PesFc7BoA55US
	 RIahAv8RfXOK8UGMbkggxCdFZCnZqtBSRs4/DZ84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406845AbgAPSEq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:04:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389695AbgAPRkS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 16 Jan 2020 12:40:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B4824731;
        Thu, 16 Jan 2020 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196417;
        bh=KPGjdXEAIWa/tzOeY7sU6vy4h8YTgu68F93lD1zPqnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2GBzKJlOTmSBVYCXrDR4o/bt1fCYTf+oAQAvQTgAlccl2TrPw2ZrvncmcdGFoORI
         ZZ3rrYQRHTkXV+0pnu8jjs6WB7kDlvEKxKJv/+ajkd4G4AfveZjV3flauSewqd7+e2
         WE7mlb7TKc/RmN5ovMu6udSPxGZkYprGZ9sVlkIo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 188/251] ahci: Do not export local variable ahci_em_messages
Date:   Thu, 16 Jan 2020 12:35:37 -0500
Message-Id: <20200116173641.22137-148-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 60fc35f327e0a9e60b955c0f3c3ed623608d1baa ]

The commit ed08d40cdec4
  ("ahci: Changing two module params with static and __read_mostly")
moved ahci_em_messages to be static while missing the fact of exporting it.

WARNING: "ahci_em_messages" [vmlinux] is a static EXPORT_SYMBOL_GPL

Drop export for the local variable ahci_em_messages.

Fixes: ed08d40cdec4 ("ahci: Changing two module params with static and __read_mostly")
Cc: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libahci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index f233ce60a678..1610fff19bb3 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -190,7 +190,6 @@ struct ata_port_operations ahci_pmp_retry_srst_ops = {
 EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
 
 static bool ahci_em_messages __read_mostly = true;
-EXPORT_SYMBOL_GPL(ahci_em_messages);
 module_param(ahci_em_messages, bool, 0444);
 /* add other LED protocol types when they become supported */
 MODULE_PARM_DESC(ahci_em_messages,
-- 
2.20.1

