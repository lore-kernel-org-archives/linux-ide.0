From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Fri, 06 Feb 2009 02:31:14 +0300
Message-ID: <498B76C2.7030709@ru.mvista.com>
References: <200902031147.22827.stf_xl@wp.pl> <498987E6.7040909@ru.mvista.com> <200902052223.08637.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:64330 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755689AbZBEXbX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Feb 2009 18:31:23 -0500
In-Reply-To: <200902052223.08637.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk, Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>> +void at91_ide_tf_load(ide_drive_t *drive, ide_task_t *task)
>>> +{
>>> +	ide_hwif_t *hwif = drive->hwif;
>>> +	struct ide_io_ports *io_ports = &hwif->io_ports;
>>> +	struct ide_taskfile *tf = &task->tf;
>>> +	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
>>> +
>>> +	if (task->tf_flags & IDE_TFLAG_FLAGGED)
>>> +		HIHI = 0xFF;
>>> +
>>> +	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
>>>   
>>>       
>>    Sigh. Bart, couldn't we drop that stupid flag? I bet nobody ever used it.
>>     
>
> It is there for HDIO_DRIVE_TASKFILE ioctl and I prefer not to break it.
>
> Just add ->{read,write}_data methods for IDE_TFLAG_{IN,OUT}_DATA to struct
> ide_tp_ops -- it should also help some other host drivers like tx493*.
>   

  That would be extremely senseless activity sicne I believe this flag 
is totally useless. I have better thing to do. :-)

> Thanks,
> Bart

MBR, Sergei


