From: Roger Heflin <rogerheflin@gmail.com>
Subject: Re: 2.6.24.3: regular sata drive resets - worrisome?
Date: Tue, 01 Apr 2008 14:27:52 -0500
Message-ID: <47F28CB8.6060305@gmail.com>
References: <200803201518.32109.hpj@urpla.net> <200803300114.40096.hpj@urpla.net> <47EEE4BF.5080609@gmail.com> <200803301400.10766.hpj@urpla.net> <47EF8A65.1010005@gmail.com> <47F06987.2060208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:49846 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbYDAT2V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2008 15:28:21 -0400
Received: by rn-out-0910.google.com with SMTP id e24so1265597rng.1
        for <linux-ide@vger.kernel.org>; Tue, 01 Apr 2008 12:28:19 -0700 (PDT)
In-Reply-To: <47F06987.2060208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Hans-Peter Jansen <hpj@urpla.net>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
>>> I can offer to you rebuilding that md in a test environment, and 
>>> giving you access to it, if you're interested.
> 
> Can you hook up those failed drives to a different controller?  Say, 
> ahci or ata_piix and put them under write load (ext3 w/ barrier=1 and 
> copying lots of files into it should work) and see whether the problem 
> reproduces?

I can move switch the disks to a sata_promise controller, I also have a sata_via 
controller but I cannot get those disks to work at all on it (it initially sees 
the disk, but does not finish init).

I don't on the machine that those disks are on have any other sata controllers.

> 
>> Here are the errors I get, though look at it closer, I am don't appear 
>> to be getting the reset, just this error from time to time:
>>
>> sd 9:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
>> sd 9:0:0:0: [sde] Write Protect is off
>> sd 9:0:0:0: [sde] Mode Sense: 00 3a 00 00
>> sd 9:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't 
>> support DPO or FUA
>> ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x280000 action 0x0
>> ata8.00: BMDMA2 stat 0x687d8009
>> ata8.00: cmd 25/00:80:a7:00:1d/00:01:1d:00:00/e0 tag 0 cdb 0x0 data 
>> 196608 in
>>          res 51/04:8f:98:01:1d/00:00:1d:00:00/f0 Emask 0x1 (device error)
>> ata8.00: configured for UDMA/100
> 
> That's device abort error on read.  The drive just can't read sector one 
> of the requested sectors and it's not sata_sil24.  It's a bmdma one.
> 
>> I have 4 identical disks, with all 4 connected to the SIL controller 
>> all give some errors, moving 2 of the disks to a promise controller 
>> makes the errors go away on the 2 connected to the promise 
>> controller.   All drives are part of a software raid5 array.
> 
> Ah.. okay, sata_sil.  Roger, the moving and errors are not very likely 
> to have anything to do with each other.  The only possibility is 
> transmission problems but the drive didn't report transport error (ICRC) 
> and it's more likely that the drive was experiencing temporary failures. 
>  It's also possible that the drive set ABRT although there was some 
> problem with the transport tho.
> 
> If you move the drive back to the sata_sil, do those problems appear 
> again?  Anyways, this doesn't really have anything to do with what Hans 
> is seeing.

I can swap the disk around next time I reboot the machine, the 2 on the promise 
will go to the sil and the 2 on the sil will go to the promise, from past 
testing I expect the disk on the sil to have the errors and the ones on the 
promise to not have errors.

After I looked at the error more carefully and I though that too, I had 
originally thought I was getting resets also but I was wrong on that.

                       Roger
