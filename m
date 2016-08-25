From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Thu, 25 Aug 2016 02:31:22 -0500
Message-ID: <CAJVOszDOPpMZgooKHc9+Tnjyd6a+sbMCJb0xeLyAD5n1vLT8nw@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-3-shaun@tancheff.com>
 <CAGnHSEmVbkJ30uNbW1O-Wh4E7RKbf+OojxRYjWanMYH_OrvHnA@mail.gmail.com>
 <CAJVOszDck0HOVKdnqG=wWyE9G=gGwmouh-YF2RL93AJHvbSTcg@mail.gmail.com>
 <CAGnHSEmQz9tLrUjE4UF_Taa6tUjO1X22o5GcU79KFPXHaOTGOg@mail.gmail.com>
 <CAGnHSEnEUu0E3rQmyB3+wjUK8v-Ojg8xpKxMMZoiXHdfWwuhkg@mail.gmail.com>
 <CAJ48U8XgkjapcfZTka0xFKa3h=tEEE5hW3d9tuL4Q1MW88NEFw@mail.gmail.com> <CAGnHSEm-EjtmtT+VDOdJqNMq_bZ-n8Qe_oMLcorZGJT3+550Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGnHSEm-EjtmtT+VDOdJqNMq_bZ-n8Qe_oMLcorZGJT3+550Fg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 25, 2016 at 1:23 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> You only fill the bytes that you want to to set explicitly:
>
> +       put_unaligned_le16(0x0002,  &sctpg[0]); /* SCT_ACT_WRITE_SAME */
> +       put_unaligned_le16(0x0101,  &sctpg[1]); /* WRITE PTRN FG */
> +       put_unaligned_le64(lba,     &sctpg[2]);
> +       put_unaligned_le64(num,     &sctpg[6]);
> +       put_unaligned_le32(0u,      &sctpg[10]);
>
> What I doubted is, if you don't memset (zero-fill) the buffer first,
> will other bytes have indeterministic value that causes random
> unexpected behavior?

No.
If there is random or unexpected behaviour the device is broken
and some other remedy, such as blacklisting, is required.

---
Shaun
