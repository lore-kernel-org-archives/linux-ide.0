Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E91DC4332F
	for <linux-ide@archiver.kernel.org>; Tue, 18 Jan 2022 08:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbiARI3R (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 Jan 2022 03:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344352AbiARI3P (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2022 03:29:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEEBC06161C
        for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2022 00:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F17BB810CE
        for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2022 08:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37AD0C340E1;
        Tue, 18 Jan 2022 08:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642494553;
        bh=UwPZT/QSSCqWgODdyZok7LfBSZp4UbI+w+/D3Fm7O2g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QAyrxMeAZN7d82TyYZ0IcfhMHQy7zGVNPnSifqrll4pvf2+n0f7DW6AXrbgEYyKeJ
         KcjFTiFuUFJZ7Lq73OwxslZfuvl2HazRGJRHRCgcwp9QcnLOnviGSlesVC2/hVKHqd
         PQf7GK/cgNMhi3Kv8BIC+toY9mO1hAmhbxstxTUkJHgL5OqmazUd8THkU/Z6/2Jini
         MrpOTeT/s8DZVo9dWD2tcNnW6m/uaAVz3P3N8ghlea5RA2iVMj22t/cB/Q+cxs3Zx9
         J85SHVHl7faiOcM0wjpthLU7NZXEmjOx32gDQ3HFqPMQtIxBfDloacjsGyhS43fnBa
         ovbY6w/E0fC/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25CAFF60794;
        Tue, 18 Jan 2022 08:29:13 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220114065906.622181-1-damien.lemoal@opensource.wdc.com>
References: <20220114065906.622181-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220114065906.622181-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc1
X-PR-Tracked-Commit-Id: 237fe8885a3fdab169bf670790c9f40046af45d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe81ba137ebcc7f236780996a0b375732c07e85c
Message-Id: <164249455315.3500.12273047095389786673.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jan 2022 08:29:13 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 15:59:06 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe81ba137ebcc7f236780996a0b375732c07e85c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
