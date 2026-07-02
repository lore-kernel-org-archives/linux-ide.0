Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0694301468;
	Thu,  2 Jul 2026 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959257; cv=none; b=eAp9FO/93f5gUH5ffgY8xHltTDEme5C79bGIlOpz0rocRX6Plmkv1btYsKPD87Du+zXqADf8LbbDFxEYJOWkVpi0+RvJkL5TJVv3rSMIaKA3RBz32xrKthy74EBkyzVax6ZH9e+KWYPfUToPpjLm2IE97UoQzbAXqMASrKOqM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959257; c=relaxed/simple;
	bh=TU3EE1xwXi51MXH+nbB3mS4U367XCQh2n7gX7pTXIXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAfeN8FnNrlUFQPTYwi2Z7j37QuwPBCZUSHJnAA8hdF3RnbrXzfLqy5uvCXLYHq3AVR9gRvpR/6seCg9aDrogiSAUun35HmOCRcjkTPe9Gi70UzVRRu+VLvJJ1JwyY+bTnGzJv9V5Apq7kTprL3zu+f6ZBCCdoHufAiZT4FWZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l60s0IlM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l60s0IlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB77F1F000E9;
	Thu,  2 Jul 2026 02:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782959256;
	bh=Ct+ByRLwivhtqoJFFwKkA7kcnWyb7pjNCSc8oe4FzPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l60s0IlMN0IhlRsEgLL13W486jugViri0gROh+zJM7hcVj6BFIAUZ+mzZfyABy6DD
	 t16wqazePjZReyw3botgzu5LSrSkukeNGbK/5jy+y2bbs9Dua4HozeCdTHHbj3NmZF
	 ZSdrWdtLMBvfby1EzUpIASsxobuvgPP7c+gq4HvZk19Xmg/HwwLdM+QhVMVh0QqNDy
	 qUOHreel4JqaM4RncoQXGjPC721ydpTfPASba35eruj91Lih4Ypv2PCVjYfuIW/Sxg
	 4e2sRGKI+OkyK9xj6rZ5+OIjp2opMKf4qJpfbHgfmU/ra6yS+2TyhNyC5QjsmW67kE
	 s4Bfn3qclFFtA==
Message-ID: <9432b90e-8897-4f5a-8fc4-7908df47449d@kernel.org>
Date: Thu, 2 Jul 2026 11:27:34 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] ata: libata-scsi: support the all command format
 for reporting supported commands
To: sashiko-reviews@lists.linux.dev
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260702015646.1702539-1-dlemoal@kernel.org>
 <20260702015646.1702539-7-dlemoal@kernel.org>
 <20260702021136.EFDE91F000E9@smtp.kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260702021136.EFDE91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 11:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Incorrect bit-shifting and field conflation for the CDLP and RWCDLP fields corrupts Command Duration Limits (CDL) reporting.
> - [Medium] ZBC_IN and VARIABLE_LENGTH_CMD are incorrectly reported as lacking service actions in the All Commands format.
> --
> 
> commit f7b18a5d6dd37eabc2de02696bfa0461178f0b87
> Author: Damien Le Moal <dlemoal@kernel.org>
> 
> ata: libata-scsi: support the all command format for reporting supported commands
> 
> This commit introduces support for the "All Commands" format (reporting option 0)
> in ata_scsi_report_supported_opcodes(). It adds ata_scsi_report_all_supported_opcodes()
> to iterate through ata_supported_cmds and report supported operations.
> 
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 3f313050c63f3..30e2cf3b03dc7 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3731,6 +3731,42 @@ static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op, u16 sa,
> [ ... ]
>> +static unsigned int
>> +ata_scsi_report_all_supported_opcodes(struct ata_device *dev, u8 *rbuf)
>> +{
> [ ... ]
>> +		/* All command format */
>> +		if (!ata_scsi_cmd_is_supported(dev, cmd->op, cmd->sa, &sup))
>> +			continue;
>> +
>> +		buf[0] = cmd->op;
>> +		put_unaligned_be16(cmd->sa, &buf[2]);
>> +		buf[5] |= (sup.rwcdlp << 6) | (sup.cdlp << 2);
> 
> [Severity: High]
> Does this code correctly shift and map the CDLP and RWCDLP fields?

No it does not.

> It looks like sup.rwcdlp is a 1-bit boolean flag (0 for A/B, 1 for T2A/T2B)
> used in the One Command format, not the 2-bit RWCDLP enum (01b=Read, 10b=Write)
> required for the All Commands format. Shifting 1 by 6 sets bit 6, resulting in
> 10b, which would incorrectly report READ_16 as a Write command.

rdwcdlp is always 1 bit, for both the one command format and the all command format.

> 
> Additionally, the CDLP field is defined at bits 4-3, but sup.cdlp is shifted
> by 2, placing it at bits 3-2. For WRITE_16 (sup.cdlp=2), shifting by 2 results
> in setting bit 3, which falls into the CDLP field as 01b instead of 10b.

cdlp in bits 4-3 of byte 1 is for the one command format, which is different
from the all command format which has cdlp in bits 3-2 of byte 5 of a descriptor.

> 
>> +		if (cmd->sa)
>> +			buf[5] |= 0x01;
> 
> [Severity: Medium]
> Will this correctly set the SERVACTV bit for all commands that require service
> actions?
> 
> Commands like ZBC_IN (0x95) and VARIABLE_LENGTH_CMD (0x7F) have their service
> action explicitly defined as 0x00 in ata_supported_cmds. Since cmd->sa evaluates
> to 0, the SERVACTV bit won't be set. This incorrectly tells the host that these
> commands do not use the SERVICE ACTION field.

Will fix that, despite the fact that this is originally a problem with the specs
making a mess with service action "0".

> 
>> +		put_unaligned_be16(cmd->cdb_len, &buf[6]);
>> +
>> +		/* CTDP == 0 */
>> +		len += 8;
>> +		buf += 8;
>> +	}
> 


-- 
Damien Le Moal
Western Digital Research
