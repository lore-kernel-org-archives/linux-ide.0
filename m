Return-Path: <SRS0=vZIR=4C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58702C3F68F
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 17:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C18206D7
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702908;
	bh=BOAuucgOG9GcK1LGryZaUi2poccOqBLsVdu3ZCwoLF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LW8gszYAWaqPz7YoQllFXEKAyIuMsot8R4olPAhYMkd8yUNi7dYajTq9PwEg/ljwQ
	 Lbvs7TS120EythJjZcMSpQPySBDTaEJCfzSwqiKWhTg3R+ZzlO9pJnb+HSP/VXXdzP
	 emNsaIlT3HySRztPIOh7SQCnS51xjNt4aIGBIWbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbgBNP5u (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:57:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388380AbgBNP5u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 14 Feb 2020 10:57:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAC424654;
        Fri, 14 Feb 2020 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695869;
        bh=BOAuucgOG9GcK1LGryZaUi2poccOqBLsVdu3ZCwoLF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nf8LEZBRCr0v+DS2icleNRKsKSX9iEIGYjj8Q67ZslWc6gE1iCtyFUxj5xVLSFxZW
         f76md5D3VXi8n9WpI0S2U7jlto7Zc7LuR0C9AGJncbnyE0/rsn1Z5FKr7wRjs9Llz7
         J5tFDG+YNjIn2GVy3uGGsvbFEQ4vfbQMijXZQQ78=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 415/542] cmd64x: potential buffer overflow in cmd64x_program_timings()
Date:   Fri, 14 Feb 2020 10:46:47 -0500
Message-Id: <20200214154854.6746-415-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 117fcc3053606d8db5cef8821dca15022ae578bb ]

The "drive->dn" value is a u8 and it is controlled by root only, but
it could be out of bounds here so let's check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ide/cmd64x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
index a1898e11b04e6..943bf944bf722 100644
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -66,6 +66,9 @@ static void cmd64x_program_timings(ide_drive_t *drive, u8 mode)
 	struct ide_timing t;
 	u8 arttim = 0;
 
+	if (drive->dn >= ARRAY_SIZE(drwtim_regs))
+		return;
+
 	ide_timing_compute(drive, mode, &t, T, 0);
 
 	/*
-- 
2.20.1

