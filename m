Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC35C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 25 Oct 2021 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B00760F6F
	for <linux-ide@archiver.kernel.org>; Mon, 25 Oct 2021 17:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhJYRjA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232657AbhJYRiz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 25 Oct 2021 13:38:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6D3BE60F9D;
        Mon, 25 Oct 2021 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635183393;
        bh=f81vmcFSB+V1S2P75zaGKLpeZLfJfgLPuneTzy8O4rU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pLyQ6WfU4kI4YcHPlJsDU7H9i8ICS8D1Wom4ZoCGQDHiHdLpTDP/EED/gGmh+wpq7
         ZrCyBz4wJuaH4kDLN/6ht1FKkpDf8WNZspmG5xkPtdeufBeuZ7BxqI+dhT9EyFquXy
         8ADecvoIGuKwixUafvJEoMJiLk3gXey1ipb3chfouN3Goa27jTCNfYNGi8RzTLgh98
         ddjAZpk/k26P2ic/rNug+PbKTGAwT9yp6zHUz+SoJVsc4Bpr2pzqCbu500n0DEjvAf
         6clQydoTt8IIrIYHt38MecmD8XTlV4aw4AEzrDmVQpyoTAY44lcuobAxtJf0fSwYNz
         gVHJX0dyGGgdw==
Subject: Re: [GIT PULL] libata fixes for 5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211025001154.856544-1-damien.lemoal@opensource.wdc.com>
References: <20211025001154.856544-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211025001154.856544-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.15-rc7
X-PR-Tracked-Commit-Id: a0023bb9dd9bc439d44604eeec62426a990054cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4862649f16e79299b4f82a8e13dd8f9e5abcaa25
Message-Id: <163518339341.28134.3221251365385641830.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Oct 2021 17:36:33 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Mon, 25 Oct 2021 09:11:54 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4862649f16e79299b4f82a8e13dd8f9e5abcaa25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
