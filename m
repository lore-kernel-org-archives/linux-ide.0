Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9294EC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 23 May 2022 21:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiEWVkw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 May 2022 17:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiEWVkt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2022 17:40:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7299460D82
        for <linux-ide@vger.kernel.org>; Mon, 23 May 2022 14:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B68EDB81696
        for <linux-ide@vger.kernel.org>; Mon, 23 May 2022 21:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BFACC385AA;
        Mon, 23 May 2022 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653342043;
        bh=mZWtN0ihVUP6DG0k+Zt1euj3Occ93VoHkWrne0OOoG0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IBFWBX9mJaNW+1K7nG/m9mGsBReMdUsVDlTMgAiDQczt4ZRgLR/Wel2v1N9xsOWga
         m4ipBrZmqGMHw6eyYFkItfPsoNJZAnzf0jz3X3tk+YcYvhzsqnDcmJoHZO9Vekr3Yn
         pavM46t/6RmJWrtd45Ma/lYl7X9RwjJwYhW8w4b0onnp9uhTIhprjEkgO639KpcWMl
         h4pQVdxmnHCAJgGBmTRJbuEHOT4qDnShs7B4yP6hGxHc6CoUwb1edqMx6ZGJgeUsS4
         B7Uotnosi+GzuShKo/fMGYVmFeS9ubgiHdxNA3Kb8JmZ6K2Pzr6ls4pe7S4QEinlVO
         oVs5Qj4uERr8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39479F03935;
        Mon, 23 May 2022 21:40:43 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523043903.328279-1-damien.lemoal@opensource.wdc.com>
References: <20220523043903.328279-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523043903.328279-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.19-rc1
X-PR-Tracked-Commit-Id: 71abb4df29815d17f3dff98dce553fc1732d9738
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a32f81a89cf3b0b0e1cc626f7f7777f62adf99d
Message-Id: <165334204323.21378.7171424072633392380.pr-tracker-bot@kernel.org>
Date:   Mon, 23 May 2022 21:40:43 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 13:39:03 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a32f81a89cf3b0b0e1cc626f7f7777f62adf99d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
