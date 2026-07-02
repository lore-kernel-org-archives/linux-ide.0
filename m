Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA138E8D8;
	Thu,  2 Jul 2026 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975621; cv=none; b=SRkRoli4RMtD2TBJf9goMCRSQLeFY3EN+aam/OiwZK29sDjBNANHyV3qq2L4loJrNjJoGN2yc7PaUQbUP9/azztWGTqXOb5DVUKNxcyw6CKA8G+6lVEtbsG1hXmlAf2I7QX1NdI644qF+BtVNV1MBBX95Gr6wuqXMLlrOLTTRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975621; c=relaxed/simple;
	bh=H0Q8gI21oGdzfUcOFvcxeAjKdH1I6nFAUlNmk/tpM3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/rbFE2XH+oJeNQDZc3EacOz5pe15YW11EYeDqOFy4AYzqK39gtddRdwHJ7Ru5LHaBwgyPyPk5ZjXOaCOrlEwsR31jQCzp4YQf0eLWyhce77RM3q39GmiL1xv4OAAQ52Yf28wWnRSKig9hK3acVuMQJxNowani8JzAvmKVS5p50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oH/H+1jI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oH/H+1jI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940381F000E9;
	Thu,  2 Jul 2026 07:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782975620;
	bh=cpCiJPZNrQ4osQRHla7T/Pi15rCP7atqnvJKmzSanak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oH/H+1jIY2EuHRQEfloOyzzqOO4JbppOdWTtS0eBvBbj0Aizmrs+BnocZzsSEA2Pu
	 NOG5cmg6FGn5BQTSdPm7bFV8hrWHo2cqpKN/twGIY54jN+vhCzFuXrKsc6G3BJmabE
	 kpWX77ppWyz7A8nEUWyPkRLqjr7+oDOHa0DghgtOe+aFBz1OUW8koiXZQ+nfF8S+Kk
	 7BEYy/hnQtPt3TppqD5WPPQI1IvWQ4ycEdrdixwqWui4Yn2/qC6gEeqh3flEWilh6v
	 t55MnRAoIG43rZLFt4ioTSLBbr07vYP3AkCNnQg4CrS5h06Xh5Asb1Agmd5+jDwvEV
	 nmaDbyCrD8Dgg==
Message-ID: <3acde700-be7c-4ca0-b646-1dc5f6976cad@kernel.org>
Date: Thu, 2 Jul 2026 16:00:18 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ata: libata-scsi: support reporting options 2 in
 REPORT SUPPORTED OPERATION CODES
To: sashiko-reviews@lists.linux.dev
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-5-dlemoal@kernel.org>
 <20260702065227.EA8671F000E9@smtp.kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260702065227.EA8671F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 15:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Reporting options 1 and 2 incorrectly terminate with CHECK CONDITION (INVALID FIELD IN CDB) for valid queries, violating SCSI protocol.
> - [Medium] Reporting option 3 incorrectly evaluates the REQUESTED SERVICE ACTION field for commands that do not use service actions.
> --
> 
> commit 8b0fcbdec2fbb5690930a99f6f8a7faf9e8bd511
> Author: Damien Le Moal <dlemoal@kernel.org>
> 
> ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED OPERATION CODES
>     
> Add support for the reporting options value 2 of the in REPORT SUPPORTED
> OPERATION CODES command in ata_scsi_report_supported_opcodes(). With this
> reporting option, the specified opcode to check must have a service
> action. Use ata_scsi_supported_cmd_has_sa() to check for this and fill the
> command reply buffer using the one command format based on the command
> support.
> 
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 86ac41a7d81ab..e75ed573e234b 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3737,6 +3737,13 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
>>  			return 0;
>>  		}
>>  		break;
>> +	case 2:
>> +		/* One command format, must have sa. */
>> +		if (!ata_scsi_supported_cmd_use_sa(cdb[3])) {
>> +			ata_scsi_set_invalid_field(dev, cmd, 3, 0xff);
>> +			return 0;
>> +		}
> 
> [Severity: Medium]
> Does this validation check incorrectly abort execution with a SCSI error for
> option 2 commands that are unknown?
> 
> According to SPC-5, option 2 queries for unsupported commands (and similarly,
> option 1 queries for commands with service actions) must return SUPPORT=001b.
> Instead, this implementation erroneously aborts the command by calling
> ata_scsi_set_invalid_field(), preventing the code from falling through and
> correctly populating the response buffer.

Sashiko, please reread the SPC specifications. It says:

If the REQUESTED OPERATION CODE field specifies an operation code for
which the device server does not implement service actions a, then the
device server shall terminate the command with CHECK CONDITION
status, with the sense key set to ILLEGAL REQUEST, and the additional
sense code set to INVALID FIELD IN CDB.

Which is exactly what we are testing here.

> 
>> +		fallthrough;
>>  	case 3:
>>  		/* One command format */
>>  		sa = get_unaligned_be16(&cdb[4]);
> 
> [Severity: Medium]
> If an initiator issues REPORT SUPPORTED OPERATION CODES with option 3 for a
> standard command that lacks service actions, while providing non-zero data in
> the requested service action field, wouldn't this unconditional extraction of
> sa cause a regression?

No. Service action is not ignored with reporting options 3.

> SPC-5 dictates that if the requested opcode does not have service actions, the
> requested service action field must be ignored. By unconditionally extracting
> sa here, it will fail to match in ata_scsi_get_supported_cmd() since
> non-service-action commands expect sa == 0, improperly yielding SUPPORT=001b
> for a valid, supported command.

No. SPC says:

a) the operation code specified by the REQUESTED OPERATION CODE
field specifies an operation code for which the device server does
not implement service actions, the REQUESTED SERVICE ACTION field
is set to 00h, and the command is supported; or
...
then the command support data shall indicate that the command is
supported (i.e., the SUPPORT field (see table 262) is set to 011b or 101b).
Otherwise, the command support data shall indicate that the command is
not supported (i.e., the SUPPORT field is set to 001b).

Set for commands that do not support service actions, the command must have
service action set to 0.


-- 
Damien Le Moal
Western Digital Research
