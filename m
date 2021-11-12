Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5317AC4332F
	for <linux-ide@archiver.kernel.org>; Fri, 12 Nov 2021 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E3E604D7
	for <linux-ide@archiver.kernel.org>; Fri, 12 Nov 2021 20:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhKLUpB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 12 Nov 2021 15:45:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235616AbhKLUpA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 12 Nov 2021 15:45:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8224A604DC;
        Fri, 12 Nov 2021 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636749729;
        bh=fhCYrLz6On2iF9/PqRzVGhUIyFE83mwaePM7JIi38pw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BmAHGkNV52z2bvPxx22AEk9ifBro+sY6bu6FReJEEs376Qp1PldFKfrvIw8Yyb4Fh
         vbPHv2Z4pjS+h28qTILo/+vVKNZ+zUuLWQeeOSeklaNAMGB5w/tJIc6TKXf9PfCHLK
         pZUjoZdJq8zn5QlDzymJVaxZJxT38Hs4YTlcZS8ShoJGbeAnUWx8/Z3NrRZmiZaWCH
         z8ymhJ8GQ3u6ASXvKQUh2FkhAoUDSw4/3x/l/+Zt6NY4C+UTNWN6Pyiolj69zEz5hg
         GsKbuCWh52pGWy6f4nbMMRy5M9+20xin1qBIf8s+Eq706tXLOxD0uQ34NkkJQnFJdR
         CC92M+X6C2v9A==
Subject: Re: [GIT PULL] second round of libata changes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211112002506.564912-1-damien.lemoal@opensource.wdc.com>
References: <20211112002506.564912-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211112002506.564912-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc1-p2
X-PR-Tracked-Commit-Id: 1b87bda1f29a91720a410ac0819866a3cf0df32d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 204d32efa8a5746682dab5038d8b54a359bb0e3e
Message-Id: <163674972950.4802.5192152298303436090.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Nov 2021 20:42:09 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Fri, 12 Nov 2021 09:25:06 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc1-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/204d32efa8a5746682dab5038d8b54a359bb0e3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
