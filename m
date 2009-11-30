From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata PM question
Date: Sun, 29 Nov 2009 21:53:19 -0600
Message-ID: <4B1341AF.2000208@gmail.com>
References: <1259547765.2076.48.camel@pasglop>	 <1259547943.2076.50.camel@pasglop> <1259552541.2076.56.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:51493 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbZK3DxQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Nov 2009 22:53:16 -0500
Received: by ywh12 with SMTP id 12so3512364ywh.21
        for <linux-ide@vger.kernel.org>; Sun, 29 Nov 2009 19:53:22 -0800 (PST)
In-Reply-To: <1259552541.2076.56.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>

On 11/29/2009 09:42 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2009-11-30 at 13:25 +1100, Benjamin Herrenschmidt wrote:
>> On Mon, 2009-11-30 at 13:22 +1100, Benjamin Herrenschmidt wrote:
>>> Hi there !
>>>
>>> So I (finally !) resumed work on pata_macio.c to replace ide/pmac.c :-)
>>>
>>> I've started looking at the suspend/resume stuff. It looks like most of
>>> it just comes for free thanks to libata, yay ! :-)
>>
>>   .../...
>>
>> Oh, another question... where do we spin the disk down&  park it on
>> suspend ? I'm missed at least that part :-)
>
> Oh and finally, one last question for today ...
>
> In drivers/ide, we have a call to ledtrig_ide_activity() inside
> ide_do_rw_disk() which allows me to flash the front light on
> the powerbook.
>
> libata has no such thing.
>
> It's as simple as adding that call, if we want to keep the trigger named
> "ide-disk" but where to put it then ? In ata_scsi_rw_xlat() ? Yuck :-)
>
> Another option is to stick it in drivers/scsi/sd.c but the trigger
> should not be named ide-disk anymore ... Also it will start tiggering
> for any "pseudo scsi" device in the machine which is note quite the
> purpose... It would be nice if it really only triggered on libata and as
> such blink the led only for the internal HD on those powerbooks (unless
> you have some libata based PCMCIA stuff but that doesn't matter).
>
> Anyway, nothing fancy, just a quick hack to get the activity led
> back :-) I could always stick it somewhere in pata_macio.c but that
> would suck probably even more.

Looks like the only libata driver that currently does LED blinking is 
ahci (for external enclosures) and it's just handled there using 
qc_issue plus a timer. Most drivers don't need this and given that you 
need to do it only for specific devices and only your driver has that 
knowledge, I don't see much problem with just sticking the LED trigger 
call into your qc_issue or something similar. No sense in trying to make 
something generic if it's not generic..
