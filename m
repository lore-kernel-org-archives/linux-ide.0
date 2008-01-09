From: Tejun Heo <htejun@gmail.com>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Wed, 09 Jan 2008 14:09:28 +0900
Message-ID: <47845708.6060900@gmail.com>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca> <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com> <4782C008.3030902@shaw.ca> <4782CB62.7040901@gmail.com> <4782CEF9.3040708@gmail.com> <4782DFFE.50301@shaw.ca> <4782E5A8.9010305@gmail.com> <4782E63E.1000606@gmail.com> <4782E78F.9050205@shaw.ca> <4782E912.1050204@gmail.com> <4783493A.7070800@gmail.com> <47838B57.8020407@shaw.ca> <47842A54.2060107@gmail.com> <47842ABA.2060605@gmail.com> <47844471.4070705@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:30657 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbYAIFJh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 00:09:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so174277wah.23
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 21:09:35 -0800 (PST)
In-Reply-To: <47844471.4070705@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

Robert Hancock wrote:
> Tejun Heo wrote:
>> Tejun Heo wrote:
>>> Robert Hancock wrote:
>>>> Tejun Heo wrote:
>>>>> Tejun Heo wrote:
>>>>>>> [   34.466899] testing NMI watchdog ... <4>WARNING: CPU#0: NMI
>>>>>>> appears
>>>>>>> to be stuck (0->0)!
>>>>>>> [   34.555056] WARNING: CPU#1: NMI appears to be stuck (0->0)!
>>>>>> Oops, missed that.  I'll see whether there's IRQ storm going on.
>>>>> I made the nv irq handler to print message every 100th time and it
>>>>> says
>>>>> nothing after lock up and no response to keyboard, sysrq or
>>>>> serial.  It
>>>>> seems like a solid lock up to me.  Anything else you want me to try
>>>>> out?
>>>> I assume that replugging or unplugging cables after that point doesn't
>>>> bring it back to life?
>>> Nope.  The machine is a solid brick.
>>>
>>
>> If you want, I can ship the board + processor + cooler to you for
>> debugging.  I guess it will be more useful in your hands than mine.
> 
> If it's an A8N-E I'd be surprised if it behaved differently from my
> A8N-SLI Deluxe, though maybe it's a different chipset revision or
> something.. The last time I tested hotplug on here it seemed to work
> fine, though I haven't done any rapid disconnect/reconnect tests.
> 
> How about putting a bunch of printks inside the interrupt handler? That
> would tell us if it's even reaching the interrupt handler..

If you give me a patch, I'll apply it and cause lock up and report the
result.  Just shoot the patches my way.  But maybe reproducing the lock
up on your machine would be the better solution.  It isn't difficult at
all.  Plug in, fire up IO, disconnect, wait.  Connect different drive.
Rinse and repeat.  It will lock up pretty soon.

-- 
tejun
