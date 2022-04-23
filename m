Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898B3C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 23 Apr 2022 01:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiDWBXi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 22 Apr 2022 21:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiDWBXh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 22 Apr 2022 21:23:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817755D18E
        for <linux-ide@vger.kernel.org>; Fri, 22 Apr 2022 18:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23159B83219
        for <linux-ide@vger.kernel.org>; Sat, 23 Apr 2022 01:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2225C385A8;
        Sat, 23 Apr 2022 01:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650676839;
        bh=RIYTMfK3sJPTKOg75jm3ZQyoHlFKMEBtwRZn+Lt+D9w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a3zPZiOma/w4PscQN1EdSPVdURPmZLeF8dZpeysKAL23cYYVO/bSYR+CLUtD7yZBk
         peHDmSpJDDJyXdfNHq32mMz42eI8lnb9vI1lcYvOklMFGgmgNGHN7Y9XpJoit6APej
         GUgYZWw5OPFFUXy1ThtEkr5rsPU8cT+h5ZsqIGrcGONlX9F3hlIsemcXgjPM8AS7oI
         DLuI01Bab2iW4du0JWKDzU5kLQK7rLwY4Vf0rDNrV26D5xUpKuZythaoo45WFN1Uka
         yJkw5QiBJT3/qZwkXMH1JGXmw4Ls9JqEsnvUlfHMClmh6lMpt7XHyTaAIUSnkjhruD
         Y6eKfV7erEMUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF07EE6D402;
        Sat, 23 Apr 2022 01:20:39 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220422221709.3776774-1-damien.lemoal@opensource.wdc.com>
References: <20220422221709.3776774-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220422221709.3776774-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.18-rc4
X-PR-Tracked-Commit-Id: aafa9f958342db36c17ac2a7f1b841032c96feb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e5991fa39e4eec45eb37a680bfdff18129cefd9
Message-Id: <165067683970.21969.5654719094325069045.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Apr 2022 01:20:39 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sat, 23 Apr 2022 07:17:09 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e5991fa39e4eec45eb37a680bfdff18129cefd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
