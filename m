Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ADAC38A2D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 09:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiJ0JOS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiJ0JOH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 05:14:07 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A34C172B72
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666861958; x=1698397958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p69ZHFimCng0hygK4jmMHnBOIswAceaVFC7wGMfRhEA=;
  b=eQ4DEL/5EzN9L6ljQNB94WogcAlphucrxg1eZD/NLzSDJeiO13SFlqHE
   wZ20bUQsRG/eFrKO7eY+bVZxUiIFBatTdLDrxxEHDmmAqOvgSMbImCLBD
   qE1kgnlxJa6QE0/5OIzWjTpSszullwQJSqr+VqpJUUFeHJUOsml7NRQcD
   4y319O8PjFh1sxWOmE1QFXLtGlJRY2YzOxjD0fsjlGnWvo56kDbtSqE+I
   YAEVmH0hNxukcWndXVl0P5wVlC5kC9p/lMVXuOwXCC/hD0Zf51q+N2HHs
   Z1F40wiNNpm+O6MpjpkPe9dvfcoKb5F/rXjpcmhHiRGAupZvpLDYYwAbl
   w==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="215220643"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 17:12:37 +0800
IronPort-SDR: NJaX2lirXM4Wyp4t9gz3IsehTpRWrC3gWvYwrZ13p0zZDnj8A4jcMvqCpqik+hFFfT/foZD0Ib
 ki2Jvit6J/aPe4WrQtY9wH6lUSj7uBJCkY5EZh2z/GCsJXuObySDJaaGGsOlQtsNuqfuT0o7tx
 sbMbyo29dEAnAotLuzFhNx5I2GbNHQp5u+wMHnGAI/h/Z1by6XJA+jr3nqBJpL+N0KKFgN3rq7
 rfloT+9YVrgk56HflI/pMrB5jefbyOQxFR7WaW8YSVZ+dyCQoJLWwz3desISAcKO4GTDByL4Rt
 oXXj4IhM5keilmpuaDi5YYsb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 01:26:16 -0700
IronPort-SDR: UHGwrOxHE8ezTHFdrNU/fx3DgRMN4eCcMWzZfrDIa9mPyCJKFtLw7jna40BVWwSZTZA5zh3qWT
 O7CkOiIi5axhoXqb3BwSo3Cpi3UrWZKvM7be3WrJ1KryI3ERb92NQhow8MY0tyeS6qfHBCwHD/
 cUCeQGAIdSmdo9W0JsFYgNzjXHeso2NWokiWb/FQRQIMcojv+6WJZdwk9Ta6infbowbzIEf9q3
 ou0m2XmvJP0iNkT7BuTgXdnYiQhpX+SbITIT4IXQP5+LW39UGh5F7fKUqrS62ivbvcQcjnU7J7
 5Oo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 02:12:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Myg1c5dSjz1RwqL
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 02:12:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666861956; x=1669453957; bh=p69ZHFimCng0hygK4jmMHnBOIswAceaVFC7
        wGMfRhEA=; b=uSQBZkAU+uBfS58SXa2iPOnzyiHY4WHDy5JtdoKuBdsq+UWgBZq
        QLnxbxriY5ZeerLrBb1TqkrkXphjtxgEAd5pSkTpwMZ0PMi1m0xpROSyROJ6MQwO
        elxljxZQsjQbVD8xYK+ICtFVr+wSOggAuQfv9IWeRAS67+bN1PoLYoyWss1M3962
        +s9s5rbBs5VY04GfrKoU4mJ8ghsKr5Gb/mV6xr5gZXXDYo1LHgoS4otrvi7Lj7Jf
        c+jB5wGI4Klfb/hd8FB7BZJtqDaCedwxkw/XZ9K2xKcmZmyuscs+Wx4f4wG+5XzF
        rctlr+rR49GPvJu1N+Ym6uPedZXis2RZ7Tw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a9fVq6Wv4TDE for <linux-ide@vger.kernel.org>;
        Thu, 27 Oct 2022 02:12:36 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Myg1b4Dbsz1RvLy;
        Thu, 27 Oct 2022 02:12:35 -0700 (PDT)
Message-ID: <a607f0b5-1bf8-e90d-b83e-4c5035697b2c@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 18:12:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 4/6] ata: libata: Fix FUA handling in ata_build_rw_tf()
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
 <20221027075026.240017-5-damien.lemoal@opensource.wdc.com>
 <Y1o/dtp+kOB4Qpeu@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y1o/dtp+kOB4Qpeu@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/27/22 17:21, Niklas Cassel wrote:
> On Thu, Oct 27, 2022 at 04:50:24PM +0900, Damien Le Moal wrote:
>> If a user issues a write command with the FUA bit set for a device with
>> NCQ support disabled (that is, the device queue depth was set to 1), the
>> LBA 48 command WRITE DMA FUA EXT must be used. However,
>> ata_build_rw_tf() ignores this and first test if LBA 28 can be used.
>> That is, for small FUA writes at low LBAs, ata_rwcmd_protocol() will
>> cause the write to fail.
>>
>> Fix this by preventing the use of LBA 28 for any FUA write request.
>> While at it, also early test if the request is a FUA read and fail these
>> requests for the NCQ-disabled case instead of relying on
>> ata_rwcmd_protocol() returning an error.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/ata/libata-core.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 81b20ffb1554..fea06f41f371 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -725,9 +725,21 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 block, u32 n_block,
>>  		    class == IOPRIO_CLASS_RT)
>>  			tf->hob_nsect |= ATA_PRIO_HIGH << ATA_SHIFT_PRIO;
>>  	} else if (dev->flags & ATA_DFLAG_LBA) {
>> +		bool lba28_ok;
>> +
>> +		if (tf->flags & ATA_TFLAG_FUA) {
>> +			/* FUA reads are not defined */
>> +			if (!(tf->flags & ATA_TFLAG_WRITE))
>> +				return -EINVAL;
> 
> Hello Damien,
> 
> I'm a bit confused.
> Didn't you write in the other thread that you wanted to force the use of
> NCQ commands, for a drive that supports NCQ, regardless of queue depth?
> Did you change your mind?

Yes. Because the user can always manually set the QD to 1, which turns
off NCQ. I do not want to change that since there may be users out there
relying on this (e.g. with a udev rule) to work around drives with buggy
NCQ support.

> Because as far as I understand, the code after this patch, for a drive
> that has NCQ support, with QD set to > 1, will accept and send down a
> read command with the FUA bit set to the drive.

Yes.

> But the same drive, with QD set to 1, will reject a read command with
> the FUA bit set and propagate that error back to user-space.

Correct. But given that we had fua disabled by default since forever,
the non-ncq read FUA part of the story keeps *not* working, as it did
before. Given that there are no in-kernel FUA read issuer that I can
find, I do not think we are breaking anything, nor are we breaking any
userspace (since that was not working before).

> 
> 
> Kind regards,
> Niklas
> 
>> +			/* We need LBA48 / WRITE DMA FUA EXT for FUA writes */
>> +			lba28_ok = false;
>> +		} else {
>> +			lba28_ok = lba_28_ok(block, n_block);
>> +		}
>> +
>>  		tf->flags |= ATA_TFLAG_LBA;
>>  
>> -		if (lba_28_ok(block, n_block)) {
>> +		if (lba28_ok) {
>>  			/* use LBA28 */
>>  			tf->device |= (block >> 24) & 0xf;
>>  		} else if (lba_48_ok(block, n_block)) {
>> @@ -742,9 +754,10 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 block, u32 n_block,
>>  			tf->hob_lbah = (block >> 40) & 0xff;
>>  			tf->hob_lbam = (block >> 32) & 0xff;
>>  			tf->hob_lbal = (block >> 24) & 0xff;
>> -		} else
>> +		} else {
>>  			/* request too large even for LBA48 */
>>  			return -ERANGE;
>> +		}
>>  
>>  		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
>>  			return -EINVAL;
>> -- 
>> 2.37.3

-- 
Damien Le Moal
Western Digital Research

