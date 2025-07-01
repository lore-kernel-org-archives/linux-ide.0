Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE825A655
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352626; cv=none; b=Lc5WdvFFsKv7c8k1MXCbvKnH9PeP3A/L15jBWQ4pVXHja/bpWkdld3CemgRCtt80YJk3tYCo6cAcyuE5Y+06Rc5E0nvgDLB+6Y5+8W5A546rBpyxbQNzoHcapLl/sQFZfdf5VfwSC3V3wa9b9yJZyt/DjMLdj5i105kEBZg0APs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352626; c=relaxed/simple;
	bh=sbISb21PqVeIzBSirQEYufITsqhkk8RXrhaobXOQWuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EFgMHUIFt+vl1YlLzPLxxxJR8v4s152Wpx48hTrvAoNKzoB5Sahin28q1JMigVyLsESKaJEuFZSfXVhxBBkmNDkacZ52qDQOyFq9LjqWqrLK42TTR7tjg5yaxXHluJUIMkuO/i/Uv1eL0epsXYHC6WxmB/z9Ka7SamKOrSUqkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXPytNiP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXPytNiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF35C4CEEF;
	Tue,  1 Jul 2025 06:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751352625;
	bh=sbISb21PqVeIzBSirQEYufITsqhkk8RXrhaobXOQWuE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=GXPytNiPc9vXmDuXAiwXOJEvsGzBy6dFqv6WAQU2T5n0zJrpednOp2GGBqS0Ixn2H
	 cROlUNlLOHI2HO/XACm08KW6c2rqrLlJvjeowIjHVZRyzSTG2gnpFSfZY5bwUNKp81
	 Mfe5+q37Vbp/WzTzPvGDZ/1wyBX9vVnGwHAYDWKcpJgq2269jiZ6QoCZm9pPlozeUN
	 Kv2GTecRPTkCjiXA7XkyXygCcaeRURWUNHePYQsc50YXEbBOjbNkcuhc8PK1eSyVf1
	 sewfowXDH94wj7zXDW6PSYHTgjv/s1ohOYBYM+ac413zexORu2X2BsXim35a8KYOph
	 WcStQRLxni6Iw==
Message-ID: <097726fe-638a-4336-8427-3eb3055de5b7@kernel.org>
Date: Tue, 1 Jul 2025 15:48:15 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] ata: libata-eh: Avoid unnecessary resets when
 revalidating devices
To: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-5-dlemoal@kernel.org>
 <60dd0013-20a3-4b10-a60b-0e567526e0f9@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <60dd0013-20a3-4b10-a60b-0e567526e0f9@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 3:23 PM, Hannes Reinecke wrote:
> On 6/30/25 08:26, Damien Le Moal wrote:
>> In ata_eh_revalidate_and_attach(), a link LPM policy is always
>> set to ATA_LPM_MAX_POWER before calling ata_dev_revalidate() to ensure
>> that the call to ata_phys_link_offline() does not return true, thus
>> causing an unnecessary device reset. This change was introduced
>> with commit 71d7b6e51ad3 ("ata: libata-eh: avoid needless hard reset
>> when revalidating link").
>>
>> However, setting the link LPM policy to ATA_LPM_MAX_POWER may be
>> visible only after some time, depending on the power state the link was
>> in. E.g. transitioning out of the Partial state should take no longer
>> than a few microseconds, but transitioning out of the Slumber or
>> DevSleep state may take several milliseconds. So despite the changes
>> introduced with commit 71d7b6e51ad3 ("ata: libata-eh: avoid needless
>> hard reset when revalidating link"), we can still endup with
>> ata_phys_link_offline() seeing a link SCR_STATUS register signaling that
>> the device is present (DET is equal to 1h) but that the link PHY is
>> still in a low power mode (e.g. IPM is 2h, signaling "Interface in
>> Partial power management state"). In such cases, ata_phys_link_offline()
>> returns true, causing an EIO return for ata_eh_revalidate_and_attach()
>> and a device reset.
>>
>> Avoid such unnecessary device resets by introducing a relaxed version
>> of the link offline test implemented by ata_phys_link_offline() with
>> the new helper function ata_eh_link_established(). This functions
>> returns true if for the link SCR_STATUS register we see that:
>>   - A device is still present, that is, the DET field is 1h (Device
>>     presence detected but Phy communication not established) or 3h
>>     (Device presence detected and Phy communication established).
>>   - Communication is established, that is, the IPM field is not 0h,
>>     indicating that the PHY is online or in a low power state.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   drivers/ata/libata-eh.c | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index f98d5123e1e4..7f5d13f9ca73 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -2071,6 +2071,33 @@ static void ata_eh_get_success_sense(struct ata_link
>> *link)
>>       ata_eh_done(link, dev, ATA_EH_GET_SUCCESS_SENSE);
>>   }
>>   +/*
>> + * Check if a link is established. This is a relaxed version of
>> + * ata_phys_link_online() which accounts for the fact that this is potentially
>> + * called after changing the link power management policy, which may not be
>> + * reflected immediately in the SSTAUS register (e.g., we may still be seeing
>> + * the PHY in partial, slumber or devsleep Partial power management state.
>> + * So check that:
>> + * - A device is still present, that is, DET is 1h (Device presence detected
>> + *   but Phy communication not established) or 3h (Device presence detected and
>> + *   Phy communication established)
>> + * - Communication is established, that is, IPM is not 0h, indicating that PHY
>> + *   is online or in a low power state.
>> + */
>> +static bool ata_eh_link_established(struct ata_link *link)
>> +{
>> +    u32 sstatus;
>> +    u8 det, ipm;
>> +
>> +    if (sata_scr_read(link, SCR_STATUS, &sstatus))
>> +        return false;
>> +
>> +    det = sstatus & 0x0f;
>> +    ipm = (sstatus >> 8) & 0x0f;
>> +
>> +    return (det & 0x01) && ipm;
>> +}
>> +
>>   /**
>>    *    ata_eh_link_set_lpm - configure SATA interface power management
>>    *    @link: link to configure
>> @@ -3275,7 +3302,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link
>> *link,
>>                       goto err;
>>               }
>>   -            if (ata_phys_link_offline(ata_dev_phys_link(dev))) {
>> +            if (!ata_eh_link_established(ata_dev_phys_link(dev))) {
>>                   rc = -EIO;
>>                   goto err;
>>               }
> 
> Makes me wonder: if the phy is taking some time, don't we need to wait
> at some point for the transition to complete?

There is a 10ms wait already in sata_link_scr_lpm() but it seems to not always
be enough. The specs say that transitions out of HIPM "shall not take more than
10ms", but hey, we all know how devices always follow the specs, right ? :)

> From a cursory glance we just continue, and (apparently) hope that
> everything will be well eventually.
> Hmm?

It is fine to continue because transitions out of DIPM/HIPM/DevSleep are
automatic if you send a command. So we actually do not need to wait at all and
probably can remove that 10ms sleep in sata_link_scr_lpm(). But I have not for now.


-- 
Damien Le Moal
Western Digital Research
