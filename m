Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63A0C64EC4
	for <linux-ide@archiver.kernel.org>; Fri,  3 Mar 2023 18:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjCCSqy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Mar 2023 13:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjCCSqu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2023 13:46:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F45A6F7
        for <linux-ide@vger.kernel.org>; Fri,  3 Mar 2023 10:46:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB04E618C5
        for <linux-ide@vger.kernel.org>; Fri,  3 Mar 2023 18:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D2B4C433EF;
        Fri,  3 Mar 2023 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677869086;
        bh=ZsTC3v3v4RcGtjhUPTvq55fNVAXogXGiPMAUihNQQWY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nq+aUvqtPe5T2kQTvyR5kv3MYxGwYKqZ85yh9q/KZBrp7XFxM6kkeymdUiXHpkBHt
         txX3nY8FGtEwnDQY4D17dd3fwb/Bchvh6KFFloDcHrVwSl1GwKjXAVJf8Eajfd+uiN
         fWl2CNRsCYpnczpqCeCExNIOMdeuuFp0mv3Gv3vi70O7Pdjk/GgbQlYS8GkUoIG6Yd
         /nFEF4qhjzbdoO86eXtwkiA9duckbp+TxiCF71PKSXoo8hSM4NodW4qUWIeACEYxIl
         YaHzWIsXOal0idt/B18GFlvENB17uPqjRmRVavzoxJ2EIB1deVbPWbg/EvgT2C3e27
         VlER3X/cUp56w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B603E68D5C;
        Fri,  3 Mar 2023 18:44:46 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.3-fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230303094618.396676-1-damien.lemoal@opensource.wdc.com>
References: <20230303094618.396676-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230303094618.396676-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.3-fix
X-PR-Tracked-Commit-Id: 6210038aeaf49c395c2da57572246d93ec67f6d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bd1aee6cdb5c8cac8234fb72def4474012c2c49
Message-Id: <167786908617.30023.15256352069284690001.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Mar 2023 18:44:46 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri,  3 Mar 2023 18:46:18 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.3-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bd1aee6cdb5c8cac8234fb72def4474012c2c49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
