From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Mon, 9 Feb 2009 20:48:23 +0100
Message-ID: <200902092048.23441.bzolnier@gmail.com>
References: <200902031147.22827.stf_xl@wp.pl> <498EC481.5080308@ru.mvista.com> <498F63A6.60807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:38217 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbZBIT5j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2009 14:57:39 -0500
Received: by bwz5 with SMTP id 5so1794009bwz.13
        for <linux-ide@vger.kernel.org>; Mon, 09 Feb 2009 11:57:37 -0800 (PST)
In-Reply-To: <498F63A6.60807@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk, Atsushi Nemoto <anemo@mba.ocn.ne.jp>

On Sunday 08 February 2009, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >>>>>>> +void at91_ide_tf_load(ide_drive_t *drive, ide_task_t *task)
> >>>>>>> +{
> >>>>>>> +    ide_hwif_t *hwif = drive->hwif;
> >>>>>>> +    struct ide_io_ports *io_ports = &hwif->io_ports;
> >>>>>>> +    struct ide_taskfile *tf = &task->tf;
> >>>>>>> +    u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
> >>>>>>> +
> >>>>>>> +    if (task->tf_flags & IDE_TFLAG_FLAGGED)
> >>>>>>> +        HIHI = 0xFF;
> >>>>>>> +
> >>>>>>> +    if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
> >>>>>>>                   
> >>>>>>    Sigh. Bart, couldn't we drop that stupid flag? I bet nobody 
> >>>>>> ever used it.
> >>>>>>             
> >>>>> It is there for HDIO_DRIVE_TASKFILE ioctl and I prefer not to 
> >>>>> break it.
> >>>>>
> >>>>> Just add ->{read,write}_data methods for IDE_TFLAG_{IN,OUT}_DATA 
> >>>>> to struct
> >>>>> ide_tp_ops -- it should also help some other host drivers like 
> >>>>> tx493*.
> >>>>>         
> >>>>   That would be extremely senseless activity sicne I believe this 
> >>>> flag is totally useless. I have better thing to do. :-)
> >>>>     
> >>>
> >>> I would love to remove this flag but it is used by user-space exposed
> >>> interface 
> >>
> >>   I know that...
> >>
> >>> (which was used by few drive vendors for their diagnostics
> >>> tools -- doesn't matter whether internal or external) so you should put
> >>> some technical arguments behind its removal (you know many of low-level
> >>> technical details better than me so I may be missing something which is
> >>> obvious to you).
> >>>   
> >>
> >>   Well, the vendors can do strange things, of course...
> >>   However, accessing the data register is certainly not a part of any 
> >> ATA/PI defined command's inputs/outputs (the corresponding tables 
> >> just don't have this register). I suspect that this flag was added 
> >> just "for completeness".
> >>
> >>> OTOH while ->{read,write}_data approach would result in something like
> >>> ~50 extra LOC (or even less with be_tp_ops) compared to removal it is
> >>> completely safe and we don't need to spend a single second wondering
> >>> about potential breakage 
> >>
> >>   Go for it. ;-)
> >
> >   I think I have a better idea than creating another (useless) couple 
> > of "transport" methods. Why not (ab)use the exisitng 
> > {in|out}put_data() methods instead? :-)

Good idea.

>    Besides, those methods are clearly subject to some size 
> optimization... I'll cook up a patch while I'm at it. :-)

:)
