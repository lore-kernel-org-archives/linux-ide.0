Received: from devloop.tasossah.com (devloop.tasossah.com [145.239.141.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680A33F3
	for <linux-ide@vger.kernel.org>; Wed, 21 May 2025 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.141.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817819; cv=none; b=k+Y34irmtOlzRUB13LbBshnDks5DS7a5FUoOfHdh+awVCLgQj3A5BM2079xYAg08YmZW9cFPc4ux4HnjsVeWYyaqi0RinhOK0mG/mRbPXkQoHJxzw582Bwg4BNKfGCqDYJI8e94ypeyYmncL+K77qggyTb72C+LnwlesnRSjuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817819; c=relaxed/simple;
	bh=89xpaeLKIilgCa8VPZiCd1dNxWt94p0mr+mN4ZHLYaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mh7xo9FgLzmRuTT4UY9RtLeFCA9pjsHHIN+XX5quJ4XfRkowKlsjNoteSfIt2LCgMBDoQRt6ZrMDXCk55vh5nyqeCsSqpTzQNcVVFvPmNGH90m2oJx6CqII8g2iAPC8gq45tSCYq3IrFFu2EC4tqt4hsmMiwms4qb0c2fJEAUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com; spf=pass smtp.mailfrom=tasossah.com; dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b=VSoYBNAV; arc=none smtp.client-ip=145.239.141.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tasossah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b="VSoYBNAV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tasossah.com; s=devloop; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eucWOZBQoc9kDpugYII4VrzuNaXAhglkFKCeHZHz+ng=; b=VSoYBNAV2uWH6KLJVijTEVEkLE
	PE38tlu3mBGze7jxpo5IIEpsrAXomHAzNVaxRZxbtH5xQjvE6bwxC2q5yYZOT64Xf+b+pwWDFw+OZ
	W+UOfZaSczcNF8++TvtAL5OgeJKoUq7yFi1Hq1oagUO8bBvVrQO9W3kBTQ/DH0fS5fmH+iMHyJSG4
	sYgHjU3G8j387UXSZsyuknMGve1n0lVgWDOPJXIQyEok3L2MhqF1179ZYLV0Mg4PcVw4guQPpZ9/j
	JXAqabLWbEvY42tDPn//CPEkvryb7XTc4kJNWEnh6kWkD3cnTuF71/gvziQf0Bnn8DoKfBzgbUOjj
	d1v1FS89iOg4a/DfQ4RxkaDqgakLNPGBwizIyC6Tmluloq9Qs0WqFODOOZLD/OA8cJGS0RwgpXY7F
	xYDYlNGPvdROGIfrLuM9sFUxXxIabHwym502IICQ9hWJoUHhGCM51oveCsmgUkt5BwBQ1LMcNDw8A
	EBEK9XdBc2fOHXbtKcggYDokJ0nTQ8nGnCwO2/wwxtjxmdcZvyph9GNw0HhwbiT1gUwv2BnhMp9ib
	qWQu2vpdlAeD2jTRd2GmEZPyNdX0UeMDwKGQKPbHjm5NeJibDnSpj2oAvYsuoRJ7eUdJGk2QZ/5K3
	9JrvOeRCXGWn9jGBzGueC491E7Cm9pGZbCEkCrn1k=;
Received: from [2a02:587:6a09:4a00:3263:4c19:b861:4371]
	by devloop.tasossah.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.97)
	(envelope-from <tasos@tasossah.com>)
	id 1uHfFv-0000000Cc4P-1cAY;
	Wed, 21 May 2025 11:56:55 +0300
Message-ID: <920a533b-a881-4e26-9129-9e4499b13774@tasossah.com>
Date: Wed, 21 May 2025 11:56:50 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-acpi: Do not assume 40 wire cable if no
 devices are enabled
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20250519085945.1399466-1-tasos@tasossah.com>
 <001a24b4-1f77-42db-91ad-462bc835e275@kernel.org>
From: Tasos Sahanidis <tasos@tasossah.com>
Content-Language: el-GR, en-GB
Autocrypt: addr=tasos@tasossah.com; keydata=
 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
In-Reply-To: <001a24b4-1f77-42db-91ad-462bc835e275@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-05-20 12:29, Damien Le Moal wrote:
> Nit: "it has been renamed" -> "it is renamed"

Will do.

>> @@ -530,13 +534,17 @@ int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
>>  		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
>>  		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
>>  
>> -		if (udma_mask & ~ATA_UDMA_MASK_40C)
>> -			return 1;
>> +		ret = ATA_CBL_PATA40;
>> +
>> +		if (udma_mask & ~ATA_UDMA_MASK_40C) {
>> +			ret = ATA_CBL_PATA80;
> 
> Please change this to "return ATA_CBL_PATA80;" and change the last return at the
> end of the function to "return ATA_CBL_PATA40;". That will be cleaner.
> 
> Other than these, this looks good.
> 

Apologies, but I am not sure I understand.

Wouldn't changing the last return to ATA_CBL_PATA40 undo the point of
this change? The function must return ATA_CBL_PATA_UNK if the loop is
never entered (no enabled devices).

If it does enter the loop but the mask hasn't matched at all after it
has gone through all the devices, it must return ATA_CBL_PATA40, which
is why there's the unconditional assignment ret = ATA_CBL_PATA40. If,
however, there is at least one "80 wire device", the whole cable is
considered 80 wire (thus the immediate break in the if).

I believe the most that can be done is:

if (udma_mask & ~ATA_UDMA_MASK_40C)
	return ATA_CBL_PATA80;

with the rest remaining the same. I opted for assignment + break there
instead of return as it seemed more readable to me, and it's consistent.
