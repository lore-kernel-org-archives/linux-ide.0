Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3D450F2
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351042; cv=none; b=OEB/Cf6DcbkUiWJOuDMJ/JCf5hc6BnVu4zZVutMFUwLT/HWgsvHcn5VKL0GZ9jM/umrs2LQqGRv3HKml2vRyN4EARygmDJ9CQWo/x4UXKMpmIoSvruncNMD0WFtAXQsbNzuCEcwuDv2X/C+ArrY7r6/ds41xT7Rx0lhxjrY/vTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351042; c=relaxed/simple;
	bh=l2rlY4J2xUKqR2bbW89pcQRI1P6W6TtdIc6QM0G1opc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O1jK/jEFpGDlQO+LCQKbJk6/nzSBbjIKaBtz8r4wPrAne8Y1+zKcWdMf1/H025RhPef2EulMpJ037aJPY1MrgkxyhsefrnbSImhGkodJbJaJpYadc2oriQuvcXklFF/7ElmGrlUFcjVwQLc9pUpJ+TQwQHAKFh7ywTuus8enusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IKk3bcbl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3u/CVGr8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IKk3bcbl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3u/CVGr8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IKk3bcbl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3u/CVGr8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IKk3bcbl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3u/CVGr8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6ECB81F388;
	Tue,  1 Jul 2025 06:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+6NZLanCuj3UMyHhRmIfrrsTjJlyeN8Z2s45fHcuJ4=;
	b=IKk3bcblHG/hyJjVelvzgN9x4/85+bzRZbEf09T2+iMJVL+PAR81ufdJ1dfQNq1/vxd6Qe
	ItONU+G/pXiiC5XEvbZNOYxWrBL1g1HBn4mEIafEXP3e09ztKM/3yhUVd5x1wAPFhtgN6p
	AyFxrvSxqxPdN+Mf4UiPcCnJ21boWiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+6NZLanCuj3UMyHhRmIfrrsTjJlyeN8Z2s45fHcuJ4=;
	b=3u/CVGr8p1uKmwMPLRag+wJd31+8yty92BHlNvayjoTCnRyNGnWNCqg8dYAHjwTgKzcoyE
	QbCcIndI/HhP3hBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+6NZLanCuj3UMyHhRmIfrrsTjJlyeN8Z2s45fHcuJ4=;
	b=IKk3bcblHG/hyJjVelvzgN9x4/85+bzRZbEf09T2+iMJVL+PAR81ufdJ1dfQNq1/vxd6Qe
	ItONU+G/pXiiC5XEvbZNOYxWrBL1g1HBn4mEIafEXP3e09ztKM/3yhUVd5x1wAPFhtgN6p
	AyFxrvSxqxPdN+Mf4UiPcCnJ21boWiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+6NZLanCuj3UMyHhRmIfrrsTjJlyeN8Z2s45fHcuJ4=;
	b=3u/CVGr8p1uKmwMPLRag+wJd31+8yty92BHlNvayjoTCnRyNGnWNCqg8dYAHjwTgKzcoyE
	QbCcIndI/HhP3hBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CF0A1364B;
	Tue,  1 Jul 2025 06:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 61ZLEf9+Y2h3bgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 06:23:59 +0000
Message-ID: <d2be8189-e5a0-4c37-9d66-b36dbaadda69@suse.de>
Date: Tue, 1 Jul 2025 08:23:58 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] ata: ahci: Disable DIPM if host lacks support
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-7-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630062637.258329-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Level: 

On 6/30/25 08:26, Damien Le Moal wrote:
> The AHCI specification version 1.3.1 section 8.3.1.4 (Software
> Requirements and Precedence) states that:
> 
> If CAP.SSC or CAP.PSC is cleared to ‘0’, software should disable
> device-initiated power management by issuing the appropriate SET
> FEATURES command to the device.
> 
> To satisfy this constraint and force ata_dev_configure to disable the
> device DIPM feature, modify ahci_update_initial_lpm_policy() to set the
> ATA_FLAG_NO_DIPM flag on ports that have a host with either the
> ATA_HOST_NO_PART flag set or the ATA_HOST_NO_SSC flag set.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/ahci.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 1b4151d95888..0760fa47d90e 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1780,6 +1780,13 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>   		return;
>   	}
>   
> +	/* If no Partial or no Slumber, we cannot support DIPM. */
> +	if ((ap->host->flags & ATA_HOST_NO_PART) ||
> +	    (ap->host->flags & ATA_HOST_NO_SSC)) {
> +		ata_port_dbg(ap, "Host does not support DIPM\n");
> +		ap->flags |= ATA_FLAG_NO_DIPM;
> +	}
> +
>   	/* If no LPM states are supported by the HBA, do not bother with LPM */
>   	if ((ap->host->flags & ATA_HOST_NO_PART) &&
>   	    (ap->host->flags & ATA_HOST_NO_SSC) &&

Reviewed-by: Hannes Reinecke <hare@suse.de.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
