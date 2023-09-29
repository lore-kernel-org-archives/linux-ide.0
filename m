Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D89CE7AF3
	for <linux-ide@archiver.kernel.org>; Fri, 29 Sep 2023 20:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjI2UsO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 29 Sep 2023 16:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjI2UsO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 29 Sep 2023 16:48:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46091A7
        for <linux-ide@vger.kernel.org>; Fri, 29 Sep 2023 13:48:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C091C433C8;
        Fri, 29 Sep 2023 20:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696020492;
        bh=S9PZJ3seC8l5+5ovvaI6o8XrAd6O8kzh22gL0tUHy+U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O6Z2trFWJcLlyHr6GCrmTI+uQxshRykKtkT7msnCBBV/G7GfYYG6Y/V70y8rwAhIG
         jY+Yu2KMzoPeRBlUGENNoe1+x7G6fqMi5IvnqaSmed4+wff4P7pV7wI15uLhUD2QA/
         D2dryyzB3/02IOCWrXjDnNWifz0VE70FnmaKWCgjMS4je9wHCkkteuoo6X/4Ns9jlD
         2AfHELkz7OAyUNsA6wyAAd08FNJqMO9ySsQ09hP0K8SqLrcwKDHsP6v0zf/2tmIyJF
         bx3ZD196PP4P6C5uPgJUQusnk1SUVJ0E00/ZgSUIKh16WOqsFocNmgeJePOXrpSmHj
         Sa7YnFwgzITBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52728C395C5;
        Fri, 29 Sep 2023 20:48:12 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230929133324.164211-1-dlemoal@kernel.org>
References: <20230929133324.164211-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230929133324.164211-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc4
X-PR-Tracked-Commit-Id: 49728bdc702391902a473b9393f1620eea32acb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95289e49f0a05f729a9ff86243c9aff4f34d4041
Message-Id: <169602049233.6106.15402327378791787825.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Sep 2023 20:48:12 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 29 Sep 2023 22:33:24 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95289e49f0a05f729a9ff86243c9aff4f34d4041

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
