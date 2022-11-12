Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEFAC433FE
	for <linux-ide@archiver.kernel.org>; Sat, 12 Nov 2022 04:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiKLEas (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 23:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiKLEak (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 23:30:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7813F55
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 20:30:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1306460765
        for <linux-ide@vger.kernel.org>; Sat, 12 Nov 2022 04:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73B64C433C1;
        Sat, 12 Nov 2022 04:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668227438;
        bh=zmLEXGzHxGRJYpiuuqqcZrq1nPf0mRtzcghhZOrSHjU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XFEAaQTP3RZL7YwX+VXA4841lw4oNdDQxE4dBwZ4NBJBCS12g9mCgXr6g5qmyAkzQ
         RB/OkNFAQBkKFyt+o3CYb4WCTM+NPXpir1rxp3QFl+/HfVzJ4+wJYOf+4yg14wh5rd
         NZiO3aPzLZE/Tdae13Cn+kjN3EK1rqjC6zg+t8Wan0p1GojKYK+cIzz3CXtp7zs7Jd
         zvYl1CaLObapqlMae0Iytku7gKZ2ERD3ALuNmjc/bP9DlDTNYSde3IvcTh5N332Ujo
         iJAmh3I6/YX2bXusbiMDpPSCsKBBsIs00RO8sBduPHxeByIvXX8rWTu/y8yOUW6h8+
         qUN9WIhybDARg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 618C0C395F7;
        Sat, 12 Nov 2022 04:30:38 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221112015802.2192898-1-damien.lemoal@opensource.wdc.com>
References: <20221112015802.2192898-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221112015802.2192898-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.1-rc5
X-PR-Tracked-Commit-Id: e20e81a24a4d58744a29715aac2f795cd1651955
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f2975c2bb4c6fd43d778db55481fc11806c8773
Message-Id: <166822743839.3173.10589371344383084186.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Nov 2022 04:30:38 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sat, 12 Nov 2022 10:58:02 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f2975c2bb4c6fd43d778db55481fc11806c8773

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
