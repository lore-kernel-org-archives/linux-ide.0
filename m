From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata machine check on Alpha
Date: Tue, 04 Apr 2006 10:49:07 +0800
Message-ID: <4431DEA3.5040202@tw.ibm.com>
References: <1br232p2g092l611qrqvmvpuus2bqp7bc2@4ax.com> <4431CF4D.6000806@gmail.com> <4431D5F5.4010905@tw.ibm.com> <4431D6D1.9020206@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:10210 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964976AbWDDCtT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Apr 2006 22:49:19 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k342nDJ4012319
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 22:49:13 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k342jsvm262566
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 20:45:54 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k342nCVX003764
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 20:49:12 -0600
In-Reply-To: <4431D6D1.9020206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Albert Lee wrote:
> 
>> Tejun Heo wrote:
>>
>>> Jonathan Blake Benson wrote:
>>>
>>>> I posted a couple of months ago regarding enabling libata.atapi on a
>>>> Digital Alpha 164LX, equipped with a Silicon Image 3114 controller.  I
>>>> decied to give kernel 2.6.16 (release, was previously using rc-1) a
>>>> shot, and it no longer longer panics.  I still have a Lite-ON DVD ROM
>>>> drive connected via a sil3611 bridge to port number 4, hoping that I
>>>> can avoid using the onboard CMD646.
>>>>
>>>> No panic this time, though it appears to throw a machine check.  The
>>>> system continues all the way to multi-user, and the Maxtor drives are
>>>> usable.  Hope the attached dmesg helps.  Let me know if I can be of
>>>> any assitance.
>>>>
>>> Can you build your kernel with ATA_DEBUG set and post dmesg?  Just
>>> change #undef ATA_DEBUG to #define ATA_DEBUG at the top of
>>> include/linux/libata.h
>>>
>>
>> For the SiI 3611 bridge + ATAPI devices, maybe the ATAPI_ENABLE_DMADIR
>> workaround should also be turned on as well. (in linux/libata.h)
>>
>> My JMicron 20330 bridge + SiI 3112 can handle ATAPI DMA without
>> the ATAPI_ENABLE_DMADIR workaround. However, the SiI 3611 bridge seems
>> need it.
> 
> 
> Is there any way to make this thing automatic?  'Recompile with #define
> tweak if you have some invisible bridge chip' doesn't sound too hot.
> 

The bridge is transparent to the software. So, it's hard to detect the chip
used. Maybe the SiImage developers know how to detect the chip?

For the time being, maybe we can use a module paramater instead of
compile time #ifdef. Will submit a patch for this later.
--
Albert

