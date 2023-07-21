Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A4EB64DD
	for <linux-ide@archiver.kernel.org>; Fri, 21 Jul 2023 03:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGUDkm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Jul 2023 23:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjGUDkb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Jul 2023 23:40:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D22733
        for <linux-ide@vger.kernel.org>; Thu, 20 Jul 2023 20:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19C6D60C88
        for <linux-ide@vger.kernel.org>; Fri, 21 Jul 2023 03:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A94BC433C7;
        Fri, 21 Jul 2023 03:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689910829;
        bh=ZCWkex18pHNJa6Wz8SSjap1TopFJA3OT2SMic8YuQA4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a2vEN1ATf3slmIQSp6F9BrCW6p8Cj73Gl/svvwKB1VsGLFBkhWl6aoo7FpmhnnDZ/
         +cNCrh9S8eBeXjjkrqdnEsXU77BR8w5i6eIpMClpmyzj920jlGD+PhAqeRiBXQLuFx
         WU75LMIJ93AM4Xf6mYXt6fURNpF4P2DBexidWV9V8VMcyFjDZ/QqPvP9qJ+IhJLTUe
         LTe8hv9caa0rK/6f63vA9OjviaUxEp1DFX5iBZ4H1t5jDHSQK2xU6uThWNS5ZewrGv
         ysL5gMVJJUUtphtzZ7uKM4jgtc0YmC7RVOwf7PQnXO9rngUKi4emfvzbGb7bhAXBZU
         PebHNKVdQs1yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F8D0C595C5;
        Fri, 21 Jul 2023 03:40:29 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230721013954.37605-1-dlemoal@kernel.org>
References: <20230721013954.37605-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230721013954.37605-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.5-rc3
X-PR-Tracked-Commit-Id: cec148c2476a6e06cf8190b20de81f98983b53ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12a5088eb138fbf14eaa0eea5fe6061c4341401c
Message-Id: <168991082938.19113.9033756876357395008.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jul 2023 03:40:29 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 21 Jul 2023 10:39:54 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12a5088eb138fbf14eaa0eea5fe6061c4341401c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
