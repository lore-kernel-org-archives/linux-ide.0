Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6044FC38A02
	for <linux-ide@archiver.kernel.org>; Fri, 28 Oct 2022 16:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJ1Qpv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Oct 2022 12:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJ1Qpt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Oct 2022 12:45:49 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0827065003
        for <linux-ide@vger.kernel.org>; Fri, 28 Oct 2022 09:45:46 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1ooSUE-0005FZ-Db; Fri, 28 Oct 2022 18:45:38 +0200
Message-ID: <3f14c490-0ac4-4355-4b56-567d5547049c@maciej.szmigiero.name>
Date:   Fri, 28 Oct 2022 18:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 4/6] ata: libata: Fix FUA handling in ata_build_rw_tf()
Content-Language: en-US, pl-PL
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
 <20221027075026.240017-5-damien.lemoal@opensource.wdc.com>
 <69b5067c-dd13-a56a-3267-867902953045@suse.de>
 <e171ce82-fdd5-0db2-c821-849dd9467fef@opensource.wdc.com>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
In-Reply-To: <e171ce82-fdd5-0db2-c821-849dd9467fef@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 28.10.2022 00:22, Damien Le Moal wrote:
> On 10/27/22 18:42, Hannes Reinecke wrote:
>> On 10/27/22 09:50, Damien Le Moal wrote:
>>> If a user issues a write command with the FUA bit set for a device with
>>> NCQ support disabled (that is, the device queue depth was set to 1), the
>>> LBA 48 command WRITE DMA FUA EXT must be used. However,
>>> ata_build_rw_tf() ignores this and first test if LBA 28 can be used.
>>> That is, for small FUA writes at low LBAs, ata_rwcmd_protocol() will
>>> cause the write to fail.
>>>
>>> Fix this by preventing the use of LBA 28 for any FUA write request.
>>> While at it, also early test if the request is a FUA read and fail these
>>> requests for the NCQ-disabled case instead of relying on
>>> ata_rwcmd_protocol() returning an error.
>>>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> ---
>>>    drivers/ata/libata-core.c | 17 +++++++++++++++--
>>>    1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 81b20ffb1554..fea06f41f371 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -725,9 +725,21 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 block, u32 n_block,
>>>    		    class == IOPRIO_CLASS_RT)
>>>    			tf->hob_nsect |= ATA_PRIO_HIGH << ATA_SHIFT_PRIO;
>>>    	} else if (dev->flags & ATA_DFLAG_LBA) {
>>> +		bool lba28_ok;
>>> +
>>> +		if (tf->flags & ATA_TFLAG_FUA) {
>>> +			/* FUA reads are not defined */
>>> +			if (!(tf->flags & ATA_TFLAG_WRITE))
>>> +				return -EINVAL;
>>> +			/* We need LBA48 / WRITE DMA FUA EXT for FUA writes */
>>> +			lba28_ok = false;
>>> +		} else {
>>> +			lba28_ok = lba_28_ok(block, n_block);
>>> +		}
>>> +
>>>    		tf->flags |= ATA_TFLAG_LBA;
>>>    
>>> -		if (lba_28_ok(block, n_block)) {
>>> +		if (lba28_ok) {
>>>    			/* use LBA28 */
>>>    			tf->device |= (block >> 24) & 0xf;
>>>    		} else if (lba_48_ok(block, n_block)) {
>>
>> I am still skeptical about this change.
>> Having checked the code I don't think that we ever issue a
>> REQ_READ|REQ_FUA; but at the same time there doesn't seem to be a strict
>> rule. I wonder if we shouldn't move that check into the block layer, and
>> error out any attempts to issue such?
> 
> That definitely would be good for ATA, but potentially restrictive for
> scsi ? Not sure about NVMe, I have not checked the specs. That said, the
> only reasonable reason to do an FUA read that I can think of would be a
> "scrub" like write-and-verify feature. And I do not think that any FS
> implement their scrub process using FUA.
> 
>> Otherwise we would error out an otherwise fine I/O (which we _could_
>> have handled via PREFLUSH etc semantics), which I don't think is a good
>> idea.
> 
> Well no. Given that there is no FUA read command for the non-ncq case,
> doing the same as for a write FUA in reverse order (synchronize cache
> first, then read) would still not necessarily force the drive to access
> the media because synchronize cache is *not* and "invalidate cache"
> operation. So we cannot use the block layer either as we potentially would
> end up lying about the media access part of "FUA". With that in mind,
> failing the FUA read is a much safer option I think.
> 
> What we could do given that we now have FUA restricted to NCQ is this:
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 77a7be74e65e..61e449877d8d 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -693,7 +693,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64
> block, u32 n_block,
>          tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>          tf->flags |= tf_flags;
> 
> -       if (ata_ncq_enabled(dev)) {
> +       if (ata_ncq_enabled(dev) || tf->flags & ATA_TFLAG_FUA) {
>                  /* yay, NCQ */
>                  if (!lba_48_ok(block, n_block))
>                          return -ERANGE;
> 
> That is, ignore if NCQ is off and always use NCQ read/write for FUA.
> I am not a huge fan of this as that would lead to mixing NCQ and non-NCQ
> commands when the drive QD is set to 1. Not exactly nice, which is why I
> did not initially modify the patch to do that.
> However, with this change, we would be fully on par with scsi and can do
> both read and write FUA with the same semantic, as expected from the user
> if we declare that we support FUA.
> 
(..)
> 
> Thoughts ?
> 

To be honest, this seems like much cleaner solution to me - as you say,
it makes libata consistent with SCSI.

In this case, obviously the FUA support still needs to be dependent on
NCQ support.

Thanks,
Maciej

