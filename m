Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F3CC7619A
	for <linux-ide@archiver.kernel.org>; Tue, 11 Apr 2023 18:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDKSwl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDKSwf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2023 14:52:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE775581
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2023 11:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD2260AFA
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2023 18:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F2E5C4339B;
        Tue, 11 Apr 2023 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681239153;
        bh=aPzupWyPckFXVVbYOx55hhtisGG+iCgCY+aZvzB5qlc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X1akAG/rIfY3YfxxIB/S9esQX1CAdlifxXmO/nkn1V2DAekj6KREFOpR6SZPGBoZC
         romy61fdaVZZbWc9LU33SQALqforPnzpl4N9/Jp7jCq6FXNJtIOuVsVbGqZtrajD1I
         MrWhejF3cdLoqDrckttrxvZAkGTAP09xZNq8fyWmrACLWPfXJXHmyGuO/fGND3/icZ
         8y9DVpfFuVzwT41ItaaDNOtqh4ZU9LdKCpc1HSD7MEpb/Cy8qaQQDkmv/QmRwpq1nn
         qMT8ONQcJg7+Y+zAwvMW1gzifu8CtvysnPRV+6SP93Q1+oagotuzaIrAVfL+DIb2i5
         5dS7J9Z5eeCRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18298E52441;
        Tue, 11 Apr 2023 18:52:33 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230411071444.8357-1-dlemoal@kernel.org>
References: <20230411071444.8357-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230411071444.8357-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.3-rc7
X-PR-Tracked-Commit-Id: 2096134b5a00bf0bd15745d3a492039e801e84c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43fef9ae02fb5fa554e5df3c1899f06e4394cffc
Message-Id: <168123915309.3950.4875214941419679925.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Apr 2023 18:52:33 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Tue, 11 Apr 2023 16:14:44 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43fef9ae02fb5fa554e5df3c1899f06e4394cffc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
