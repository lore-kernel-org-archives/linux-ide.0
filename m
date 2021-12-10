Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4DEC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 19:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbhLJUCW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 15:02:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56698 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhLJUCV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 15:02:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A548B829D7
        for <linux-ide@vger.kernel.org>; Fri, 10 Dec 2021 19:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E134C00446;
        Fri, 10 Dec 2021 19:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639166324;
        bh=eZwuFSRNp5H1E0ggCgk/gElO0hMlb2ABxRhjNGO2u2s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fEf17QJfS8zhqYosGC/sRj38FQlzEKs0/DeLodYec1w5zJHTgVNxGflzCQgDSXEt1
         pFqkWISjPgMXdGrbQNrH2acjfDCOAa3ToDmVrkdhw5b687nB94cDh7vqzkoLKM2CDQ
         ozbHaZA79W4ugI9O23xf1vNZJKWmT/qT2tOAwPrtG32CuE2qqbdlW5GaufoVDL70hm
         vdrh94h7GqojX239+weovcP5pdMX+TEtSc/BvyP9GnqTP3wv1Ed10wOPnPHpPSHQ2V
         EZx+SHZCHjWcP5hMFI5hh4nRPO4eZTeOQGPoWX3Wqi4sKc1UMtvj3Xmx27r1bQgeGQ
         6ADKiy3vZKFBw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0D95060A39;
        Fri, 10 Dec 2021 19:58:44 +0000 (UTC)
Subject: Re: [GIT PULL] libata fixes for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211210072309.324363-1-damien.lemoal@opensource.wdc.com>
References: <20211210072309.324363-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211210072309.324363-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc5
X-PR-Tracked-Commit-Id: a66307d473077b7aeba74e9b09c841ab3d399c2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bec8cb26f44c5c6cf3b37a27b297ddaa2d3486ce
Message-Id: <163916632399.27955.15004023640815280189.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Dec 2021 19:58:43 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 16:23:09 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bec8cb26f44c5c6cf3b37a27b297ddaa2d3486ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
