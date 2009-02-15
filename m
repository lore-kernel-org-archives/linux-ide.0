From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/6] ide: remove ide_execute_pkt_cmd()
Date: Sun, 15 Feb 2009 15:24:25 +0300
Message-ID: <49980979.6090305@ru.mvista.com>
References: <20090209231945.32406.14874.sendpatchset@localhost.localdomain>	 <20090209232019.32406.98822.sendpatchset@localhost.localdomain>	 <20090211065535.GC937@gollum.tnic> <4992D108.2070709@ru.mvista.com>	 <9ea470500902110537g4d6c67a3o35d1d8a4dcca0927@mail.gmail.com>	 <4992D77F.3090802@ru.mvista.com> <9ea470500902110832p58cf6b6at38a20f9ea7557017@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:31943 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753173AbZBOMYb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 07:24:31 -0500
In-Reply-To: <9ea470500902110832p58cf6b6at38a20f9ea7557017@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Borislav Petkov wrote:

>>>>> or similar instead of wasting stack space?
>>>>>
>>>>>          =20
>>>>  It doesn't necessarily waste stack space. Haven't you heard about
>>>> compiler
>>>> putting local vairables into registers?
>>>>
>>>>        =20
>>> Yes, have you heard of unnecessary register spilling?
>>>
>>>      =20
>>  No -- only about stack spilling on CPUs "caching" the top of stack =
in their
>> register file (like SPARC).
>>  Linux runs not only on x86 and many RISCs can store several local v=
ariables
>> in the dedicated registers -- it's the part of say MIPS ABIs...
>>    =20

   Oh, it's really the same on x86, only there are only 3 registers=20
dedicated to that. RISCs typically have more, however x86_64 wiuth 16=20
its registers is close to that already. However, you're right -- these=20
registers need saving at the function entry, so they effectively take=20
the stack space.

>>>>> It'll also read better in the if() check:
>>>>>
>>>>> if (drv_can_irq_interrupt(drive)) { ...
>>>>>
>>>>>
>>>>>          =20
>>>>  It's faster to checj a local variable than to dereference drv sev=
eral
>>>> times
>>>> -- unless gcc optimizes that away (by creating an implicit local v=
ariable
>>>> :-).
>>>>        =20
>
>
> Let's look at an example:
>
> In ide-cd.c:cdrom_newpc_intr() you have the following code snippet:
>
> <ide-cd.c>
>  799         thislen =3D blk_fs_request(rq) ? len : rq->data_len;
>  800         if (thislen > len)
>  801                 thislen =3D len;
>  802
>  803         ide_debug_log(IDE_DBG_PC, "%s: DRQ: stat: 0x%x, thislen:=
 %d\n",
>  804                       __func__, stat, thislen);
>  805
>  806         /* If DRQ is clear, the command has completed. */
>  807         if ((stat & ATA_DRQ) =3D=3D 0) {
>  808                 if (blk_fs_request(rq)) {
> </ide-cd.c>
>
> Now watch the blk_fs_request() thing.
>
> Here's what my gcc=C2=B9 spits out:
>  =20

   Thsi code is somewhat confused. Also, I was of a better opinion of g=
cc...

> <ide-cd.s>
> .LVL174:
>         .loc 1 799 0
>         movl    76(%r12), %ecx  # <variable>.cmd_type, prephitmp.1128
>         cmpl    $1, %ecx        #, prephitmp.1128
>         movl    %ecx, %r8d      # prephitmp.1128, prephitmp.1047
>         je      .L225   #,
>  =20

  Now where is that label?

> .LVL175:
>         .loc 1 800 0
>         movzwl  -44(%rbp), %r15d        # len, thislen
>  =20

   Oh, that AT&T syntax... it took me a while to realize that it's a=20
movzx insn. :-)

> .LVL176:
>         .loc 1 799 0
>         movl    280(%r12), %edx # <variable>.data_len, thislen.1129
> .LVL177:
>         .loc 1 800 0
>         cmpl    %r15d, %edx     # thislen, thislen.1129
>         movl    %r15d, %ebx     # thislen, thislen.1163
>         jg      .L145   #,
> .LVL178:
>         movl    %edx, %r15d     # thislen.1129, thislen
>  =20

   I wonder why it doesn't generate cmovng ISO jg and mov...

> .LVL179:
> .L145:
>         .loc 1 807 0
>         testb   $8, -64(%rbp)   #, stat
>         jne     .L147   #,
> .LVL180:
>         .loc 1 808 0
>         cmpl    $1, %ecx        #, prephitmp.1128
>         je      .L226   #,
>         .loc 1 825 0
>         cmpl    $2, %ecx        #, prephitmp.1128
>         .p2align 4,,3
>         .p2align 3
>         je      .L152   #,
> .LBB408:
> </ide-cd.s>
>  =20
> and at label .LVL174 you see the blk_fs_request() check from line
> 799 above. Later, at label .LVL180 you see the next blk_fs_request() =
check from
> line 808 and this is cached in %ecx so gcc is smart enough to do that=
=2E So,
>  =20

   Yes, CSE optimization does work...

> actually you get the same thing/or even better with variables in regi=
sters
> instead of on stack

  I still don't undestand why you assume that such variable will be=20
alloceted on stack -- gcc has 3 registers available for local variables=
=20
(which doesn't have to save across function calls). However, the=20
register variables have to take stack space indeed as they need to be=20
saved on funciton entry... though I'm not sure that gcc will necessary=20
put such variable in one of those 3 registers if it figures out that=20
there are no function calls going to happen during its life time.

> and the code is more readable. A win-win situation, I'd say :).
>  =20

  You haven't presented the code which gets generated when the local=20
variable is used, so it's impossible to compare.

MBR, Sergei


