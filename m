Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD65C7EE23
	for <linux-ide@archiver.kernel.org>; Thu,  1 Jun 2023 21:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjFAVPc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjFAVPa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jun 2023 17:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED983128
        for <linux-ide@vger.kernel.org>; Thu,  1 Jun 2023 14:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 844A06168D
        for <linux-ide@vger.kernel.org>; Thu,  1 Jun 2023 21:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8B19C433EF;
        Thu,  1 Jun 2023 21:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685654128;
        bh=zsZRyS3kkWqBl8/EG9HwH8y3UEjFJimI7MbBqrGNxo8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hl6p6jKE80te9a8v7m6YD3cVqz3Lb1O2Fdjm5KK++1RlRBa17psnHec1TDyXLiHIH
         RsMHi/niFcnP/EkKVGlmIeP4LTwgfUXPetol2y46cehUgWoIF2bBBQbtTD/sZ8QBh/
         +oExR2AIkoe+/ll2R7Rp5fKLGIXpa/3KSFjge6j1eFRofCc30Yp3bkiH7sHzcFtipN
         LWgLsqONcuLSOJKqmSfb7UIfJlkU2s6MMqiPMy9ACdCI5w4kjtCHwhuLm0+7k1SrDh
         bJuzoYmubTeTwnaEok+yE7qZpwKgMerwr5u9Q44y4fsg6uGJlARrlbYNCw7nqG25fF
         FkpidraPsJ4Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D16AFC43162;
        Thu,  1 Jun 2023 21:15:28 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230601005401.3298-1-dlemoal@kernel.org>
References: <20230601005401.3298-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230601005401.3298-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc5
X-PR-Tracked-Commit-Id: 7f875850f20a42f488840c9df7af91ef7db2d576
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba059590ec97ddf137ac7f200bfc5c8ce90c0237
Message-Id: <168565412885.3839.10962373405502147890.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Jun 2023 21:15:28 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Thu,  1 Jun 2023 09:54:01 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba059590ec97ddf137ac7f200bfc5c8ce90c0237

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
