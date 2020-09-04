Return-Path: <SRS0=qdst=CN=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F65FC43461
	for <linux-ide@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BD020C56
	for <linux-ide@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599252552;
	bh=SHzPNAJPdsFXsZpClmW+/wuOVTP6VHyCAmnWcwO7gSI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xUb+ecjEC3OrzT13kjVE7uXch/TRoYUBV9BmW7Y72BpU6y+u1wYJQdHaddkC5Nghy
	 FJ9Np0YGXa2f4GB7m1UG2BcHAtn4qPAfZm9TSkmyRdgB2T/mKh2AuhAFWgXvNa2Qj1
	 5zCKKlQq/TzEGeHUXLgLfEvNc4oZKRFYdGg4+PwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIDUtK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgIDUtK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:10 -0400
Subject: Re: [GIT PULL] libata fixes for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252549;
        bh=SHzPNAJPdsFXsZpClmW+/wuOVTP6VHyCAmnWcwO7gSI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y6c8Lc5d9pK6pnGBlV8I3TO5CMWcl5VvK+eaNBGCeCeSdvm6NNUeyasBp4Jk1OWPq
         6uxpsy5toulFcD8CzNSU5KGMkhTP9ubq49ZkLYeBngIMzIa4M7F0KyhIFmWiaLKrpq
         2AVIcPlCv3I5PuPmUZHiuTXY3PCm4rxWzIUcF6+M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ecf36c20-0cfd-9010-84f7-334e3ea3b67d@kernel.dk>
References: <ecf36c20-0cfd-9010-84f7-334e3ea3b67d@kernel.dk>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <ecf36c20-0cfd-9010-84f7-334e3ea3b67d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/libata-5.9-2020-09-04
X-PR-Tracked-Commit-Id: 3b5455636fe26ea21b4189d135a424a6da016418
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d824e0809ce3c9e935f3aa37381cda7fd4184f12
Message-Id: <159925254982.25529.1538564870537095655.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 09:26:04 -0600:

> git://git.kernel.dk/linux-block.git tags/libata-5.9-2020-09-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d824e0809ce3c9e935f3aa37381cda7fd4184f12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
