Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C01DC433FE
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 19:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJGTVE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 15:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJGTUi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 15:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67351AF19
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 12:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76BB061D10
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 19:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAD1AC4347C;
        Fri,  7 Oct 2022 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665170415;
        bh=+JAFbeOPgkHERH9O4t6GWNVprDm6Sr4OoGj1qqKz6xk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WrdUNWN6anxA4Lz+kQkfXL1s0DLLt9JJv7oveECICWbE0C+GwLA2OCXCeOeJH543N
         jkcnQIK28a6yANNdyrBgQkDu23VBUC5oARPAYRgN1oF+5viHUyixT0QsriPeD13UJP
         UXrRrAd+NqPBoOMv/B6qWliCVdOsMJPNuuEp/sIJVmedOMQ17DVK03xY0MjD73j54O
         JMcCwk+YI1Z0MSy+0wlcIuKK8vLOBKUW58AZ3yKv/CWjpfxlgKDw2PZKjFWp84qLwy
         iT7uKaeoDHcv9dF5QO01pkwGPmb3Wcdg/WCHEWwK9IVyhvRFKa+V5ZacdebVp8awMc
         yYE5SofuPS5BQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB778E2A05C;
        Fri,  7 Oct 2022 19:20:15 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221005061637.160994-1-damien.lemoal@opensource.wdc.com>
References: <20221005061637.160994-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221005061637.160994-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.1-rc1
X-PR-Tracked-Commit-Id: 71d7b6e51ad3370d850303b61b79528fb2872f0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4078aa68509746d0c1a70c50ab22a761ad7c2e0d
Message-Id: <166517041582.8063.9958364745651455749.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:20:15 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Wed,  5 Oct 2022 15:16:37 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4078aa68509746d0c1a70c50ab22a761ad7c2e0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
