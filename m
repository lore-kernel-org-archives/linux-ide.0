From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: dvdrw->cdrom
Date: Mon, 21 Jan 2008 08:12:51 -0600
Message-ID: <4794A863.8010801@shaw.ca>
References: <6d98c5450801110719t3979a4f4j6a515e2c3b7ffcd8@mail.gmail.com>
 <47944B76.5030804@gmail.com>
 <Pine.BSO.4.64.0801210243230.22203@transpose.10k.org>
 <47945CB5.4040708@gmail.com>
 <Pine.BSO.4.64.0801210454430.19381@transpose.10k.org>
 <47947036.2050402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:30333 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbYAUOMx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 09:12:53 -0500
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUZ00D9PZHH07B0@l-daemon> for linux-ide@vger.kernel.org; Mon,
 21 Jan 2008 07:12:53 -0700 (MST)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
 by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUZ00C1VZHHRSD0@pd2mr6so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Mon, 21 Jan 2008 07:12:54 -0700 (MST)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUZ00BQTZHGIO00@l-daemon> for linux-ide@vger.kernel.org; Mon,
 21 Jan 2008 07:12:52 -0700 (MST)
In-reply-to: <47947036.2050402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jake <kfc@10k.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jake wrote:
>>>> http://marc.info/?l=linux-ide&m=120069298104580&w=4
>>>>
>>>> It has been 2 weeks here hunting for some solutions,
>>>> can you recommend anything that I should try? Thank you.
>>> Can you please post full boot log from the working kernel && broken
>>> kernel?  It seems you were using ide-scsi driver previously, right?
>>> Also, w/ libata driver, does the reading part work okay?  Can you read
>>> cd's?
>> Sure, Tejun, here they are:
>>
>> working 2.6.16 kernel boot log
>> http://tinyurl.com/2xtzjf
>>
>> broken 2.6.23.9 kernel boot log
>> http://tinyurl.com/yvkq6v
>>
>> I will reboot as soon as my batch job completes to test the cds.
> 
> Does sata_nv.adma=0 fix your problem?

This is almost certainly the already-known DMA mask issue with ADMA 
enabled and memory over 4GB present.
