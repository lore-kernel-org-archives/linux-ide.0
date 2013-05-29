From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH] ahci: add an observed PCI ID for Marvell 88se9172 SATA controller
Date: 29 May 2013 08:36:27 -0400
Message-ID: <20130529123627.24818.qmail@science.horizon.com>
References: <20130529012231.GB2874@mtj.dyndns.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:58004 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965709Ab3E2Mg2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 May 2013 08:36:28 -0400
In-Reply-To: <20130529012231.GB2874@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org

> Applied to libata/for-3.10-fixes.  In the future, please base patches
> on top of git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
> for-XXX branches.

As you saw, it didn't initially occur to me to prepare a patch at all;
it seemed such a trivial copy/paste/one-character-edit exercise.
After diagnosis, the most difficult part was writing a meaningful
commit message.

Which I presumed would be easier for you; a lot of the difficulty for me
was trying to figure out one line that would fit the ongoing narrative
that is the kernel changelog.

I was actually surprised when you asked for a full patch, so I just sent
you a copy of my private commit, with an improved commit message and S-o-b.
(Should I have added "Cc: stable" to it?)

But since I now know you prefer even trivial changes like this in formal
patch form, I'll try to do it right in future.
