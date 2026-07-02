Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE68F7262E;
	Thu,  2 Jul 2026 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958775; cv=none; b=g4hnRLcfPevBaoECEtaxIzuy6u6RFv1bKBw5vEtmiOSRtPZQ+wO4KeWvwFr1sfjNqBjex8qdtfrfNIKx6gynibvH5TmYVCcREBf+c/BdAiOqwy0H8vHt1wGxvWVdYRS5nZcgHEJ0sbqU3JZ9f97dWzxSJEligdeP3/bPrXyqbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958775; c=relaxed/simple;
	bh=aWcXcNSTyC8w2G/i9juMoMt4zWRNJQ67g4Bqco3YHF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbyZiYqApqYGeSP3+mde9AfbzsuNS34mY9T0eED/7/Gvdhor6lUVxqnfYgVPmJk1YVN/6KcAtDcFrE3mIOjkOVrzqSCxTDrexgaa5F6umiUBDxYe0NPhgWLa+Gut9fgnjgLmCYbhIsVVrPxCt+3VLxq2liFqkcZoRgTXBpOS6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X680cmhF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X680cmhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00A51F000E9;
	Thu,  2 Jul 2026 02:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782958774;
	bh=hUxBaKt4Kk+Fjood6whqXgKIiJJVftxRALRC+L+/IVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=X680cmhF7H11qCeLXH8/cakafHtjtq9/WQ91mRJSQuxXsa9Cw9Dv4i2IIXldhEc4r
	 YUduZ1dqugOL2RQAcNzhFPswxbdbn48EU9KBX0es50fi1VMaEeWQ7rVR9j+bvS2cEi
	 3BZPS0KAHvnfvdshyGlKmMXL+LfsfVosfIEZLDzwtfBUW3JjXK6iWBoyEGFitT3jfi
	 3v03ZwS1LjsAbWtlUov1mKcW/NHdTg0mlOgpk+dYCFSjcDH/sUtpOrRJpISmaP1lZX
	 aGvkQMRrzLmHY0+n4VSQWu9WTeR0BwpBn8gER6J1w4cS+bK9O8tqfu9JDB6g+Mck33
	 5v/janRFgOvWg==
Message-ID: <a6cbe516-7147-48da-8cdc-b67ebfa0dcce@kernel.org>
Date: Thu, 2 Jul 2026 11:19:32 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] ata: libata-scsi: improves checks for ZBC_IN and
 ZBC_OUT commands support
To: sashiko-reviews@lists.linux.dev
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260702015646.1702539-1-dlemoal@kernel.org>
 <20260702015646.1702539-5-dlemoal@kernel.org>
 <20260702020737.E00E61F000E9@smtp.kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260702020737.E00E61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 11:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] ZBC_IN is incorrectly evaluated as not having service actions because ZI_REPORT_ZONES equals 0, breaking all REPORT SUPPORTED OPERATION CODES (RSOC) formats.
> --
> 
> commit 6af9854276b3609a524ea350c87e6e2924aee340
> Author: Damien Le Moal <dlemoal@kernel.org>
> 
> ata: libata-scsi: improves checks for ZBC_IN and ZBC_OUT commands support
> 
> Improve ata_scsi_cmd_is_supported() to check the service action for the
> ZBC_IN and ZBC_OUT opcodes, to correctly report supported zone management
> commands for zoned disks.
> 
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index e432e521ad318..f9e6bda6833e4 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3708,8 +3708,17 @@ static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op, u16 sa,
>>  		}
>>  		return true;
>>  	case ZBC_IN:
>> +		return sa == ZI_REPORT_ZONES && ata_dev_is_zoned(dev);
> 
> [Severity: Medium]
> Does this inadvertently break REPORT SUPPORTED OPERATION CODES (RSOC) formats
> for ZBC_IN?
> 
> Because ZI_REPORT_ZONES evaluates to 0, the helper
> ata_scsi_supported_cmd_has_sa() will evaluate this as not having service
> actions:
> 
> drivers/ata/libata-scsi.c:ata_scsi_supported_cmd_has_sa() {
>     return cmd->sa != 0;
> }
> 
> This appears to cause incorrect behavior during RSOC handling for ZBC_IN:
> 
> - Format 0 (ata_scsi_report_all_supported_opcodes) fails to set the SERVACTV
>   (Service Action Valid) bit because cmd->sa evaluates to 0.
> 
> - Format 1 incorrectly accepts ZBC_IN.
> 
> - Format 2 (ata_scsi_report_supported_opcodes) incorrectly rejects valid
>   queries for ZBC_IN with CHECK CONDITION (ILLEGAL REQUEST), preventing
>   userspace from probing ZBC_IN service actions.

Yes, these observations are correct if one assumes that "0" is a valid service
action. But it is not: the SPC specifications actually define service action "0"
as "reserved". So this is a mess, but the specifications are responsible here.

With these changes, report zones is still reported as supported and everything
works.

-- 
Damien Le Moal
Western Digital Research
