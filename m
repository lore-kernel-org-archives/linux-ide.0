From: Tejun Heo <htejun@gmail.com>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Wed, 23 Aug 2006 02:26:07 +0900
Message-ID: <44EB3E2F.4040504@gmail.com>
References: <44EB32E4.8080706@mvista.com> <44EB33BB.4090101@gmail.com> <44EB3650.1080404@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:56489 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932293AbWHVR1L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 13:27:11 -0400
Received: by wr-out-0506.google.com with SMTP id i28so462814wra
        for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 10:27:10 -0700 (PDT)
In-Reply-To: <44EB3650.1080404@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-ide@vger.kernel.org, Deepak Saxena <dsaxena@mvista.com>

Kevin Hilman wrote:
> Tejun Heo wrote:
>> Kevin Hilman wrote:
>>> I have a Silicon Images 3112 PCI card on an XScale IXP425 platform.  
>>> The card works well in a PC, but I haven't got it to work in on the 
>>> ARM platform.  On the PC, I see the cards BIOS executed and am 
>>> guessing that since this can't happen on the ARM, that's why things 
>>> aren't working.
>>>
>>> The card is at least detected on the ARM, and the driver tries to 
>>> probe for devices, but times out an moves on.
>>>
>>> Before I debug this too deeply, I want to make sure this should work 
>>> on embedded boards, even without the BIOS execution.
>>
>> sil3112 works fine w/o any BIOS initialization.
>>
> 
> I'm curious what platforms this has been tested.  Any non-x86 platforms? 
>  Any big endian platforms?
> 
> Thanks for the quick response.

I've personally seen it working on XScale and ATI's mips.

-- 
tejun
