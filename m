From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE
 SAME xlat
Date: Tue, 23 Aug 2016 05:26:18 +0000
Message-ID: <CAGnHSEmsgp93X85-bgFyV0CdQbvdMHZsWj6e=VNH_7dUDUewHA@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-2-shaun@tancheff.com>
 <CAGnHSEnMS+wYWiwLxoYsTDOoVb9qJ=gZbcQmhsZumiO+wbQi4A@mail.gmail.com>
 <CAJVOszBVXftz9hqmOgWG5DvxW7cQjFPUFaGygWcj_exgNwT4=w@mail.gmail.com>
 <CAGnHSE=t1qg5ukA7btSwD=AaQZB6W6bmF9HMC_K2JsCqoSNGVg@mail.gmail.com> <CAJVOszBP_JLgKUsknSmG+AuCVW8VEB4VUuaTNQ-MrE9B0nuXBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35278 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754799AbcHWF0s (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2016 01:26:48 -0400
In-Reply-To: <CAJVOszBP_JLgKUsknSmG+AuCVW8VEB4VUuaTNQ-MrE9B0nuXBg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On 23 August 2016 at 01:01, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
> On Mon, Aug 22, 2016 at 6:49 PM, Tom Yan <tom.ty89@gmail.com> wrote:
>> The only 512 I can see in the old code is the one in:
>>
>>> -       used_bytes = ALIGN(i * 8, 512);
>>
>> where the alignment is necessary because 'used_bytes' will be returned
>> as 'size', which will be used for setting the number of 512-byte block
>> payload when we construct the ATA taskfile / command. It may NOT be a
>> good idea to replace it with ATA_SECT_SIZE. Some comment could be
>> nice.
>
> Not sure I agree with that analysis. Could just as well assign it directly,
> as ALIGN() is just superfluous here.
> Later the count is always 512/512 -> 1. Always.

It is always 1 merely because we prefer sticking to that. Say we want
to enable multi-block payload now, it won't be 1 anymore.

Also note that the payload is NOT always fully-filled. Say, I issue a
discard request of 1M or a SCSI Write Same (16) commands of 2048
blocks. If you do not round up used_bytes, the result of the division
will be 0 in those cases.

Basically that's the mathematical version of the story of why we need
the following memset().

>
> "i" is used here to limit the number of bytes that need to be memset()
> after filling to payload. Personally I think memset is fast enough that
> it is better to do before rather than later but I figure if the code works
> let it be.

Not sure what you mean by "fast enough"/"do before". What memset() do
here is to locate the offset/location to starting filling the memory
(buffer + i) and fill zero until the payload is 512-byte aligned
(used_bytes - i * 8, where used_bytes is an aligned/rounded-up-to-512
version of i * 8). Again, it does NOT and should NOT limit the
allocated memory to _one_ 512-byte block.

>
>> So I don't think it makes any sense to check ATA_SCSI_RBUF_SIZE
>> against 512 here.
>
> Again, not sure I agree, but I don't really care on that point. Just many
> years of defensive coding.

The thing is you can't even tell what exactly you are defending here.
This would only make the perhaps already obfuscated code more
obfuscated, without actually preventing any bad thing to happen.

The only case you would want to check ATA_SCSI_RBUF_SIZE here is, you
somehow want to use it as buflen parameter in the following
sg_copy_from_buffer call. Then you may say "I want to make sure that
we wouldn't carelessly decrease the currently 4096 ATA_SCSI_RBUF_SIZE
to a value smaller than 512 someday, which cannot even accommodate a
single full-block payload." And even that's a weak reason.

>
>> On 22 August 2016 at 22:00, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>>> Because this is re-using the response buffer in a new way.
>>> Such reuse could be a surprise to someone refactoring that
>>> code, although it's pretty unlikely. The build bug on
>>> gives some level of confidence that it won't go unnoticed.
>>> It also codifies the assumption that we can write 512 bytes
>>> to the global ata_scsi_rbuf buffer.
>>>
>>> As to using a literal 512, I was just following what was here
>>> before.
>>>
>>> It looks like there is a ATA_SECT_SIZE that can replace most
>>> of the literal 512's in here though. That might be a nice cleanup
>>> overall. Not sure it belongs here though.
>>>
>>
>>>>> +       used_bytes = ALIGN(i * 8, 512);
>>>>> +       memset(buffer + i, 0, used_bytes - i * 8);
>>>>> +       sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buffer, 512);
>>
>> And I don't think you have a reason to use 512 here either. It appears
>> to me that you should use ATA_SCSI_RBUF_SIZE instead (see
>> ata_scsi_rbuf_put in libata-scsi). If not, it should probably be a
>> _derived_ value (e.g. from `i`) that tells the _actual_ size of
>> `buffer`.
>
> Nope. We *must* copy the whole 512 byte payload into the sglist.
> Otherwise what was the point of the memset to clear out an cruft?
> Failing to move the whole payload into place could leave whatever
> garbage is in the buffer to be interpreted as an actual trim and do
> real damage. I certainly can't use ATA_SCSI_RBUF_SIZE because
> the payload attached to the cmd need only be 512 bytes. Trying
> to copy in 4k is going to cause bad things when you check
> the return from sg_copy_from_buffer() and notice you failed to
> copy in you payload.

I don't really know how scatter/gather list and the related functions
work to be honest. You should probably use used_bytes then, since
used_bytes is exactly the final size of buffer (after memset, and it
is 512-byte aligned, but not always 512 in terms of logic).

>
>> Again, note that even when we prefer to stick with _one_ 512-byte
>> block TRIM payload, we should probably NEVER _hard code_ such limit
>> (for it's really ugly and unnecessary) in functions like this. All we
>
> The interface requires well formed 512 byte chunks so we have to
> at least have to do enough to ensure that we work in multiples of
> 512. Since 512 is all over the spec for this type of thing I think
> it would be reasonable to have a define or enum if you don't think
> reusing ATA_SECT_SIZE is good maybe something
> like ATA_CMD_XFER_SIZE ?

I have no idea. Perhaps it is fine to use ATA_SECT_SIZE if what you
described ("512 is all over the spec for this type of thing") is true.
It's just personally I don't see any benefit in terms of readability
introducing macro like that. If anything should be done, I would say
it is to add comment above ALIGN() and the ATA taskfiles pointing out
512 is used because ACS specifically pointed out that "TRIM payload
blocks are always 512-byte, but not the logical sector size or so".

>
>> need to do is to advertise the limit (or lower) as Maximum Write
>> Length, and make sure our SATL works as per SBC that it will reject
>> SCSI Write Same commands that is "larger" than that.
>>>>> +       spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
>>>>> +
>>>>> +       return used_bytes;
>>>>> +}
>
>
> --
> Shaun Tancheff
