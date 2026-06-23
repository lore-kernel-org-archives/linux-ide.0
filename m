Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE714E2F2;
	Tue, 23 Jun 2026 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177037; cv=none; b=kbepVDAap/3jCkfNKH9sQbmaw18MBkb/sSjnsjB8Ug1/xi6xUD3QX9/OUZIBb80HHKNh5tpbuDUdu4gyyufuMhoZAOvMKKwhQKPyPKwFM0a6lvwx6tf9ysy/24SZduIIsnDsV3BR/D+tDP1hIAAYnlNYqszrkfLWPvBtZPuTdsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177037; c=relaxed/simple;
	bh=YeD8TVeBUzibAc1ULcZxf6DgZ5UmJ5UgLyUhW4Aqj2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uE7r0xMjtys+djq/92DWRdG3gxsRNsEByNzez9eU2OrXNYACjCQ6q49Dt4WIA6lBJripVwpxlRusIw8RqroTmQrkL98285EKxHh/9NxxhZZKPR8pZT40GVDs5WehLuYpca9iWsoXf8/rtzCU/hT6xjL3KHqmcXXz6X9Zw1Y88H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojg5bbUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojg5bbUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CE91F000E9;
	Tue, 23 Jun 2026 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782177036;
	bh=NgAcPfYL9CiB/gWlE31PjH5ICXP6C5g6WScpx9SA9cE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ojg5bbUzTTeIvP8RLxAhFedvfcXpOuj31uovfMqHo405CHJdj7zggpkTg3LG+/elR
	 fyP4xv9dbJT1NPSL2UmvFhHBk557+IEZbxgPMW5u3q0hPSTzdRnnTHvARYL1sGpxAC
	 +fj1/CK4LvTcFko9zCbG9hM4VzmNXFUlY7h1GElDt1vV0jHxNtfJdKl9b1MM+y1KLt
	 JqJfDT/DJ0y2fccmJvkWlwl+haeFd/ND7gWGJllicgPLrgv2hBj8MPeyxP/qBS7zXp
	 5HYmfOmhekIVtuQMhaAdsWVQmeyJYHFp4ENQuM9l5KHpFYLoervR9cKukhg6uz5v40
	 Pjfsj5AAPFLCw==
Message-ID: <cf9f4000-8813-4834-8404-e7070207aaaf@kernel.org>
Date: Tue, 23 Jun 2026 10:10:34 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-core: Reject an invalid concurrent
 positioning ranges count
To: sashiko-reviews@lists.linux.dev,
 Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org
References: <20260622-b4-disp-5734c6f2-v2-1-53083c2df3c6@proton.me>
 <20260622184657.27C851F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260622184657.27C851F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 03:46, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch strictly rejects the entire Concurrent Positioning Ranges (CPR) log if the range count exceeds 62 or the returned log size, permanently disabling the feature for otherwise compliant devices.
> --
> 
> commit fb7353b474c07b1173b746d017d47feac25f57b1
> Author: Bryam Vargas <hexlabsecurity@proton.me>
> 
> ata: libata-core: Reject an invalid concurrent positioning ranges count
> 
> This commit adds bounds checking for the concurrent positioning ranges (CPR)
> log count. It rejects the log if the count exceeds 62 (the maximum capacity
> of the VPD B9h buffer) or if the count exceeds the returned log size.
> 
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 3d0027ec33c2a..017a16be158b6 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -2832,6 +2832,18 @@ static void ata_dev_config_cpr(struct ata_device *dev)
>>  	if (!nr_cpr)
>>  		goto out;
>>  
>> +	/*
>> +	 * The count is reported independently of the log size and is also
>> +	 * emitted into the fixed 2048-byte VPD B9h buffer, which holds at most
>> +	 * (2048 - 64) / 32 = 62 descriptors. Reject a count that exceeds that
>> +	 * or does not fit the log the device returned.
>> +	 */
>> +	if (nr_cpr > 62 || buf_len < 64 + (size_t)nr_cpr * 32) {
>> +		ata_dev_warn(dev,
>> +			     "Invalid number of concurrent positioning ranges\n");
>> +		goto out;
>> +	}
> 
> [Severity: Medium]
> Does this code completely disable the CPR feature for spec-compliant devices
> that report more than 62 ranges?
> 
> The ATA specification allows up to 255 concurrent positioning ranges, and the
> 62-descriptor limit seems to be an internal Linux SCSI translation limit based
> on the fixed 2048-byte ata_scsi_rbuf size. By jumping to out, we discard the
> log entirely rather than capping it to fit internal limits.

Bryan, I think we can ignore this since again, more than a few CPRs is simply
not realistic in practice. But update the code comment to mention that the specs
allow up to 255 CPRs but that we limit this to what fits in the RBUF for
emitting the VPD page. And maybe we should have:

/*
 * Maximum number of concurrent positioning ranges supported. The ACS
 * specifications allow up to 255, but we limit this to what fits in the
 * internal rbuf buffer used to emit VPD page B9h.
 */
#define ATA_DEV_MAX_CPR		min(255, ((ATA_SCSI_RBUF_SIZE - 64) / 32))

> 
> Also, the commit message states "Capping the stored count keeps the emitter in
> bounds", but the code appears to reject the log outright instead of capping
> the count. Could we instead dynamically cap nr_cpr to 62 here, so that devices
> with more ranges still get partial functionality rather than having the feature
> disabled entirely?

Yes, we do not cap but reject. Let's update the comment.

> 
>> +
>>  	cpr_log = kzalloc_flex(*cpr_log, cpr, nr_cpr);
>>  	if (!cpr_log)
>>  		goto out;
> 


-- 
Damien Le Moal
Western Digital Research
