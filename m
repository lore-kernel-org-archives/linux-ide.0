From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 3/4] SCT Write Same / DSM Trim
Date: Tue, 23 Aug 2016 02:52:28 +0800
Message-ID: <CAGnHSEkOm3nmmeHMQ5Jok2v2Up3ygNE5AE0sjkFTY26_4PTKvg@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-4-shaun@tancheff.com>
 <CAGnHSEn95Z8wKfq1Nf0ntKSzze-ScP5WeAahziD5Sk0QfmEXyw@mail.gmail.com>
 <CAGnHSEmFMx1Q6mRV-hXwR4_08OvvSR1xcxoT1dLjVMvOHYY_+g@mail.gmail.com>
 <CAJVOszCvXwjJCEwxOG0GhN9wq+Axq15zW7Ja=EybyZLRZBYkpA@mail.gmail.com>
 <CAGnHSE=-kqLyQQ4dZ1=VQ=iBectjHmbF7wg_bxUJ_k+H6nq8bA@mail.gmail.com> <CAJVOszCjjjx39GsdFtKAdwVRG0dJ0Frf4MKSQVHorA_qSZzR7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36046 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbcHVSwb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2016 14:52:31 -0400
In-Reply-To: <CAJVOszCjjjx39GsdFtKAdwVRG0dJ0Frf4MKSQVHorA_qSZzR7w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>

In that case I see no reason that my suggestion should not be adopted.
Currently speaking (as I mentioned in the commit message) it is
reasonable to decrease it per logical sector size in the TRIM-only
sense as well because of the block layer / bio size limit.

FWIW, as of ACS-4, RANGE LENGTH field in DSM(XL)/TRIM range entry
should be "number of logical sectors". Therefore, if there will be any
4Kn SSDs, _bytes_ TRIM'd per command is expected to be increased with
the sector size as well, just like SCT Write Same.

For the "payload block size" that is "always" 512-byte as per the same
spec, I don't think we need to concern about it. I think it only
matters if we want to enable multi-block TRIM payload according to the
reported limit in IDENTIFY DEVICE data. Probably it merely means that
the "each of the blocks" in the reported limit will always mean 64
TRIM entries, even on 4Kn drives, instead of 512.

On 23 August 2016 at 02:00, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
> On Mon, Aug 22, 2016 at 12:02 PM, Tom Yan <tom.ty89@gmail.com> wrote:
>> On 22 August 2016 at 15:04, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>>> On Mon, Aug 22, 2016 at 3:33 AM, Tom Yan <tom.ty89@gmail.com> wrote:
>>>> On 22 August 2016 at 08:31, Tom Yan <tom.ty89@gmail.com> wrote:
>
>> Since I have no experience with SCT Write Same at all, and neither do
>> I own any spinning HDD at all, I cannot firmly suggest what to do. All
>> I can suggest is: should we decrease it per sector size? Or would 2G
>> per command still be too large to avoid timeout?
>
> Timeout for WS is 120 seconds so we should be fine there.
>
> The number to look for is the:
>    Max. Sustained Transfer Rate OD (MB/s): 190 8TB (180 5TB)
>
> Which means the above drives should complete a 2G write in
> about 10 to 11 seconds.
>
> If these were 4Kn drives and we allowed a 16G max then it
> would be 80-90 seconds, assuming the write speed didn't
> get any better.
>
> So holding the maximum to around 2G is probably the best
> overall, in my opinion.
>
> --
> Shaun Tancheff
>
> On Mon, Aug 22, 2016 at 12:02 PM, Tom Yan <tom.ty89@gmail.com> wrote:
>> On 22 August 2016 at 15:04, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>>> On Mon, Aug 22, 2016 at 3:33 AM, Tom Yan <tom.ty89@gmail.com> wrote:
>>>> On 22 August 2016 at 08:31, Tom Yan <tom.ty89@gmail.com> wrote:
>>>>> As mentioned before, as of the latest draft of ACS-4, nothing about a
>>>>> larger payload size is mentioned. Conservatively speaking, it sort of
>>>>
>>>> *payload block size
>>>>
>>>>> means that we are allowing four 512-byte block payload on 4Kn device
>>>>
>>>> *eight 512-byte-block payload
>>>>
>>>>> regardless of the reported limit in the IDENTIFY DEVICE data. I am
>>>>> really not sure if it's a good thing to do. Doesn't seem necessary
>>>>> anyway, especially when our block layer does not support such a large
>>>>> bio size (well, yet), so each request will end up using a payload of
>>>>> two 512-byte blocks at max anyway.
>>>>>
>>>>> Also, it's IMHO better to do it in a seperate patch (series) after the
>>>>> SCT Write Same support has entered libata's repo too, because this has
>>>>> nothing to with it but TRIM translation. In case the future ACS
>>>>> standards has clearer/better instruction on this, it will be easier
>>>>> for us to revert/follow up too.
>>>
>>> I am certainly fine with dropping this patch as it is not critical to
>>> the reset of the series.
>>>
>>> Nothing will break if we stick with the 512 byte fixed limit. This
>>> is at most a prep patch for handling increased limits should
>>> they be reported.
>>>
>>> All it really is doing is acknowledging that any write same
>>> must have a payload of sector_size which can be something
>>> larger than 512 bytes.
>>
>> Actually I am not sure if we should hard code the limit
>> ata_format_dsm_trim_descr() / ata_set_lba_range_entries() at all. The
>> current implementation (with or without your patch) seems redundant
>> and unnecessary to me.
>>
>> All we need to do should be: making sure that the block limits VPD
>> advertises a safe Maximum Write Same Length, and reject Write Same
>> (16) commands that have "number of blocks" that exceeds the limit
>> (which is what I introduced in commit 5c79097a28c2, "libata-scsi:
>> reject WRITE SAME (16) with n_block that exceeds limit").
>>
>> In that case, we don't need to hard code the limit in the
>> while-condition again; instead we should just make it end with the
>> request size, since the accepted request could never be larger than
>> the limit we advertise.
>>
>>>
>>>>> And you'll need to fix the Block Limits VPD simulation
>>>>> (ata_scsiop_inq_b0) too, so that it will advertise the Maximum Write
>>>>> Same Length dynamically as per the logical sector size, otherwise your
>>>>> effort will be completely in vain, even if our block layer is
>>>>> overhauled in the future.
>>>
>>> Martin had earlier suggested that I leave the write same defaults
>>> as is due to concerns with misbehaving hardware.
>>
>> It doesn't really apply in libata's anyway. SD_MAX_WS10_BLOCKS means
>> nothing to ATA drives, except from coincidentally being the same value
>> as ATA_MAX_SECTORS_LBA48 (which technically should have been 65536
>> instead).
>>
>>>
>>> I think your patch adjusting the reported limits is reasonable
>>> enough. It seems to me we should have the hardware
>>> report it's actual limits, for example, report what the spec
>>> allows.
>>
>> As you mentioned yourself before, technically SCT Write Same does not
>> have a limit. The only practical limit is the timeout in the SCSI
>> layer, so the actual bytes being (over)written is probably our only
>> concern.
>>
>> For the case of TRIM, devices do report a limit in their IDENTIFY
>> DEVICE data. However, as Martin always said, it is not an always-safe
>> piece of data for us to refer to, that's why we have been statically
>> allowing only 1-block payload.
>>
>> Therefore, it seems convenient (and consistent) that we make SCT Write
>> Same always use the same limit as TRIM, no matter if it is supported
>> on a certain device. And to make sure the actual bytes being written /
>> time required per command does not increase enormously as per the
>> sector size, we decrease the limit accordingly. Certainly that's not
>> necessary if 16G per command is fine on most devices.
>>
>> Also, does SCT Write Same commands that write 32M/256M per command
>> make any sense? I mean would we benefit from such small SCT Write Same
>> commands at all?
>>
>>>
>>> Of course there are lots of reasons to limit the absolute
>>> maximums.
>>>
>>> So in this case we are just enabling the limit to be
>>> increased but not changing the current black-listing
>>> that distrusts DSM Trim. Once we have 4Kn devices
>>> to test then we can start white-listing and see if there
>>> is an overall increase in performance.
>>>
>>>>> Please be noted that, since your haven't touched ata_scsiop_inq_b0 at
>>>>> all, the reported Maximum Write Same Length will be:
>>>>>
>>>>> On device with TRIM support:
>>>>> - 4194240 LOGICAL sector per request split / command
>>>>> -- ~=2G on non-4Kn drives
>>>>> -- ~=16G on non-4Kn drives
>>>>>
>>>>> On device without TRIM support:
>>>>> - 0 --> SD_MAX_WS10_BLOCKS (65535) per request split / command
>>>>> -- ~= 32M on non-4Kn drives
>>>>> -- ~=256M on non-4Kn drives
>>>>>
>>>>> Even if we ignore the upper limit(s) of the block layer, do we want
>>>>> such inconsistencies?
>>>
>>> Hmm. Overall I think it is still okay if a bit confusing.
>>> It is possible that for devices which support SCT Write Same
>>> and DSM TRIM will still Trim faster than they can Write Same,
>>> However the internal implementation is opaque so I can't
>>> say if Write Same is often implemented in terms of TRIM
>>> or not. I mean that's how _I_ do it [Write 1 block and map
>>> N blocks to it], But not every FTL will have come to the
>>> same conclusion.
>>
>> Why would SCT Write Same be implemented in terms of TRIM? Neither
>> would we need to care about that anyway. Considering we will unlikely
>> allow multi-block payload TRIM, and we probably have no reason to
>> touch the SCSI Write Same timeout, the only thing we need to consider
>> is whether we want to decrease the advertised limit base on the
>> typical SCT Write Same speed on traditional HDDs and the timeout,
>> especially in the 4Kn case.
>>
>> Since I have no experience with SCT Write Same at all, and neither do
>> I own any spinning HDD at all, I cannot firmly suggest what to do. All
>> I can suggest is: should we decrease it per sector size? Or would 2G
>> per command still be too large to avoid timeout?
>>
>>>
>>> I also suspect that given the choice for most use casess that
>>> TRIM is preferred over WS when TRIM supports returning
>>> zeroed blocks.
>>
>> Well, for devices with discard_zeroes_data = 1, the block layer will
>> not issue write same requests (see blkdev_issue_zeroout in
>> block/blk-lib.c). However, libata only consider the RZAT support bit
>> from a white list of devices (see ata_scsiop_read_cap in libata-scsi
>> and the white list in libata-core).
>>
>>>
>>> --
>>> Shaun Tancheff
>
>
>
> --
> Shaun Tancheff
