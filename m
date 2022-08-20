Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58015C25B08
	for <linux-ide@archiver.kernel.org>; Sat, 20 Aug 2022 17:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiHTRzr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 20 Aug 2022 13:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiHTRzp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2022 13:55:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B5C5465D
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2022 10:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22BEAB80A09
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2022 17:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB6AFC433B5;
        Sat, 20 Aug 2022 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661018141;
        bh=CCZzsucQxP8JqbifPkKC3QFKGUjCdp4S222gIXoqbNU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ltd5NKlBuupDpd7ZiP5QsKzX72Y2zfga5abUwj0iF6InYtR+iqLTnhnR4to843fwg
         PdUZ0oryV8arltuLT3OxvjslxYcW6qk/01pM7xNxH6ntpBi8zjql7HDl8b1FDWtRcq
         ONBLSwgsHau2u9lsz40XNO+BHtkbXYdfPSW7cCAsjN6m0FjRBbNgGQ8i3jyfegJ7qU
         lbk3MN4iABqPV2p2AvYGMHU1vClL4WFcUPly8xNSvTq9NHekITpHGaE0cuTmP8HmZe
         ejMjBCNyMOljDGl9YQS7UzNWHNXNEZD8xwTtzLCCGyYeE/xWY5Abo551yLOXdpeHBx
         v0cfrjmAeEJiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8933C4166F;
        Sat, 20 Aug 2022 17:55:41 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220820163444.128237-1-damien.lemoal@opensource.wdc.com>
References: <20220820163444.128237-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220820163444.128237-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.0-rc2
X-PR-Tracked-Commit-Id: a357f7b4583ebf81d19c95aef57497ae81c5f63c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 044610f8e4155ec0374f7c8307b725b7d01d750c
Message-Id: <166101814175.10395.17067739471601129570.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Aug 2022 17:55:41 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sun, 21 Aug 2022 01:34:44 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/044610f8e4155ec0374f7c8307b725b7d01d750c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
