From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Thu, 26 Sep 2013 19:14:49 +0200
Message-ID: <CAAsK9AEUoXLTN=MoCJyr1UCtKPQZ+on5O2CeqshYQGTpNBVuFg@mail.gmail.com>
References: <523EF645.7050808@linux.com>
	<20130922153959.GB28571@htj.dyndns.org>
	<523F10BB.8020503@gmail.com>
	<20130922160551.GD28571@htj.dyndns.org>
	<CAAsK9AF_sJFcNTkCAR1vE5O80bJ0OoUL2AykqOoUvZt=5AYnxQ@mail.gmail.com>
	<20130926140930.GA3482@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41]:55609 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab3IZROu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Sep 2013 13:14:50 -0400
Received: by mail-vb0-f41.google.com with SMTP id g17so1070807vbg.14
        for <linux-ide@vger.kernel.org>; Thu, 26 Sep 2013 10:14:49 -0700 (PDT)
In-Reply-To: <20130926140930.GA3482@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Kay Sievers <kay@vrfy.org>

2013/9/26 Tejun Heo <tj@kernel.org>:
> (cc'ing Kay)
>
> On Wed, Sep 25, 2013 at 04:40:30PM +0200, Levente Kurusa wrote:
>> I am getting the following output:
>> [    2.236379] ata_piix 0000:00:1f.2: MAP [
>> [    2.236492]  P0 P2 -- -- ]
>> Instead of the expected:
>> [    2.236379] ata_piix 0000:00:1f.2: MAP [ P0 P2 -- -- ]
>>
>> This might be a minor problem, but I think it is better the second way.
>> Of course, now that I better understand the code, I see that my fix to this,
>> is not the best. I will make a new patch, if you think this should be fixed.
>
> Hmmm... so, you're saying pr_cont() is misbehaving after dev_info()?
> If so, we don't want to paper over that from a low level driver like
> ata_piix.  Let's find out what's going on with pr_cont().
>
Yes, however I am not familiar with printk() and the likes (like _dev_info()),
but it looks like either _dev_info() is putting a trailing '\n' or
only KERN_CONT
lines can be continued, which is probably not the way it is, because I think
that sort of defeats the purpose.

Regards,
Levente Kurusa
