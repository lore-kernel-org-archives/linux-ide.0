Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2A0C43217
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 20:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiBGUUJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 15:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241847AbiBGUOp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2022 15:14:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD1C0401E4
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 12:14:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3687F6132E
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 20:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D957C340EF;
        Mon,  7 Feb 2022 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644264884;
        bh=XberJCkALj+9MhUWkWJHA2JDXniKF6D9AUaAZ4r3JZM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HCCdbHzKGOCzgpmqsXN7bIAadaYtiFerMRExAqVLdSm9Vrr+jMHZEP1gqvFDzWo9N
         +mUjXi/Z7i0sDiLIp8DcnAoMq+r8mUwMsu3HBDPasrGJoReeGi4genwZ1xwud2kTsG
         CkTZZvpfgcMtSKXCLbPMkyghMBmpCAwnyRk77u8cWB27UqaL0fSg7A/Pdt5vXMGnc2
         RMpEJYjB/ThHocg86UOn29zuYTYuYgu7dR1/Fo8QfaquG+6RuBqtvyjgOdC9DcZC2G
         EWT5nGArt30xcrdTCbhfc/hw5hxig9P44GPPG13B0IkKjQJKUOc7DVel0v8BSUnQ3g
         waEkufNMjlu7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84CC1E5CF96;
        Mon,  7 Feb 2022 20:14:44 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220207140450.1072531-1-damien.lemoal@opensource.wdc.com>
References: <20220207140450.1072531-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220207140450.1072531-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc4
X-PR-Tracked-Commit-Id: fda17afc6166e975bec1197bd94cd2a3317bce3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ade8eef993c37a2a43e51a9b1f6c25509a2acce
Message-Id: <164426488454.18191.2127539811569742246.pr-tracker-bot@kernel.org>
Date:   Mon, 07 Feb 2022 20:14:44 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org,
        "Justin M . Forbes" <jforbes@fedoraproject.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Mon,  7 Feb 2022 23:04:50 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ade8eef993c37a2a43e51a9b1f6c25509a2acce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
