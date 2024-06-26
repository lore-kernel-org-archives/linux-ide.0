Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A633C5;
	Wed, 26 Jun 2024 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382921; cv=none; b=lfZCUhSptFrJNen6hSo8NdOAC7Git/QeH6pl+xczHDm5Vg2fKbihuB9VyVbkdhj8hO+KM8tUeYVWpjlFji0N4YaPM3b7yVPT8xg4V//gH9S4EjhJdbba6CTK9XQE4v1vCPZERKme7eO/eMAVb/d4ezJhSLQnfAkc8krhRRlcHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382921; c=relaxed/simple;
	bh=1Yqx0WkL7pvMSlUmi9moTnQle6ioWFoYo3zI/ISLmP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzPC0wZTqx7BXj+UgEc3TphX0yXzl2z/2oEDFgMqq54tKEY9vfMbdWJVuh40HWJngBbAijkoNMw3Pwp9fAQZ63p0qcCEY/d9oNrZWx+xOLZScLYYi54w+oeKnM5oFtwYT15yASuUGVXJTEICXfyMZkyP14VUwKl7I120kMDMvjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlQGZrKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlQGZrKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED0EC2BD10;
	Wed, 26 Jun 2024 06:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719382920;
	bh=1Yqx0WkL7pvMSlUmi9moTnQle6ioWFoYo3zI/ISLmP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VlQGZrKQgu05rMOK6YmjwjYQdiGA5F0WnTMfTUe7Fr58UZDYzil5gT+YvXEQf9Qif
	 545W0ANA2sQtaPGxw0pBXkW4NVBb3BDDsX5ACVdDWxQWoyGiW9UWnKvQinPJtoC/s+
	 sbIDhIgvFz3upWBx1m0RPHZRdP/HoIqKfT+CM2ksxQIcc8EFnVEHzHn3M5xhxPyCN7
	 8l25d1sDn4vbKi3x6eeS30IH7CZNkq36g9UeZlCD3CZezK281XrlORD9jG3DhFknin
	 K3uV0/KOS2YX8IoAhBqGdDMmf9IvNLZUO24Z1Mmuvq05C4UAENCPmjHHc0V2JYaPmY
	 J5C1hb8fbVmJA==
Message-ID: <ab9f6564-3df1-4061-93e7-32a59aacb205@kernel.org>
Date: Wed, 26 Jun 2024 15:21:58 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
To: Igor Pylypiv <ipylypiv@google.com>, Hannes Reinecke <hare@suse.de>
Cc: Niklas Cassel <cassel@kernel.org>, Tejun Heo <tj@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-7-ipylypiv@google.com>
 <7d085940-2ad1-4f44-83bb-33d852e80da0@suse.de> <ZnthK-NjkSgIiGiE@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZnthK-NjkSgIiGiE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/26/24 09:30, Igor Pylypiv wrote:
> On Tue, Jun 25, 2024 at 08:26:59AM +0200, Hannes Reinecke wrote:
>> On 6/25/24 00:12, Igor Pylypiv wrote:
>>> qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
>>> is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
>>> that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
>>>
>>> For ATA errors and ATA PASS-THROUGH commands the ATA_QCFLAG_RTF_FILLED
>>> flag should be always set. Added WARN_ON_ONCE() checks to generate
>>> a warning when ATA_QCFLAG_RTF_FILLED is not set and libata needs to
>>> generate sense data.
>>>
>>> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
>>> ---
>>>   drivers/ata/libata-scsi.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index e5669a296d81..7a8a08692ce9 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -246,6 +246,9 @@ static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
>>>   	struct ata_taskfile *tf = &qc->result_tf;
>>>   	unsigned char *sb = cmd->sense_buffer;
>>>
>>> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
>>> +		return;
>>> +
>>>   	if ((sb[0] & 0x7f) >= 0x72) {
>>>   		unsigned char *desc;
>>>   		u8 len;
>>> @@ -928,6 +931,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>>>   	unsigned char *sb = cmd->sense_buffer;
>>>   	u8 sense_key, asc, ascq;
>>> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
>>> +		return;
>>> +
>>>   	/*
>>>   	 * Use ata_to_sense_error() to map status register bits
>>>   	 * onto sense key, asc & ascq.
>>> @@ -971,6 +977,10 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>>>   		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
>>>   		return;
>>>   	}
>>> +
>>> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
>>> +		return;
>>> +
>>>   	/* Use ata_to_sense_error() to map status register bits
>>>   	 * onto sense key, asc & ascq.
>>>   	 */
>>
>> Hmm. Not sure if we really need the WARN_ON() here or whether a simple
>> logging message wouldn't be sufficient; after all, we continue fine here.
>>
> 
> My worry about adding a simple log statement is that it might cause a log
> spam if things go wrong for some reason.
> 
> This code is more like a "this should never happen" comment and we always
> expect ATA_QCFLAG_RTF_FILLED to be present when generating sense data
> based on ATA registers.
> 
> If WARN_ON_ONCE() is too much for this case I guess we can just remove it
> and silently return?

what about ata_dev_dbg() or ata_port_dbg() ?
No message spamming by default and if problems are detected, they can be turned
on to figure out what is going on.

> 
> Damien, Niklas, what are your thoughts on this?
> 
> Thanks,
> Igor
> 
>> Cheers,
>>
>> Hannes
>> -- 
>> Dr. Hannes Reinecke                  Kernel Storage Architect
>> hare@suse.de                                +49 911 74053 688
>> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
>> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
>>

-- 
Damien Le Moal
Western Digital Research

