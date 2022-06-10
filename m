Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A786BC43334
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jun 2022 18:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbiFJSZ7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jun 2022 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349693AbiFJSZ5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2022 14:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D0D2AE4
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2022 11:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6AE4621E1
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2022 18:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43BA3C34114;
        Fri, 10 Jun 2022 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885554;
        bh=5QYl9NK60wUdIAtHRONcFdoPplv//o4x3V2jN4ZmUTw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DaUAMXJC11hn5tSy5zk1ZbPEvrQ/tzDz6OvKUabNzTz0xF0jxpUobGpAZb5OPt7mL
         mal1acoA6tHVy57UOoSucH1fZAnW+JlpwqiAPspWpH95GloKXHs+lONQA6o/+fveJG
         rI4Eq3ejK3pIkvF0j1l+HRAI3f2edORjPzgudmlwWwUQQiT5gvUDTFkT/9NiL+bktQ
         rIRSLzr7timyMCCopvAyCWR1OVKPl1trcjY31yvcJnYQfTEdHS2I7IgWF1JHHNwumm
         Tmbwlv0OrFuW7X5GfMhElV08P0wpoWzweZeb+mHMk6BkyKe1w8YNoJeDaCwWd/IQ7k
         Wft7mv2kmEUpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3064FE737EA;
        Fri, 10 Jun 2022 18:25:54 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220610112700.794521-1-damien.lemoal@opensource.wdc.com>
References: <20220610112700.794521-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220610112700.794521-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.19-rc2
X-PR-Tracked-Commit-Id: 481f7017c37a8c722a0b09985db1a35f15749d5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7a1d00e749f1357b48c1e50abf605819c1e8404
Message-Id: <165488555419.32117.2891248375234792840.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 18:25:54 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 20:27:00 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7a1d00e749f1357b48c1e50abf605819c1e8404

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
