From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 2/4] Add support for SCT Write Same
Date: Tue, 23 Aug 2016 05:55:18 +0000
Message-ID: <CAGnHSEmLq0qcg8_LZBCqFYJohZORBSe58SSjC3sK7cCf=0g9EQ@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-3-shaun@tancheff.com>
 <CAGnHSE=KijjA8ZBhNBQZH-5CeC1w4vu8wWob4Mm9tTKVNSL_GQ@mail.gmail.com>
 <CAJVOszBPL4LM8MYMyrmnfFBqqdV6E3OCpShn12KKFv8E+tSL8Q@mail.gmail.com>
 <CAGnHSEnZe0iipr2hO=QDSq6s7+5JoevXvPNes=WP7gwToFzHsw@mail.gmail.com>
 <CAJVOszAHcuyLoSJwmKvK5vgM8aLqfQJsaw=Vx7K66wMEaqmu_A@mail.gmail.com>
 <CAGnHSEm5Ur-7eCj-_mJsTeDwxhkGHPERAodebDS7rRg0AvGn3Q@mail.gmail.com> <CAJVOszC_MfPtGTR05p=qSHjY_wu4ziMMAqgra7Pu0tQYoxa-Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33497 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756229AbcHWFzU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2016 01:55:20 -0400
In-Reply-To: <CAJVOszC_MfPtGTR05p=qSHjY_wu4ziMMAqgra7Pu0tQYoxa-Kg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

On 23 August 2016 at 00:36, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
> On Mon, Aug 22, 2016 at 6:09 PM, Tom Yan <tom.ty89@gmail.com> wrote:
>> I am not sure about what you mean here. Rejecting SCSI Write Same
>> commands that has its "number of blocks" field set to a value higher
>> than the device's reported Maximum Write Same Length is only natural
>> and mandated by SBC. We have no reason (even if it is practically not
>> a must) not to do it while we are implementing a SCSI-ATA Translation
>> Layer here as long as we advertise Maximum Write Same Length. It does
>> not matter here whether the command ends up being translated to SCT
>> Write Same or TRIM.
>>
>> How high or how lower the limit should be advertised has nothing to do
>> with the checking.
>>
>> FWIW, letting the SCSI/block layer fall back with SD_MAX_WS10_BLOCKS
>> does NOT count as advertising Maximum Write Same Length, that's why we
>> may or may not (in terms of SBC) check n_block against it if we are
>> really gonna leave ata_scsiop_inq_b0 in libata-scsi untouched.
>
> Sorry I'm still a bit confused.

It's alright. I guess I am not good at expressing my ideas. (And poor English)

>
> SCT Write Same does not have a limit ... it's a u64 of logical sectors.

As I've said, it is not really about SCT Write Same or TRIM. The check
here is added just to make our SATL (which is in some sense a SCSI
device) behave as how we advertised it (Maximum Write Same Length /
rbuf[36] set in ata_scsiop_inq_b0, that's why the value of the check
should always be the same as that).

So for both cases (TRIM and SCT Write Same), _if_ we advertise Maximum
Write Same Length, we should make our SATL (or in other word, our
"SCSI device") reject SCSI Write Same commands as per what we "told"
the users (and the SCSI/block layer).

The SCSI disk driver or so would NOT reject Write Same commands for us
as per the Maximum Write Same Length we reported, because it is the
responsibility of the SCSI device itself (as per SBC). The limit will
only be used to tell the block layer how large at max should each
split of the discard / write same request be.

> Any limit specified is smaller based on other parts of the stack.
> The SATL code being used to emulating SCSI Write Same which does
> have a limited number of sectors .. so falling back to the SCSI limit
> seems reasonable.

I am really not going to tell the whole story here again. We have a
really long discussion on whether we should advertise Maximum Write
Same Length for SCT Write Same, and the value we should advertise.
(Didn't we come to an conclusion on that as well?)

The check should be added here is just a knee-jerk reaction for the
Maximum Write Same Length we advertise. If you end up not advertising
one for SCT Write Same, you don't need to add the check here.

>
> So the limit that is being applied is either the current TRIM limit,
> or the SCSI Write Same limit.
> --
> Shaun Tancheff
