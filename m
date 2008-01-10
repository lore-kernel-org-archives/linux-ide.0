From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_nv: disable ADMA mode by default
Date: Thu, 10 Jan 2008 15:29:25 +0900
Message-ID: <4785BB45.5040304@gmail.com>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca> <478246AE.3020500@gmail.com> <4785B3F6.4000802@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:37295 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbYAJG3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 01:29:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so884638wah.23
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 22:29:33 -0800 (PST)
In-Reply-To: <4785B3F6.4000802@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Robert Hancock <hancockr@shaw.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hello, haven't fell asleep yet?

Jeff Garzik wrote:
> Tejun Heo wrote:
>> There still are remaining issues with ADMA support.  Disable it by
>> default and warn when enabling.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>> Jeff, please hold off till Robert acks.  Robert, what do you think?
>>
>>  drivers/ata/sata_nv.c |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Don't worry, I won't "pull the trigger" immediately and without a lot of
> discussion.  (and please help keep nvidia cc'd on changes to sata_nv)
> 
> Current sleepless (thus discountable? :)) thoughts:
> 
> * definitely leaning towards adma=0 default.  if distros are disabling
> it, and upstream is not, that's a big hint :)

Well, here the distro is just 'me', so don't put too much weight on it.
 Maybe I'm just stressed out from all the bugs.

> * By switching to the tried-and-true legacy-IDE-like interface, adma=0
> seems to make a lot of problems go away.
> 
> * It is so late in 2.6.24-rc, it seems unlikely that we have enough time
> for testing such a major, fundamental behavior change in sata_nv, this
> late in the game.
>
> If it weren't for the time factor, I would be in favor of applying the
> patch and getting test results.

Everyone using suse using CK804 will end up testing adma=0 in a few
weeks.  Let's see how it explodes.

-- 
tejun
