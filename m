From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Tue, 23 Aug 2016 04:14:32 +0800
Message-ID: <CAGnHSEnZe0iipr2hO=QDSq6s7+5JoevXvPNes=WP7gwToFzHsw@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-3-shaun@tancheff.com>
 <CAGnHSE=KijjA8ZBhNBQZH-5CeC1w4vu8wWob4Mm9tTKVNSL_GQ@mail.gmail.com> <CAJVOszBPL4LM8MYMyrmnfFBqqdV6E3OCpShn12KKFv8E+tSL8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33236 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756134AbcHVUOf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2016 16:14:35 -0400
In-Reply-To: <CAJVOszBPL4LM8MYMyrmnfFBqqdV6E3OCpShn12KKFv8E+tSL8Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On 23 August 2016 at 03:43, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>>> +       if (unmap) {
>>> +               /* If trim is not enabled the cmd is invalid. */
>>> +               if ((dev->horkage & ATA_HORKAGE_NOTRIM) ||
>>> +                   !ata_id_has_trim(dev->id)) {
>>> +                       fp = 1;
>>> +                       bp = 3;
>>> +                       goto invalid_fld;
>>> +               }
>>> +               /* If the request is too large the cmd is invalid */
>>> +               if (n_block > 0xffff * trmax) {
>>> +                       fp = 2;
>>> +                       goto invalid_fld;
>>> +               }
>>
>> This response should be generally applied to the Write Same (16)
>> translation, since it is required by SBC,
>>
>>> +       } else {
>>> +               /* If write same is not available the cmd is invalid */
>>> +               if (!ata_id_sct_write_same(dev->id)) {
>>> +                       fp = 1;
>>> +                       bp = 3;
>>> +                       goto invalid_fld;
>>> +               }
>>
>> therefore, you should add an n_block check here as well, if you are
>> going to advertise an Maximum Write Same Length even when the device
>> supports only SCT Write Same but not TRIM. Most likely you would want
>> to simply move the existing check one-level up (if the same limit is
>> advertised no matter TRIM is supported not or not).
>
> Why would we enforce upper level limits on something that doesn't
> have any?

If we advertise a limit in our SATL, it makes sense that we should
make sure the behaviour is consistent when we issue a write same
through the block layer / ioctl and when we issue a SCSI Write Same
command directly (e.g. with sg_write_same). IMHO that's pretty much
why SBC would mandate such behaviour as well.

>
> If the upper level, or SG_IO, chooses to set a timeout of 10 hours and
> wipe a whole disk it should be free to do so.
>

That's why I said, "if you are going to advertise an Maximum Write Same Length".
