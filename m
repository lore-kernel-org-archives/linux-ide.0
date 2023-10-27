Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D3CC27C47
	for <linux-ide@archiver.kernel.org>; Fri, 27 Oct 2023 23:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjJ0Xoz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 27 Oct 2023 19:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0Xoy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 Oct 2023 19:44:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7CB1B1
        for <linux-ide@vger.kernel.org>; Fri, 27 Oct 2023 16:44:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B6C8C433C7;
        Fri, 27 Oct 2023 23:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698450291;
        bh=L+e616wpQYprSkBJiIRQqL/aWFi34MSra6Q4/ajG2Ec=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NJeGHo7zPz1qXBBGkwkS1Dl2fqa2NAa28vWGnq11XfRul5ZaxdU3QuDuDeMyC1Tf3
         G/rlw8MCUDNZCMys/JcyGJqYyNiSbMecO59OgftvkeVqH+2HlK/RoC+c6f0bTePJc/
         e911keXPZFLEjggWcim5NjLNkVzd05J2oTPfpa8/JADZIKwYj76tz6WhWhe8wq65oc
         zgnrjkwRPOkyCuNQbgISnnuYh7bzphKEb/FjGHKRqFAwTTdRcQ21/XuUzVgXKzfWkr
         0IkaNln7k82KVEUrnzJGIan6UmBpbqqDsmXxtWPmb3O8OYa+HSGJuxOyT33Y02m0UU
         BaiOW9fCWo/Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60017C39563;
        Fri, 27 Oct 2023 23:44:51 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.6-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027073115.170201-1-dlemoal@kernel.org>
References: <20231027073115.170201-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027073115.170201-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-final
X-PR-Tracked-Commit-Id: 24eca2dce0f8d19db808c972b0281298d0bafe99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 832328c9f8aa4b41423f29a53ba7080eb7214976
Message-Id: <169845029138.14431.376790954856465447.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Oct 2023 23:44:51 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 16:31:15 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/832328c9f8aa4b41423f29a53ba7080eb7214976

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
