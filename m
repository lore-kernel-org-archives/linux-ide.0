Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D62AD11
	for <linux-ide@vger.kernel.org>; Sat,  2 Aug 2025 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754105587; cv=none; b=NliEPKuA+I8tUBkyFJuG+Bxu0MpZwZsBrUATQ01DKJzTOS+t6hTbuefge2TL/K3msGPKLKo2VOwOPBMlfij0ENJeDmuTllnHejwDEGn/seWvJxhxLJqHYToZ7tJENh3IP6KyBr+mtkBK+wNRgkxX0skQKpRMpCnXzCjwuvPjjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754105587; c=relaxed/simple;
	bh=sN1p5gmZ1McvuAD2ghsoQRWwHwfr+ApjP/CXNUfukrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxxbkoj/cRdP7CihbNb5Yq+TV9XpvYSY4uK9vYw8lbckHgLHDeuEzh/yUCOI8IfIxbdbzNKN7HsLwOJ6deRc4AvDrFg75Lsoictk9DNUwBchSQ7D9npxSUb0jtKNWlGsrphSb9DC2j8C7fuEipEUEzED6jMEQ0BvJmmcjCh2FiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvnhTQBw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvnhTQBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C89EC4CEEF;
	Sat,  2 Aug 2025 03:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754105587;
	bh=sN1p5gmZ1McvuAD2ghsoQRWwHwfr+ApjP/CXNUfukrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QvnhTQBwicnhHGieFhPkA0A5Z5zrXyAYDuFTHtbnza0MqsV/eP4UGyoZKtzcZp35x
	 Xr3TmYXphaocKTKSTOIpv/OSxZdFKPgQ26jpNRkecNBn9fz7dHsn7KHln0pFXVOeQj
	 yl531sf3x12vWzIG3Rws6Q1SwwoBVzFznS+1G1Iev7s0IFeu7nAgVfQMsWbvV60Lm4
	 nE+2zMOTinNdBFhNdDnT6bSzJ0+Bfsd5tEtzFdQ0amqI3ucBgAyN7Y9j2hpOS5MbiG
	 X1kolGhN8lYCMkejKe6AVp/bEstG1FsSgQDiEjWUD8UXXGXwuN3gFvjzkGDVOBgV/I
	 MeIZdfhvNuonQ==
Message-ID: <822c1251-d3fe-4dfe-ba26-63128d9ea3f1@kernel.org>
Date: Sat, 2 Aug 2025 12:33:05 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-scsi: Return aborted command when missing
 sense and result TF
To: Igor Pylypiv <ipylypiv@google.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Lorenz Brun <lorenz@brun.one>,
 Brandon Schwartz <Brandon.Schwartz@wdc.com>
References: <20250730002441.332816-1-dlemoal@kernel.org>
 <20250730002441.332816-3-dlemoal@kernel.org> <aI0jVxj7GoHMkncK@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aI0jVxj7GoHMkncK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/25 05:28, Igor Pylypiv wrote:
> On Wed, Jul 30, 2025 at 09:24:41AM +0900, Damien Le Moal wrote:
>> ata_gen_ata_sense() is always called for a failed qc missing sense data
>> so that a sense key, code and code qualifier can be generated using
>> ata_to_sense_error() from the qc status and error fields of its result
>> task file. However, if the qc does not have its result task file filled,
>> ata_gen_ata_sense() returns early without setting a sense key.
>>
>> Improve this by defaulting to returning ABORTED COMMAND without any
>> additional sense code, since we do not know the reason for the failure.
>> The same fix is also applied in ata_gen_passthru_sense() with the
>> additional check that the qc failed (qc->err_mask is set).
>>
>> Fixes: 816be86c7993 ("ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/ata/libata-scsi.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 9b16c0f553e0..57f674f51b0c 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -938,6 +938,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>>  	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
>>  		ata_dev_dbg(dev,
>>  			    "missing result TF: can't generate ATA PT sense data\n");
>> +		if (qc->err_mask)
>> +			ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
>>  		return;
>>  	}
>>  
>> @@ -992,8 +994,8 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>>  
>>  	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
>>  		ata_dev_dbg(dev,
>> -			    "missing result TF: can't generate sense data\n");
>> -		return;
>> +			    "Missing result TF: reporting aborted command\n");
>> +		goto aborted;
>>  	}
>>  
>>  	/* Use ata_to_sense_error() to map status register bits
>> @@ -1004,13 +1006,15 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> 
> There is a redundant check in ata_gen_ata_sense(). qc->err_mask (is_error) is
> already checked in ata_scsi_qc_complete() before it calls ata_gen_ata_sense().
>  
> 	if (qc->err_mask ||
> 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> 
> The function will be much cleaner once we remove this check. 

Yep, we can remove the err_mask check.


-- 
Damien Le Moal
Western Digital Research
