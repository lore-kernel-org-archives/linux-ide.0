From: Tejun Heo <htejun@gmail.com>
Subject: Re: translated ATA stat/err 0x51/0c to ... PDC20376 (FastTrak 376)
 related cold freezes
Date: Mon, 28 Aug 2006 01:24:18 +0900
Message-ID: <44F1C732.10307@gmail.com>
References: <1156440866.29118.14.camel@localhost>	 <44F167C0.6020903@gmail.com> <1156692788.12244.11.camel@localhost> <44F1C5C5.3030504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:1285 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932162AbWH0QYZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Aug 2006 12:24:25 -0400
Received: by py-out-1112.google.com with SMTP id n25so2143282pyg
        for <linux-ide@vger.kernel.org>; Sun, 27 Aug 2006 09:24:25 -0700 (PDT)
In-Reply-To: <44F1C5C5.3030504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

[cc'ing Jeff & linux-ide, quoting whole body]

Jeff, here's a EH test case for sata_promise, just in case you missed 
this thread.

Tejun Heo wrote:
> Soeren Sonnenburg wrote:
>> On Sun, 2006-08-27 at 18:37 +0900, Tejun Heo wrote:
>>> Soeren Sonnenburg wrote:
>>>> Dear all,
>>>>
>>>> I just upgraded to using 2 sata disks (both seagate drives
>>>> ST3400832AS and ST3750640AS) on this asus a7v8x on-board promise 
>>>> fastrak
>>>> 376 (PDC20376) controller. However, as soon as I do a lot of io (cp 
>>>> some
>>>> G of files) I get swamped in
>>>> ata1: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
>>>> ata1: status=0x51 { DriveReady SeekComplete Error }
>>>> ata1: error=0x0c { DriveStatusError }
>>>> ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
>>>> ata2: status=0x51 { DriveReady SeekComplete Error }
>>>> ata2: error=0x0c { DriveStatusError }
>>>> ...
>>> Is the system usable after these messages?
>>
>> Yes, however I got cold freezes from (time to time) after a while...
> 
> I see.  your drive is reporting error for some reason and libata is 
> failing to recover.
> 
>>>> messages. For that it is enough to do it on a single drive or copy from
>>>> drive to drive. This is on kernel 2.6.17.4, but I remember (when I was
>>>> still using a single drive) this very same output to happen on 2.6.15.
>>>>
>>>> Can anyone translate these dubious error messages to me ?
>>>>
>>>> Here are more details about the system:
>>>>
>>>> - the sata_promise driver version 1.04 is used
>>> Can you give a shot at 2.6.18-rc4?
>>
>> I will, though I don't see much changes in that driver...
> 
> Ah.. right.  sata_promise isn't converted to new EH yet.  There's no 
> reason to try -rc4.  Please stand by.
> 
> Thanks.

-- 
tejun
