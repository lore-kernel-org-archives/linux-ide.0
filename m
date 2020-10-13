Return-Path: <SRS0=uILu=DU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72723C433E7
	for <linux-ide@archiver.kernel.org>; Tue, 13 Oct 2020 20:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB8820872
	for <linux-ide@archiver.kernel.org>; Tue, 13 Oct 2020 20:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602621189;
	bh=hnx7FIvvdB6yf4j34gYOIXG5pjBEj4DxUn+1UxgBVtc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Mj2mcNgUDO0z63DmboDeHCoprmhxgD3llyXAMdTcFFoHyA9zxyERxCbsgtZA5G7C5
	 hWzK/tTdqPprR3PanlsSETbgVAJK4jibtapdZTirjF85K02ukMlJT0GJiVvt+WoPXq
	 yFXV90vjUEYI72hOIXOZT+mvSDE9UgDlkliMnjIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgJMUdI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 13 Oct 2020 16:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgJMUdI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 13 Oct 2020 16:33:08 -0400
Subject: Re: [GIT PULL] libata updates for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602621187;
        bh=hnx7FIvvdB6yf4j34gYOIXG5pjBEj4DxUn+1UxgBVtc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WJ9RyjQFPqrVt1+3T9ByEyyagUrEOIpnJRWkITj2Y4XunN4sFHBcTtIp4YFSTnD5N
         GNvOzPjn2ffeGgz7cN3v6iqT5N/OfgfvAD2PikClyW0XvzuW3p5JwQTQ4OgF5nOFvY
         NlqAU134lfKZlGKfxrp4jmT0kge/o2AhAJCj2F34=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d4e07ddd-092a-256a-5b25-841e95fa3fcc@kernel.dk>
References: <d4e07ddd-092a-256a-5b25-841e95fa3fcc@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d4e07ddd-092a-256a-5b25-841e95fa3fcc@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/libata-5.10-2020-10-12
X-PR-Tracked-Commit-Id: 45aefe3d2251e4e229d7662052739f96ad1d08d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79ec6d9cac46d59db9b006bc9cde2811ef365292
Message-Id: <160262118790.22802.10133242985400694711.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 20:33:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 07:48:15 -0600:

> git://git.kernel.dk/linux-block.git tags/libata-5.10-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79ec6d9cac46d59db9b006bc9cde2811ef365292

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
