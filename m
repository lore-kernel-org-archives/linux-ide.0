From: Jeremy Smith <alceste@xmission.com>
Subject: Re: PROBLEM: Silicon Image 3112 Lockups
Date: Tue, 6 Sep 2005 21:21:20 -0600 (MDT)
Message-ID: <Pine.LNX.4.63.0509062102290.11772@xmission.xmission.com>
References: <Pine.LNX.4.63.0509061835230.2270@xmission.xmission.com>
 <431E4A0A.3060504@gmail.com> <431E4CDA.6090909@pobox.com> <431E519A.2090905@gmail.com>
 <431E5380.8010601@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mgr2.xmission.com ([198.60.22.202]:22416 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP id S1750913AbVIGDVX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Sep 2005 23:21:23 -0400
In-Reply-To: <431E5380.8010601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alexander Shaposhnikov <shaposh@isp.nsc.ru>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Paul Taylor <Paul.Taylor@siliconimage.com>, linux-ide@vger.kernel.org


On Wed, 7 Sep 2005, Tejun Heo wrote:

> Tejun Heo wrote:
>> Jeff Garzik wrote:
>> 
>>> Tejun Heo wrote:
>>>
>>>>  In the following mail, I've attached a patch which might alleviate 
>>>> errors during writes (as Alexander was reporting CRC errors with write 
>>>> commands), but it won't do any good if you're getting errors during 
>>>> reading.
>>>> 
>>>> http://marc.theaimsgroup.com/?l=linux-ide&m=112602112819183&w=2
>>> 
>>> 
>>> 
>>> Note that I would put BIG CAPITAL LETTER WARNINGS on that patch, since it 
>>> messes with the voltage.
>>> 
>>
>>  Alexander & Jeremy.
>>
>>  It's as Jeff said.
>>
>>  TRY THE PATCH AT YOUR OWN RISK.  IT MIGHT FRY PHY OF YOUR DRIVE. (enough 
>> capitals?)
>>
>>  Even if you're brave enough to try, DO NOT GO OVER 600mV.  600mV is at 
>> least inside specified limits.  Also, it won't change anything regarding 
>> read errors.  All it does is increasing voltage swing while transmitting 
>> data (writes).
>
> Oh.. it might affect writes if errors are occurring due to CRC errors during 
> command trasmit.  If you're getting ABRT errors instead of ICRC's, it might 
> indicate that commands are being mistransferred (again, I'm not sure at all).
>
> -- 
> tejun
>

Did you mean reads here?  Because I think it's happening on reads as 
well--it happens on an "e2fsck -b -n" on the drive when I'm booted off a 
CDROM.  I'm willing to try it out if it could help, but if it's unlikely 
too...

I don't have any idea how these drivers work, but the ASUS K8N-DL also has 
the nvidia SATA controller in it--which doesn't appear to work at all, so 
I started by hooking up the drivers to the SI controller.  Can the mere 
presence of this additional controller make a difference?

For what it's worth, I don't _think_ I was seeing similar lockups until I 
updated the firmware on this board to the latest version (1004 from 1003), 
but that could be a red herring because I also wasn't paying attention to 
syslog.

I've tried changes to cabling...both drives experience the exact same 
symptoms for me; it certainly could be hardware related, but it would be 
on the board, for which I don't have a spare.

Is there any additional information I can provide?

Jer
