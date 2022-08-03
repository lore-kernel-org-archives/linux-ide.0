Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF563C25B06
	for <linux-ide@archiver.kernel.org>; Wed,  3 Aug 2022 22:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiHCW3q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbiHCW3j (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Aug 2022 18:29:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2445C953
        for <linux-ide@vger.kernel.org>; Wed,  3 Aug 2022 15:29:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A2CEB82405
        for <linux-ide@vger.kernel.org>; Wed,  3 Aug 2022 22:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4D1EC433C1;
        Wed,  3 Aug 2022 22:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659565768;
        bh=4FDuL6Dy5oqxswXVWPM5vg7s0QM/w+odG33JxF5H1F8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l/ctItNIdR4GYFTWCbZzOGffMemwwk+ekC/CmAEMBLshnFQXG9Un+M2EcLw7Y6/pw
         kCSJG8V2sqpw8SYVrH9lkb9Z/uXAwBiLhMQjeBTYFxrcPfV9VcyW8PX/CcUyJe7NKs
         2Yd9etcsmY/QCzVGsCS/dKzBiVRsPTBuOTcwQYxTmVq0tzxLFlFHBkjNjmukyz/51S
         KjAmq+Hs6+YznGCxHxEyafxrWGwToavIiTGdZJ90xaDOqNzUMwUfqLyqeXWkj81fST
         SMvSiLs5wzlH6Y8TLHPYhj6RkDA3y3Ba7494YT4761Or2R3grRr+eQWd4KGhjCEcH8
         lizVobltZePWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3F47C43140;
        Wed,  3 Aug 2022 22:29:28 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220803063825.986717-1-damien.lemoal@opensource.wdc.com>
References: <20220803063825.986717-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220803063825.986717-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.20-rc1
X-PR-Tracked-Commit-Id: b3b2bec9646eb1d3f43c85f6d0d2211d6f8af42b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 526942b8134cc34d25d27f95dfff98b8ce2f6fcd
Message-Id: <165956576886.24057.15292898127870800942.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 22:29:28 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Wed,  3 Aug 2022 15:38:25 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/526942b8134cc34d25d27f95dfff98b8ce2f6fcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
