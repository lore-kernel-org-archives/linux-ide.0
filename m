Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3169C636D6
	for <linux-ide@archiver.kernel.org>; Wed, 22 Feb 2023 21:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjBVVuI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Feb 2023 16:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjBVVuG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2023 16:50:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD97F39BAB
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2023 13:50:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10334616D6
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2023 21:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8504EC433EF;
        Wed, 22 Feb 2023 21:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677102532;
        bh=cQ6KPQtv0VCDFZgZqx4X5u0L8FZior4WMnIi8JPUlJQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qLPnwR3YBTFga8XwIWhsPEzHBtl0BO3aGSGQG/tokJM+UqmAw3yd1ROaCbuEObCga
         Js1HmMrg9p7lErKKL+JTuoFdXL+ONdeVd5O0EdtnzuNGNshon5dtddTxfC3SDISLOC
         ByFtWB8JSqJ/SdewZshmsOCTUmFHZmB4l3BuT222k66AaseMBj9F5UyssPxXzZwzRQ
         kQNC5bd4MycG10ZlTTWx/vs3ZYUx6U87EoX5e4DKxW3ZmsDxo0bSAP/j1qC1oaQ0UE
         plDlDPyQK+lw3VF0KtH4JLtdKY0P0GqYxKGZrAQmYDA6eCVbhCyN4dFfd4Xl1PH0+3
         XjIwnmjICwyZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73E52C43157;
        Wed, 22 Feb 2023 21:48:52 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230221233024.927877-1-damien.lemoal@opensource.wdc.com>
References: <20230221233024.927877-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230221233024.927877-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.3-rc1
X-PR-Tracked-Commit-Id: 8844f0aa8dc42f54dc278c8d4ecbf32e92f2d6f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6861eaf79155f0a5544ff989754159f806795c31
Message-Id: <167710253247.31368.16743015498599583958.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 21:48:52 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 08:30:24 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6861eaf79155f0a5544ff989754159f806795c31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
