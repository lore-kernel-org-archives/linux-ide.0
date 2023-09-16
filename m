Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D19C2BA1A
	for <linux-ide@archiver.kernel.org>; Sat, 16 Sep 2023 19:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjIPTAb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 16 Sep 2023 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbjIPTAV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 16 Sep 2023 15:00:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9795CCF0
        for <linux-ide@vger.kernel.org>; Sat, 16 Sep 2023 12:00:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 529F0C433A9;
        Sat, 16 Sep 2023 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694890816;
        bh=Q2L1efWa9xTfKNy6jFG5otyac4lcaXbSSWsKR+0H6R0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aHQSIly/WTRqSa9J+/tXaUcgv2sWyGKstyH4p2PtLpCDc36bHNJdatpoaSwyRtGyp
         GeMsgAOK5J+3za80kaSQ6lAstO0vWBgrsmoU8x8apOevOsmnP/hI0SsK4HNcTb9Pr+
         E2d6TCMYypk6MhgIEwpPf+2moTQTNFnphpcnT7X7BuhroLxQdv9sqKBCOWh4XecSd/
         ErJ0cQa7uVjxg1Km5C8URJ4r7jvOgglsSpZ98SAEOgCawUXIGVHvR91piMY9G/LRs4
         ILJ1o6QSGo2U/jEJIu4N6KOMOIEjXzga2yhI7OYLt+A/I6Py7jqPYmLi1mb+6ZPq0O
         Y2DtP3G4ygNZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A2FBE26884;
        Sat, 16 Sep 2023 19:00:16 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230916121841.778684-1-dlemoal@kernel.org>
References: <20230916121841.778684-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230916121841.778684-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc2
X-PR-Tracked-Commit-Id: 5e35a9ac3fe3a0d571b899a16ca84253e53dc70c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc3e5afc6a8c5d9d1c30e7612da80ca327e43552
Message-Id: <169489081623.3998.17942451048543763066.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Sep 2023 19:00:16 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sat, 16 Sep 2023 21:18:41 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc3e5afc6a8c5d9d1c30e7612da80ca327e43552

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
