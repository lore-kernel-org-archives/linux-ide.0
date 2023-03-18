Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B7C74A5B
	for <linux-ide@archiver.kernel.org>; Sat, 18 Mar 2023 19:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCRTBj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 18 Mar 2023 15:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCRTBi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 18 Mar 2023 15:01:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEF32BF22
        for <linux-ide@vger.kernel.org>; Sat, 18 Mar 2023 12:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88994B806A1
        for <linux-ide@vger.kernel.org>; Sat, 18 Mar 2023 19:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CA63C4339C;
        Sat, 18 Mar 2023 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679166095;
        bh=4rkCRkZ5DxhZgNuG0osQFk/gsh2YZbc2XTJndT7hG2Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jSddt1KdNqRjiFgi/KLxKMa0fHzNCKUJwcdqdxjx3y9Y59M1xPUYl4ODr4ozMbRBL
         FPrWm5GNp6vcElSjF9ztFOYH15TNitBZHe5UdWSRmoxHuhh7GmKuVfjBCoVBUq8wAT
         9fvc+xOb1UPe2JME1WmluzKHSuw0PP1spKNiYbKavxRAFpsYAM8y73Vr1BxRd/Ls7m
         65RCC2oSM7BB6/8mYHediyzT0p+IRA6o12iC3axIrqzrAF4viCwuQuItCoDjCM/9Wr
         hXj2uCnlxLZbRE/b3cHTqLKbTKGRLpJgiG5T6MYsnJLrOeoMVgzNx5XEpk31TdUFOB
         Nt9gGjrlUUp9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BEC5C41671;
        Sat, 18 Mar 2023 19:01:35 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230317225334.30582-1-damien.lemoal@opensource.wdc.com>
References: <20230317225334.30582-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230317225334.30582-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.3-rc3
X-PR-Tracked-Commit-Id: 5bc9e2d43f86105a95f86fa096fb4e517bb0ce73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f900bffe2dac7eca800406b152da5acd05e92129
Message-Id: <167916609524.11643.17148485545078154674.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Mar 2023 19:01:35 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sat, 18 Mar 2023 07:53:34 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f900bffe2dac7eca800406b152da5acd05e92129

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
