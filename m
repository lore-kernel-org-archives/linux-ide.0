Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16732C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  2 Nov 2021 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3ED96103C
	for <linux-ide@archiver.kernel.org>; Tue,  2 Nov 2021 18:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhKBSjz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235030AbhKBSjy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 2 Nov 2021 14:39:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EB15160F90;
        Tue,  2 Nov 2021 18:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635878239;
        bh=O2K7HLTpEH50/zwwGXESDE9WquaQCDXiwXYFNVjih2E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sWPbWXfWY8gl39Qvi6H++fT1SUVQOQAQNatQFA2XcVc7YfP44Wf1NpSlPBVMLjvXN
         dr0140UGD7Hh+8vxkbMiLaplVuTD9VN8s84PeYioh80QfA87doIWag08p6W9EBORMy
         NNOuEEwej02ceZkAy+eHqdoboSTfRrTOEQpngU9I1UEZ2AfPmHDirXK6ZT8RtsR+Ge
         3oxQQe4+W0HKd0huz/HDYCQvF861aBPMOHJ9tAdWyhp6OJaAujXBoM3MTZyD02kGII
         I40gHPcNWOXpNi/mqDSz5xsbi/zdwqutr1Mxa/5Tw0NXUEvxCz1bHOw5wpOG6IDn/D
         jn6X3u9YNVEzQ==
Subject: Re: [GIT PULL] libata changes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211102060829.78453-1-damien.lemoal@opensource.wdc.com>
References: <20211102060829.78453-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211102060829.78453-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc1
X-PR-Tracked-Commit-Id: 1af5f7af2484004e71d384d8b88c221fc62cd6b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61f90a8e8068c1176593858df9daf02b430fb4d7
Message-Id: <163587823893.14475.2352224652956182898.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 18:37:18 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Tue,  2 Nov 2021 15:08:29 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61f90a8e8068c1176593858df9daf02b430fb4d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
