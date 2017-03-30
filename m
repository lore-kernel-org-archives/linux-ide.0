From: Tejun Heo <tj@kernel.org>
Subject: Re: pata_atiixp: Fix IDE detection on SB7xx
Date: Thu, 30 Mar 2017 11:51:57 -0400
Message-ID: <20170330155157.GA22780@htj.duckdns.org>
References: <49ce56dc322.70129c23@auth.smtp.1and1.co.uk>
 <20170328170048.GD28157@htj.duckdns.org>
 <49d09a00a4e.6d8687b5@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36378 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933356AbdC3PwA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2017 11:52:00 -0400
Received: by mail-yw0-f176.google.com with SMTP id i203so26343035ywc.3
        for <linux-ide@vger.kernel.org>; Thu, 30 Mar 2017 08:51:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49d09a00a4e.6d8687b5@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>
Cc: tourula@gmail.com, linux-ide@vger.kernel.org

Hello,

On Thu, Mar 30, 2017 at 10:08:52AM +0100, Darren Stevens wrote:
> What would you prefer the commit message to say? I was only explaining why the
> patch was needed.

Oh, I want it to explain why it matters to mark the unused port dummy.
It does reduce the probing time, right?

> I need to fix formatting anyway, as Sergei has pointed out, so either I rework
> this or you revert as originally planned and I'll resubmit the original patch
> for the SB600 only, whichever works best for you, I'm aware time is an issue
> here.

Can you please generate the patch on top of the following branch?

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.11-fixes

The revert was days ago, so I don't wanna replace it at this point.
Let's just do an incremnetal patch on top.

> I didn't include Markku as I'm not sure I should be adding people to the
> Commit without their express permission.

I see.  I sometimes try to get permission if the person only wrote off
list but once things are on the mailing list I don't think there's
anything to worry about.  Just cc them.

> I'm still quite new at this so sorry for causing all this trouble.

No worries.  You're doing great. :)

Thanks.

-- 
tejun
