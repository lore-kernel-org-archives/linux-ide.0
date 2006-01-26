From: Tejun <htejun@gmail.com>
Subject: Re: [akpm@osdl.org: Re: 2.6.16 eating filesystems]
Date: Fri, 27 Jan 2006 01:49:41 +0900
Message-ID: <43D8FDA5.3000701@gmail.com>
References: <20060125185320.GL14225@havoc.gtf.org> <43D8373B.1070802@gmail.com> <20060126080544.GH4212@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:44 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964795AbWAZQtt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 11:49:49 -0500
Received: by zproxy.gmail.com with SMTP id 34so391470nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 08:49:48 -0800 (PST)
In-Reply-To: <20060126080544.GH4212@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nicolas.Mailhot@LaPoste.net, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jan 26 2006, Tejun Heo wrote:
> 
>>Jeff Garzik wrote:
>>
>>>----- Forwarded message from Andrew Morton <akpm@osdl.org> -----
>>>
>>>From: Andrew Morton <akpm@osdl.org>
>>>To: Jeff Garzik <jgarzik@pobox.com>
>>>Subject: Re: 2.6.16 eating filesystems
>>>Date: Wed, 25 Jan 2006 10:51:15 -0800
>>>X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
>>>
>>>Jeff Garzik <jgarzik@pobox.com> wrote:
>>>
>>>
>>>>Returning from a biz trip today, and will be looking (and/or passing the
>>>>buck to Tejun/Jens) at the stuff you mentioned.
>>>>
>>>>Was there just the one case of filesystem eating?
>>>>Pointers / message-ids / URLs?
>>>
>>>
>>>http://bugzilla.kernel.org/show_bug.cgi?id=5914
>>>
>>
>>The device reports FUA support.
>>
>>SCSI device sda: drive cache: write back w/ FUA
>>SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
>>
>>This is my first time to see an ATA drive which supports FUA, great. 
>>Anyways, my guess is...
> 
> 
> Really? I've seen several of them, in fact the Maxtor in my workstation
> here supports it.

[CC'ing Nicolas & linux-ide]

Hmm.. I just bought three SATA-II drives 7200.9, samsung and WD, and I 
have two NCQ maxtor drives Eric sent me (the ones with read log page 10h 
bug).  None of these reports FUA capability.  Can you let me know the 
model names of FUA-capable drives you have?

>>1. I screwed up libata FUA part.
>>2. Maxtor screwed up.  It reports FUA but chokes when one is given.
>>
>>Both will result in failure of all barrier requests and that won't be 
>>very good for filesystem integrity.
> 
> 
> Auch, test case?
> 

It's just a guess.  Weird thing with Nicolas's case is that the 
supposedly FUA failures resulted in filesystem corruption.  Plain ext3 
just backs out if it meets an error during barrier operation and no 
corruption occurs due to the failure.  It seems like dm/md isn't 
reacting very well to barrier failures.  I'm not sure at all.

What do you think about implementing auto-fallback?  If FUA-write gets 
aborted, the queue is switched to non-FUA mode and the barrier is 
retried.  This feature was in the first few drafts of the new barrier 
implementation but I dropped it because it was difficult to get right 
for ordered tags and is pretty clearly an over-design.  Hmmm... still 
doesn't sound right.

Anyways, it's clear that we need to do something to prevent data 
corruption on barrier failures.  Nicolas's case is just too scary.  It 
should warn and turn off barrier, not corrupt whole fs.  Maybe we should 
turn off libata FUA support until this issue is resolved?

-- 
tejun
