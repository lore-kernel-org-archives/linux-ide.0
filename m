Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D66C433FE
	for <linux-ide@archiver.kernel.org>; Fri,  3 Dec 2021 18:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhLCS5Y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Dec 2021 13:57:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52750 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbhLCS5X (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Dec 2021 13:57:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D2FE62C89
        for <linux-ide@vger.kernel.org>; Fri,  3 Dec 2021 18:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69EAAC53FD1;
        Fri,  3 Dec 2021 18:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638557638;
        bh=Kb5dty9Qmyz2z+grkdrFmIjYkMBe85rOcpBiqLuYqS0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MjBVeb2KGPQaYa/Cn+4J03JstkUwTr1V0DDwc35FhNv005abyDFr2XtdV8g4/LFEB
         2B+gqq82vOckyrI194RX/yyRd/kV04oxdwpgXv6tkwDzRqHNCpQEicGIsCqRvCnlCK
         /LsTZJa3WuweYrmJBgm8C7VFKgx8c2z5pA2h3r4oskSQ3wesCIYBghkkGo6pD/tbNa
         t1vFrWabAdklwtSOjrnc8AkA49XUNLxJgX2HTe20276vs1mzmCHnRY8uiX/PgTHr2K
         VCRqJr5F+xj9rYrHXSHpYEGrkTz6zEX3mpm+d0wglMmismcxPq8QWmYVmttg49XAEy
         rWTj7gV+Y0LDA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 587D960A7E;
        Fri,  3 Dec 2021 18:53:58 +0000 (UTC)
Subject: Re: [GIT PULL] libata fixes for 5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211203104033.656678-1-damien.lemoal@opensource.wdc.com>
References: <20211203104033.656678-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211203104033.656678-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc4
X-PR-Tracked-Commit-Id: 06d5d558f5a30582546dcbe9327601af867ce1c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a44f27e45148260229ffb9c00e388b33e03bb7dc
Message-Id: <163855763835.17226.7138420424617150821.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Dec 2021 18:53:58 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri,  3 Dec 2021 19:40:33 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a44f27e45148260229ffb9c00e388b33e03bb7dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
