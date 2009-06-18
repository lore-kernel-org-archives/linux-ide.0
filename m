From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: prevent null pointer deref via cdrom_newpc_intr
Date: Thu, 18 Jun 2009 19:07:29 +0200
Message-ID: <9ea470500906181007y4cff3e58n440a64c807fd14df@mail.gmail.com>
References: <87zlc58xgd.fsf@fever.mssgmbh.com>
	 <9ea470500906180739qdabce04u7c7875acc05358f@mail.gmail.com>
	 <87vdmt8ugm.fsf@fever.mssgmbh.com>
	 <9ea470500906180843w73435e74sade8a78894f75be5@mail.gmail.com>
	 <87my858qhn.fsf@fever.mssgmbh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f212.google.com ([209.85.220.212]:43348 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZFRRH2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 13:07:28 -0400
In-Reply-To: <87my858qhn.fsf@fever.mssgmbh.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rainer Weikusat <rweikusat@mssgmbh.com>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Thu, Jun 18, 2009 at 6:18 PM, Rainer Weikusat<rweikusat@mssgmbh.com>=
 wrote:
> Borislav Petkov <petkovbb@googlemail.com> writes:
>> On Thu, Jun 18, 2009 at 4:52 PM, Rainer Weikusat<rweikusat@mssgmbh.c=
om> wrote:
>>> Borislav Petkov <petkovbb@googlemail.com> writes:
>
> [...]
>
>>>> so this request is completed as a whole and the rq
>>>> freed."
>>>
>>> Technically, this is not quite correct (assuming I haven't overlook=
ed
>>> something), because ide_cd_queue_pc still has a reference to the rq=
=2E
>>
>> That doesn't matter because the OOPS happens after the command has b=
een
>> issued and _before_ ide_cd_queue_pc() gets to access the rq ptr
>> again.
>
> Yes. Because the pointer I already mentioned has been reset. But the
> request itself is still alive.
>
> [...]
>
>> ide_complete_rq simply does
>>
>> blk_end_request
>> |->blk_end_bidi_request
>> =A0 =A0|->blk_finish_request
>>
>> after checking the rq->bio pointer through blk_update_bidi_request()=
 and
>> if the prior is NULL it does __blk_put_request in blk_finish_request=
 and
>> this is where the thing vanishes.
>>
>> The second time ide_complete_rq() comes to run at the end of the IRQ
>> handler the rq is already 0xdeadbeef :).
>
> Not quite. Below is the blk_execute_rq-function:
>
> int blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct request *rq, int at_head)
> {
> =A0 =A0 =A0 =A0DECLARE_COMPLETION_ONSTACK(wait);
> =A0 =A0 =A0 =A0char sense[SCSI_SENSE_BUFFERSIZE];
> =A0 =A0 =A0 =A0int err =3D 0;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * we need an extra reference to the request, so we ca=
n look at
> =A0 =A0 =A0 =A0 * it after io completion
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0rq->ref_count++;
>
> =A0 =A0 =A0 =A0if (!rq->sense) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(sense, 0, sizeof(sense));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rq->sense =3D sense;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rq->sense_len =3D 0;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0rq->end_io_data =3D &wait;
> =A0 =A0 =A0 =A0blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end=
_sync_rq);
> =A0 =A0 =A0 =A0wait_for_completion(&wait);
>
> =A0 =A0 =A0 =A0if (rq->errors)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EIO;
>
> =A0 =A0 =A0 =A0return err;
> }
>
> and the refcount is incremented at the start of that 'so we can look
> at it after io-completion', which means 'after the code below has
> executed':
>
> static void blk_end_sync_rq(struct request *rq, int error)
> {
> =A0 =A0 =A0 =A0struct completion *waiting =3D rq->end_io_data;
>
> =A0 =A0 =A0 =A0rq->end_io_data =3D NULL;
> =A0 =A0 =A0 =A0__blk_put_request(rq->q, rq);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * complete last, if this is a stack request the proce=
ss (and thus
> =A0 =A0 =A0 =A0 * the rq pointer) could be invalid right after this c=
omplete()
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0complete(waiting);
> }
>
> which puts the rq once, decrementing the refcount by
> one.

Please, look at the following trace:

ide-cd: ide_cd_queue_pc: cmd[0]: 0x51, write: 0x0, timeout: 1750,
cmd_flags: 0x8000
ide-cd: ide_cd_do_request: cmd: 0x51, block: 18446744073709551615
ide_cd_do_request: dev hda: type=3Da, flags=3D108a640
  sector 18446744073709551615, nr/cnr 0/0
  bio (null), biotail (null), buffer (null), data ffff88011b849ba0, len=
 32
ide-cd: cdrom_do_block_pc: rq->cmd[0]: 0x51, rq->cmd_type: 0xa
ide-cd: cdrom_newpc_intr: cmd: 0x51, write: 0x0
ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 30
ide-cd: ide_cd_check_ireason: ireason: 0x2, rw: 0x0
ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0xa, ireason: 0x=
2
ide-cd: cdrom_newpc_intr: cmd: 0x51, write: 0x0
ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 2
ide-cd: ide_cd_request_sense_fixup: rq->cmd[0]: 0x51
#3

[ this is a printk I added to show from where we hit the out_end label.
There we call the first ide_complete_rq() over ide_cd_error_cmd() where
we put the request. __blk_put_request returns without freeing the rq if
the refcount is > 1, which, in this case, is.]

and now here we do the second direct ide_complete_rq and here the rq is=
 freed:

BUG: unable to handle kernel NULL pointer dereference at 00000000000000=
48

However, despite the refcounting, the rq->bio check kills the rq -
otherwise the block layer would've waited, see the beginning of
blk_update_request():

	if (!req->bio)
		return false;

but let me do more tracing to see exactly what happens and when it
happens, now that we're waist-deep into the block layer :).

--=20
Regards/Gruss,
Boris
