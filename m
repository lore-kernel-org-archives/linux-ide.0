Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C91C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 22 Jan 2022 09:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiAVJk4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 22 Jan 2022 04:40:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59244 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiAVJkm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 22 Jan 2022 04:40:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9825C60B02
        for <linux-ide@vger.kernel.org>; Sat, 22 Jan 2022 09:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08AFFC004E1;
        Sat, 22 Jan 2022 09:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642844442;
        bh=LQ/IhxUKG38SLcVSbRYlFYOypEJREjUDSAWhAlf/9H0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ey3cVPML/cJDYXJDzzrxv44+knyTRWgarqWt7PJFFYPYRn/2N5hidN5MY0nooOYFP
         J2UA6iHcMW5ms+rlZeteCCuMGAjY+Jax75Cfr0Ewn32hqvqvEq5v4ikDCzhA7N00hp
         q+PPs+niqZrja6vPtG0zntKEEg2eIeyfBX3QCeB52iOriEN3/OiG1yXQKNsAUosDwo
         64A1xIXMpAmcx0ttIidCeHrBJUGhB1NHPeVzc4VgBs1vk6fDuO2Rcq6ftC9gEhBTyi
         j80n0buoLU4+43JY0KJv3shkO3batkv2yYAfQh3vVuwpot34+X/07JI5CB5qv7BR6T
         1JZo4GO7tXeDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC127F60798;
        Sat, 22 Jan 2022 09:40:41 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 5.17-rc1, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220122000556.1149852-1-damien.lemoal@opensource.wdc.com>
References: <20220122000556.1149852-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220122000556.1149852-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc1-part2
X-PR-Tracked-Commit-Id: b875b39e7373dcaccb19a600a52a956061c2c833
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b087788c20aa959f83df989b31fdcc4182b2d067
Message-Id: <164284444195.10005.5309086621505943009.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 09:40:41 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sat, 22 Jan 2022 09:05:56 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b087788c20aa959f83df989b31fdcc4182b2d067

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
