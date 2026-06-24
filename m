Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50523A6405
	for <linux-ide@vger.kernel.org>; Wed, 24 Jun 2026 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293667; cv=none; b=QThtkJTBPzRw0DGNmdPISaVhAi7RiO6YQoid7ZO7Aa0IdLwMcCPEwQbt5Q9Em8zppfb6e7al5QyiCc0b4yB7yIoy5nnHAXXvVqaNwTBb5bZNbjRXI6BK65vr5EJ1mi620V1WqRvko15OQyfYT2p4WxMVND8T3jBbHmgO3icFQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293667; c=relaxed/simple;
	bh=9jAllvut33UUNAalFWxDHvArDxlMVhNBLwT6fyVnxjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zvh3m9OICunDytk0unshM5tUQRK1Qg1x/84BjLwzYduv/PoRlsqBngAmHOxehBz0lTwDdRP5prqb6f809N/KdSaBtDJ72I2PE6ftZc5GHK+Z58hfHlLiz4Htsu3rkbii6Xf785kma9Jx+yukJ4zpCce6WOFLt8oLkLuCnfhlOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WI9+QcFj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4xiAYX24; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WI9+QcFj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4xiAYX24; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WI9+QcFj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4xiAYX24";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WI9+QcFj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4xiAYX24"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EE6A6D92C;
	Wed, 24 Jun 2026 09:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782293662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40v/oI+seZ4K1HPSU+3b45d+4IBHRyp4/Veqdi8phzo=;
	b=WI9+QcFjBJKt5xdkc9OjL3E+1j1LK0hwDi9EsHrpxbneRz/r51NmZvoGlNLIq1n/5TI/+Y
	eMFQvYBv0tXaNdssraYxe0Pwa44kXRn4lOGVokKdzm5HlVepV49uoorNXThxH3f0Ng3WoD
	rP6vmZ/D3O3xp6zW/6pnsChncVATt+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782293662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40v/oI+seZ4K1HPSU+3b45d+4IBHRyp4/Veqdi8phzo=;
	b=4xiAYX24+jCbvFKyvvyldmJTZLGBsY2SS0QNkf3Jv2Vn1GxjLzI8Zq3N7ueqvIvzeG/qn0
	2BPMQ34tXv+UgxAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782293662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40v/oI+seZ4K1HPSU+3b45d+4IBHRyp4/Veqdi8phzo=;
	b=WI9+QcFjBJKt5xdkc9OjL3E+1j1LK0hwDi9EsHrpxbneRz/r51NmZvoGlNLIq1n/5TI/+Y
	eMFQvYBv0tXaNdssraYxe0Pwa44kXRn4lOGVokKdzm5HlVepV49uoorNXThxH3f0Ng3WoD
	rP6vmZ/D3O3xp6zW/6pnsChncVATt+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782293662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40v/oI+seZ4K1HPSU+3b45d+4IBHRyp4/Veqdi8phzo=;
	b=4xiAYX24+jCbvFKyvvyldmJTZLGBsY2SS0QNkf3Jv2Vn1GxjLzI8Zq3N7ueqvIvzeG/qn0
	2BPMQ34tXv+UgxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34D69779AB;
	Wed, 24 Jun 2026 09:34:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9tf7C56kO2rREAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jun 2026 09:34:22 +0000
Message-ID: <873e5289-d745-4549-a591-a8818f2f5300@suse.de>
Date: Wed, 24 Jun 2026 11:34:21 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: fix ata_scsi_security_inout_xlat()
 buffer length conversion
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
References: <20260624090931.1483644-1-dlemoal@kernel.org>
 <bbd49b9f-f1a4-4685-b8f7-2049a61fd86e@suse.de>
 <baba29d7-16c0-4d8d-b275-064a562b5d09@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <baba29d7-16c0-4d8d-b275-064a562b5d09@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 6/24/26 11:24 AM, Damien Le Moal wrote:
> On 6/24/26 6:22 PM, Hannes Reinecke wrote:
>> On 6/24/26 11:09 AM, Damien Le Moal wrote:
>>> ata_scsi_security_inout_xlat() converts the SCSI command buffer length
>>> into the ATA sector size based size by aligning upward the length to 512B.
>>> That is incorrect as that can lead to specifying a buffer size that is
>>> larger than the memory allocated for the command buffer, resulting in all
>>> sorts of possible command failures and/or memory corruptions.
>>>
>>> Ideally, we should bounce the buffer to a large enough size to fit
>>> the entire SCSI command buffer, but we do not have anything in place to do
>>> that cleanly. So for now, fix this by converting the command buffer length
>>> downward with a simple division of the buffer length by ATA_SECT_SIZE.
>>>
>>> Fixes: 818831c8b22f ("libata: implement SECURITY PROTOCOL IN/OUT")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>>    drivers/ata/libata-scsi.c | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index d54ec1631e9a..e78801e7ea8c 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -4330,7 +4330,13 @@ static unsigned int
>>> ata_scsi_security_inout_xlat(struct ata_queued_cmd *qc)
>>>            }
>>>              /* convert to the sector-based ATA addressing */
>>> -        len = (len + 511) / 512;
>>> +        if (len) {
>>> +            len = len / ATA_SECT_SIZE;
>>> +            if (!len) {
>>> +                ata_scsi_set_invalid_field(qc->dev, scmd, 6, 0);
>>> +                return 1;
>>> +            }
>>> +        }
>>>        }
>>>          tf->protocol = dma ? ATA_PROT_DMA : ATA_PROT_PIO;
>>
>> round_down(), maybe?
>> To make the intention clear?
> 
> Nope. We do not want a number of bytes but a number of ATA 512B sector count :)
> 
Argl. Of course.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
