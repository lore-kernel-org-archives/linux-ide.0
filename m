Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F418DB27
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350416; cv=none; b=WzXKF2FLFP/teb7X0eQlmhMtvnQQ4eUrLPUCG/ZtqgTH4owEVG3nqCvaa5zD6MzkIszJhMVPTOegYeaHDQkEQuZkCfDJxumXV5+jfd9ZA6YcubwxqqUxt7eSSHlFPfvQ7giQx5TBeZSOzt7Zx+wfLX018RQo+ofkZH7dg2q7soI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350416; c=relaxed/simple;
	bh=P5horLzv6/A4hicvzqakhrSCyfWKi/LeHFmHJuwv2xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aemHV2Cb2pPP0lhoiT9+A1lUBdukMmeAO8ULq/Z6KPbSlnXAbF1XL9+4KcT3CQhkUZDBQNSMryR1hNc7KVZlE+vxo7vf72yaBkuVd56cvVwpy70mRUQ5KQR4wk2Eik7E43X3X5Kwh0S3eAuCzGFIA3agXY7ilk526lOx2w9UXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DdQPyTtj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n7UZrwOk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DdQPyTtj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n7UZrwOk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DdQPyTtj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n7UZrwOk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DdQPyTtj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n7UZrwOk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 063DC1F388;
	Tue,  1 Jul 2025 06:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751350413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlfvjB9d2Gv85cI1GN991wjjxRveQOczlHidLkAg0HM=;
	b=DdQPyTtj7TbHcXlZUbPFmg5hyGfnYaBT+NrWPJUNXUvj1kujP15tq8cfY8OGs3AEuZ1FIq
	7dK0oN9zi/vYDqCdaJR2YSDpQHoRVhdwSOSB2B3xQW2B7LcRpHsLRvxL0VJVYSb40RbMLL
	BxY3hB+VYwLGV86lp3r8BJXrsrvGHeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751350413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlfvjB9d2Gv85cI1GN991wjjxRveQOczlHidLkAg0HM=;
	b=n7UZrwOkL2NOOYbqXTrar4jtWe8CZDiOgfj2Sz+P2CO0MWucYq46GNgoFqIz1GkdRDh97G
	+CP+cJg8mfJJMeDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751350413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlfvjB9d2Gv85cI1GN991wjjxRveQOczlHidLkAg0HM=;
	b=DdQPyTtj7TbHcXlZUbPFmg5hyGfnYaBT+NrWPJUNXUvj1kujP15tq8cfY8OGs3AEuZ1FIq
	7dK0oN9zi/vYDqCdaJR2YSDpQHoRVhdwSOSB2B3xQW2B7LcRpHsLRvxL0VJVYSb40RbMLL
	BxY3hB+VYwLGV86lp3r8BJXrsrvGHeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751350413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlfvjB9d2Gv85cI1GN991wjjxRveQOczlHidLkAg0HM=;
	b=n7UZrwOkL2NOOYbqXTrar4jtWe8CZDiOgfj2Sz+P2CO0MWucYq46GNgoFqIz1GkdRDh97G
	+CP+cJg8mfJJMeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFD6B1364B;
	Tue,  1 Jul 2025 06:13:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ot/gMIx8Y2ipawAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 06:13:32 +0000
Message-ID: <aa7c533b-38fc-44d0-981b-cd499cc20ac6@suse.de>
Date: Tue, 1 Jul 2025 08:13:32 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] ata: libata-core: Move device LPM quirk settings to
 ata_dev_config_lpm()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630062637.258329-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Level: 

On 6/30/25 08:26, Damien Le Moal wrote:
> Move the various cases of setting the ATA_QUIRK_NOLPM quirk flag for a
> device in ata_dev_configure() to the function ata_dev_config_lpm().
> This allows having all LPM related settings in one place to facilitate
> maintenance.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c | 43 +++++++++++++++++++++++----------------
>   1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0d85474f6640..fdce96fd3ffa 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2798,6 +2798,32 @@ static void ata_dev_config_lpm(struct ata_device *dev)
>   	struct ata_port *ap = dev->link->ap;
>   	unsigned int err_mask;
>   
> +	if (ap->flags & ATA_FLAG_NO_LPM) {
> +		/*
> +		 * When the port does not support LPM, we cannot support it on
> +		 * the device either.
> +		 */
> +		dev->quirks |= ATA_QUIRK_NOLPM;
> +	} else {
> +		/*
> +		 * Some WD SATA-1 drives have issues with LPM, turn on NOLPM for
> +		 * them.
> +		 */
> +		if ((dev->quirks & ATA_QUIRK_WD_BROKEN_LPM) &&
> +		    (dev->id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
> +			dev->quirks |= ATA_QUIRK_NOLPM;
> +
> +		/* ATI specific quirk */
> +		if ((dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI) &&
> +		    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
> +			dev->quirks |= ATA_QUIRK_NOLPM;
> +	}
> +
> +	if (dev->quirks & ATA_QUIRK_NOLPM) {
> +		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
> +		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
> +	}
> +
>   	/*
>   	 * If the device port does not support Device Initiated Power Management
>   	 * (DIPM), and the device supports this feature, disable it.
> @@ -2881,23 +2907,6 @@ int ata_dev_configure(struct ata_device *dev)
>   	if (rc)
>   		return rc;
>   
> -	/* some WD SATA-1 drives have issues with LPM, turn on NOLPM for them */
> -	if ((dev->quirks & ATA_QUIRK_WD_BROKEN_LPM) &&
> -	    (id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
> -		dev->quirks |= ATA_QUIRK_NOLPM;
> -
> -	if (dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI &&
> -	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
> -		dev->quirks |= ATA_QUIRK_NOLPM;
> -
> -	if (ap->flags & ATA_FLAG_NO_LPM)
> -		dev->quirks |= ATA_QUIRK_NOLPM;
> -
> -	if (dev->quirks & ATA_QUIRK_NOLPM) {
> -		ata_dev_warn(dev, "LPM support broken, forcing max_power\n");
> -		dev->link->ap->target_lpm_policy = ATA_LPM_MAX_POWER;
> -	}
> -
>   	/* let ACPI work its magic */
>   	rc = ata_acpi_on_devcfg(dev);
>   	if (rc)

And this now is only dealing with modifying LPM setting, independent on
any DIPM setting. Why not make two functions (one for DIPM and one for
LPM) so make matters less confusing?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
