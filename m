From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata dbg scheme conversion, take 1
Date: Fri, 30 Jun 2006 02:42:51 +0900
Message-ID: <44A4111B.5090601@gmail.com>
References: <20060629160912.GA23122@zmei.tnic> <44A407CF.4000508@gmail.com> <20060629171806.GA20882@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:64388 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751097AbWF2Rmb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 13:42:31 -0400
Received: by py-out-1112.google.com with SMTP id b36so346424pyb
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 10:42:30 -0700 (PDT)
In-Reply-To: <20060629171806.GA20882@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Borislav Petkov wrote:
> On Fri, Jun 30, 2006 at 02:03:11AM +0900, Tejun Heo wrote:
> <snip> 
>> Hello,
>>
>> I think this patchset is looking good generally.  Please consider the 
>> following.
>>
>> * Don't make currently visible-by-default messages invisible-by-default 
>> or vice-versa.
> The way I see it, we print by default everything marked ERR/WARN/DRV, as it is
> being done down in libata-core.c
> 
>> * Don't mix visiable-by-default messages with debug messages.  e.g. It 
>> seems you made ATA_MSG_INFO debug category and put EH messages and some 
>> debug messages into it.  This is not good.  EH messages should be 
>> visible to user by default && enabling it shouldn't turn on debug 
>> messages with it.
> Well, it is sometimes unclear what level exactly a message should be but afterwe
> have converted everything changing the level is as trivial as changing the
> ATA_MSG_* arg passed to ata_(port/dev)_printk so this won't be a problem. An
> initial overhaul of the levels will be needed once the conversion is done.
> Also, I tried to stick to the levels that were there previously so since their
> semantics changes too, now, that also introduces some small differences.

EH messages shouldn't be suppressed by default.

* During EH, IOs will stop and as a result the machine will act abnormal 
and can stutter for tens of seconds.

* EH means something is wrong with the hardware or the driver, so we 
need the log to analyze the problem.

* Initial probing is also done via EH.

I don't really see the benefit of discerning between DRV and INFO. 
IMHO, DRV should just be INFO which is enabled by default.

>> * Please create ATA_MSG_DEBUG category and put 
>> important-but-not-too-frequent debug messages into it.  
> Can you please define those "important-but-not-too-frequent" more precisely and
> support it with an example in the code?

I've commented such cases w/ 'DEBUG' in the review of the patches. 
Basically, any debug messages which isn't too frequent.  I don't think 
we need to go super-fine-grained with debug messages.  CMD/SG/TRACE 
generate way too many messages so they need to be in separate categories 
but other than that I don't see much point in making debug messages 
fine-grained.

>> * To me, DRV/INFO distinction doesn't seem to be clear.
> INFO was revalidation messages, EH progress and DRV are standard driver
> messages.

Hmm... I don't know.  EH messages should be printed, so they need to go 
into DRV.  Then we have only revalidation messages left in INFO which 
are few, so they can be put into DEBUG.  So, I don't see why INFO and 
DRV should be separate.  Just rename DRV to INFO and put all standard 
messages there.

Thanks.

-- 
tejun
