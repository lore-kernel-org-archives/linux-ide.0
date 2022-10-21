Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437A6C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 00:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJUAlr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJUAle (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2022 20:41:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E619A211
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 17:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAC63B8274A
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2022 00:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B930C433C1;
        Fri, 21 Oct 2022 00:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666312881;
        bh=aUTThvviwKvA//q51eHdXyKxo2ErKQiYdKJKbtewMj8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nFLtQbq/zvC4sxqowRs7pYiq/weZKWfh7YCw7MaiJOi2SnPo5f5wutLLgfABP6tm5
         ZsYo8iiZDOV4tWDjPPf2GGbotHGntcZXq7NPrw2x1bhmYkUrDfASzCNgqIGUvs/6F4
         JWsqf9VoP6Wi3V6e52xQgzC3UeB5NU/hJSMQAoVaKpjymYvYKOVvLgjIPLRY7lC1/2
         SGcNVrXXbCZ5GYoEDfC6XCHHvFKvtkutwr3m3zyr/PWPxcUNUEzqCMmw03o566Gx7t
         70dDU0jRFWt8Wt/Jl3cX3YkdhmvP20LzidH4US0nJoCU8N5k2g8PxQj9/X42hGqoY2
         y2DleEpRt20fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66C86C4166D;
        Fri, 21 Oct 2022 00:41:21 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221020235048.181004-1-damien.lemoal@opensource.wdc.com>
References: <20221020235048.181004-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221020235048.181004-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.1-rc2
X-PR-Tracked-Commit-Id: 2ce3a0bf2010b16c78b78cc35a97fa913f1be0ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7b006525bb0673f2373f04b5b8263b022ff367b
Message-Id: <166631288141.10394.2416625857753735555.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 00:41:21 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 08:50:48 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7b006525bb0673f2373f04b5b8263b022ff367b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
