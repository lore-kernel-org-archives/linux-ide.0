Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52533C77B7E
	for <linux-ide@archiver.kernel.org>; Wed, 26 Apr 2023 20:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbjDZUNa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbjDZUN3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 26 Apr 2023 16:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11471A4
        for <linux-ide@vger.kernel.org>; Wed, 26 Apr 2023 13:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AF8163032
        for <linux-ide@vger.kernel.org>; Wed, 26 Apr 2023 20:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF741C433EF;
        Wed, 26 Apr 2023 20:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682540004;
        bh=WO/5+LGGviRdeBCSjr1Fdbi4Meqrk9SaSvIQtA3QZM4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DiZ+R1WCUpP/zDt9/sqsy/W1pyX1Nbq/SY4PaPz1wQlFKCQ4+OVg/cOwQhM4bsOtV
         tWFORR89hbr8fLEltjSVmiJk/fYJmWzKIiVA11PaqpI7UZrOvXj+Udum01FkkxHkeE
         RVBVDjneFlJbj98u8oYsE5OPL8HhqF4j1ASqsztHqFQfGCnD4pzvu8H0rzZUGujkfN
         jbtjmnB+SO35sYniVo6+UPScen0r1b1h+PuYMAIkaR8sz6JxUEVgeDLS52mCpW8xF4
         EtVgQfIgYte8lzmqZ4BzNw0zjYybZQavubxOW1idV5vqw+Sonm08Za6ed+/Awztc/G
         tO2cwrNBU5k0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6B06C43158;
        Wed, 26 Apr 2023 20:13:23 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425142311.186448-1-dlemoal@kernel.org>
References: <20230425142311.186448-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230425142311.186448-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc1
X-PR-Tracked-Commit-Id: 140b26035b2d379d94e6e3936ab2e0adf94efe46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36006b1d5c04692924f011aa949e8788f1c604de
Message-Id: <168254000386.27655.682279311808732456.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 20:13:23 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 23:23:11 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36006b1d5c04692924f011aa949e8788f1c604de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
