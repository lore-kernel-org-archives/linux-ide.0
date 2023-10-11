Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D79CDB47E
	for <linux-ide@archiver.kernel.org>; Wed, 11 Oct 2023 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjJKU6j (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 Oct 2023 16:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjJKU6i (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 Oct 2023 16:58:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B709D91
        for <linux-ide@vger.kernel.org>; Wed, 11 Oct 2023 13:58:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 640CCC433C7;
        Wed, 11 Oct 2023 20:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697057917;
        bh=zJf/zLfxKDJckx7J3aIdVeHEW15WNHVs0XQuVOUel+k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t5u6kyOwbQ+fX6yxQxJ0Gon8WseRe6dAZttOAdK6VDPfuIuwtfxEp7Ao6JYh1zK1y
         GANjOR8vYp3LzoyvRiTkCcFm8YwBlUf42NlHE4dAB9xWKsXH1Xj6VhTjFQm9ZowbP+
         yfResEg9RvXwaDe4VvgHqr3jP1zxfUr6ixl7ItxXAMOa57GlxTv0Y38K2L32XRYt0W
         vpspVZKoYWmeEj9Mslb/4Blqq+zatRPUh5tjIehbmskPd54/9jjYCdTBs0e/Ire6xH
         fz35/OsdTrhxLKipV+McmNroxtWeBYV6sInBJK2QZOWRfpw6ovDJi9KVfD3Qd7mnVh
         RO2YYRTVMVfmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 469D2C595C4;
        Wed, 11 Oct 2023 20:58:37 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231011084942.22372-1-dlemoal@kernel.org>
References: <20231011084942.22372-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231011084942.22372-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc6
X-PR-Tracked-Commit-Id: 626b13f015e080e434b1dee9a0c116ddbf4fb695
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8182d7a3f1b8982c0136dca82a846ea375a4d6e9
Message-Id: <169705791728.2785.183758018597609314.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Oct 2023 20:58:37 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Wed, 11 Oct 2023 17:49:42 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8182d7a3f1b8982c0136dca82a846ea375a4d6e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
