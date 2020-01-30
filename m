Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01074C2D0DB
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 18:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0295206F0
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 18:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580407237;
	bh=TVVDERnbLki7svyKzOyarGVOuHHjFwqBLbk8pS/iIKM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Q8egHz63KdUBaeQhwKoyzl42ISECwd5/KIm+o48/Y7qIN8HCQbf5VkPAMLAn6iN07
	 6AZmW5EC3bqVI1q0gMCJ7XKIHKT7HMoLDkYiIIj1OTF1dN6O+J3A7hHCHyOduhJvwR
	 /IiBuHnnEaqqW9EP5S5BSQ7qSMltjRlhmAuZ4qDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgA3SAU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:00:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbgA3SAU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 30 Jan 2020 13:00:20 -0500
Subject: Re: [GIT] IDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580407219;
        bh=TVVDERnbLki7svyKzOyarGVOuHHjFwqBLbk8pS/iIKM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=08aifFAukUW0CWZ7A+kr2tcJsnlEQpYEddSH0PEpqzdrWTQlXMgDQUtU6D7+MrhMg
         l41f4zFTBCUNuDC/uYNbk3oaFhJNl+wcdUvXyQbWDKF9yktI8IQup3HO57lDgqyL9n
         hyYNkFJvEq0u4mHg+jJqzJjqtNOmNSJdRiALjnmI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130.110713.2121058244629085751.davem@davemloft.net>
References: <20200130.110713.2121058244629085751.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130.110713.2121058244629085751.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master
X-PR-Tracked-Commit-Id: 2fd3c5c617937cde5aafa48db4f4056e1f705987
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e237e8c77279a0873a5e9806a5459ebc840c9ce
Message-Id: <158040721985.2766.17217644178676220349.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 18:00:19 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 11:07:13 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e237e8c77279a0873a5e9806a5459ebc840c9ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
