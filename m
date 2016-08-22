From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE
 SAME xlat
Date: Mon, 22 Aug 2016 23:49:04 +0000
Message-ID: <CAGnHSE=t1qg5ukA7btSwD=AaQZB6W6bmF9HMC_K2JsCqoSNGVg@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-2-shaun@tancheff.com>
 <CAGnHSEnMS+wYWiwLxoYsTDOoVb9qJ=gZbcQmhsZumiO+wbQi4A@mail.gmail.com> <CAJVOszBVXftz9hqmOgWG5DvxW7cQjFPUFaGygWcj_exgNwT4=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJVOszBVXftz9hqmOgWG5DvxW7cQjFPUFaGygWcj_exgNwT4=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>
List-Id: linux-ide@vger.kernel.org

The only 512 I can see in the old code is the one in:

> -       used_bytes = ALIGN(i * 8, 512);

where the alignment is necessary because 'used_bytes' will be returned
as 'size', which will be used for setting the number of 512-byte block
payload when we construct the ATA taskfile / command. It may NOT be a
good idea to replace it with ATA_SECT_SIZE. Some comment could be
nice.

So I don't think it makes any sense to check ATA_SCSI_RBUF_SIZE
against 512 here.

On 22 August 2016 at 22:00, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
> Because this is re-using the response buffer in a new way.
> Such reuse could be a surprise to someone refactoring that
> code, although it's pretty unlikely. The build bug on
> gives some level of confidence that it won't go unnoticed.
> It also codifies the assumption that we can write 512 bytes
> to the global ata_scsi_rbuf buffer.
>
> As to using a literal 512, I was just following what was here
> before.
>
> It looks like there is a ATA_SECT_SIZE that can replace most
> of the literal 512's in here though. That might be a nice cleanup
> overall. Not sure it belongs here though.
>

>>> +       used_bytes = ALIGN(i * 8, 512);
>>> +       memset(buffer + i, 0, used_bytes - i * 8);
>>> +       sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buffer, 512);

And I don't think you have a reason to use 512 here either. It appears
to me that you should use ATA_SCSI_RBUF_SIZE instead (see
ata_scsi_rbuf_put in libata-scsi). If not, it should probably be a
_derived_ value (e.g. from `i`) that tells the _actual_ size of
`buffer`.

Again, note that even when we prefer to stick with _one_ 512-byte
block TRIM payload, we should probably NEVER _hard code_ such limit
(for it's really ugly and unnecessary) in functions like this. All we
need to do is to advertise the limit (or lower) as Maximum Write
Length, and make sure our SATL works as per SBC that it will reject
SCSI Write Same commands that is "larger" than that.

>>> +       spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
>>> +
>>> +       return used_bytes;
>>> +}
