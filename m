Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F719CA100A
	for <linux-ide@archiver.kernel.org>; Tue,  5 Sep 2023 20:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbjIEUTO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjIEUTO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2023 16:19:14 -0400
X-Greylist: delayed 276 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:18:57 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18733194
        for <linux-ide@vger.kernel.org>; Tue,  5 Sep 2023 13:18:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70C16C433CA;
        Tue,  5 Sep 2023 20:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693944833;
        bh=WsiLaOkojb2gJ6d0RdApH2orTZfHc2zAa90aTMFpm9o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EPKOKN3IsBNkr0RhFFMO8xqCoxN6rbb0ABMWB5uYw4RK+cwaTT3rMdoiaZnsQ3T+c
         hvUQyyRaBUGoXAZXpjZ93qBESq2sId8jLAfbtb9EG18OoXIKGyFuGmAQkKYPpCt+K5
         TUaSHXS6oCoozMgFJXUf0NeJHdTpNe97g9m6CggysWEmQkMlIZGk8EcasOaPuaz41f
         SlebYjFnoHhLbTlYqF5hB7UnauuhKJefVwXZwjKi/uBrJSqw9VJJnCu+aV1ytJnUZ4
         K2Pn/E5MQMIaQFouupWOqpF34csTQWwb/6B5GZuGoxDxokLEtK6li9tEuceah19lpB
         Jm/DnLNvxSSTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 490CEC04E24;
        Tue,  5 Sep 2023 20:13:53 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230905071201.277320-1-dlemoal@kernel.org>
References: <20230905071201.277320-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230905071201.277320-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc1
X-PR-Tracked-Commit-Id: 27fd071040e3a5bbea9f44548c93f1092b451714
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b3d6e0c6c4cb3565c73012d7d292c22e68393a9
Message-Id: <169394483324.28658.3446601424656451759.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Sep 2023 20:13:53 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Tue,  5 Sep 2023 16:11:54 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b3d6e0c6c4cb3565c73012d7d292c22e68393a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
