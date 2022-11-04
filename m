Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9288C4332F
	for <linux-ide@archiver.kernel.org>; Fri,  4 Nov 2022 00:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKDAJY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Nov 2022 20:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDAJX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Nov 2022 20:09:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEE11E714
        for <linux-ide@vger.kernel.org>; Thu,  3 Nov 2022 17:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA2FBB81C38
        for <linux-ide@vger.kernel.org>; Fri,  4 Nov 2022 00:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6771FC433D7;
        Fri,  4 Nov 2022 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667520560;
        bh=/bmXYdZllui1bRLAcPkbnS3D+ZBOPHIOky+yqfRwPR4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jij9losmPZXm/qpg6YngtdFFr+ZAlP52wCwbZOh+n+1NaDwP/mBXYGVjAivQ9g7zw
         vmJCmSPY7Y/M+vRseUHW8TboSzO4T9MjNdzqSvkqztsgjCIJAlVFPsHuPjiuQ9jNEG
         GNoRbk/bN3xQkfb/7gzFOaOYTWOagVbaUkHyA/qOZA8aTpDVn6TjXSuCyL+xkoBfDV
         ZWn2H2ezVmjXljCLFvcgrf6kgKmukPVahmv6lfFL5RiCJdEIbLllQOS1z3EArE9sv6
         Qs22QoaGP3qIFe8z1qJo4O7NEsbPAP3CXKUxBpaDW65Nddzx8utU/1W8UL4GDMt8Gg
         QDGaqv4eF/eMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51D0FC41621;
        Fri,  4 Nov 2022 00:09:20 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221103214335.1126889-1-damien.lemoal@opensource.wdc.com>
References: <20221103214335.1126889-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221103214335.1126889-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.1-rc4
X-PR-Tracked-Commit-Id: 015618c3ec19584c83ff179fa631be8cec906aaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
Message-Id: <166752056031.21078.13302543982702695117.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Nov 2022 00:09:20 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri,  4 Nov 2022 06:43:35 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee6050c8af96bba2f81e8b0793a1fc2f998fcd20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
