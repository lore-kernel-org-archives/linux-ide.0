Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC0C4332F
	for <linux-ide@archiver.kernel.org>; Sat, 31 Dec 2022 18:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiLaS1X (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 31 Dec 2022 13:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiLaS1W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 31 Dec 2022 13:27:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ABCC3
        for <linux-ide@vger.kernel.org>; Sat, 31 Dec 2022 10:27:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6526A60A2C
        for <linux-ide@vger.kernel.org>; Sat, 31 Dec 2022 18:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCC92C433D2;
        Sat, 31 Dec 2022 18:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672511240;
        bh=00ZpB1wz+PclEUFM3rydCW/9IksogA3jzKRKtL0RpkM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DvBIjD+EPAiRDPVyRYx4fDAMY8RQUZDCSnaEZxoinGKPX/lkHAKB2r+0Ucy56qC1F
         6j47fNZH2yjljbdzuJuaKTttquPiMe8N2RmhmOa19PfVEwAZmdoYZKUJLYQC0xpyhf
         g8XMDYOA9MKZVda+PTU403w8rPaX7XXytVMURuzZzJ60IhIxvcQzctkemNdLsM/bnS
         Y8k7hNI7X+1Vs9DzEYOWapWwMcOGKWiu0Xo1bb29gBoROiw6ZFd5rzMzCrVX2Y/bJg
         JabL6EVWdf+n5yknbW8RI1Ba3zaMwmiABVDaH7gI7PSVvTaIHbKMudBvXdHb5WP2lx
         uCszOM2qgSrMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA2E6C395E0;
        Sat, 31 Dec 2022 18:27:20 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.2-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221231005943.20587-1-damien.lemoal@opensource.wdc.com>
References: <20221231005943.20587-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221231005943.20587-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.2-rc2
X-PR-Tracked-Commit-Id: 37e14e4f3715428b809e4df9a9958baa64c77d51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e39d9b9f89f2efd653212064f941de6f53c3c060
Message-Id: <167251124075.7119.12067024518915220372.pr-tracker-bot@kernel.org>
Date:   Sat, 31 Dec 2022 18:27:20 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Sat, 31 Dec 2022 09:59:43 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e39d9b9f89f2efd653212064f941de6f53c3c060

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
