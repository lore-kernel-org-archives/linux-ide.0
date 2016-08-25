From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Thu, 25 Aug 2016 14:23:24 +0800
Message-ID: <CAGnHSEm-EjtmtT+VDOdJqNMq_bZ-n8Qe_oMLcorZGJT3+550Fg@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-3-shaun@tancheff.com>
 <CAGnHSEmVbkJ30uNbW1O-Wh4E7RKbf+OojxRYjWanMYH_OrvHnA@mail.gmail.com>
 <CAJVOszDck0HOVKdnqG=wWyE9G=gGwmouh-YF2RL93AJHvbSTcg@mail.gmail.com>
 <CAGnHSEmQz9tLrUjE4UF_Taa6tUjO1X22o5GcU79KFPXHaOTGOg@mail.gmail.com>
 <CAGnHSEnEUu0E3rQmyB3+wjUK8v-Ojg8xpKxMMZoiXHdfWwuhkg@mail.gmail.com> <CAJ48U8XgkjapcfZTka0xFKa3h=tEEE5hW3d9tuL4Q1MW88NEFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35622 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757158AbcHYGkn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2016 02:40:43 -0400
In-Reply-To: <CAJ48U8XgkjapcfZTka0xFKa3h=tEEE5hW3d9tuL4Q1MW88NEFw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

You only fill the bytes that you want to to set explicitly:

+       put_unaligned_le16(0x0002,  &sctpg[0]); /* SCT_ACT_WRITE_SAME */
+       put_unaligned_le16(0x0101,  &sctpg[1]); /* WRITE PTRN FG */
+       put_unaligned_le64(lba,     &sctpg[2]);
+       put_unaligned_le64(num,     &sctpg[6]);
+       put_unaligned_le32(0u,      &sctpg[10]);

What I doubted is, if you don't memset (zero-fill) the buffer first,
will other bytes have indeterministic value that causes random
unexpected behavior?

On 25 August 2016 at 06:04, Shaun Tancheff <shaun@tancheff.com> wrote:
> On Wed, Aug 24, 2016 at 1:10 AM, Tom Yan <tom.ty89@gmail.com> wrote:
>> Btw, I wonder if you need to memset your buffer with 0 first, like
>> what is done in ata_scsi_rbuf_get.
>
> It is not necessary as the defined buffer is completely filled out here.
>
> Are you thinking as a sort of future proofing?
> Ex: In the unlikely event that the SCT Write Same command
> descriptor is expanded in a future ACS?
>
> It is more likely to see the command deprecated and replaced with a
> new SCT feature.
>
> Regardless of how unlikely I would consider a memset here to clear
> the remainder of the payload.
