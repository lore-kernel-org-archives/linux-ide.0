Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C331BC636D3
	for <linux-ide@archiver.kernel.org>; Fri,  3 Feb 2023 00:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjBCAxr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Feb 2023 19:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCAxq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2023 19:53:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157516602B
        for <linux-ide@vger.kernel.org>; Thu,  2 Feb 2023 16:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C56C1B828BF
        for <linux-ide@vger.kernel.org>; Fri,  3 Feb 2023 00:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EB50C433EF;
        Fri,  3 Feb 2023 00:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675385623;
        bh=AVbHCWKMz1/jBum0k70cuOq5JNW5BHH/BUuFjjHdJJ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Csbt343xP5lN0nD+ijx8vQEQFask89dbhBzQglNl/IJ0/+V1v8C0wD/jSjChbB97P
         gAlaoUyBBhTF7Sb0ojAvwqA9p2Za7ZellE5LhaltEOhYloEz2j64n01PUvRnalr+oL
         DG2aao7gQjjwSj1JY1HJ7cF3HG1N/dT35I/BFDgHB+VEZAkKC+wFZw4dFC4LNLCFJX
         mG+xTXV7H99C2x4rEmRBGmiNkC2HF0nhnDaUkvC2x83xH2hA2QOIOUZ7YVpktqfB4w
         rM4vfkYJ88EjM64PS8428CAU1l0PCqXY58RvYTCCM/hYa3JSOTgv269vs528Pirr+N
         tyeWT3GhK6Gdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B575E21EEC;
        Fri,  3 Feb 2023 00:53:43 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230203000255.230083-1-damien.lemoal@opensource.wdc.com>
References: <20230203000255.230083-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230203000255.230083-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.2-rc7
X-PR-Tracked-Commit-Id: 69f2c9346313ba3d3dfa4091ff99df26c67c9021
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66a87fff1a87c260452f5a57123891ca5258c449
Message-Id: <167538562343.17583.17073898623526161672.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Feb 2023 00:53:43 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri,  3 Feb 2023 09:02:55 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66a87fff1a87c260452f5a57123891ca5258c449

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
