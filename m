Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CBF4689;
	Tue, 18 Jun 2024 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677220; cv=none; b=KngOUXCwKE/wHPzEdBtSQvFHdVAlx3ob7SHYqc/kxY4zhm+kXspZgixoiHeR46PHLvqRAyJ9q+9T4QW8pUDr/vqroj5nAKEjS0U+kZi2D2vvkIk13nhwLEz9fV9hz5VeIo1VEjT6mMn8stDd+rI5s7Jp4kI+V84xiBDP8BoNyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677220; c=relaxed/simple;
	bh=AU8m4BLn7PksqMB0wIhU2UZKqSE8doPVgQ0p/Vh0wwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHhw8vaesE/hoPhLKubwuU9zJltTG08knKwSwqjvmm/F2S2dnsu6fdZkma5VgFzXJq0E4sBhBT80XsS2uwxPVNand6W7ABi6axzmJudtMJl6+GgXT/aYtQsZ7MobQ7tLE76EB+ltdwiXCNcVv6S3sORsFrHHCH8TjHlJ4xRrSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiMK7IcX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiMK7IcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B34C2BD10;
	Tue, 18 Jun 2024 02:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718677220;
	bh=AU8m4BLn7PksqMB0wIhU2UZKqSE8doPVgQ0p/Vh0wwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AiMK7IcXe2a3Q+8e5/HZ+P72yEZjBpSGiIfNAKMRuACWSA9P1vMY+35NETRVC5aL7
	 rcg4T7YLgUpFIeMVsgzxTrbUD7Ul9+DudW1o64PV+BIrpI60Nweuiiy6kEbaXOVMAL
	 d8QG5P8vsxng1VhNnKxhFBCyFTv3PTSHLAqBCioa35uxLumIMeqvENu0YqQvn5dpLi
	 cIAJ2/hQaiQVCOzG8mK/eb9ImJwOP/uCb8E7maVtMYppUx/i0oVNI0BX+B1ybodnq+
	 aL8yAzxlTSthiJBqubsPadWw5YMFz/BZ6kt3LdR/ACkDypcU6hNql4/ORQjhzlI/NZ
	 oyw/wYDiCEvRw==
Message-ID: <46037b02-5dad-4249-a63f-80ac93977aa9@kernel.org>
Date: Tue, 18 Jun 2024 11:20:18 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ata: libata-scsi: Report valid sense data for ATA
 PT if present
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Niklas Cassel <cassel@kernel.org>, Tejun Heo <tj@kernel.org>,
 Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-4-ipylypiv@google.com>
 <dfb741e5-2fe6-4b36-b1ab-55c3c33032d0@kernel.org>
 <ZnDOfqq9Jo-38LBl@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZnDOfqq9Jo-38LBl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 09:02, Igor Pylypiv wrote:
> On Mon, Jun 17, 2024 at 08:25:54AM +0900, Damien Le Moal wrote:
>> On 6/15/24 04:18, Igor Pylypiv wrote:
>>> Do not generate sense data from ATA status/error registers
>>> if valid sense data is already present.
>>
>> This kind of contradicts what you said in patch 2... So I am really confused now.
> 
> Sorry about the confustion. I think the problem is that I was using "sense data"
> to describe two different things:
> #1. SK/ASC/ASCQ
> #2. ATA Status Return sense data descriptor
> 
> Both #1 and #2 need to be populated into sense buffer. The problem with
> the current code is that we can only have either valid #1 or valid #2 but
> not both at the same time.
> 
>> Though this patch actually looks good to me, modulo the comment below.
>> But shouldn't this be squashed with patch 2 ?
> 
> Yes, that's a good point. Let me factor out the sense data descriptor
> population code into a separate function and then squash this patch with
> the patch 2.
> 
>>
>>>
>>> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
>>> ---
>>>  drivers/ata/libata-scsi.c | 17 +++++++++++------
>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index 79e8103ef3a9..4bfe47e7d266 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -858,12 +858,17 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>>>  	unsigned char *desc = sb + 8;
>>>  	u8 sense_key, asc, ascq;
>>>  
>>> -	/*
>>> -	 * Use ata_to_sense_error() to map status register bits
>>> -	 * onto sense key, asc & ascq.
>>> -	 */
>>> -	if (qc->err_mask ||
>>> -	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
>>> +	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
>>> +		/*
>>> +		 * Do not generate sense data from ATA status/error
>>> +		 * registers if valid sense data is already present.
>>> +		 */
>>
>> The empty "if" here is really horrible. Please revert the condition and add it
>> as a "&&" in the below if.
>>
> Adding the condition to the below if will change the code flow and we'll end
> up executing scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D) when
> ATA_QCFLAG_SENSE_VALID is set, which is not what we want.

I did say "reverse the condition" :)
So that if would be done only if ATA_QCFLAG_SENSE_VALID is *not* set.

> 
> I agree about horrible :)
> 
> Perhaps I should have factored out the descriptor population code into
> a separate function to make the code correct and not so horrible. Let me
> do that in v2.
> 
>>> +	} else if (qc->err_mask ||
>>> +		   tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
>>> +		/*
>>> +		 * Use ata_to_sense_error() to map status register bits
>>> +		 * onto sense key, asc & ascq.
>>> +		 */
>>>  		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
>>>  				   &sense_key, &asc, &ascq);
>>>  		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research
>>
> Thank you,
> Igor 
> 

-- 
Damien Le Moal
Western Digital Research

