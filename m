Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56089263892
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352332; cv=none; b=fXXt7EHRyTTx4xdm8kvzOuCcj1PweuGnk0vT03Jj9Hqee6A5+YQUPTVR4XkXIaVor4dTEDfuj3rFKw1ZHuhMDzVxeaDOlLdHqm6kYbLvCLR/cqc9nOcx9Xcqzl7FH245mCbNplIuRL5FyaDu+WR5qm7n1jK2Wr0Tkvt3z8n1gfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352332; c=relaxed/simple;
	bh=AciSFVf5D+WJVJtppf+CFNp/g62gPy2tZMvl/m9mecg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SUSLizrC7HkOfgQ9GwCO5xK3sPuHbMA/m9X7vJCntc+5Xlmn5UVocjt0aCWYxKE+7KHMBa2zIPF6Rt/Yx4tBldzFZlAywnLaIMRKLER2yuf1FSR8ac5TmD3zPMA3i6FNSEKw0GtYk6wHgkFthhW0wEQgXTEXgrYe9vEsOGSFozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1Oxhmi+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1Oxhmi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D367FC116C6;
	Tue,  1 Jul 2025 06:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751352331;
	bh=AciSFVf5D+WJVJtppf+CFNp/g62gPy2tZMvl/m9mecg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=A1Oxhmi+qEwy24Pv/CnfuoojmWNYtSVkqWR4lCB7OEflIZEazpf5ztfzJWN/L4Doq
	 Vu8GfFLCuORFlK4rLqlsCFdZQRezkfo9PjeYqZo/ZcVtYwrmVjdZ7hLZB3V4LxLGMq
	 aYR5n6UIKuVUBkRhtoG1pqhL/yduE5Ty7BanSNEUc8P45UO6pHiYIfK5fMe2LUM480
	 wT6IkhpAVs30qPAUaXzcImUSE5mmafA/ttgIvpUNFQFXNuBrGxOH9jzMgnZcxzMt86
	 b6gXRi1Qbq7RJmobG43Qt5Nr5O68y16lAoL+3vxY4uO3t+cH6W1z78iEvj/w+HB3AQ
	 yozjnPNL9lLZw==
Message-ID: <275a49c5-b725-4f32-9191-d6468c14ddcc@kernel.org>
Date: Tue, 1 Jul 2025 15:43:20 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] ata: libata-core: Move device LPM quirk settings to
 ata_dev_config_lpm()
To: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-3-dlemoal@kernel.org>
 <aa7c533b-38fc-44d0-981b-cd499cc20ac6@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aa7c533b-38fc-44d0-981b-cd499cc20ac6@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 3:13 PM, Hannes Reinecke wrote:
> On 6/30/25 08:26, Damien Le Moal wrote:
>> Move the various cases of setting the ATA_QUIRK_NOLPM quirk flag for a
>> device in ata_dev_configure() to the function ata_dev_config_lpm().
>> This allows having all LPM related settings in one place to facilitate
>> maintenance.
>>
>> No functional changes.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   drivers/ata/libata-core.c | 43 +++++++++++++++++++++++----------------
>>   1 file changed, 26 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 0d85474f6640..fdce96fd3ffa 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -2798,6 +2798,32 @@ static void ata_dev_config_lpm(struct ata_device *dev)
>>       struct ata_port *ap = dev->link->ap;
>>       unsigned int err_mask;
>>   +    if (ap->flags & ATA_FLAG_NO_LPM) {
>> +        /*
>> +         * When the port does not support LPM, we cannot support it on
>> +         * the device either.
>> +         */
>> +        dev->quirks |= ATA_QUIRK_NOLPM;
>> +    } else {
>> +        /*
>> +         * Some WD SATA-1 drives have issues with LPM, turn on NOLPM for
>> +         * them.
>> +         */
>> +        if ((dev->quirks & ATA_QUIRK_WD_BROKEN_LPM) &&
>> +            (dev->id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
>> +            dev->quirks |= ATA_QUIRK_NOLPM;
>> +
>> +        /* ATI specific quirk */
>> +        if ((dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI) &&
>> +            ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
>> +            dev->quirks |= ATA_QUIRK_NOLPM;
>> +    }
>> +
>> +    if (dev->quirks & ATA_QUIRK_NOLPM) {
>> +        ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
>> +        ap->target_lpm_policy = ATA_LPM_MAX_POWER;
>> +    }
>> +
>>       /*
>>        * If the device port does not support Device Initiated Power Management
>>        * (DIPM), and the device supports this feature, disable it.
>> @@ -2881,23 +2907,6 @@ int ata_dev_configure(struct ata_device *dev)
>>       if (rc)
>>           return rc;
>>   -    /* some WD SATA-1 drives have issues with LPM, turn on NOLPM for them */
>> -    if ((dev->quirks & ATA_QUIRK_WD_BROKEN_LPM) &&
>> -        (id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
>> -        dev->quirks |= ATA_QUIRK_NOLPM;
>> -
>> -    if (dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI &&
>> -        ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
>> -        dev->quirks |= ATA_QUIRK_NOLPM;
>> -
>> -    if (ap->flags & ATA_FLAG_NO_LPM)
>> -        dev->quirks |= ATA_QUIRK_NOLPM;
>> -
>> -    if (dev->quirks & ATA_QUIRK_NOLPM) {
>> -        ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
>> -        dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
>> -    }
>> -
>>       /* let ACPI work its magic */
>>       rc = ata_acpi_on_devcfg(dev);
>>       if (rc)
> 
> And this now is only dealing with modifying LPM setting, independent on
> any DIPM setting. Why not make two functions (one for DIPM and one for
> LPM) so make matters less confusing?

"less confusing" with all LPM things is I think not possible :)

The idea is to keep things together as much as possible to facilitate
tweaking/maintenance. There is more like this coming to get port capabilities
out of ahci.c and into generic libata so that platform AHCI and libsas adapters
can be supported too. Right now, it is pretty much LPM == AHCI...

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
