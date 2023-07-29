Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB22EB64DD
	for <linux-ide@archiver.kernel.org>; Sat, 29 Jul 2023 01:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjG2Bo4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Jul 2023 21:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjG2Bmn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jul 2023 21:42:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A55249
        for <linux-ide@vger.kernel.org>; Fri, 28 Jul 2023 18:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE42F62224
        for <linux-ide@vger.kernel.org>; Sat, 29 Jul 2023 01:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21E6CC433C7;
        Sat, 29 Jul 2023 01:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690594923;
        bh=/Pqti8DNRKaLRpeEVBJu4foeaNdXODKkiZN40FSDTnE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HPDGH55beDX3uolLVGPca8pURDScO2a2ejHPI7KNhBlcPWAsLTN9PZLBv4cegulWr
         +snGgNr2KsIubwaI+vFNuiyvKcZ/7bEDhKXPjvXPcNrAjuthAvqWgVGku9wbApsfiW
         Ju6Ci8s6HgDU3Ho08e7alzSo4gy45WswlFO3lJutVI+Pn6CrKV1Yx3X3DVTWLO91j7
         kJWReQEzcDXh3jLK1pPrPosdO8R0filI6SBRe0w31SLwhyRN2rrB9ExTOFfYs2oU3/
         aBLnihWrbfg+bzfvPN5apH3Sf/NFKh5sR/Mls6xTqX7ID0QjjmcOstXKSt8XfMEySP
         IyhDS+KoOhXuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00570C39562;
        Sat, 29 Jul 2023 01:42:03 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230729005612.424560-1-dlemoal@kernel.org>
References: <20230729005612.424560-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230729005612.424560-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.5-rc4
X-PR-Tracked-Commit-Id: 3ac873c76d79f055e1712754d9f2e90e41582f04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffabf7c731765da3dbfaffa4ed58b51ae9c2e650
Message-Id: <169059492299.9383.17585995182257570757.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jul 2023 01:42:02 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sat, 29 Jul 2023 09:56:12 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffabf7c731765da3dbfaffa4ed58b51ae9c2e650

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
