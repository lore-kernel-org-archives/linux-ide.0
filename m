Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F11DC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 25 Feb 2022 20:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiBYUSJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiBYUSG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Feb 2022 15:18:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5CD35DEA
        for <linux-ide@vger.kernel.org>; Fri, 25 Feb 2022 12:17:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BF2361893
        for <linux-ide@vger.kernel.org>; Fri, 25 Feb 2022 20:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1CD8C340E7;
        Fri, 25 Feb 2022 20:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645820252;
        bh=2CiLftUowQIKVuFHey5fdcoFQJZYQnYFm+EdTPlTfuo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g5YIXhoVsX8q81DzkHnO+Bk5VJJ9kHgM4g3hDPGc6jyup8FoXBUg91D5wTDBeKJOS
         f3/eIvwBTeBZghU3Nk8D9wR00d2YhOP/2OtRLy24CB+/PISp8HLrP0fytbII2bwoDc
         QTOU0+3dwMaaujckfXO+ZH7F161frIPoYM6SfnZldq151Li3+eugKEGJT5AKFEOBMQ
         y6xGpnBKIeOjO0Y6Dvk+vRgs+HZpNe8KutMyD1dFXl9lr5moBicrNhvcNzomMCrpHT
         OdS3iPUougdFcrXrffjFP8p21jZMAcj9iYDNVCkKXDub9+KSCiVnvIbhXvAMgkpTMG
         DVDS2iaaiLBPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF5EDE6D453;
        Fri, 25 Feb 2022 20:17:32 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220225060329.482448-1-damien.lemoal@opensource.wdc.com>
References: <20220225060329.482448-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220225060329.482448-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc6
X-PR-Tracked-Commit-Id: 8d093e02e898b24c58788b0289e3202317a96d2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78081594971aae94d743c1af73e63fb258c04616
Message-Id: <164582025271.12222.7129807114501078407.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:17:32 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org,
        "Justin M . Forbes" <jforbes@fedoraproject.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 15:03:29 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78081594971aae94d743c1af73e63fb258c04616

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
