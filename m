Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58863C433EF
	for <linux-ide@archiver.kernel.org>; Mon,  6 Sep 2021 17:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B2060EE6
	for <linux-ide@archiver.kernel.org>; Mon,  6 Sep 2021 17:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbhIFRQa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243812AbhIFRQa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 6 Sep 2021 13:16:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4E27661004;
        Mon,  6 Sep 2021 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630948525;
        bh=NHszRdsEugz7z7nOZ9Ux5N0HWFK1Me9ttTcD1MhbnWo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IrFL8wE+dFfqNnVejAu9gT0dDrPqVdocQBOn3Tp6TL0u/dvABf5VSVAWc5uyqG3Q1
         fCMziba+oZJi4XbzMn1Lbsp69T/z2IWdDafIFUC4YvoTaOiO4k9F4s3l1a1nwTXnGB
         a+GWb+4GJYgRoy4kiLkKPDd4H+SJKU2iHz9dVZdna+LkK0dJCmlHvPPvBjBRShk/au
         WlKCMjrsqJlEKi0fQski5QFRzK0lxhJVIYgHfntM8XsIsd766GDGrJYNdd17SFMuAm
         8Ljrjkv2SCotXL4q6BuJMGIGiVgzysT3ijda77Jb2LL2OriQ9Mm/s9sG2ESkpYyp7r
         3syqxi/+LhQQg==
Subject: Re: [GIT PULL] libata fixes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9004cd72-d5a7-da36-10c0-7ef80d222950@kernel.dk>
References: <9004cd72-d5a7-da36-10c0-7ef80d222950@kernel.dk>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <9004cd72-d5a7-da36-10c0-7ef80d222950@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/libata-5.15-2021-09-05
X-PR-Tracked-Commit-Id: 7a8526a5cd51cf5f070310c6c37dd7293334ac49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eebb4159a2bf660b545ecb6ee318179971d610a2
Message-Id: <163094852529.9377.11013413572782361337.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Sep 2021 17:15:25 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ALWAYS copy <linux-ide@vger.kernel.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sun, 5 Sep 2021 12:57:29 -0600:

> git://git.kernel.dk/linux-block.git tags/libata-5.15-2021-09-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eebb4159a2bf660b545ecb6ee318179971d610a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
