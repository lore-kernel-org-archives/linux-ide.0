From: Stefan <gentoopower@yahoo.de>
Subject: Re: System freezes with kernel >2.6.19 - sata_nv [added crash info
 kern 2.6.21.1]
Date: Thu, 03 May 2007 00:04:46 +0200
Message-ID: <46390AFE.8000800@yahoo.de>
References: <46351BE2.70901@yahoo.de> <4635BF4A.3050509@gmail.com> <46367F58.7000609@shaw.ca> <4636A4DC.8070606@gmail.com> <4637CCEA.8020202@yahoo.de> <4637D3FA.2070403@shaw.ca> <463878E5.4020607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:53503 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993180AbXEBWE5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2007 18:04:57 -0400
In-Reply-To: <463878E5.4020607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Robert Hancock wrote:
>   
>> Stefan wrote:
>>     
>>> Okay, I had time to set this up. I'm attaching the log messages I got
>>> via netconsole.
>>>
>>> I tested about 20h with adma disabled, the crash won't occur.
>>>
>>> If I remove
>>>
>>> sata_nv.adma=0
>>>
>>> from boot options again it doesn't take long until my machine locks up.
>>>
>>> [Attached dmesg output with 2.6.21.1 kernel + crash info I got via
>>> netconsole]
>>>
>>> I hope this is useful to you guys.
>>>       
>> It looks like you've got SError bits set from the controller, 0x200000
>> means link layer CRC error (btw, we really should be decoding that error
>> and printing it in human readable form rather than making people pore
>> through the SATA spec and count bits).
>>     
>
> Hmmm... Maybe, but most of the bits are nearly meaningless to end users
> anyway.
>
>   
>> First thing you should try is replacing the SATA cable to that drive.
>>     
>
> Yeap, please apply some hardware debugging techniques - replacing /
> reseating SATA cables and connecting it to different power connector.
> But it's disturbing to see machine lock up even if CRC error occurs.
> sata_nv non-adma interface locks the whole machine up too after certain
> error conditions but I thought adma was saner than that.  I hope we can
> work around this somehow.
>
> Thanks.
>
>   
I have just replaced the cables with brand new ones, still no change the
machine freezes ~10min after boot.
Sometimes I even have to completely power down the machine to be able to
boot again.
