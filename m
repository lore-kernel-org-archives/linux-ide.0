Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968732E6BD
	for <linux-ide@vger.kernel.org>; Tue, 24 Feb 2026 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966743; cv=none; b=HompHW9GOC5JxSmvfoJu6FDAibWA4EL75oY1tpjajW1UkaDcR5PdbdJkvhne/a3zjhDSFUEHf8sV3cREBc6ZzP/rRmDib08M5rMY5Sfrq6o6ttvDtppphQUdCatFS0kwIzvtM4hXEViL7/IsfpSm/COyWy+HJlQfg0u2oYhGhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966743; c=relaxed/simple;
	bh=iVIrwSAmnRAqiSbSJWRvj8wZ+kDOqY1RVQEm68qZXoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/eGoiXJU9Rz3414r+bOsrFAqaSsRyM5Ql1FZZepohIUcWOXyYdBQk16A2GLmiYDhPd1XAY0MdR2bli+nMHTPd5TZ7F6sqdGqHQhfFh6nkojRmUoWwndSKjjFSxbLeghutkHWPHmpBXK5kPXR4omBFSS3leqDF+/rB2kiejqFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWTLcj6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWTLcj6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C11C116D0;
	Tue, 24 Feb 2026 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771966742;
	bh=iVIrwSAmnRAqiSbSJWRvj8wZ+kDOqY1RVQEm68qZXoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TWTLcj6fsxzt4Ea7uhIDcm60QTvErk2Br9wJg25JrGTNV7GIaIXD01ep5N7VxBfIU
	 3HKn7nkE3bNxWgfux/82dVQ+FJ0Jf9KV1XXlpFSHTg63uwvdacv2+UZFbDHqrfN4JF
	 YUwwWdFXi0mzmGZYn1yHkBY6gqWUIeS9/MHa39zyBU065UbKAQMKjtu4J/S5mOEkej
	 in12S99eKNQdyIY4UB1H5gCYLKlPDk2y9kslP5Lmesr/7QRTRvEAvGKxpvH7QlOM1a
	 82Nv9oyn/7NHR8ZBP3Cs/M5VUf2NapNVXuDYcS/UvvPKJJuYfAQgjEcXI3kcWQzMhm
	 AHPI6WTJhcnOw==
Message-ID: <d27a152a-7ceb-4d85-ba26-165a6da7e2ea@kernel.org>
Date: Wed, 25 Feb 2026 05:59:00 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-eh: avoid unnecessary calls to
 ata_scsi_port_error_handler()
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260224020638.1194842-1-dlemoal@kernel.org>
 <aZ2wyWgR02F1cEvJ@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aZ2wyWgR02F1cEvJ@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/26 23:08, Niklas Cassel wrote:
> On Tue, Feb 24, 2026 at 11:06:38AM +0900, Damien Le Moal wrote:
>> When handling SCSI command timeouts, if we had no actual command
>> timeouts (either because the command was a deferred qc or the completion
>> path won the race with ata_scsi_cmd_error_handler()), we do not need to
>> go through a port error handling, as there was in fact no errors at all.
>>
>> Modify ata_scsi_cmd_error_handler() to return the number of commands
>> that timed out and use this return value in ata_scsi_error() to call
>> ata_scsi_port_error_handler() only if we had command timeouts, or if
>> the port EH has already been scheduled due to failed commands.
>> Otherwise, simply call scsi_eh_flush_done_q() to finish the completed
>> commands without running the full port error handling.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> 
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index db87c99e4189..c872d1f9f43b 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -1225,7 +1225,8 @@ extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
>>  extern struct ata_device *ata_dev_pair(struct ata_device *adev);
>>  int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
>>  extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
>> -extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap, struct list_head *eh_q);
>> +extern int ata_scsi_cmd_error_handler(struct Scsi_Host *host,
>> +				struct ata_port *ap, struct list_head *eh_q);
> 
> Nit: we could drop the extern while touching this line anyway.

Sure. Can you fix that up when applying ?


-- 
Damien Le Moal
Western Digital Research
