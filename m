From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Sun, 28 Sep 2008 07:09:35 +0900
Message-ID: <48DEAF1F.8040200@gmail.com>
References: <48C851ED.4090607@ru.mvista.com> <48CA8BEE.1090305@ru.mvista.com> <20080913.005904.07457691.anemo@mba.ocn.ne.jp> <200809271819.19510.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:32300 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbYI0WLB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 18:11:01 -0400
Received: by ti-out-0910.google.com with SMTP id b6so625781tic.23
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 15:11:00 -0700 (PDT)
In-Reply-To: <200809271819.19510.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, sshtylyov@ru.mvista.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@HansenPartnership.com>

Bartlomiej Zolnierkiewicz wrote:
> On Friday 12 September 2008, Atsushi Nemoto wrote:
>> On Fri, 12 Sep 2008 19:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> 
> [...]
> 
>>>>>> +	__ide_flush_dcache_range((unsigned long)addr, size);
>>>>>   Why is this needed BTW?
>>>> Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
>>>> inconsistency on PIO drive.  PIO transfer only writes to cache but
>>>> upper layers expects the data is in main memory.
>>>     Hum, then I wonder why it's MIPS specific...
>> SPARC also have it.  And there were some discussions for ARM IIRC.
> 
> I was under the impression that it has been addressed by Tejun at
> the higher-layer level (for both ide/libata) long time ago and that
> MIPS/SPARC code are just a left-overs which could be removed now?

cc'ing Jens and James.  IIRC, I posted several patches but they never
went in.  I don't remember what the objections were or whether any
alternative fix went in.

Thanks.

-- 
tejun
