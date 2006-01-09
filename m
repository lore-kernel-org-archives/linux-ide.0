From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ide: add dcache flushing after PIO
Date: Mon, 09 Jan 2006 18:16:25 +0900
Message-ID: <43C229E9.6080705@gmail.com>
References: <20051221094847.GA12279@htj.dyndns.org> <20051221140022.GA25001@htj.dyndns.org> <20051221140344.GA1736@flint.arm.linux.org.uk> <43A969FD.3090106@gmail.com> <58cb370e0512210757n25ddd614p33f3d70c8ff813cd@mail.gmail.com> <20051221175416.GH1736@flint.arm.linux.org.uk> <20060107170623.GA15171@flint.arm.linux.org.uk> <58cb370e0601071217x390fc1fpbbc9866b38ac28d7@mail.gmail.com> <20060107212248.GJ31384@flint.arm.linux.org.uk> <58cb370e0601071441v2d2e8f6eq18ebd8ea0280d1d1@mail.gmail.com> <20060109090842.GB9189@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:62340 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751130AbWAIJQb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2006 04:16:31 -0500
Received: by zproxy.gmail.com with SMTP id 14so4135807nzn
        for <linux-ide@vger.kernel.org>; Mon, 09 Jan 2006 01:16:30 -0800 (PST)
In-Reply-To: <20060109090842.GB9189@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Steward <james.steward@dynamicratings.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Russell King wrote:
> On Sat, Jan 07, 2006 at 11:41:53PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
>>Tejun posted RFC to lkml which got zero replies so I thought
>>that I will apply his patch if it *works*.
> 
> 
> Which appears to have been missed.
> 
> 
>>>>So far there was none and nobody seemed to care to test/comment
>>>>this patch ("works fine" is enough).
>>>
>>>Odd, as demonstrated by the linux-ide archives above I've already
>>>commented on it.
>>
>>OK, we have discussed the way to fix the problem.
>>
>>Still nothing was said whether this patch *actually* works or not.
> 
> 
> That's because I've already suggested that the patch is over-complex
> and I'm waiting for an updated patch.  I'm not going to ask folk to
> test one patch which I know is doing far too much, only to have to
> ask them to test another patch later on.
> 
> IOW, I'm not going to waste folk's time with a patch I know isn't
> suitable.
> 
> 
>>Test original Tejun's patch then.
> 
> 
> I can't - I'm not able to reproduce the problem due to the systems
> I have available to me.
> 
> The way forward is an updated patch - Tejun's original patch updated
> with my comments.  Once that's available, folk can test a patch which
> stands a chance of making it into mainline.
> 
> 
> Let me make my position clear: I don't care about this problem myself
> because I don't see it.  That's why it's hung around since 2.4 times.
> My only involvement here is due to (a) other folk caring about it and
> (b) the lack of knowledge to get it fixed.
> 

Hi, Russel & Bartlomiej.

As the message to the lkml didn't get any replies, I kind of forgot 
about it.  And after Russel's explanation, I don't think my first 
approach is good.  I will make another patch according to what I've 
proposed in the message to lkml.  I'm currently burried under libata EH 
related stuff, but I think (or hope) it will be sorted out in a few days.

So, see you guys in a few days.  Thanks.

-- 
tejun
