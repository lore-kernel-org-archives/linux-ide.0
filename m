From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 5/6] ide: remove ide_execute_pkt_cmd()
Date: Mon, 16 Feb 2009 09:56:08 +0100
Message-ID: <20090216085608.GB18517@gollum.tnic>
References: <20090209231945.32406.14874.sendpatchset@localhost.localdomain> <20090209232019.32406.98822.sendpatchset@localhost.localdomain> <20090211065535.GC937@gollum.tnic> <4992D108.2070709@ru.mvista.com> <9ea470500902110537g4d6c67a3o35d1d8a4dcca0927@mail.gmail.com> <4992D77F.3090802@ru.mvista.com> <9ea470500902110832p58cf6b6at38a20f9ea7557017@mail.gmail.com> <49980979.6090305@ru.mvista.com> <20090215173901.GA5156@gollum.tnic> <4998A2A9.2060607@ru.mvista.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:41970 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbZBPI4H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2009 03:56:07 -0500
Content-Disposition: inline
In-Reply-To: <4998A2A9.2060607@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>
>  Didn't quite get that statement.
>  Well, this example wasn't very convincing...

Oh, I'm really getting tired of this!

Here's your final example:

A stack variable caching the flags check. REMEMBER, no write accesses to
it!:

<ide-cd.c>
int ide_cd_read_toc(ide_drive_t *drive, struct request_sense *sense)
{
        int stat, ntracks, i;
        struct cdrom_info *info = drive->driver_data;
        struct cdrom_device_info *cdi = &info->devinfo;
        struct atapi_toc *toc = info->toc;
        struct {
                struct atapi_toc_header hdr;
                struct atapi_toc_entry  ent;
        } ms_tmp;
        long last_written;
        unsigned long sectors_per_frame = SECTORS_PER_FRAME;
        u8 tmp = drive->atapi_flags & IDE_AFLAG_TOCTRACKS_AS_BCD;
</ide-cd.c>

later you access the _same_ variable in an if-check:

<ide-cd.c>
        if (tmp) {
                toc->hdr.first_track = bcd2bin(toc->hdr.first_track);
                toc->hdr.last_track  = bcd2bin(toc->hdr.last_track);
        }
</ide-cd.c>


Resulting assembly snippets:

<ide-cd.s>
.LCFI166:
        .loc 1 1202 0
        movl    %edx, -52(%ebp) # sense, sense
        .loc 1 1213 0
        movl    500(%edi), %ecx # <variable>.atapi_flags,
        .loc 1 1204 0
        movl    24(%eax), %eax  # <variable>.driver_data,
.LVL399:
        movl    %eax, -40(%ebp) #, info
.LVL400:
        .loc 1 1206 0
        movl    16(%eax), %esi  # <variable>.toc, toc
.LVL401:
        .loc 1 1212 0
        movl    $4, -20(%ebp)   #, sectors_per_frame
.LVL402:
        .loc 1 1213 0
        movl    %ecx, -48(%ebp) #, D.31862
</ide-cd.s>

you see here the ->atapi_flags, dereferenced above, being saved on the
stack. Here's the asm for the check later:

<ide-cd.s>
.LVL415:
        jne     .L283   #,
        .loc 1 1256 0
        movb    -48(%ebp), %al  # D.31862,
.LVL416:
        andb    $16, %al        #,
        movb    %al, -33(%ebp)  #, tmp
.LVL417:
        je      .L287   #,
        .loc 1 1257 0
</ide-cd.s>

So, the ->atapi_flags is moved into 8bit %al from the stack! Then the
$16 is the IDE_AFLAG_TOCTRACKS_AS_BCD, so the binary & against the
->atapi_flags is done actually here. Then the tmp variable is SAVED ON
THE STACK at -33(%ebp) and it is dereferenced AGAIN in the next check:

.LVL426:
        jne     .L283   #,
        .loc 1 1297 0
        cmpb    $0, -33(%ebp)   # tmp
        je      .L290   #


If you still don't see it, go play with your own assembler and do some
code staring on your own which doesn't involve me!

-- 
Regards/Gruss,
    Boris.
