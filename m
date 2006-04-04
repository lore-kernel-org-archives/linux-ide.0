From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata machine check on Alpha
Date: Tue, 04 Apr 2006 12:05:52 +0900
Message-ID: <4431E290.6060707@gmail.com>
References: <1br232p2g092l611qrqvmvpuus2bqp7bc2@4ax.com> <4431CF4D.6000806@gmail.com> <4431D5F5.4010905@tw.ibm.com> <4431D6D1.9020206@gmail.com> <4431DEA3.5040202@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:50658 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964984AbWDDDF4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 23:05:56 -0400
Received: by zproxy.gmail.com with SMTP id o37so2069223nzf
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 20:05:55 -0700 (PDT)
In-Reply-To: <4431DEA3.5040202@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

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
