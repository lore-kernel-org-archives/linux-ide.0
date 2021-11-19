Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD809C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 22:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhKSWYP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:24:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234568AbhKSWYO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 19 Nov 2021 17:24:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A1910610E9;
        Fri, 19 Nov 2021 22:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637360472;
        bh=6D/SeycIOUqFMwGzTNU2MhXCHcq1SVviHLGrgkgNH0Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GFXTfsJqpRh2AQVQ8oDkw1uFyODkA78GoAzArcXNy5bTPtYMFf+zZtcxz2BFGqqS1
         adARPmY37m617BlKid18eTnN04/AdMl+qbUG8lTOg4onSJW+dX9OgOAYonWYY95tHU
         nQCF/vgeuDEqco1Ch4/ScGZJvYdyqg5BzMYQS2VgPL6d5Rp3MO8EzUK6crgbn+0DJN
         Cf6oSHVsyl5BegPskhGv/qZla/Ca/dxneLdqZf/jnlSL0JTiZu3NShkSmkocOXA85B
         JLNgAosAEFGendDDRp+UIXFQzvWo9m/dn6ueJkz+qPW5daNqmIytKYC1k/YmV0oZEV
         ZQk78pkuBN2Jw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8E6E060977;
        Fri, 19 Nov 2021 22:21:12 +0000 (UTC)
Subject: Re: [GIT PULL] libata fixes for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211119221349.130509-1-damien.lemoal@opensource.wdc.com>
References: <20211119221349.130509-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211119221349.130509-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc2
X-PR-Tracked-Commit-Id: cac7e8b5f5fa94e28d581fbb9e76cb1c0c7fd56a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a90af8f15bdc9449ee2d24e1d73fa3f7e8633f81
Message-Id: <163736047252.7890.11402774633371130559.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Nov 2021 22:21:12 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sat, 20 Nov 2021 07:13:49 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a90af8f15bdc9449ee2d24e1d73fa3f7e8633f81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
