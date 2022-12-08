Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA29C10F1B
	for <linux-ide@archiver.kernel.org>; Thu,  8 Dec 2022 19:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLHT1F (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Dec 2022 14:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLHT0p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2022 14:26:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5AA99535
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 11:26:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ECA0B82607
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 19:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31E55C433D2;
        Thu,  8 Dec 2022 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670527602;
        bh=vQ+WKIftkUgmsF4RstOH6/c+kjI3WnD6cAhjvrrAGNw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OXOQKpKVn9ebYpQW2B2AeAjtr3iKQG3vjWraTsF4fn30p6hmUJ236bQMFPijReR3c
         Fgbafa71JSHycBRJuveYlCm+SNP45kp+66vXF3WJOZDj2StrwQvLmY6Zb58gtS1mAl
         zBA0gzykFMGmd50X0y+d/7IGKVY7ATKFQLf+MmXJlZ0yAqPtPObyUCTabyFLHkcn/h
         J+dPYYJ/RX6R5IFb2ySaHJ36Q00VQU4XzPRnj6M/iAsEXWfFona4OglhzLavtmaAW/
         tGBbD/kEFjE027sYu0Y2IIEfneI2gKJhSiV7pR7NVpgpMlR7Utq4/6ZwpVdPow0suv
         /iNdECwiJuvOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2048AC433D7;
        Thu,  8 Dec 2022 19:26:42 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.1-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221208023927.3982-1-damien.lemoal@opensource.wdc.com>
References: <20221208023927.3982-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221208023927.3982-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.1-rc8
X-PR-Tracked-Commit-Id: d95d140e83634e7914277862dee841564d02879f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57fb3f66a3aa3e92b6008124bfa641702bd69a53
Message-Id: <167052760212.15249.18000269508475048968.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Dec 2022 19:26:42 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Thu,  8 Dec 2022 11:39:27 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57fb3f66a3aa3e92b6008124bfa641702bd69a53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
