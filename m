Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150FB2AD11
	for <linux-ide@vger.kernel.org>; Sat,  2 Aug 2025 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754105495; cv=none; b=IctUlwV+U5DsKM8TaKqC0Q3F0cz08St0L7tvLGP73DltN++UHH2SLlZ/N7MF8wFBwCD4Fc2d2pIi5jGVa/nY5CgMiPnM8knaIT+HNGCfOrDflmhLIdx/mLPG9kCpglLl4mdDf7WwD+ADS0NdGXbseCPmry4kvAsJZSjwGbXoP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754105495; c=relaxed/simple;
	bh=skX1xoA8772WuFaA/at3RxTzuHsjmbxfNO5kPekfEkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bX/L9Q4Mj7aDAwrLsytwkLz9Zy36+xgQsdB4N1xNCWUrXObC7I3fTkhTAWpP9ObHAQXCXeBuGubvxpIbs0eHqsX1sh2672dLE2hdE7zzA8Cx1cmUEvPqP2nY/PPKp33To6e46uyHOmN1xpMTCN1xumbwgiFGr9FSoJV/3QJm/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db4zDrCv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db4zDrCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13B9C4CEEF;
	Sat,  2 Aug 2025 03:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754105493;
	bh=skX1xoA8772WuFaA/at3RxTzuHsjmbxfNO5kPekfEkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=db4zDrCvFxibQvPLkIjtJcNuhfqROGIS0tuifgPVdWSK7XoHFhy3VV2bp0Y9a8Zp+
	 f5QUhbIgLNwSFW/fQPT9hNHIiBrhcaPjWVipVJyUMn41X5d246zkzIiUOVrol+8nDT
	 21W1AGO4jHdYdosldI/cD+hkRSkXtIGlpa6fb7J4DrA+szc8ifEudqy5lcx3Z7vHfz
	 SRcfOjJEyoA/GCpxdgb4Slnf+qkQIyodcrVxKo8z2camqmhvwrmfv/Aojwg74Ftezk
	 tkjHLrU4kIAJeCyAzbr5osUStVRdTNNXyQFt8aoJ5RlRZq+LeNoT9KHm8tkNlWajb+
	 Dx0YKYubM8oDA==
Message-ID: <c375b4b4-5762-42d6-aae5-be1f64e7c720@kernel.org>
Date: Sat, 2 Aug 2025 12:31:31 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-scsi: Fix ata_to_sense_error() status
 handling
To: Igor Pylypiv <ipylypiv@google.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Lorenz Brun <lorenz@brun.one>,
 Brandon Schwartz <Brandon.Schwartz@wdc.com>
References: <20250730002441.332816-1-dlemoal@kernel.org>
 <20250730002441.332816-2-dlemoal@kernel.org> <aI0d06Z1crjpA2-X@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aI0d06Z1crjpA2-X@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/2/25 05:04, Igor Pylypiv wrote:
> On Wed, Jul 30, 2025 at 09:24:40AM +0900, Damien Le Moal wrote:
>> Commit 8ae720449fca ("libata: whitespace fixes in ata_to_sense_error()")
>> inadvertantly added the entry 0x40 (ATA_DRDY) to the stat_table array in
>> the function ata_to_sense_error(). This entry ties a failed qc which has
>> a status filed equal to ATA_DRDY to the sense key ILLEGAL REQUEST with
>> the additional sense code UNALIGNED WRITE COMMAND. This entry will be
>> used to generate a failed qc sense key and sense code when the qc is
>> missing sense data and there is no match for the qc error field in the
>> sense_table array of ata_to_sense_error().
>>
>> As a result, for a failed qc for which we failed to get sense data (e.g.
>> read log 10h failed if qc is an NCQ command, or REQUEST SENSE EXT
>> command failed for the non-ncq case, the user very often end up seeing
>> the completely misleading "unaligned write command" error, even if qc
>> was not a write command. E.g.:
>>
>> sd 0:0:0:0: [sda] tag#12 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> sd 0:0:0:0: [sda] tag#12 Sense Key : Illegal Request [current]
>> sd 0:0:0:0: [sda] tag#12 Add. Sense: Unaligned write command
>> sd 0:0:0:0: [sda] tag#12 CDB: Read(10) 28 00 00 00 10 00 00 00 08 00
>> I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>>
>> Fix this by removing the ATA_DRDY entry from the stat_table array so
>> that we default to always returning ABORTED COMMAND without any
>> additional sense code, since we do not know any better. The entry 0x08
>> (ATA_DRQ) is also removed since signaling ABORTED COMMAND with a parity
>> error is also misleading (as a parity error would likely be signaled
>> through a bus error). So for this case, also default to returning
>> ABORTED COMMAND without any additional sense code. With this, the
>> previous example error case becomes:
>>
>> sd 0:0:0:0: [sda] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> sd 0:0:0:0: [sda] tag#17 Sense Key : Aborted Command [current]
>> sd 0:0:0:0: [sda] tag#17 Add. Sense: No additional sense information
>> sd 0:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 00 00 10 00 00 00 08 00
>> I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>>
>> Together with these fixes, refactor stat_table to make it more readable
>> by putting the entries comments in front of the entries and using the
>> defined status bits macros instead of hardcoded values.
>>
>> Reported-by: Lorenz Brun <lorenz@brun.one>
>> Reported-by: Brandon Schwartz <Brandon.Schwartz@wdc.com>
>> Fixes: 8ae720449fca ("libata: whitespace fixes in ata_to_sense_error()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/ata/libata-scsi.c | 20 ++++++++------------
>>  1 file changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 27b15176db56..9b16c0f553e0 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -859,18 +859,14 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
>>  		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
>>  	};
>>  	static const unsigned char stat_table[][4] = {
>> -		/* Must be first because BUSY means no other bits valid */
>> -		{0x80,		ABORTED_COMMAND, 0x47, 0x00},
>> -		// Busy, fake parity for now
>> -		{0x40,		ILLEGAL_REQUEST, 0x21, 0x04},
>> -		// Device ready, unaligned write command
>> -		{0x20,		HARDWARE_ERROR,  0x44, 0x00},
>> -		// Device fault, internal target failure
>> -		{0x08,		ABORTED_COMMAND, 0x47, 0x00},
>> -		// Timed out in xfer, fake parity for now
>> -		{0x04,		RECOVERED_ERROR, 0x11, 0x00},
>> -		// Recovered ECC error	  Medium error, recovered
>> -		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
>> +		/* Busy: must be first because BUSY means no other bits valid */
>> +		{ ATA_BUSY,	ABORTED_COMMAND, 0x00, 0x00 },
> 
> Hi Damien,
> 
> ata_to_sense_error() already has a check for ATA_BUSY. Perhaps we could add
> a goto statement and fill ABORTED_COMMAND without looking up the same data in
> the stat_table?

Yes, we could do that. I minimized the changes here since this is a bug fix.

>> +		/* Device fault: INTERNAL TARGET FAILURE */
>> +		{ ATA_DF,	HARDWARE_ERROR,  0x44, 0x00 },
>> +		/* Corrected data error */
>> +		{ ATA_CORR,	RECOVERED_ERROR, 0x00, 0x00 },
> 
> I'm trying to understand what this "Corrected data error" is. ACS-6 does not
> seem to have any references to such corrected errors. BIT(2) of STATUS field
> is defined as "N/A or ALIGNMENT ERROR bit – See 6.2.2". Does it make sense
> to translate this bit to "unaligned write command" instead?

This is an odd one. Indeed, ACS defines it as N/A or alignment error, but up to
SAT-3, its translation to sense data says "This condition is not considered an
error". The libata-scsi code has this defined as a recovered error since
forever, so I did not change it. SAT4 onward do not even define a translation
for this at all.

For modern drives, this is all almost completely irrelevant anyway as we get
sense data, unless there is a big issue with the drive preventing that, which is
the case this patch is for so that we do not get the non-sensical "unaligned error".

If you have a look at SAT specifications, you'll see that most of the error bits
translation in this function are "completely made up", or rather, as the SAT
specs allows, based on the 3ware driver translation (as noted in the comment for
the error table).

I do not want to hit regressions with excessive cleaning of this code, so I just
let it be.

-- 
Damien Le Moal
Western Digital Research
