From: Vlad Codrea <VladCodrea@mail.utexas.edu>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Wed, 14 Mar 2007 11:58:18 -0500
Message-ID: <45F829AA.4080000@mail.utexas.edu>
References: <45F631F7.6020106@mail.utexas.edu> <45F7760B.10102@gmail.com> <45F81177.9070106@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironmaiden.mail.utexas.edu ([128.83.32.53]:37906 "EHLO
	ironmaiden.mail.utexas.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751696AbXCNQ6Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 12:58:24 -0400
In-Reply-To: <45F81177.9070106@mail.utexas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Vlad Codrea wrote:
> Tejun Heo wrote:
>> Vlad Codrea wrote:
>>  
>>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>>> ata2.00: (BMDMA stat 0x25)
>>> ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 
>>> 36 in
>>>         res 58/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x2 (HSM 
>>> violation)
>>> ata2: soft resetting port
>>> ata2: port is slow to respond, please be patient (Status 0xd8)
>>> ata2: port failed to respond (30 secs, Status 0xd8)
>>> ATA: abnormal status 0xD8 on port 0x177
>>> ATA: abnormal status 0xD8 on port 0x177
>>>     
>>
>> Okay, now that you're on libata driver, it's easier for me to debug.
>> Can you apply the attached patch over 2.6.20 and report what the kernel
>> says? (the patch will apply with some noise, it's okay)
>>   
>
>
> I've applied your patch and recompiled the kernel, but the new dmesg 
> (attached as dmesg_2.txt) doesn't seem to have changed much.

After doing a cold reboot without an inserted CD, it's now saying 
"ata2.00: (BMDMA stat 0x5)"  instead of "ata2.00: (BMDMA stat 0x25)" I'm 
not sure whether this is significant...

Vlad
