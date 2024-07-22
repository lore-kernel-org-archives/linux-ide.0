Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F3487B3
	for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2024 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689803; cv=none; b=kchLW046CPvtDW73kKBE+DozOxmypVycjNrKRRKXWocw/R4bcdTVagwbQCyLPQtQfoBRwFEJYmYpIJuNNCUyb+ueUZV8umjPxeX2ZZz5udxnliXve41hxBJ7KQJKPACedCHkHaeLhrICnR6/zxMxTcVBbL+GdM8WZwo4wRm5BEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689803; c=relaxed/simple;
	bh=Mf3KagHXA26uLBUadDRg3yNL+FkLPuAjneT8qIE+hAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUHxiX3Ap8TNPvPo3JPxx70IKxMkwSl61STXkIEqY/zCtP2PYGJ30Ngd0jEObyG7n3BtvDPjS3i44Qv5WzyNNRB7wrGBEIkDtwjdlFdjTvl32TmMOfW7wglgO5Sg8tNOuLCqCUbN4BRUn4j7V69GN3UTC4rH69owMR4ps7tpP00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8Q76pnR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8Q76pnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89067C116B1;
	Mon, 22 Jul 2024 23:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721689803;
	bh=Mf3KagHXA26uLBUadDRg3yNL+FkLPuAjneT8qIE+hAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O8Q76pnRnULupwDIKlruqtNmZHtlpBHuJ5Gev0osTZroy8bo/IEMnVMLRD+Suro+q
	 3r/eqb2s5BdCST1H+CCZEkd/9b06snbZlz5rg5/MppPsW93zEKnVtYXEWJWwRiKVR7
	 5ZRfcFHqW738KyhcpwSQMtIWIgJRQ1Jbj6NtyYJdbU1korMutnp2WAhOcVDklbucY5
	 eMCml7pyq64zU2TZD/0888dSCON3kIsuH/g4VgMCXk7pgT4Q3Q1kJyz7ZcpSeSoKDG
	 4wilm4PmMy325Ndnr/8Pc6TO5ZA97AWoXbceiyNisuGdM7fSv5dDFVOXvbvE9lraMt
	 SCzpndesTc01g==
Message-ID: <0abbefb8-351a-4be9-90a7-bf26dbe969c7@kernel.org>
Date: Tue, 23 Jul 2024 08:10:01 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ata: libata: Print horkages applied to devices
To: Igor Pylypiv <ipylypiv@google.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20240722013412.274267-1-dlemoal@kernel.org>
 <20240722013412.274267-4-dlemoal@kernel.org> <Zp7PjJ0dJidXmY7c@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Zp7PjJ0dJidXmY7c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/24 06:30, Igor Pylypiv wrote:
>>  static const struct ata_dev_horkage_entry ata_dev_horkages[] = {
>> @@ -4266,21 +4329,24 @@ static const struct ata_dev_horkage_entry ata_dev_horkages[] = {
>>  	{ }
>>  };
>>  
>> -static unsigned long ata_dev_horkage(const struct ata_device *dev)
>> +static unsigned int ata_dev_horkage(const struct ata_device *dev)
>>  {
>>  	unsigned char model_num[ATA_ID_PROD_LEN + 1];
>>  	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
>>  	const struct ata_dev_horkage_entry *ad = ata_dev_horkages;
>>  
>> +	/* dev->horkage is an unsigned int. */
>> +	BUILD_BUG_ON(__ATA_HORKAGE_MAX > 31);
> 
> Should this check be '__ATA_HORKAGE_MAX > 32'?
> 
> When __ATA_HORKAGE_MAX is 32 then the last horkage bit will be 31.

Oops... Yes, of course you are right. Good catch.

>> +enum ata_horkage {
>> +	__ATA_HORKAGE_DIAGNOSTIC,	/* Failed boot diag */
>> +	__ATA_HORKAGE_NODMA,		/* DMA problems */
>> +	__ATA_HORKAGE_NONCQ,		/* Don't use NCQ */
>> +	__ATA_HORKAGE_MAX_SEC_128,	/* Limit max sects to 128 */
>> +	__ATA_HORKAGE_BROKEN_HPA,	/* Broken HPA */
>> +	__ATA_HORKAGE_DISABLE,		/* Disable it */
>> +	__ATA_HORKAGE_HPA_SIZE,		/* native size off by one */
>> +	__ATA_HORKAGE_IVB,		/* cbl det validity bit bugs */
>> +	__ATA_HORKAGE_STUCK_ERR,	/* stuck ERR on next PACKET */
>> +	__ATA_HORKAGE_BRIDGE_OK,	/* no bridge limits */
>> +	__ATA_HORKAGE_ATAPI_MOD16_DMA,	/* use ATAPI DMA for commands
>> +					    not multiple of 16 bytes */
>> +	__ATA_HORKAGE_FIRMWARE_WARN,	/* firmware update warning */
>> +	__ATA_HORKAGE_1_5_GBPS,		/* force 1.5 Gbps */
>> +	__ATA_HORKAGE_NOSETXFER,		/* skip SETXFER, SATA only */
> nit: extra tab                          ^^^^^^^^

Yep. Fixed.

-- 
Damien Le Moal
Western Digital Research

