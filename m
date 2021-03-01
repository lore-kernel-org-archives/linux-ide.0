Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B91C433DB
	for <linux-ide@archiver.kernel.org>; Mon,  1 Mar 2021 00:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EA564E10
	for <linux-ide@archiver.kernel.org>; Mon,  1 Mar 2021 00:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhCAAIv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 28 Feb 2021 19:08:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhCAAIt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 28 Feb 2021 19:08:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A9CAD64E10;
        Mon,  1 Mar 2021 00:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614557288;
        bh=BwqDsHy3oaOJKlPRI9FScTEDjKIUeHYvRwkTmlnVUwk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aZ1SitFb5UypqtQbqdPQ0M93lu08ub3h+6Bhphd3pws8cZyqXO1L6U3CiZfcnI0Y3
         ifPVBX96xY+x7gAqYB3unG6kFApgJK7fiBtdLt5Z6HRFoe6G86lftalKDMbUPifu93
         UyrVX/FN/uECWHlVfHJgc1x0AydDfEsnp1Jqu/h4YsnT8TWpxR5t3SkJT8CWzRyEIV
         HTqNNo2nm2RZ6MM6we+2sS4vnJrxZeEv8YC8YQQ+V4xlUmpMd40kKsIK1Qcqe7cB2p
         xLKg8DISO1YwW81x/EURz7SUyZBwNYbPoCvgaEUdncEvoHdMEhgEFXe+Icq3MMkYq0
         i1hJh5KNtpJYA==
Subject: Re: [GIT PULL] Forgotten IDE fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ce99da11-1b6e-2734-3a5d-bc83d68b4ed3@kernel.dk>
References: <ce99da11-1b6e-2734-3a5d-bc83d68b4ed3@kernel.dk>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <ce99da11-1b6e-2734-3a5d-bc83d68b4ed3@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/ide-5.11-2021-02-28
X-PR-Tracked-Commit-Id: 07f1dc8cc85bbfb2f9270f25060c4755f4509f45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d346da4a4a4485e3e728569a48bec6bfbf9e53d5
Message-Id: <161455728857.7470.18345130275007624401.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Mar 2021 00:08:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sun, 28 Feb 2021 16:47:57 -0700:

> git://git.kernel.dk/linux-block.git tags/ide-5.11-2021-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d346da4a4a4485e3e728569a48bec6bfbf9e53d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
