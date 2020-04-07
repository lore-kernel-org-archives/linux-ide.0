Return-Path: <SRS0=Xbu2=5X=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF00C2D0EC
	for <linux-ide@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FB820730
	for <linux-ide@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586289341;
	bh=DdsK/OKUpp/DaTXIu5GzJY7e9eBhbCVSF043546D5Jc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hudgEo0jTX/q4/kd8/erMj9yFCRwJBaU/r67cldog2E9KX1zMtDXHkvbjCy9/CDPD
	 8FU4AT0poYZNexxJ8K41CYqv5Axoswm9z50FjctP1cENw5DaSbBdQA+GKQD/U4H2WX
	 mQwHftkaqIbAiazz0BdyeTPYEyLWNmfskZJRCphE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDGTzY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgDGTzY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 7 Apr 2020 15:55:24 -0400
Subject: Re: [GIT] IDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586289323;
        bh=DdsK/OKUpp/DaTXIu5GzJY7e9eBhbCVSF043546D5Jc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QFMkmJtu5t4cCh3icLqLPGo4nvNznt1PZARJekiFCC4/ZXNZUNTlS4Lb4sSpDIp+p
         fpNaKm/jBhDUmnb0NB1xHMaXUDu1Yr0g8haXUQIgMX542rX+1Du1dZOdp1lplpIN3U
         OZ4Wl82p7LBb8I90mcJDpI4ZGAZkt3aYZ91fR2NM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200406.112410.1593839462932058.davem@davemloft.net>
References: <20200406.112410.1593839462932058.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200406.112410.1593839462932058.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master
X-PR-Tracked-Commit-Id: 78a515f9faf3af43cf9c4f61254dd1c5b3cb2d0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 498ff42d557df021632d50cbd3f438c2e09d9743
Message-Id: <158628932356.3792.13123860548701530577.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 19:55:23 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Mon, 06 Apr 2020 11:24:10 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/498ff42d557df021632d50cbd3f438c2e09d9743

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
