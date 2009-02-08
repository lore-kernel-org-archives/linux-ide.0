From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Sun, 08 Feb 2009 03:10:50 +0300
Message-ID: <498E230A.8060807@ru.mvista.com>
References: <200902031147.22827.stf_xl@wp.pl> <200902052223.08637.bzolnier@gmail.com> <498B76C2.7030709@ru.mvista.com> <200902061736.23051.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:45829 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754365AbZBHAK5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Feb 2009 19:10:57 -0500
In-Reply-To: <200902061736.23051.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk, Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>> +void at91_ide_tf_load(ide_drive_t *drive, ide_task_t *task)
>>>>> +{
>>>>> +	ide_hwif_t *hwif = drive->hwif;
>>>>> +	struct ide_io_ports *io_ports = &hwif->io_ports;
>>>>> +	struct ide_taskfile *tf = &task->tf;
>>>>> +	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
>>>>> +
>>>>> +	if (task->tf_flags & IDE_TFLAG_FLAGGED)
>>>>> +		HIHI = 0xFF;
>>>>> +
>>>>> +	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
>>>>>   
>>>>>       
>>>>>           
>>>>    Sigh. Bart, couldn't we drop that stupid flag? I bet nobody ever used it.
>>>>     
>>>>         
>>> It is there for HDIO_DRIVE_TASKFILE ioctl and I prefer not to break it.
>>>
>>> Just add ->{read,write}_data methods for IDE_TFLAG_{IN,OUT}_DATA to struct
>>> ide_tp_ops -- it should also help some other host drivers like tx493*.
>>>   
>>>       
>>   That would be extremely senseless activity sicne I believe this flag 
>> is totally useless. I have better thing to do. :-)
>>     
>
> I would love to remove this flag but it is used by user-space exposed
> interface 

   I know that...

> (which was used by few drive vendors for their diagnostics
> tools -- doesn't matter whether internal or external) so you should put
> some technical arguments behind its removal (you know many of low-level
> technical details better than me so I may be missing something which is
> obvious to you).
>   

   Well, the vendors can do strange things, of course...
   However, accessing the data register is certainly not a part of any 
ATA/PI defined command's inputs/outputs (the corresponding tables just 
don't have this register). I suspect that this flag was added just "for 
completeness".

> OTOH while ->{read,write}_data approach would result in something like
> ~50 extra LOC (or even less with be_tp_ops) compared to removal it is
> completely safe and we don't need to spend a single second wondering
> about potential breakage 

   Go for it. ;-)

> (one day this ioctl will go away together with
> the flag and issue will solve itself).
>   

  I certainly can live with this feature in the meantime... :-)
  BTW, looks like libata has already dropped HDIO_DRIVE_TASKFILE ioctl.

> Thanks,
> Bart
>   

MBR, Sergei


