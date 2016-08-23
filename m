From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE
 SAME xlat
Date: Tue, 23 Aug 2016 07:53:57 +0000
Message-ID: <CAGnHSEn7M9Kmse+_JFFCgvZY5TqZt1TDzXGhKaqimog4OKiktg@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-2-shaun@tancheff.com>
 <CAGnHSEnMS+wYWiwLxoYsTDOoVb9qJ=gZbcQmhsZumiO+wbQi4A@mail.gmail.com>
 <CAJVOszBVXftz9hqmOgWG5DvxW7cQjFPUFaGygWcj_exgNwT4=w@mail.gmail.com>
 <CAGnHSE=t1qg5ukA7btSwD=AaQZB6W6bmF9HMC_K2JsCqoSNGVg@mail.gmail.com>
 <CAJVOszBP_JLgKUsknSmG+AuCVW8VEB4VUuaTNQ-MrE9B0nuXBg@mail.gmail.com>
 <CAGnHSEmsgp93X85-bgFyV0CdQbvdMHZsWj6e=VNH_7dUDUewHA@mail.gmail.com> <CAJVOszD8HDqQMxyAnU=Yh6UDA+KE13u7Mq6s248uguRf-uUkYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35413 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbcHWHyb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2016 03:54:31 -0400
In-Reply-To: <CAJVOszD8HDqQMxyAnU=Yh6UDA+KE13u7Mq6s248uguRf-uUkYg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On 23 August 2016 at 06:20, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
> On Tue, Aug 23, 2016 at 12:26 AM, Tom Yan <tom.ty89@gmail.com> wrote:
>
>> It is always 1 merely because we prefer sticking to that. Say we want
>> to enable multi-block payload now, it won't be 1 anymore.
>
> Sorry, I though that DSM TRIM is using 512 bytes here because
> WRITE_SAME_16 has a payload of a single logical sector.

Nope, SCSI Write Same commands does not have payload (or in SCSI
terms, parameter list / data-out buffer).

>
>> Also note that the payload is NOT always fully-filled.
>
> Oh, I was considering filling the remainder of the buffer
> with 0's using memset() as you described to be "filly-filled"
> in this case. Sorry for the confusion.

Well yeah _after_ memset() it should always be "fully-filled" (i.e.
512-byte aligned).

>
> --
> Shaun Tancheff
