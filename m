From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: prevent null pointer deref via cdrom_newpc_intr
Date: Thu, 18 Jun 2009 17:43:31 +0200
Message-ID: <9ea470500906180843w73435e74sade8a78894f75be5@mail.gmail.com>
References: <87zlc58xgd.fsf@fever.mssgmbh.com>
	 <9ea470500906180739qdabce04u7c7875acc05358f@mail.gmail.com>
	 <87vdmt8ugm.fsf@fever.mssgmbh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f212.google.com ([209.85.220.212]:49890 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbZFRPna (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 11:43:30 -0400
In-Reply-To: <87vdmt8ugm.fsf@fever.mssgmbh.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rainer Weikusat <rweikusat@mssgmbh.com>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hi,

On Thu, Jun 18, 2009 at 4:52 PM, Rainer Weikusat<rweikusat@mssgmbh.com> wrote:
> Borislav Petkov <petkovbb@googlemail.com> writes:
>> On Thu, Jun 18, 2009 at 3:48 PM, Rainer Weikusat<rweikusat@mssgmbh.com> wrote:
>>> From: Rainer Weikusat <rweikusat@mssgmbh.com>
>>>
>>> With 2.6.30, the error handling code in cdrom_newpc_intr was changed
>>> to deal with partial request failures by normally completing the 'good'
>>> parts of a request and only 'error' the last (and presumably,
>>> incompletely transferred) bio associated with a particular
>>> request. This doesn't work for requests which don't have bios
>>> associated with them ('GPCMD_READ_DISC_INFO'), because the first call
>>> to ide_end_rq, done via ide_complete_rq in order to do the
>>> partial completion part, returns with a code of zero for all non-bio
>>> requests, causing the drive->hwif->rq pointer to be set to NULL.
>>
>> This is a bit misleading, it should be more like: "ide_complete_rq is
>> called over ide_cd_error_cmd() to partially complete the rq but the rq
>> is without a bio and the block layer does partial completion only for
>> requests with bio's so this request is completed as a whole and the rq
>> freed."
>
> Technically, this is not quite correct (assuming I haven't overlooked
> something), because ide_cd_queue_pc still has a reference to the rq.

That doesn't matter because the OOPS happens after the command has been
issued and _before_ ide_cd_queue_pc() gets to access the rq ptr again.

ide_cd_queue_pc() does blk_execute_rq() which does wait for completion
of the request so it doesn't access the rq pointer before the IRQ
handler has completed. Even if it would reach the blk_put_request part,
the OOPS would have already happened.

ide_complete_rq simply does

blk_end_request
|->blk_end_bidi_request
   |->blk_finish_request

after checking the rq->bio pointer through blk_update_bidi_request() and
if the prior is NULL it does __blk_put_request in blk_finish_request and
this is where the thing vanishes.

The second time ide_complete_rq() comes to run at the end of the IRQ
handler the rq is already 0xdeadbeef :).

(this is all latest git but the old code (without the bidi stuff) did
the same thing wrt to rq->bio).


-- 
Regards/Gruss,
Boris
