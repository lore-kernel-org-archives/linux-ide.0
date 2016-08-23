From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Tue, 23 Aug 2016 05:56:26 -0500
Message-ID: <CAJVOszDck0HOVKdnqG=wWyE9G=gGwmouh-YF2RL93AJHvbSTcg@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-3-shaun@tancheff.com>
 <CAGnHSEmVbkJ30uNbW1O-Wh4E7RKbf+OojxRYjWanMYH_OrvHnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGnHSEmVbkJ30uNbW1O-Wh4E7RKbf+OojxRYjWanMYH_OrvHnA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Aug 23, 2016 at 5:37 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> On 22 August 2016 at 04:23, Shaun Tancheff <shaun@tancheff.com> wrote:
>> +/**
>> + * ata_format_dsm_trim_descr() - SATL Write Same to ATA SCT Write Same
>> + * @cmd: SCSI command being translated
>> + * @lba: Starting sector
>> + * @num: Number of logical sectors to be zero'd.
>> + *
>> + * Rewrite the WRITE SAME descriptor to be an SCT Write Same formatted
>> + * descriptor.
>> + * NOTE: Writes a pattern (0's) in the foreground.
>> + *       Large write-same requents can timeout.
>> + */
>> +static void ata_format_sct_write_same(struct scsi_cmnd *cmd, u64 lba, u64 num)
>> +{
>> +       u16 *sctpg;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
>> +       sctpg = ((void *)ata_scsi_rbuf);
>
> Because ata_scsi_rbuf is of a fixed size of ATA_SCSI_RBUF_SIZE.
>
> #define ATA_SCSI_RBUF_SIZE      4096
> ...
> static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
>
>> +
>> +       put_unaligned_le16(0x0002,  &sctpg[0]); /* SCT_ACT_WRITE_SAME */
>> +       put_unaligned_le16(0x0101,  &sctpg[1]); /* WRITE PTRN FG */
>> +       put_unaligned_le64(lba,     &sctpg[2]);
>> +       put_unaligned_le64(num,     &sctpg[6]);
>> +       put_unaligned_le32(0u,      &sctpg[10]);
>> +
>> +       sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), sctpg, 512);
>
> You have no reason to use 512 here instead of ATA_SCSI_RBUF_SIZE this time.

Ah .. because SCT Write Same is a fixed 512 byte transfer?
Ah .. because I only have 512 bytes to copy?

>> +       spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
>> +}
