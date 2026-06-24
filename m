Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB258175A66
	for <linux-ide@vger.kernel.org>; Wed, 24 Jun 2026 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307149; cv=none; b=VmpErRKKyppAY6RGxxSpUtUXEuWIcsOa2Gy9qaqnsaNGsb5spbiZlnpqn7e2JCYggwvhN0RpQnO2g3/rnlGbUtmvDz6dqnOj8mzcTXFTNNb/57x/ri9MFUbTe/3Kt6BRsxAuPigMTdau1UR/3RaPgyRMUx8Rwc4joHVgwfjZRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307149; c=relaxed/simple;
	bh=jjieZ2YUQ1vAZ3sYbux/EUQ5bUcub0OKQV/NU+5OJaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6yCBefD+XNxay2KaNPXXjtNQCDCpJzTam8aR+3VSq4uoyebYss2OEkVM3lzBJPItq/AsWz7hOz20WZgWQ9hTS+izH62Uy5x9N+/AiVBY08PMu9SbzkBcP7rprxZGW+EYAeKwqqHopIDIy4pWvDAgVecvkFIlqLBf3EeNm3GZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmhTyW4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmhTyW4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C5A1F000E9;
	Wed, 24 Jun 2026 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307148;
	bh=4owze0UDfT09WmQAibm5oV653GD5I6uz4aSc7avHMQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jmhTyW4eSrNKn1idFVmAf7iHzqoMqEPrfTp422zQHh+cBwXlPXWMHObOSOixyiRFg
	 IQmnGEo45sH7z/AsPMC2XBS4lXDiUHQBj8ooa/T+3K65uUqmkmrA1NmXQTUMlPkQYt
	 XYKCbX0mPz8PHpZq1rL3LrwYVs/Mp04Qll4a/px1CsiB1yqNd3Hqio1+zvq8x9bs2D
	 n8GOfuo2dnk5VVRdgTGtobCIeVtIijH8wbbvrTZzsHKHJoOm+32WA0UlsKKux1co6H
	 NKMkXGAb1oJjOpl2zqqfhxaO3cXVsNbwKU44DIuDLQp7DDbZ4hujr1DHIxNGYUVe9a
	 KealnJLDqjVKw==
Message-ID: <b15e1f77-fc69-46b4-84b5-dc0399a56050@kernel.org>
Date: Wed, 24 Jun 2026 22:18:56 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: fix ata_scsi_security_inout_xlat()
 buffer length conversion
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20260624090931.1483644-1-dlemoal@kernel.org>
 <ajvErjEiGUuFm75I@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ajvErjEiGUuFm75I@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/26 20:51, Niklas Cassel wrote:
> On Wed, Jun 24, 2026 at 06:09:31PM +0900, Damien Le Moal wrote:
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
>>  drivers/ata/libata-scsi.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index d54ec1631e9a..e78801e7ea8c 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -4330,7 +4330,13 @@ static unsigned int ata_scsi_security_inout_xlat(struct ata_queued_cmd *qc)
>>  		}
>>  
>>  		/* convert to the sector-based ATA addressing */
>> -		len = (len + 511) / 512;
>> +		if (len) {
>> +			len = len / ATA_SECT_SIZE;
>> +			if (!len) {
>> +				ata_scsi_set_invalid_field(qc->dev, scmd, 6, 0);
>> +				return 1;
>> +			}
>> +		}
>>  	}
> 
> The code in question is located in the else clause for:
> if (cdb[4] & 7) { /* INC_512 */
> 
> So this is for INC_512 set to zero.
> 
> 
> From SAT6r02, SECURITY PROTOCOL OUT (sending security info to the device),
> 8.13.1 TRANSFER LENGTH field and INC_512 field:
> 
> """
> If the INC_512 bit is set to zero, then:
> 
> b) if the TRANSFER LENGTH field is set to a value less than or equal to
> 01FF_FE00h, the ATA TRANSFER LENGTH field shall be translated from a
> number of bytes to a number of padded 512-byte units from the result of
> the following calculation:
> 
> ATA TRANSFER LENGTH(15:0) = ((transfer length + 511) / 512)
> 
> If the length of the final data block is not a multiple of 512 bytes,
> then the final data block shall be zero-padded (see SPC-5) to a multiple
> of 512 bytes. The ATA trusted send command shall transfer the padded data
> for the number of blocks specified by the ATA TRANSFER LENGTH field.
> """
> 
> So, at least as per SAT6r06, it says that the buffer for SECURITY PROTOCOL
> OUT (as per SPC-5), which we receive from SCSI, when using INC_512 set to
> zero, should already be padded with zero bytes to be a multiple of 512.

OK. Let's ignore this patch for now. I will revisit this.


-- 
Damien Le Moal
Western Digital Research
