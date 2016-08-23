From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE
 SAME xlat
Date: Tue, 23 Aug 2016 09:04:38 +0000
Message-ID: <CAGnHSEkONd-XJx9TKSVqeBaOXaZANBtNn9kQyRbXf735CsMqZg@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-2-shaun@tancheff.com>
 <CAGnHSEnMS+wYWiwLxoYsTDOoVb9qJ=gZbcQmhsZumiO+wbQi4A@mail.gmail.com>
 <CAJVOszBVXftz9hqmOgWG5DvxW7cQjFPUFaGygWcj_exgNwT4=w@mail.gmail.com>
 <CAGnHSE=t1qg5ukA7btSwD=AaQZB6W6bmF9HMC_K2JsCqoSNGVg@mail.gmail.com>
 <CAJVOszBP_JLgKUsknSmG+AuCVW8VEB4VUuaTNQ-MrE9B0nuXBg@mail.gmail.com>
 <CAGnHSEmsgp93X85-bgFyV0CdQbvdMHZsWj6e=VNH_7dUDUewHA@mail.gmail.com>
 <CAJVOszD8HDqQMxyAnU=Yh6UDA+KE13u7Mq6s248uguRf-uUkYg@mail.gmail.com>
 <CAGnHSEn7M9Kmse+_JFFCgvZY5TqZt1TDzXGhKaqimog4OKiktg@mail.gmail.com> <CAJVOszDu8WfoSysar=a5vvKb8ADtGb2faR=dGJm9vtvC_OSeUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35953 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757310AbcHWJG7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2016 05:06:59 -0400
In-Reply-To: <CAJVOszDu8WfoSysar=a5vvKb8ADtGb2faR=dGJm9vtvC_OSeUQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

There's comment about `rq->__data_len` in sd.c (and blkdev.h,
definition of struct `request`). Apparently it is "internal only" (in
terms of the kernel).

As for `cmd->transfersize`, it's probably talking about the CDB
itself. Although different commands have CDB of various lengths (much
shorter than 512-byte), but I guess when the actual command is sent to
the device, we will still transfer it in a full logical block for some
reason.

Anyway these will not have anything to do with how we form the TRIM
payload. The SATL simply read the LBA (starting offset) and NUMBER OF
BLOCK (to TRIM) field in the CDB and pack ranges according to that.
All we care is the actual TRIM limit of the ATA device (and
conservative concern on bogus ones).

On 23 August 2016 at 08:42, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
> On Tue, Aug 23, 2016 at 2:53 AM, Tom Yan <tom.ty89@gmail.com> wrote:
>> On 23 August 2016 at 06:20, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>>> On Tue, Aug 23, 2016 at 12:26 AM, Tom Yan <tom.ty89@gmail.com> wrote:
>>>
>>>> It is always 1 merely because we prefer sticking to that. Say we want
>>>> to enable multi-block payload now, it won't be 1 anymore.
>>>
>>> Sorry, I though that DSM TRIM is using 512 bytes here because
>>> WRITE_SAME_16 has a payload of a single logical sector.
>>
>> Nope, SCSI Write Same commands does not have payload (or in SCSI
>> terms, parameter list / data-out buffer).
>
> Hmm. Not sure about T10, but that's not how I read
> sd_setup_write_same_cmnd(), it always setups up a transfer of
> sector_size for scsi_init_io().
>
> As I understand things, this is how the cmd's sglist is populated and why
> this should be using sg_copy_from_buffer() rather than open coding
> to the page.
> --
> Shaun Tancheff
