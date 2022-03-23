Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EADC4332F
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 23:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbiCWXjW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346846AbiCWXiA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 19:38:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1252C6E781
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:36:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2FCD61840
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 23:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13398C340EE;
        Wed, 23 Mar 2022 23:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648078588;
        bh=hMOcEB2h+cPJQNXKTVazOPWQo/BWOKi9z/2pQJZ43is=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kHRn9+eyUUuyQvM4G7TOgIrAjQ4nv2ECVcpRvIuPyeiTivzeONHwBV2UCcbDd50fn
         KHZ+X8kh70q9AZHVIJNTRfZdS5uJylUgshT9PeDZVD3ULsrol9EdkFGJ0Xc3BNuoPX
         9aLUCVrQq0/0W70qJvQmu6Eupk04gHfo8YfGoNm6N52ChiYqUMkoel//1shZujA6Rz
         pVUYoOB1Z58zHuL9E2aSCROK2ZArJ883B6ZK0XiVLtPwN+CrdYW1bfu4eR8wqFvcyS
         kPTCb3Yx560xOWAlqvnrj6RPGg+pZPm7ae5zm7E/cmdSqWOsM9+yJk50I38K+LuhRr
         7XK9Yyo6fy1hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 018DDE7BB0B;
        Wed, 23 Mar 2022 23:36:28 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.18-rc1
X-PR-Tracked-Commit-Id: d268afa1ff6f582dede1819fbed7ded7442a406c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7d4b15372bde442059c7d6415afeba073a09474
Message-Id: <164807858800.14397.4465111615025879194.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 23:36:28 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Tue, 22 Mar 2022 15:56:08 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7d4b15372bde442059c7d6415afeba073a09474

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
