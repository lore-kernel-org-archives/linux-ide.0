From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: add an observed PCI ID for Marvell 88se9172 SATA
 controller
Date: Thu, 30 May 2013 15:52:22 +0900
Message-ID: <20130530065222.GD21293@mtj.dyndns.org>
References: <20130529012231.GB2874@mtj.dyndns.org>
 <20130529123627.24818.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59136 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967616Ab3E3Gw0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 May 2013 02:52:26 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so8905461pde.18
        for <linux-ide@vger.kernel.org>; Wed, 29 May 2013 23:52:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130529123627.24818.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Wed, May 29, 2013 at 08:36:27AM -0400, George Spelvin wrote:
> As you saw, it didn't initially occur to me to prepare a patch at all;
> it seemed such a trivial copy/paste/one-character-edit exercise.
> After diagnosis, the most difficult part was writing a meaningful
> commit message.
> 
> Which I presumed would be easier for you; a lot of the difficulty for me
> was trying to figure out one line that would fit the ongoing narrative
> that is the kernel changelog.
> 
> I was actually surprised when you asked for a full patch, so I just sent
> you a copy of my private commit, with an improved commit message and S-o-b.
> (Should I have added "Cc: stable" to it?)
> 
> But since I now know you prefer even trivial changes like this in formal
> patch form, I'll try to do it right in future.

It's partly for convenience on my part but more to attribute changes
correctly.  This is something you did so if at all possible I'd like
you to take the credit and (however minute it may be) the accompanying
responsibility.  It doesn't have to be perfect and I'm happy to edit
the commit messages / patches as necessary and adding cc to stable.
Well, at least unless you're gonna be submitting large volume of
patches.

Thanks.

-- 
tejun
