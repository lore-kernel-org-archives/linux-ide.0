Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D807C77B73
	for <linux-ide@archiver.kernel.org>; Sun, 21 May 2023 18:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjEUS6q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 21 May 2023 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjEUS6p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 21 May 2023 14:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD9B6
        for <linux-ide@vger.kernel.org>; Sun, 21 May 2023 11:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91758614E7
        for <linux-ide@vger.kernel.org>; Sun, 21 May 2023 18:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00C1BC433D2;
        Sun, 21 May 2023 18:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684695524;
        bh=R3Pk1eX6olsPk/cE4qbFq4g9TiGiFDl3zYmFBQbTeQw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=poLvUBiYMu+yqUhdunBRCkbk7KPrKVoweQmQZt1rHjPLk1Ak+sQ8nTSzh5kPx838m
         m//6QAVZgkMy/hXd6jYp2YYcR6ewKz4ixYuT/XAdDY7z6YJblarlRmH0TT0aCNFXxb
         bvcVzfQIFUXH7KXRsYIzSzM9nDGf4wih2z6WxprFmUJRuJmnc+havw6nEbv59uIWjc
         VEEWr4sIszG6VueHDGpt5nYPnvRyrAmcZJkuBTkEEPlosnh2t6zxkvJgITYrCR00ul
         v8hwlcre5SRmIaWlxvx6csdkQlU+OLKCu32LhPdxWMkfEJ3heWXB4svp+PJs4T7iRu
         8wnt35RdatStg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE940C3959E;
        Sun, 21 May 2023 18:58:43 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230521114732.2290216-1-dlemoal@kernel.org>
References: <20230521114732.2290216-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230521114732.2290216-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc3
X-PR-Tracked-Commit-Id: a7844528722619d2f97740ae5ec747afff18c4be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90af47edea473e5776989f4b669401552c7ca558
Message-Id: <168469552390.22409.14346636903605325292.pr-tracker-bot@kernel.org>
Date:   Sun, 21 May 2023 18:58:43 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sun, 21 May 2023 20:47:32 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90af47edea473e5776989f4b669401552c7ca558

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
