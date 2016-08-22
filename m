From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH v6 3/4] SCT Write Same / DSM Trim
Date: Mon, 22 Aug 2016 10:04:38 -0500
Message-ID: <CAJVOszCvXwjJCEwxOG0GhN9wq+Axq15zW7Ja=EybyZLRZBYkpA@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-4-shaun@tancheff.com>
 <CAGnHSEn95Z8wKfq1Nf0ntKSzze-ScP5WeAahziD5Sk0QfmEXyw@mail.gmail.com> <CAGnHSEmFMx1Q6mRV-hXwR4_08OvvSR1xcxoT1dLjVMvOHYY_+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGnHSEmFMx1Q6mRV-hXwR4_08OvvSR1xcxoT1dLjVMvOHYY_+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Aug 22, 2016 at 3:33 AM, Tom Yan <tom.ty89@gmail.com> wrote:
> On 22 August 2016 at 08:31, Tom Yan <tom.ty89@gmail.com> wrote:
>> As mentioned before, as of the latest draft of ACS-4, nothing about a
>> larger payload size is mentioned. Conservatively speaking, it sort of
>
> *payload block size
>
>> means that we are allowing four 512-byte block payload on 4Kn device
>
> *eight 512-byte-block payload
>
>> regardless of the reported limit in the IDENTIFY DEVICE data. I am
>> really not sure if it's a good thing to do. Doesn't seem necessary
>> anyway, especially when our block layer does not support such a large
>> bio size (well, yet), so each request will end up using a payload of
>> two 512-byte blocks at max anyway.
>>
>> Also, it's IMHO better to do it in a seperate patch (series) after the
>> SCT Write Same support has entered libata's repo too, because this has
>> nothing to with it but TRIM translation. In case the future ACS
>> standards has clearer/better instruction on this, it will be easier
>> for us to revert/follow up too.

I am certainly fine with dropping this patch as it is not critical to
the reset of the series.

Nothing will break if we stick with the 512 byte fixed limit. This
is at most a prep patch for handling increased limits should
they be reported.

All it really is doing is acknowledging that any write same
must have a payload of sector_size which can be something
larger than 512 bytes.

>> And you'll need to fix the Block Limits VPD simulation
>> (ata_scsiop_inq_b0) too, so that it will advertise the Maximum Write
>> Same Length dynamically as per the logical sector size, otherwise your
>> effort will be completely in vain, even if our block layer is
>> overhauled in the future.

Martin had earlier suggested that I leave the write same defaults
as is due to concerns with misbehaving hardware.

I think your patch adjusting the reported limits is reasonable
enough. It seems to me we should have the hardware
report it's actual limits, for example, report what the spec
allows.

Of course there are lots of reasons to limit the absolute
maximums.

So in this case we are just enabling the limit to be
increased but not changing the current black-listing
that distrusts DSM Trim. Once we have 4Kn devices
to test then we can start white-listing and see if there
is an overall increase in performance.

>> Please be noted that, since your haven't touched ata_scsiop_inq_b0 at
>> all, the reported Maximum Write Same Length will be:
>>
>> On device with TRIM support:
>> - 4194240 LOGICAL sector per request split / command
>> -- ~=2G on non-4Kn drives
>> -- ~=16G on non-4Kn drives
>>
>> On device without TRIM support:
>> - 0 --> SD_MAX_WS10_BLOCKS (65535) per request split / command
>> -- ~= 32M on non-4Kn drives
>> -- ~=256M on non-4Kn drives
>>
>> Even if we ignore the upper limit(s) of the block layer, do we want
>> such inconsistencies?

Hmm. Overall I think it is still okay if a bit confusing.
It is possible that for devices which support SCT Write Same
and DSM TRIM will still Trim faster than they can Write Same,
However the internal implementation is opaque so I can't
say if Write Same is often implemented in terms of TRIM
or not. I mean that's how _I_ do it [Write 1 block and map
N blocks to it], But not every FTL will have come to the
same conclusion.

I also suspect that given the choice for most use casess that
TRIM is preferred over WS when TRIM supports returning
zeroed blocks.

-- 
Shaun Tancheff
