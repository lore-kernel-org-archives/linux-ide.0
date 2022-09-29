Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1626C4332F
	for <linux-ide@archiver.kernel.org>; Thu, 29 Sep 2022 15:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbiI2Pk6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbiI2Pkc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Sep 2022 11:40:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7271CB23
        for <linux-ide@vger.kernel.org>; Thu, 29 Sep 2022 08:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 842EF61964
        for <linux-ide@vger.kernel.org>; Thu, 29 Sep 2022 15:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E96B8C433C1;
        Thu, 29 Sep 2022 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465923;
        bh=drNWSCuW1sh9N1EXbAbBbxfwLImeBUvxiIJyUcuT0Hw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NzYotOXC/nMdovy+8Dhe0TbJppA2/ojg6jySfK4TNUEewtrqsxYvqFiig9kGxCD3C
         D4we732HkftTJ5hGGwEJtTG5nkNnQuUFrS0W78gEb5LJHMYmk9wo9EnZbeMaFFigxt
         KmlUfA29qM5Pv6ty6/p2+dS70s7c641flonlv9ztWXHJLWEzEJgQqdTrwoyf9dyp9F
         HPZWZoUhpW1TRCAiPPxMKJ0A2q0xtkmPLsIcPaE89a3X1ClxH0sFHHwhyiQCuooLVG
         4p1C/dnML/oKjFfF5e4DIOopgg5GGISqSBOlSIg4Hjap0yuk6rTYq31f4LYc6MNGj0
         3ysYc3D5O526g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6D22C070C8;
        Thu, 29 Sep 2022 15:38:43 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220929034501.9700-1-damien.lemoal@opensource.wdc.com>
References: <20220929034501.9700-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220929034501.9700-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.0-rc7
X-PR-Tracked-Commit-Id: 141f3d6256e58103ece1c3dd2835e871f1dde240
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71f187570592e74d32db4f52e7f50a64c11ee621
Message-Id: <166446592386.14842.1787169814219118327.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Sep 2022 15:38:43 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Thu, 29 Sep 2022 12:45:01 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71f187570592e74d32db4f52e7f50a64c11ee621

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
