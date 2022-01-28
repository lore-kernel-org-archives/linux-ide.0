Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA0C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 28 Jan 2022 09:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbiA1Jsm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Jan 2022 04:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiA1Jsl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2022 04:48:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3931EC061714
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 01:48:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2EA8B824FF
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 09:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6302C340E0;
        Fri, 28 Jan 2022 09:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643363316;
        bh=CexXTuhNRDof14DRErT69AroACns0tjB1v8FoJOGgP4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Mmcaptk+Ng7LQiIMf+rN/Ckt+PCYhn/YP+gXo8e56MTzs5OcxQooTANnxncVnehAd
         D/1GxFMYiy8HL+T3Xz3skhGwzhJLcVeQ3LSG65H29w26wSiTq6ok7VwVT6abNMVGb6
         0pOJZe8Vq4ZDesBZ2E092ERvSOIj5r9ng/erveGJoRcHZXaHIcGLW/rC0MNyjFlseq
         eS0WIWQKTQdxkCD9X1mCkR9Ef7j90XgbZ72kLpjYM0difVy56IGVpqriIlQZrVeM/L
         VgvS5q3kgyODgOZbf7s8n4O4oQLE0Dpw4mwWKKsmxZZk4kXnm9bz9jvVCZ3l2eGLRh
         jxWQazNMkwAUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5067F6079F;
        Fri, 28 Jan 2022 09:48:36 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 5.17.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220128093204.33882-1-damien.lemoal@opensource.wdc.com>
References: <20220128093204.33882-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220128093204.33882-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc2
X-PR-Tracked-Commit-Id: 9b6d90e2085ca2ce72ef9ea78658bf270855e62e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 145d9b498fc827b79c1260b4caa29a8e59d4c2b9
Message-Id: <164336331673.26927.42740176834192502.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 09:48:36 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 18:32:04 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/145d9b498fc827b79c1260b4caa29a8e59d4c2b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
