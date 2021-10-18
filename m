Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F8C433FE
	for <linux-ide@archiver.kernel.org>; Mon, 18 Oct 2021 06:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24BED60FDC
	for <linux-ide@archiver.kernel.org>; Mon, 18 Oct 2021 06:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhJRGEl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 18 Oct 2021 02:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230153AbhJRGEk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 18 Oct 2021 02:04:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6A70460FDA;
        Mon, 18 Oct 2021 06:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634536949;
        bh=J6swmJ7YPd3bM9vtiDOZKrt2pAZqPFEOTrDCV2TqEZ0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iLOqdv8sGpiszhKA8lrx/KMD65SjqfZtAECg2Aq9FnC0fqWjivROci2x3ttt1x/tC
         /1Q1QXeRhv6R9jiZeAUfi2UIYs7TWRdX4GOtv6AcE+UErPvhrS/vsS6Bcn0ilsjguf
         aMOi30DDD/mdK5+Em3WjO9b1z0YIzOEPgUbIuJDe6IXjtHsjOWXzC3Dg9XL0DupIj9
         0clQAVzQJ9pNUNUEnFg46jciOtxD+o0ctlVoF88/v/U64K6UeUFUUe6qb7rST2Il7d
         1WGJ94X/lSU96gKaU+KDCG8+LZ8NvwvOqwOX9VtCjFDr55x9HQNVJtOIMvyxhJhohA
         M37O2etiXnPdA==
Subject: Re: [GIT PULL] libata fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211018015418.11674-1-damien.lemoal@opensource.wdc.com>
References: <20211018015418.11674-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211018015418.11674-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.15-rc6
X-PR-Tracked-Commit-Id: 776c75010803849c1cc4f11031a2b3960ab05202
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd079b1f870729a9fe3294f800dff18b548f129d
Message-Id: <163453694940.9773.9193666033234877424.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 06:02:29 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Mon, 18 Oct 2021 10:54:18 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd079b1f870729a9fe3294f800dff18b548f129d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
