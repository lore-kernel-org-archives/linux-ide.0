From: Tejun Heo <htejun@gmail.com>
Subject: Re: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
Date: Wed, 30 Nov 2005 14:37:44 +0900
Message-ID: <438D3AA8.9030504@gmail.com>
References: <438BD351.60902@ucla.edu> <438D2792.9050105@gmail.com> <438D2DCC.4010805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:38417 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751061AbVK3Fhy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2005 00:37:54 -0500
Received: by zproxy.gmail.com with SMTP id 14so1836182nzn
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2005 21:37:51 -0800 (PST)
In-Reply-To: <438D2DCC.4010805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ethan Chen <thanatoz@ucla.edu>, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Linux-ide <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> [CC'ing Jeff, Carlos & linux-ide]
>>
>> Ethan Chen wrote:
>>
>>> I've got a dual Opteron 242 machine here with 2x Seagate ST3200822AS 
>>> SATA drives attached to a Silicon Image SI3114 controller, and after 
>>> upgrading to 2.6.14 from 2.6.13, it seems the SIL_QUIRK_MOD15WRITE 
>>> workaround for the sata_sil driver isn't being applied anymore. This 
>>> caused me trouble in the past before my drive was added to the 
>>> blacklist, and this message that comes up when writing (~4GBfiles to 
>>> test) files, right before the computer locks up, is the same as before:
>>> kernel: ata1: command 0x35 timeout, stat 0xd8 host_stat 0x61
>>> In the dmesg, the 'Applying Seagate errata fix' message doesn't 
>>> appear anymore as well.
>>> Finally, without the fix, write speeds are much higher as well, 
>>> before it locks up.
>>
>>
>>
>> Hello, Ethan.
>>
>> Sometime ago, Silicon Image has confirmed that 3114's and 3512's are 
>> not affected by the m15w problem - only 3112's are affected.  So, a 
>> patch has made into the tree before 2.6.14 to apply the m15w quirk 
>> selectively.
> 
> 
> Most likely, mod15write quirk was just hiding an unrelated problem. 
> mod15write often hid BIOS problems in the past which led to corruption.
> 
> Until sata_sil properly handles SATA phy / DMA errors by resetting the 
> controller and retrying the command, we won't know if its a driver 
> problem or not.
> 

Ethan confirmed that it's 1095:3114.  Arghhh....  Maybe we should keep 
m15w quirk for 3114's for the time being?  Better be slow than hang. 
Whatever bug the m15w quirk was hiding.

Carlos, can you double check that 3114's don't have the m15w issue?  It 
just seems too similar to the usual m15w lockup.

-- 
tejun
