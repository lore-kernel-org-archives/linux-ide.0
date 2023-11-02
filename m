Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52422C4332F
	for <linux-ide@archiver.kernel.org>; Thu,  2 Nov 2023 00:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjKBABs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Nov 2023 20:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjKBABr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2023 20:01:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C050A11D
        for <linux-ide@vger.kernel.org>; Wed,  1 Nov 2023 17:01:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68D3EC433C7;
        Thu,  2 Nov 2023 00:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698883304;
        bh=FdJxvLGJfq6rfrhSaGJoo0XNGl0vQQLXiFVMNEGTZsk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WteRtfHB/TZpqLU0h93dyBfynC961PsgyHKVZT5QM/uErQwul+5F3ItpEEfB2R/u5
         3Bs9USTw3WnUBHp94HkaBAZZAlFmcxMgfFFuP+WyCstaF9a6O/JJ7SDI9c3h3jGIeJ
         TUAcc3eK2MNVnbMBgDY9jd9VVWgZLFbYC6Pu40zo0H7rw1gJl/bzmTniX4MoQnCY4Z
         sY2D4ogs6p3GJhe/3j5jWIx9Bj2n3vdjafZY3B6EycjdVJ0aUcx4uarCItwpYRTCAT
         /iSlpIXgfUP+BVElbYBLK4hvyp5RzL1iRfqImyxEyBz8wbzqvfroQBZK5Z4wWwwLJi
         KghHxJUXTWNVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55EE4C4316B;
        Thu,  2 Nov 2023 00:01:44 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231030064037.282268-1-dlemoal@kernel.org>
References: <20231030064037.282268-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231030064037.282268-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.7-rc1
X-PR-Tracked-Commit-Id: 0e533cba38011457b51f13b3b5afd33c693bfcca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39714efc23beb38ce850b29f4f132da6d997fc22
Message-Id: <169888330434.31464.8515235691244748369.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 00:01:44 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 15:40:37 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39714efc23beb38ce850b29f4f132da6d997fc22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
