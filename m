From: "Carlos Pardo" <Carlos.Pardo@siliconimage.com>
Subject: RE: libata machine check on Alpha
Date: Tue, 4 Apr 2006 10:12:51 -0700
Message-ID: <2E9B8131C44AF746B1E06BF9B15A434B045D8198@mail.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.siimage.com ([12.24.47.101]:60198 "EHLO mail.siimage.com")
	by vger.kernel.org with ESMTP id S1750749AbWDDRLS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Apr 2006 13:11:18 -0400
Content-Class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, albertl@mail.com
Cc: Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org


The 3611 bridge does not support the ATAPI DMA direction bit in hardware.(software support only)  

The 3811 bridge supports ATAPI DMA direction bit in both software and hardware.

The 646 chip is ancient and he should upgrade.  The behavior of this device is unknown since this part was EOL'd years ago.


-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Monday, April 03, 2006 8:06 PM
To: albertl@mail.com
Cc: Jonathan Blake Benson; linux-ide@vger.kernel.org; Carlos Pardo
Subject: Re: libata machine check on Alpha

Albert Lee wrote:
> Tejun Heo wrote:
>> Albert Lee wrote:
>>
>>> Tejun Heo wrote:
>>>
>>>> Jonathan Blake Benson wrote:
>>>>
>>>>> I posted a couple of months ago regarding enabling libata.atapi on a
>>>>> Digital Alpha 164LX, equipped with a Silicon Image 3114 controller.  I
>>>>> decied to give kernel 2.6.16 (release, was previously using rc-1) a
>>>>> shot, and it no longer longer panics.  I still have a Lite-ON DVD ROM
>>>>> drive connected via a sil3611 bridge to port number 4, hoping that I
>>>>> can avoid using the onboard CMD646.
>>>>>
>>>>> No panic this time, though it appears to throw a machine check.  The
>>>>> system continues all the way to multi-user, and the Maxtor drives are
>>>>> usable.  Hope the attached dmesg helps.  Let me know if I can be of
>>>>> any assitance.
>>>>>
>>>> Can you build your kernel with ATA_DEBUG set and post dmesg?  Just
>>>> change #undef ATA_DEBUG to #define ATA_DEBUG at the top of
>>>> include/linux/libata.h
>>>>
>>> For the SiI 3611 bridge + ATAPI devices, maybe the ATAPI_ENABLE_DMADIR
>>> workaround should also be turned on as well. (in linux/libata.h)
>>>
>>> My JMicron 20330 bridge + SiI 3112 can handle ATAPI DMA without
>>> the ATAPI_ENABLE_DMADIR workaround. However, the SiI 3611 bridge seems
>>> need it.
>>
>> Is there any way to make this thing automatic?  'Recompile with #define
>> tweak if you have some invisible bridge chip' doesn't sound too hot.
>>
> 
> The bridge is transparent to the software. So, it's hard to detect the chip
> used. Maybe the SiImage developers know how to detect the chip?
> 
> For the time being, maybe we can use a module paramater insted of
> compile time #ifdef. Will submit a patch for this later.

[CC'ing Carlos Pardo]

Hello, Carlos.

Is there anyway to detect SiL3611 bridge?  As written above, the chip 
requires a workaround in libata and it would be nice if we can do it 
automatically.

Thanks.

-- 
tejun
