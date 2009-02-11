From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/6] ide: remove ide_execute_pkt_cmd()
Date: Wed, 11 Feb 2009 16:49:51 +0300
Message-ID: <4992D77F.3090802@ru.mvista.com>
References: <20090209231945.32406.14874.sendpatchset@localhost.localdomain>	 <20090209232019.32406.98822.sendpatchset@localhost.localdomain>	 <20090211065535.GC937@gollum.tnic> <4992D108.2070709@ru.mvista.com> <9ea470500902110537g4d6c67a3o35d1d8a4dcca0927@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:6702 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750945AbZBKNt5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 08:49:57 -0500
In-Reply-To: <9ea470500902110537g4d6c67a3o35d1d8a4dcca0927@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Borislav Petkov wrote:

>>>> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>>> Subject: [PATCH] ide: remove ide_execute_pkt_cmd()
>>>>
>>>> * Pass command structure to ide_execute_command() and skip
>>>>  __ide_set_handler() for ATAPI protocols.
>>>>
>>>> * Convert ide_issue_pc() to always use ide_execute_command()
>>>>  and remove no longer needed ide_execute_pkt_cmd().
>>>>
>>>> There should be no functional changes caused by this patch.
>>>>
>>>> Cc: Borislav Petkov <petkovbb@gmail.com>
>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>>> ---
>>>>  drivers/ide/ide-atapi.c    |   15 +++++++--------
>>>>  drivers/ide/ide-iops.c     |   23 ++++++-----------------
>>>>  drivers/ide/ide-taskfile.c |    6 ++----
>>>>  include/linux/ide.h        |    5 ++---
>>>>  4 files changed, 17 insertions(+), 32 deletions(-)
>>>>
>>>> Index: b/drivers/ide/ide-atapi.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- a/drivers/ide/ide-atapi.c
>>>> +++ b/drivers/ide/ide-atapi.c
>>>> @@ -481,6 +481,7 @@ static void ide_init_packet_cmd(struct i
>>>>        cmd->protocol  =3D dma ? ATAPI_PROT_DMA : ATAPI_PROT_PIO;
>>>>        cmd->tf_flags |=3D IDE_TFLAG_OUT_LBAH | IDE_TFLAG_OUT_LBAM =
|
>>>>                         IDE_TFLAG_OUT_FEATURE | tf_flags;
>>>> +       cmd->tf.command =3D ATA_CMD_PACKET;
>>>>        cmd->tf.feature =3D dma;          /* Use PIO/DMA */
>>>>        cmd->tf.lbam    =3D bcount & 0xff;
>>>>        cmd->tf.lbah    =3D (bcount >> 8) & 0xff;
>>>> @@ -626,6 +627,7 @@ ide_startstop_t ide_issue_pc(ide_drive_t
>>>>        unsigned int timeout;
>>>>        u32 tf_flags;
>>>>        u16 bcount;
>>>> +       u8 drq_int =3D !!(drive->atapi_flags & IDE_AFLAG_DRQ_INTER=
RUPT);
>>>>
>>>>        =20
>>> How about we finally add those check macros in block layer fashion =
like
>>> blk_pc_request et al and do
>>>
>>> #define drv_can_drq_interrupt(drive)    ((drive)->atapi_flags &
>>> IDE_AFLAG_DRQ_INTERRUPT)
>>>
>>>      =20
>>  I suppose it's for the devices that interrupt on packet DRQ? Then i=
t's
>> hardly a good name because it's not like this is some optional capab=
ility.
>>    =20
>
> No, I was alluding to the command packet DRQ type used by the device =
as it is
> put in SFF8020i, 7.1.7.1 General Con=EF=AC=81guration Word.
>  =20

   I was talking about exactly the same feature. :-)

>>> or similar instead of wasting stack space?
>>>      =20
>>  It doesn't necessarily waste stack space. Haven't you heard about c=
ompiler
>> putting local vairables into registers?
>>    =20
>
> Yes, have you heard of unnecessary register spilling?
>  =20

   No -- only about stack spilling on CPUs "caching" the top of stack i=
n=20
their register file (like SPARC).
   Linux runs not only on x86 and many RISCs can store several local=20
variables in the dedicated registers -- it's the part of say MIPS ABIs.=
=2E.

>>> It'll also read better in the if() check:
>>>
>>> if (drv_can_irq_interrupt(drive)) { ...
>>>
>>>      =20
>>  It's faster to checj a local variable than to dereference drv sever=
al times
>> -- unless gcc optimizes that away (by creating an implicit local var=
iable
>> :-).
>>    =20
>
> I hope gcc is smart enough to do that.
>  =20

   Then where's the win?

MBR, Sergei


