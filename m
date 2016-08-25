From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE
 SAME xlat
Date: Thu, 25 Aug 2016 02:18:52 -0500
Message-ID: <CAJVOszDcLxue8NzvzPphAhfZJBeV_NzTjgZxk0ehK_=sMDCvjA@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-2-shaun@tancheff.com>
 <CAGnHSEnMS+wYWiwLxoYsTDOoVb9qJ=gZbcQmhsZumiO+wbQi4A@mail.gmail.com>
 <CAJVOszBVXftz9hqmOgWG5DvxW7cQjFPUFaGygWcj_exgNwT4=w@mail.gmail.com>
 <CAGnHSE=t1qg5ukA7btSwD=AaQZB6W6bmF9HMC_K2JsCqoSNGVg@mail.gmail.com>
 <CAJVOszBP_JLgKUsknSmG+AuCVW8VEB4VUuaTNQ-MrE9B0nuXBg@mail.gmail.com>
 <CAGnHSEmsgp93X85-bgFyV0CdQbvdMHZsWj6e=VNH_7dUDUewHA@mail.gmail.com>
 <CAJVOszD8HDqQMxyAnU=Yh6UDA+KE13u7Mq6s248uguRf-uUkYg@mail.gmail.com>
 <CAGnHSEn7M9Kmse+_JFFCgvZY5TqZt1TDzXGhKaqimog4OKiktg@mail.gmail.com>
 <yq1vayqdeng.fsf@sermon.lab.mkp.net> <CAGnHSEntXZzZ8qU4ha+F8NvpXBjWNUE=9a_dKjTyiCuSyXpEHQ@mail.gmail.com>
 <CAJVOszC96Z0KUcYgnaana-6_+tzvJTSBEucKDxLRMeRw6gdXcg@mail.gmail.com> <CAGnHSE=4N5udMa005B+bT7ngbzDk5vKxk=SNE6nmiBF9oiQpoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00003501.pphosted.com ([67.231.144.15]:41418 "EHLO
        mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755944AbcHYHTU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2016 03:19:20 -0400
Received: from pps.filterd (m0075554.ppops.net [127.0.0.1])
        by mx0a-000cda01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7P75RJl037589
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2016 03:19:13 -0400
Received: from mail-qt0-f198.google.com (mail-qt0-f198.google.com [209.85.216.198])
        by mx0a-000cda01.pphosted.com with ESMTP id 251uqpg2gs-61
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2016 03:19:13 -0400
Received: by mail-qt0-f198.google.com with SMTP id 93so75756955qtg.1
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2016 00:19:13 -0700 (PDT)
In-Reply-To: <CAGnHSE=4N5udMa005B+bT7ngbzDk5vKxk=SNE6nmiBF9oiQpoQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On Thu, Aug 25, 2016 at 1:31 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> On 25 August 2016 at 05:28, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>> On Wed, Aug 24, 2016 at 12:31 AM, Tom Yan <tom.ty89@gmail.com> wrote:
>>> On 24 August 2016 at 11:33, Martin K. Petersen
>>> <martin.petersen@oracle.com> wrote:
>>>>>>>>> "Tom" == Tom Yan <tom.ty89@gmail.com> writes:
>>>>
>>>> Tom> Nope, SCSI Write Same commands does not have payload (or in SCSI
>>>> Tom> terms, parameter list / data-out buffer).
>>>>
>>>> WRITE SAME has a a payload of 1 logical block (unless NDOB is set but we
>>>> have had no good reason to support that yet).
>>>
>>> Interesting, I wasn't aware of the bit. I just didn't see any
>>> parameter list defined for any of the Write Same commands. Ah wait, it
>>> carries the pattern (the "same") and so.
>>>
>>> Hmm, it doesn't seem like the translation implemented in this patch
>>> series cares about the payload though?
>>
>> As repeated here and elsewhere the payload is:
>>     scsi_sglist(cmd)
>> and it was put there by scsi_init_io() when it called scsi_init_sgtable()
>
> What I mean is:
>
> put_unaligned_le32(0u,      &sctpg[10]);
>
> So even if the payload of the SCSI Write Same commands instruct a
> non-zero pattern writing, SCT Write Same will conveniently ignore that
> do zero-filling anyway. That's what I mean by "doesn't care about the
> payload".

If you would like to add support for that it would be nice. I am not
planning to do so here.

> Though that would only be case with SG_IO though. SCSI Write Same
> issued from block layer (BLKZEROOUT) will be instructing zero-filling
> anyway.

>>>> UNMAP has a payload that varies based on the number of range
>>>> descriptors. The SCSI disk driver only ever issues a single descriptor
>>>> but since libata doesn't support UNMAP this doesn't really come into
>>>> play.
>>>>
>>>> Ideally there would be a way to distinguish between device limits for
>>>> WRITE SAME with the UNMAP bit and for "regular" WRITE SAME. One way to
>>>> do that would be to transition the libata discard implementation over to
>>>> single-range UNMAP, fill out the relevant VPD page B0 fields and leave
>>>> the WRITE SAME bits for writing zeroes.
>>>>
>>>> One reason that has not been particularly compelling is that the WRITE
>>>> SAME payload buffer does double duty to hold the ATA DSM TRIM range
>>>
>>> Huh? Why would the SATL care about its payload buffer for TRIM (i.e.
>>> when the UNMAP bit is set)? Doesn't it just read the LBA and NUMBER OF
>>> BLOCKS field and pack TRIM ranges/payload according to that?
>>>
>>>> descriptors and matches the required ATA payload size. Whereas the UNMAP
>>>
>>> Why would it need to "matches the required ATA payload size"?
>>>
>>>> command would only provide 24 bytes of TRIM range space.
>>>
>>> I don't really follow. The UNMAP descriptor has LBA (8 bytes / 64-bit)
>>> and NUMBER OF BLOCKS (4 bytes / 32-bit) field of the same length as
>>> Write Same (16). Even if the SCSI disk driver will only send one
>>> descriptor, it should work as good as Write Same (16).
>>
>> The "payload" is the data block transferred with the command.
>> The "descriptor" is, in this context, the contents of the payload as
>> it "describes" what the action the command is supposed to perform.
>>
>
> I know right.
>
>> The "payload" contains the "descriptor" that "describes" how
>> DSM TRIM should determine which logical blocks it should UNMAP.
>
> This should only be the case of UNMAP command, but not SCSI Write Same
> with UNMAP bit set. And either way it should not affect how large the
> ATA TRIM payload can be.

The current SATL does not report support for UNMAP.
If you think it should be added please submit a patch.

If you would like to extend the current translate to support sending
multiple blocks of trim data please submit a patch.

>>>> Also, please be careful with transfer lengths, __data_len, etc. As
>>>> mentioned, the transfer length WRITE SAME is typically 512 bytes and
>>>> that's the number of bytes that need to be DMA'ed and transferred over
>>>> the wire by the controller. But from a command completion perspective we
>>>> need to complete however many bytes the command acted upon. Unlike reads
>>>> and writes there is not a 1:1 mapping between the transfer length and
>>>> the affected area. So we do a bit of magic after the buffer has been
>>>> mapped to ensure that the completion byte count matches the number of
>>>> blocks that were affected by the command rather than the size of the
>>>> data buffer in bytes.
>>>>
>>>> --
>>>> Martin K. Petersen      Oracle Linux Engineering
>> --
>> Shaun Tancheff
-- 
Shaun Tancheff
