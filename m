From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v6 1/4] libata: Safely overwrite attached page in WRITE SAME xlat
Date: Tue, 23 Aug 2016 23:33:39 -0400
Message-ID: <yq1vayqdeng.fsf@sermon.lab.mkp.net>
References: <20160822042321.24367-1-shaun@tancheff.com>
        <20160822042321.24367-2-shaun@tancheff.com>
        <CAGnHSEnMS+wYWiwLxoYsTDOoVb9qJ=gZbcQmhsZumiO+wbQi4A@mail.gmail.com>
        <CAJVOszBVXftz9hqmOgWG5DvxW7cQjFPUFaGygWcj_exgNwT4=w@mail.gmail.com>
        <CAGnHSE=t1qg5ukA7btSwD=AaQZB6W6bmF9HMC_K2JsCqoSNGVg@mail.gmail.com>
        <CAJVOszBP_JLgKUsknSmG+AuCVW8VEB4VUuaTNQ-MrE9B0nuXBg@mail.gmail.com>
        <CAGnHSEmsgp93X85-bgFyV0CdQbvdMHZsWj6e=VNH_7dUDUewHA@mail.gmail.com>
        <CAJVOszD8HDqQMxyAnU=Yh6UDA+KE13u7Mq6s248uguRf-uUkYg@mail.gmail.com>
        <CAGnHSEn7M9Kmse+_JFFCgvZY5TqZt1TDzXGhKaqimog4OKiktg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGnHSEn7M9Kmse+_JFFCgvZY5TqZt1TDzXGhKaqimog4OKiktg@mail.gmail.com>
        (Tom Yan's message of "Tue, 23 Aug 2016 07:53:57 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>, Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>
List-Id: linux-ide@vger.kernel.org

>>>>> "Tom" == Tom Yan <tom.ty89@gmail.com> writes:

Tom> Nope, SCSI Write Same commands does not have payload (or in SCSI
Tom> terms, parameter list / data-out buffer).

WRITE SAME has a a payload of 1 logical block (unless NDOB is set but we
have had no good reason to support that yet).

UNMAP has a payload that varies based on the number of range
descriptors. The SCSI disk driver only ever issues a single descriptor
but since libata doesn't support UNMAP this doesn't really come into
play.

Ideally there would be a way to distinguish between device limits for
WRITE SAME with the UNMAP bit and for "regular" WRITE SAME. One way to
do that would be to transition the libata discard implementation over to
single-range UNMAP, fill out the relevant VPD page B0 fields and leave
the WRITE SAME bits for writing zeroes.

One reason that has not been particularly compelling is that the WRITE
SAME payload buffer does double duty to hold the ATA DSM TRIM range
descriptors and matches the required ATA payload size. Whereas the UNMAP
command would only provide 24 bytes of TRIM range space.

Also, please be careful with transfer lengths, __data_len, etc. As
mentioned, the transfer length WRITE SAME is typically 512 bytes and
that's the number of bytes that need to be DMA'ed and transferred over
the wire by the controller. But from a command completion perspective we
need to complete however many bytes the command acted upon. Unlike reads
and writes there is not a 1:1 mapping between the transfer length and
the affected area. So we do a bit of magic after the buffer has been
mapped to ensure that the completion byte count matches the number of
blocks that were affected by the command rather than the size of the
data buffer in bytes.

-- 
Martin K. Petersen	Oracle Linux Engineering
