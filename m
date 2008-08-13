From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: ide: Remove ide_spin_wait_hwgroup() and use special requests instead
Date: Wed, 13 Aug 2008 23:16:16 +0200
Message-ID: <87k5ek1uqn.fsf@denkblock.local>
References: <87iqu73128.fsf@denkblock.local>
	<200808130041.07424.bzolnier@gmail.com>
	<87tzdp0wgo.fsf@denkblock.local>
	<200808132232.33425.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:55013 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbYHMVR6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 17:17:58 -0400
In-Reply-To: <200808132232.33425.bzolnier@gmail.com> (Bartlomiej
	Zolnierkiewicz's message of "Wed, 13 Aug 2008 22:32:32 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On Wednesday 13 August 2008, Elias Oltmanns wrote:
>> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
>> > Hi,
>> >
>> > On Monday 11 August 2008, Elias Oltmanns wrote:
[...]
>> >> +	rq->cmd_len = DEVSET_CDB_LEN;
>> >> +	ds = (ide_devset_cdb_t *)rq->cmd;
>> >> +	ds->opcode = REQ_DEVSET_EXEC;
>> >> +	ds->arg = arg;
>> >
>> > How's about just doing:
>> >
>> > 	rq->cmd[0] = REQ_DEVSET_EXEC;
>> > 	(int *)rq->cmd[1] = arg;
>> 
>>   CC [M]  drivers/ide/ide-io.o
>> drivers/ide/ide-io.c: In function 'ide_devset_execute':
>> drivers/ide/ide-io.c:748: warning: cast to pointer from integer of different size
>> drivers/ide/ide-io.c:748: error: lvalue required as left operand of assignment
>
> Heh, I must have been falling asleep already when writing this,
> it should have been:
>
> 	*(int *)&rq->cmd[1] = arg;

Well, this I can make sense of.

>
>> Personally, I'd feel more comfortable with casting rq->cmd to a
>> dedicated struct, especially since I'm not exactly a wizard when it
>> comes to casting. Naturally, if you prefer something else (and I get it
>> to work), I'll happily accept that too.
>
> What I find ugly about this dedicated struct is that it overlaps with
> rq->cmd[0] and in all other places we just use rq->cmd[0] directly
> (+ it is very easy for people unfamiliar with the code to overlook it).

Yes, I see.

>
> Then if 'opcode' gets removed all that is left is 'arg' so the struct
> no loger makes much sense.
>
> I fixed it locally (interdiff attached), I hope you're fine with it.

Certainly.

Regards,

Elias
