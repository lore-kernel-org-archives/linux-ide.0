Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F42C433F5
	for <linux-ide@archiver.kernel.org>; Fri,  4 Feb 2022 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbiBDUe7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiBDUes (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2022 15:34:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B04C061749
        for <linux-ide@vger.kernel.org>; Fri,  4 Feb 2022 12:34:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25142B838EC
        for <linux-ide@vger.kernel.org>; Fri,  4 Feb 2022 20:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE27BC36AE3;
        Fri,  4 Feb 2022 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644006884;
        bh=v//Hn2yngFhY99U0pLO0YNo13KLyGt5QbORmwVNAIos=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FO3b85xjNCfz9/gTeV6guODPbLdAx9jCwTIOkPl308s69gj8prb3AF7WiYjSmuPue
         yoIUZI6g1o/YKjzEAssEu/Iv9lGJtVdSgbp8NcTJRIuewRlBwr7z1Vj1N5r7XmrJCA
         iWjpHULgFlC3195J75n8kaqMqh97g8+biWfCbTHwNYC18ssntmWdqRCpQS5KhjQiKN
         yaqeM++inrLZbnFs0xC9hgZAZyMGbjQSSvwf1qhAVM50yJeJfl9VVwCNqWzGDCNYQx
         W91TEeCZXHaj+Xg47JuOGafgNHr5ZHuLIGXS1D78OJTOW+7GwPf53aaxezotn7NPve
         Ozi4yAJYNcYkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBCB2E6BBD2;
        Fri,  4 Feb 2022 20:34:43 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220204084141.720789-1-damien.lemoal@opensource.wdc.com>
References: <20220204084141.720789-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220204084141.720789-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc3
X-PR-Tracked-Commit-Id: ac9f0c810684a1b161c18eb4b91ce84cbc13c91d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 494a2c2b27c5d2a3c4f65a325fe5a0087013c1a4
Message-Id: <164400688389.31755.4981699166644784299.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 20:34:43 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri,  4 Feb 2022 17:41:41 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/494a2c2b27c5d2a3c4f65a325fe5a0087013c1a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
