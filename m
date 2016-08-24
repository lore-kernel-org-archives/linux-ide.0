From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE
 SAME xlat
Date: Wed, 24 Aug 2016 13:31:03 +0800
Message-ID: <CAGnHSEntXZzZ8qU4ha+F8NvpXBjWNUE=9a_dKjTyiCuSyXpEHQ@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-2-shaun@tancheff.com>
 <CAGnHSEnMS+wYWiwLxoYsTDOoVb9qJ=gZbcQmhsZumiO+wbQi4A@mail.gmail.com>
 <CAJVOszBVXftz9hqmOgWG5DvxW7cQjFPUFaGygWcj_exgNwT4=w@mail.gmail.com>
 <CAGnHSE=t1qg5ukA7btSwD=AaQZB6W6bmF9HMC_K2JsCqoSNGVg@mail.gmail.com>
 <CAJVOszBP_JLgKUsknSmG+AuCVW8VEB4VUuaTNQ-MrE9B0nuXBg@mail.gmail.com>
 <CAGnHSEmsgp93X85-bgFyV0CdQbvdMHZsWj6e=VNH_7dUDUewHA@mail.gmail.com>
 <CAJVOszD8HDqQMxyAnU=Yh6UDA+KE13u7Mq6s248uguRf-uUkYg@mail.gmail.com>
 <CAGnHSEn7M9Kmse+_JFFCgvZY5TqZt1TDzXGhKaqimog4OKiktg@mail.gmail.com> <yq1vayqdeng.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33422 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbcHXFqN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 Aug 2016 01:46:13 -0400
In-Reply-To: <yq1vayqdeng.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>, Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On 24 August 2016 at 11:33, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Tom" == Tom Yan <tom.ty89@gmail.com> writes:
>
> Tom> Nope, SCSI Write Same commands does not have payload (or in SCSI
> Tom> terms, parameter list / data-out buffer).
>
> WRITE SAME has a a payload of 1 logical block (unless NDOB is set but we
> have had no good reason to support that yet).

Interesting, I wasn't aware of the bit. I just didn't see any
parameter list defined for any of the Write Same commands. Ah wait, it
carries the pattern (the "same") and so.

Hmm, it doesn't seem like the translation implemented in this patch
series cares about the payload though?

>
> UNMAP has a payload that varies based on the number of range
> descriptors. The SCSI disk driver only ever issues a single descriptor
> but since libata doesn't support UNMAP this doesn't really come into
> play.
>
> Ideally there would be a way to distinguish between device limits for
> WRITE SAME with the UNMAP bit and for "regular" WRITE SAME. One way to
> do that would be to transition the libata discard implementation over to
> single-range UNMAP, fill out the relevant VPD page B0 fields and leave
> the WRITE SAME bits for writing zeroes.
>
> One reason that has not been particularly compelling is that the WRITE
> SAME payload buffer does double duty to hold the ATA DSM TRIM range

Huh? Why would the SATL care about its payload buffer for TRIM (i.e.
when the UNMAP bit is set)? Doesn't it just read the LBA and NUMBER OF
BLOCKS field and pack TRIM ranges/payload according to that?

> descriptors and matches the required ATA payload size. Whereas the UNMAP

Why would it need to "matches the required ATA payload size"?

> command would only provide 24 bytes of TRIM range space.

I don't really follow. The UNMAP descriptor has LBA (8 bytes / 64-bit)
and NUMBER OF BLOCKS (4 bytes / 32-bit) field of the same length as
Write Same (16). Even if the SCSI disk driver will only send one
descriptor, it should work as good as Write Same (16).

>
> Also, please be careful with transfer lengths, __data_len, etc. As
> mentioned, the transfer length WRITE SAME is typically 512 bytes and
> that's the number of bytes that need to be DMA'ed and transferred over
> the wire by the controller. But from a command completion perspective we
> need to complete however many bytes the command acted upon. Unlike reads
> and writes there is not a 1:1 mapping between the transfer length and
> the affected area. So we do a bit of magic after the buffer has been
> mapped to ensure that the completion byte count matches the number of
> blocks that were affected by the command rather than the size of the
> data buffer in bytes.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
