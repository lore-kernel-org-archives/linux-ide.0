From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE
 SAME xlat
Date: Tue, 23 Aug 2016 04:12:58 +0800
Message-ID: <CAGnHSEnC1CA=jiGBOtThPiQRJdASQKQVT1P4V688rjk3nexgKQ@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-2-shaun@tancheff.com>
 <CAGnHSEkKcp-mr0LDfqPyUbd=f8RygsGWD756CT7u5Vycs-cPkg@mail.gmail.com> <CAJVOszCXdZVGwCcOv+E-NT8bANsvPEUHH+UUe=eFza0WhfEpNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32999 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753338AbcHVUOC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2016 16:14:02 -0400
In-Reply-To: <CAJVOszCXdZVGwCcOv+E-NT8bANsvPEUHH+UUe=eFza0WhfEpNw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

Oh, 0xffff is fine for me, as long as you change it in
ata_scsiop_inq_b0 as well. Actually I think replacing it with a macro
(as suggested by Martin in another thread) is a good idea as well. A
line split would be better than introducing an unnecessary variable
that costs readability in the logic sense.

On 23 August 2016 at 03:51, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
> On Mon, Aug 22, 2016 at 2:27 PM, Tom Yan <tom.ty89@gmail.com> wrote:
>> On 22 August 2016 at 12:23, Shaun Tancheff <shaun@tancheff.com> wrote:
>>> Safely overwriting the attached page to ATA format from the SCSI formatted
>>> variant.
>>>
>>> Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
>>> ---
>>> v6:
>>>  - Fix bisect bug reported by Tom Yan <tom.ty89@gmail.com>
>>>  - Change to use sg_copy_from_buffer as per Christoph Hellwig <hch@lst.de>
>>> v5:
>>>  - Added prep patch to work with non-page aligned scatterlist pages
>>>    and use kmap_atomic() to lock page during modification.
>>>
>>>  drivers/ata/libata-scsi.c | 56 ++++++++++++++++++++++++++++++++++++++++++-----
>>>  include/linux/ata.h       | 26 ----------------------
>>>  2 files changed, 51 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index e207b33..7990cb2 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -3282,6 +3282,54 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>>>         return 1;
>>>  }
>>>
>>> +/**
>>> + * ata_format_dsm_trim_descr() - SATL Write Same to DSM Trim
>>> + * @cmd: SCSI command being translated
>>> + * @num: Maximum number of entries (nominally 64).
>>> + * @sector: Starting sector
>>> + * @count: Total Range of request
>>> + *
>>> + * Rewrite the WRITE SAME descriptor to be a DSM TRIM little-endian formatted
>>> + * descriptor.
>>> + *
>>> + * Upto 64 entries of the format:
>>> + *   63:48 Range Length
>>> + *   47:0  LBA
>>> + *
>>> + *  Range Length of 0 is ignored.
>>> + *  LBA's should be sorted order and not overlap.
>>> + *
>>> + * NOTE: this is the same format as ADD LBA(S) TO NV CACHE PINNED SET
>>> + */
>>> +static unsigned int ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 num,
>>> +                                             u64 sector, u32 count)
>>> +{
>>> +       __le64 *buffer;
>>> +       u32 i = 0, used_bytes;
>>> +       unsigned long flags;
>>> +
>>> +       BUILD_BUG_ON(512 > ATA_SCSI_RBUF_SIZE);
>>> +
>>> +       spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
>>> +       buffer = ((void *)ata_scsi_rbuf);
>>> +       while (i < num) {
>>> +               u64 entry = sector |
>>> +                       ((u64)(count > 0xffff ? 0xffff : count) << 48);
>>> +               buffer[i++] = __cpu_to_le64(entry);
>>> +               if (count <= 0xffff)
>>> +                       break;
>>> +               count -= 0xffff;
>>> +               sector += 0xffff;
>>> +       }
>>> +
>>> +       used_bytes = ALIGN(i * 8, 512);
>>> +       memset(buffer + i, 0, used_bytes - i * 8);
>>> +       sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buffer, 512);
>>> +       spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
>>> +
>>> +       return used_bytes;
>>> +}
>>> +
>>>  static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>>>  {
>>>         struct ata_taskfile *tf = &qc->tf;
>>> @@ -3290,8 +3338,8 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>>>         const u8 *cdb = scmd->cmnd;
>>>         u64 block;
>>>         u32 n_block;
>>> +       const u32 trmax = ATA_MAX_TRIM_RNUM;
>>
>> This does not seem like a good idea.
>>
>>>         u32 size;
>>> -       void *buf;
>>>         u16 fp;
>>>         u8 bp = 0xff;
>>>
>>> @@ -3319,10 +3367,8 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>>>         if (!scsi_sg_count(scmd))
>>>                 goto invalid_param_len;
>>>
>>> -       buf = page_address(sg_page(scsi_sglist(scmd)));
>>> -
>>> -       if (n_block <= 65535 * ATA_MAX_TRIM_RNUM) {
>>> -               size = ata_set_lba_range_entries(buf, ATA_MAX_TRIM_RNUM, block, n_block);
>>> +       if (n_block <= 0xffff * trmax) {
>>
>> Note that the limit here would always be the advertised Maximum Write
>> Same Length (ata_scsiop_inq_b0). It would be best for them to look the
>> same. Besides, it doesn't seem necessary to create this trmax anyway.
>
> It is entirely a style thing. I tend to prefer hex when describing an interface
> that specifies number of bits. The trmax is just to keep the following line
> under 80 chars.
> I am not tied to either. I can change it if people really find it confusing.
>
>>> +               size = ata_format_dsm_trim_descr(scmd, trmax, block, n_block);
>>>         } else {
>>>                 fp = 2;
>>>                 goto invalid_fld;
>>> diff --git a/include/linux/ata.h b/include/linux/ata.h
>>> index adbc812..45a1d71 100644
>>> --- a/include/linux/ata.h
>>> +++ b/include/linux/ata.h
>>> @@ -1071,32 +1071,6 @@ static inline void ata_id_to_hd_driveid(u16 *id)
>>>  #endif
>>>  }
>>>
>>> -/*
>>> - * Write LBA Range Entries to the buffer that will cover the extent from
>>> - * sector to sector + count.  This is used for TRIM and for ADD LBA(S)
>>> - * TO NV CACHE PINNED SET.
>>> - */
>>> -static inline unsigned ata_set_lba_range_entries(void *_buffer,
>>> -               unsigned num, u64 sector, unsigned long count)
>>> -{
>>> -       __le64 *buffer = _buffer;
>>> -       unsigned i = 0, used_bytes;
>>> -
>>> -       while (i < num) {
>>> -               u64 entry = sector |
>>> -                       ((u64)(count > 0xffff ? 0xffff : count) << 48);
>>> -               buffer[i++] = __cpu_to_le64(entry);
>>> -               if (count <= 0xffff)
>>> -                       break;
>>> -               count -= 0xffff;
>>> -               sector += 0xffff;
>>> -       }
>>> -
>>> -       used_bytes = ALIGN(i * 8, 512);
>>> -       memset(buffer + i, 0, used_bytes - i * 8);
>>> -       return used_bytes;
>>> -}
>>> -
>>>  static inline bool ata_ok(u8 status)
>>>  {
>>>         return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
>>> --
>>> 2.9.3
>>>
>
>
>
> --
> Shaun Tancheff
