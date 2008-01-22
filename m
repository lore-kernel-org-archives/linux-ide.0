From: Jake <kfc@10k.org>
Subject: Re: dvdrw->cdrom
Date: Mon, 21 Jan 2008 22:42:44 -0500 (EST)
Message-ID: <Pine.BSO.4.64.0801212237230.13449@transpose.10k.org>
References: <6d98c5450801110719t3979a4f4j6a515e2c3b7ffcd8@mail.gmail.com>
 <47944B76.5030804@gmail.com> <Pine.BSO.4.64.0801210243230.22203@transpose.10k.org>
 <47945CB5.4040708@gmail.com> <Pine.BSO.4.64.0801210454430.19381@transpose.10k.org>
 <47947036.2050402@gmail.com> <4794A863.8010801@shaw.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bruno.cs.columbia.edu ([128.59.18.129]:5292 "EHLO
	bruno.cs.columbia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbYAVDnU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 22:43:20 -0500
In-Reply-To: <4794A863.8010801@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

>> Jake wrote:
>>>>> http://marc.info/?l=linux-ide&m=120069298104580&w=4
>>>>> 
>>>>> It has been 2 weeks here hunting for some solutions, can you 
>>>>> recommend anything that I should try? Thank you.
>>>> Can you please post full boot log from the working kernel && broken 
>>>> kernel?  It seems you were using ide-scsi driver previously, right? 
>>>> Also, w/ libata driver, does the reading part work okay?  Can you 
>>>> read cd's?
>>> 
>>> I will reboot as soon as my batch job completes to test the cds.
>> 
>> Does sata_nv.adma=0 fix your problem?
>
> This is almost certainly the already-known DMA mask issue with ADMA enabled 
> and memory over 4GB present.

Tejun,

the boot flag made the difference!
Ahh, so it is > and = 4GB (I have exactly 4GB).

I will pass on the wisdom in hope to save someone
else a few hours down the road.

Thank you!

Jake
