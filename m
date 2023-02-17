Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892A7C636D6
	for <linux-ide@archiver.kernel.org>; Fri, 17 Feb 2023 22:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBQWrp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Feb 2023 17:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjBQWrm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2023 17:47:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125C642EF
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2023 14:47:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 350F8B82E78
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2023 22:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D076FC433EF;
        Fri, 17 Feb 2023 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676674058;
        bh=dHT9q3bGyYox2cKaGTgDgYx/jMayBwNsru4Uj1GKGRQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LItOsDmMi+lSeojbWGnCnFx+oVjkkeF7svPXqJsBaSlIp8Vf/XMHzgxHjnRkHwSjh
         Tuj8hNhNL0nJl/m8yyqZemfPgM/yMIH7EbGjV+QYFMGgs5iQEsNwXiFS+159QSdEFp
         /mUjT1/DyIBbiJUxLdzLnIjQv6cUwiIYE6MSguP45AxpgkiB1ORT5VcBsjRc8dtvWk
         HODxC3dhfQ9jkL8FpjfEmSNPedCT9FJ5LQkPFAh8f+fEOS5E81ofCxxvCFYxptdkkn
         vd8p5iaCA5Ab1c4hCu6g9izvvr4BLi5Gln4xxYoW919I0qUC7sXxKKu4a4loBBsTvy
         oI3s02cqBNxUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF354E68D2F;
        Fri, 17 Feb 2023 22:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.2-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230217104139.789424-1-damien.lemoal@opensource.wdc.com>
References: <20230217104139.789424-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230217104139.789424-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.2-rc8
X-PR-Tracked-Commit-Id: 1aff53b2fd903b300dfd71af0064c21fbca313c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d2e62e162e143330f8543e88bc298c77ca34e03
Message-Id: <167667405877.13496.17642851017806515649.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Feb 2023 22:47:38 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 19:41:39 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.2-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d2e62e162e143330f8543e88bc298c77ca34e03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
