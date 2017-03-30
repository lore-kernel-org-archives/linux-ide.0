From: Darren Stevens <darren@stevens-zone.net>
Subject: Re: pata_atiixp: Fix IDE detection on SB7xx
Date: Thu, 30 Mar 2017 10:08:52 +0100 (BST)
Message-ID: <49d09a00a4e.6d8687b5@auth.smtp.1and1.co.uk>
References: <49ce56dc322.70129c23@auth.smtp.1and1.co.uk>
 <20170328170048.GD28157@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:52844 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932191AbdC3KJD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2017 06:09:03 -0400
In-Reply-To: <20170328170048.GD28157@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: tourula@gmail.com, linux-ide@vger.kernel.org

Hello Tejun

On 28/03/2017, Tejun Heo wrote:
> Hello,
>
> On Tue, Mar 28, 2017 at 04:57:16PM +0100, Darren Stevens wrote:
>> Commit: 5946fdaee4ba(pata_atiixp: Don't use unconnected secondary port
>> on SB600/SB700) disabled the check for secondary ports on AMD
>> SB700/710/750
>
>> While these chips have only 1 IDE port, it can be reconfigured on SB7xx
>> to appear as a secondary channel, especially when 'Legacy IDE emulation'
>> is enabled, breaking IDE detection on some boards with this chipset.
>> 
>> Fix by removing the check for SB7xx.
>> 
>> Fixes: 5946fdaee4ba(pata_atiixp: Don't use unconnected secondary port
>> on SB600/SB700)
>> Signed-off-by: Darren Stevens <Darren@stevens-zone.net>
>
> Hmmm... I can replace the revert with this but can you please explain
> why we want this in the commit message?  Also, it'd be nice to cc
> Markku and link to his report.

What would you prefer the commit message to say? I was only explaining why the
patch was needed.

I need to fix formatting anyway, as Sergei has pointed out, so either I rework
this or you revert as originally planned and I'll resubmit the original patch
for the SB600 only, whichever works best for you, I'm aware time is an issue
here.

I didn't include Markku as I'm not sure I should be adding people to the
Commit without their express permission.

I'm still quite new at this so sorry for causing all this trouble.

Regards
Darren

