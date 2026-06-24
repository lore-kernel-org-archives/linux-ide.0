Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9F23EAB3
	for <linux-ide@vger.kernel.org>; Wed, 24 Jun 2026 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293123; cv=none; b=g/5DiFe2RRhtPYSeXB1qn6NRxxAJu5h5QH32o7HZjXJY6M3TgU7TFFRxMa727EFQKdWQ33NZAWMYPeefGNfpZo4Zwab6he9gUsys+JDDnfByM/l1UDyV0bYtS4Urn00XX1SZOUgr1xK+Bt5iicHmhboXu+jbPRsRZYGAMWE21tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293123; c=relaxed/simple;
	bh=fNbPSsxdojeoB1E3hI+cJ0eQiAhJPcousYrBm6TmNH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCs8jnJ5ZlhNyKv+6j0bK54MLnqhoPkhCtUjhVoNaNyZhu51Bzx8G1usEiu3aTdBvm0ODsTFcAGSeB+PrsKGXS7JoSbM1rUOssmeAEkYQKFWkqCNgbj9sIz+hjykgLXhgmX6s1hxVZJ7w6usG+4rTo4vSvhBGhl5k/Jyp6aGnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGs8NUJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGs8NUJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA691F000E9;
	Wed, 24 Jun 2026 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782293108;
	bh=clT/VW1/ezOM3EWmLPp92V+SDkFNwRrBNE+farflk/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lGs8NUJSaJATx/f6MFGkjsnErhNKU4gdPGjSMhft9voYL2r2h02C9GXOoImGBsxaE
	 3a1CWLxQTykQHNJ0iTqYmFDRkvW0F7hxvrM59prXecNvqJbVIaHqiuS9ij4Y5gAhQw
	 bv++oDpzO2vjUeKJ/L/cWmU3NLxL7jvxLKB9THrNFs+8nCBg097fKGESsHg46/4+cp
	 DkZEU9aGZGujGk3ZfJVdKIj+vvkyulKCiUuBo70bwcjsYQNhWQcuCDlyDVsmnwHwdM
	 q6F0VK4QdWRLQOAZKsfwVIOLiHNnqOHumwF8WqKq3tPxMuCKq6LA16QQatiHJhCTye
	 NMMXUnJo/lUEg==
Message-ID: <baba29d7-16c0-4d8d-b275-064a562b5d09@kernel.org>
Date: Wed, 24 Jun 2026 18:24:57 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: fix ata_scsi_security_inout_xlat()
 buffer length conversion
To: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
References: <20260624090931.1483644-1-dlemoal@kernel.org>
 <bbd49b9f-f1a4-4685-b8f7-2049a61fd86e@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <bbd49b9f-f1a4-4685-b8f7-2049a61fd86e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/24/26 6:22 PM, Hannes Reinecke wrote:
> On 6/24/26 11:09 AM, Damien Le Moal wrote:
>> ata_scsi_security_inout_xlat() converts the SCSI command buffer length
>> into the ATA sector size based size by aligning upward the length to 512B.
>> That is incorrect as that can lead to specifying a buffer size that is
>> larger than the memory allocated for the command buffer, resulting in all
>> sorts of possible command failures and/or memory corruptions.
>>
>> Ideally, we should bounce the buffer to a large enough size to fit
>> the entire SCSI command buffer, but we do not have anything in place to do
>> that cleanly. So for now, fix this by converting the command buffer length
>> downward with a simple division of the buffer length by ATA_SECT_SIZE.
>>
>> Fixes: 818831c8b22f ("libata: implement SECURITY PROTOCOL IN/OUT")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   drivers/ata/libata-scsi.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index d54ec1631e9a..e78801e7ea8c 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -4330,7 +4330,13 @@ static unsigned int
>> ata_scsi_security_inout_xlat(struct ata_queued_cmd *qc)
>>           }
>>             /* convert to the sector-based ATA addressing */
>> -        len = (len + 511) / 512;
>> +        if (len) {
>> +            len = len / ATA_SECT_SIZE;
>> +            if (!len) {
>> +                ata_scsi_set_invalid_field(qc->dev, scmd, 6, 0);
>> +                return 1;
>> +            }
>> +        }
>>       }
>>         tf->protocol = dma ? ATA_PROT_DMA : ATA_PROT_PIO;
> 
> round_down(), maybe?
> To make the intention clear?

Nope. We do not want a number of bytes but a number of ATA 512B sector count :)

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
