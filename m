Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A40C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 24 Jun 2022 18:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiFXSoO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 24 Jun 2022 14:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiFXSoL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Jun 2022 14:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930137FD15
        for <linux-ide@vger.kernel.org>; Fri, 24 Jun 2022 11:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BF95620BC
        for <linux-ide@vger.kernel.org>; Fri, 24 Jun 2022 18:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2797C34114;
        Fri, 24 Jun 2022 18:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656096248;
        bh=5NY+QMWKuUThmMsHNV2V2ad0OmZmbfizJPcCVbi8fR8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tlR38TiG2XgcwAUfgXtGFbK5BpIaKB9ym4ydmgkLaQAcPhxCdTfddShU9GGWpXAri
         6neCkD3e2t/b0neXU4TPO6Ve5efzmT+Yq0BhLPxEWagi0rLRSMsJFgud65Ajw4Hjat
         WaASqPZn11Swa0SNaWVmuUsMeg4/Mr1opVo7Xr9YZyXJdb8rgLNlmi8bgmf+y6upBk
         WGcq2D58oIrplXKJ/ja9k1No92KUHf5xBl6qRgscklaVAHiXY61CCgCXeJ0QKz1PRY
         RZsceqQQ1HRYU9ci91OaEAIln5uv4b3B+G1LtaI+wOKwaXrv6qtGp40Y9uF/kdE4OD
         JcGPrMR9S+PBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEFB1E737F0;
        Fri, 24 Jun 2022 18:44:08 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220624021320.3081-1-damien.lemoal@opensource.wdc.com>
References: <20220624021320.3081-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220624021320.3081-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.19-rc4
X-PR-Tracked-Commit-Id: 540a92bfe6dab7310b9df2e488ba247d784d0163
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43627618a0dff4d7b2d743c2b57e0130f3fa6a7e
Message-Id: <165609624877.26462.14814012046967632972.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 18:44:08 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 11:13:20 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43627618a0dff4d7b2d743c2b57e0130f3fa6a7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
