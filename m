Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B48C4167B
	for <linux-ide@archiver.kernel.org>; Tue, 13 Dec 2022 19:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiLMTDb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 13 Dec 2022 14:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbiLMTDJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2022 14:03:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503D463B1
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2022 11:03:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0348BB81240
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2022 19:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F1F4C433EF;
        Tue, 13 Dec 2022 19:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670958179;
        bh=wjarJ5VzWcWVh3uo6d5GV8rolhSnOE4MSWa1KXFmwWI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GgKq/agzL9eenDePFj9UoTDRH2DrC3tbvPMtmV+ECE9jQ04g2IbZHOIJw6/qIfdCt
         3xvr85J6RcgRXzwbMe8WPLS/Vk/jVKfeCe8P8bP8yDahCozDQ+1AAYGjdadMVyEfU7
         QC73RcUv85wUzACD2ulwJYbNieRZDHtx7CGOyA0nU2OyvVl7FK12HghYr6qAWpk574
         y+bxe0OyDIMwv3Omx2pZWaGjskBnNiRLV1hQTVRkhjxPz/N5PGIc1V6PDa/esI6gmi
         9gC6wg0H9/wcqSaBWNTOZLh6FftM/5qy5JAU/kRa0wD+FDE9pP5VBFz7furRlx6vRn
         wppTGZIqlBfNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8ECF9C00445;
        Tue, 13 Dec 2022 19:02:59 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212050841.1877401-1-damien.lemoal@opensource.wdc.com>
References: <20221212050841.1877401-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212050841.1877401-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.2-rc1
X-PR-Tracked-Commit-Id: f07788079f515ca4a681c5f595bdad19cfbd7b1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ecd28b7a3a4c43a875a8840851f72468a2ca1d7
Message-Id: <167095817958.20557.2358630721393806032.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 19:02:59 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 14:08:41 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ecd28b7a3a4c43a875a8840851f72468a2ca1d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
