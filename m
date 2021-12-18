Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A38C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 18 Dec 2021 01:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhLRBfV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Dec 2021 20:35:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47186 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhLRBfU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Dec 2021 20:35:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE2D2B82B4F
        for <linux-ide@vger.kernel.org>; Sat, 18 Dec 2021 01:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D306C36AE1;
        Sat, 18 Dec 2021 01:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639791318;
        bh=4d/kYgdAc+VO18f6zYeoKYjSdUqNf93zAll40XQbYnA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CwDhSg+LXc5pzP/CbpwkGaj+v9c1FryUl8k3gys8uscbyMegS2oDF9cj3ZbtKOkcs
         VGrUGN6L1pKqg4/aS4dl0eOaBfGSoa2btijq46c0Zt+tMfWmUl+Bmw8k73TsPKco5o
         qnygwAsInnBdpktDTluh5emKv60vnVWRSzD0XAsZyApQzcWSToXb6j/+fNKjhwCCp9
         bIok4Eb/3CRzj3vE6EkxKnQJy8Sawy03LshHWZdBQZb/jM3E7ESVhKV7O6oYp5nxhx
         BQiBp09IEumvPcU1VSviIi8myK0f4omdfkSn4OhjGN+W0m9x0G+TswNn20nzOV0y9H
         U+DKDa3JQ9tcw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4B11F60A3A;
        Sat, 18 Dec 2021 01:35:18 +0000 (UTC)
Subject: Re: [GIT PULL] libata fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211217235731.304392-1-damien.lemoal@opensource.wdc.com>
References: <20211217235731.304392-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211217235731.304392-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc6
X-PR-Tracked-Commit-Id: 5da5231bb47864e5dd6c6731151e98b6ee498827
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9eaa88c7036eda3f6c215f87ca693594cf90559b
Message-Id: <163979131824.2028.10125665423561595282.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Dec 2021 01:35:18 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sat, 18 Dec 2021 08:57:31 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9eaa88c7036eda3f6c215f87ca693594cf90559b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
