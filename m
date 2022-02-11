Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468DEC4167D
	for <linux-ide@archiver.kernel.org>; Fri, 11 Feb 2022 20:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353167AbiBKUF2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:05:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353174AbiBKUF1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2022 15:05:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC7CE4
        for <linux-ide@vger.kernel.org>; Fri, 11 Feb 2022 12:05:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B63A562000
        for <linux-ide@vger.kernel.org>; Fri, 11 Feb 2022 20:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D7AC340E9;
        Fri, 11 Feb 2022 20:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644609925;
        bh=YvPY3/CUIbJr9BiDJdxhJSY49W4WPvs4awmep4ZAjUg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b4tv8OFhQ1Oqc1j6dMTWtjKtinLUusQmavHfx4YS2VcHKpj45m4ZULH3OzfQW2KhB
         WKp4YE1/8BY3mgiqH8gGVKiRkJTsOQjYbkYNBXfUWzQPcMLTSpGrKYyJmeYHXG3D1H
         RTNIyR5+mW9coNaqNinfKX60ejEtyx8NBRMwc49ycgixvp9JtboLd3uNJwLnN+pf7X
         IFL4rBuK2SwdK94GBuLMSG17ZNCuH1vE5ZHSgE2ldMr/I7ccbUfrBhMmJegTLuUpk8
         EjWB3E1vHXycZ99M0r66kkBIMsFQrJEBiV+byxp+WZ2ppSwu1hLf/q8D8DDjvsIaBH
         oLPKxlIFuD/vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13763E5CF96;
        Fri, 11 Feb 2022 20:05:25 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 5.17-rc4, followup
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220211130622.965310-1-damien.lemoal@opensource.wdc.com>
References: <20220211130622.965310-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220211130622.965310-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc4-2
X-PR-Tracked-Commit-Id: c8ea23d5fa59f28302d4e3370c75d9c308e64410
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 284fce0443329b641694894bd1757e4cda626c1f
Message-Id: <164460992507.1412.12661703849611461988.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 20:05:25 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org,
        "Justin M . Forbes" <jforbes@fedoraproject.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 11 Feb 2022 22:06:22 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/284fce0443329b641694894bd1757e4cda626c1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
