Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EA8EB64DA
	for <linux-ide@archiver.kernel.org>; Fri, 30 Jun 2023 19:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjF3T2m (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Jun 2023 15:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjF3T2h (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2023 15:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5BB9
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2023 12:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DCCB617F5
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2023 19:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C774CC433C8;
        Fri, 30 Jun 2023 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688153315;
        bh=ysRJcNUnL6jhThPkCrGBXyxUbL+0nlfsyQZhNo82ZZw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oB5YgG8WbxNlfNqPbq2BpFSgfjSyDa3ZJRIyNIqU2s8Zs7I3b2/oyvN27ml/TKV1J
         +CH1LQ3pKoKYr0Y0jKrQ1FgMnUxaWgo4UPrURHmUNS1dgUj7R23BGdbUeprmvYTKta
         tQWuATu6LUjEdpiwpWJXBRhS1H7qWpfC5SxdQlLDAYgIpS2+l9ph8dD4dZ9Z7qxHHz
         DN5jVJTyYnXVpG/ojb2E7FgQCYZ9qnZ2oG6P4r97HxLtEXTm1IY1E3pNOx5pxlG/SN
         zq2cnHavYqEhZsEOJLXvugyopo6QDOcCws7UAtLcF5a5BLyovpVxwZEeM0WCzjPTqU
         sI0hubO9PZQ1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFBDCC43158;
        Fri, 30 Jun 2023 19:28:35 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627003656.1963466-1-dlemoal@kernel.org>
References: <20230627003656.1963466-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627003656.1963466-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.5-rc1
X-PR-Tracked-Commit-Id: fd3ac6e8049799ca7dbd2738de8e149536e92a5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1546cd4bfda49fd6faad47eb30f4e744e2d79a8f
Message-Id: <168815331571.22437.4858431702778770528.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 19:28:35 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 09:36:56 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1546cd4bfda49fd6faad47eb30f4e744e2d79a8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
