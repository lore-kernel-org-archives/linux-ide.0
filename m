From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata NCQ blacklist entry
Date: Fri, 30 Nov 2007 07:57:04 +0900
Message-ID: <474F43C0.6080008@gmail.com>
References: <20071107111813.GA9064@dudweiler.stuttgart.redhat.com>	 <4731B5DD.1060203@gmail.com> <5501535d0711290917r16a16b0dx36669de89f829231@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:27036 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933703AbXK2W5M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 17:57:12 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1723812rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 14:57:11 -0800 (PST)
In-Reply-To: <5501535d0711290917r16a16b0dx36669de89f829231@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjoern Olausson <lkmlist@gmail.com>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Bjoern Olausson wrote:
> On 11/7/07, Tejun Heo <htejun@gmail.com> wrote:
>> Thanks.  We're currently trying to find out what's actually going on
>> with all these drives.  At first, drives which got blacklisted aren't
>> many and made sense (had other problems with NCQ, etc..) but with new
>> generation drives from many vendors showing the same symptom, we aren't
>> too sure now.
>>
>> I'll keep your email in my todo list and add the drive to the blacklist
>> once the problem is verified.
>>
>> Thanks.
> 
> Something new on the NCQ front?
> Just asking if you need someone to test some of your ideas?
> 
> I got the "WDC WD740ADFD-00NLR1"

I now have affected drives on my desk and am gonna try reproduce it.  My
gut feeling says it's timing related problem on controller / driver
side.  Please wait a bit.

> by the way, and OT, did the Plextor DVD-RW drive reach you, Tejun?

No, not yet.  Do you have a tracking number or something?

Thanks.

-- 
tejun
