Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB7370AE2;
	Fri,  3 Jul 2026 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059351; cv=none; b=qMxF07l2zVBpO8C5BCO4On3XtXOQlF+T7wTETDXUQVXmVi6MRvJ/ZaCIGBvADKyaxyykV8+gzZO2+dPjvTUVnlVMQ347YsX0Tvqrk7ebDzc+QhYhl1MNq2DGsOuqJDP2iJzMLNM8zgQDAVD+eEHIiwSK3w1j+N51qu0BLS8T+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059351; c=relaxed/simple;
	bh=TjCHp6F4IyeY4OyauWrhrVLxVHGBiSDZIcoKVGiJEbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XP2v4+6mbWkBJbX2nchRSStjNPl7CH5KJfLN1nJ8Oqld6edZRsA8IwoNgAiUJkqVNIDYJV4EUGzMDh8INsTy7WmzShT2lHcNZIPDSuHhA4hcXWtR4onf75wyltCJSK8pK+/DmDeh/48AE2fIQjNN58MlzvHIjydBm1/Q5UgA13U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF4C/kT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF4C/kT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4CF1F000E9;
	Fri,  3 Jul 2026 06:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783059350;
	bh=F3A0uI4K8b9/FYpxGygmIqL6McpQ6kjySDRiNPjdp6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HF4C/kT69dHsEtqrUVnkeEIjeJKUKYTotlMk+uAFJoqUaYamJdWKIXK3jvkWQ7SvD
	 W51Yo9IZt9iOYAMI0BLbm5xv3K3A99stH9y6Ca3G2Zooa1qNIjhQ4U1MSPawqiMEVv
	 Vb9fzPhCVtg4x8GqBS6JfC+OdPZYzL1LnMdKziozyUxkJiziAasvthNcnmanRfYG5B
	 SA71RVUBR0WI5bG9Iyf1hbYAWlE4D6FRbO96cGuKYxj8nJrt1/PTw5ZL65eJda/HVy
	 q5zjZBeB60U8cYZNO/egBaqdPrjFAiskXWEKdjJ9awp5XS76hSTgn/RvzT/H2DaNqh
	 Zo3vYXwbO9v6A==
Message-ID: <088a4644-0c5a-46b4-9491-61b941c22f41@kernel.org>
Date: Fri, 3 Jul 2026 15:15:48 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] ata: libata: rename ata_dev_is_zac()
To: sashiko-reviews@lists.linux.dev
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260703040532.2152614-1-dlemoal@kernel.org>
 <20260703040532.2152614-2-dlemoal@kernel.org>
 <20260703045945.BA9F11F000E9@smtp.kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260703045945.BA9F11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 13:59, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch introduces an undocumented functional change (implicit bug fix) for Device Managed zoned drives, while the commit message falsely claims the refactor merely replaces identical open-coded tests.
> --
> 
> commit c24879d1eda5cc422a0b0da776fb6aef5fe25e22
> Author: Damien Le Moal <dlemoal@kernel.org>
> 
> ata: libata: rename ata_dev_is_zac()
> 
> The helper function ata_dev_is_zac() checks if a device is a ZAC class
> device (host managed zoned disk) or if it is a host aware zoned disk, that
> is, a regular ATA disk that supports the zoned capabilities. So the name
> of this helper function is confusing as it hints at the first case only.
> 
> Rename this helper function to ata_dev_is_zoned() to avoid confusions and
> better reflect the two cases tested. Use this helper in
> ata_scsiop_inq_std(), ata_scsiop_read_cap() and
> ata_scsi_report_supported_opcodes() instead of having the same tests open
> coded.
> 
> While at it, to stay consistent with this renaming, also rename
> ata_dev_config_zac() to ata_dev_config_zoned().
> 
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index d54ec1631e9a6..a86721b5df7f6 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -2020,7 +2020,7 @@ static unsigned int ata_scsiop_inq_std(struct ata_device *dev,
>>  	if (rbuf[32] == 0 || rbuf[32] == ' ')
>>  		memcpy(&rbuf[32], "n/a ", 4);
>>  
>> -	if (ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC)
>> +	if (ata_dev_is_zoned(dev))
> 
> [Severity: Medium]
> Does this introduce an undocumented functional change for Device Managed
> zoned drives?
> 
> The commit message states this is a replacement of "the same tests open coded",
> but the old condition would evaluate to true for Device Managed drives,
> since ata_id_zoned_cap() returns 0x02 for them.
> 
> The new ata_dev_is_zoned() helper checks ata_id_zoned_cap(dev->id) == 0x01,
> which evaluates to false for Device Managed drives.
> 
> This appears to alter SCSI emulation for these drives, as they will no longer
> report ZBC version compatibility here.
> 
> Could the commit message be updated to mention this functional bug fix?
> 
>>  		memcpy(rbuf + 58, versions_zbc, sizeof(versions_zbc));
>>  	else
>>  		memcpy(rbuf + 58, versions, sizeof(versions));

Correct. But I think that we should never had reported that. In any case, with
host aware also now deprecated, we now definitely do *not* want to report that a
drive managed disk is compatible zbc, as we treat such drives no different than
regular disks.

> 
> [ ... ]
> 
>> @@ -2848,7 +2848,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
>>  	rbuf[10] = sector_size >> (8 * 1);
>>  	rbuf[11] = sector_size;
>>  
>> -	if (ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC)
>> +	if (ata_dev_is_zoned(dev))
>>  		rbuf[12] = (1 << 4); /* RC_BASIS */
> 
> [Severity: Medium]
> Similarly, does this silently fix Device Managed drives incorrectly
> reporting the RC_BASIS bit in READ CAPACITY 16?

The old code was buggy ! we do not want to set rc basis for drive managed devices.

> 
>>  	rbuf[13] = log2_per_phys;
>>  	rbuf[14] = (lowest_aligned >> 8) & 0x3f;
> 
> [ ... ]
> 
>> @@ -3656,8 +3656,7 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
>>  		break;
>>  	case ZBC_IN:
>>  	case ZBC_OUT:
>> -		if (ata_id_zoned_cap(dev->id) ||
>> -		    dev->class == ATA_DEV_ZAC)
>> +		if (ata_dev_is_zoned(dev))
>>  			supported = 3;
> 
> [Severity: Medium]
> Does this also correctly prevent ZBC_IN and ZBC_OUT from being reported as
> supported for Device Managed drives?

Yes it does and that is fine.

-- 
Damien Le Moal
Western Digital Research
