Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAD25BF0E
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351238; cv=none; b=mhpOr4TaxMGuP+Ssu/EDm+Eq+nObAPJsXIXu6MlQKrMPgRiuknECklWH4RFjZUT7ToWrlOyEtRzrJnokh+tOR1E7Yvw6vPTkEW9nhvThxjRIlQaAZXxk+lTLxKh9Uxip9Hw3dFPFlzQNYwhB7U4+AZvr68pzvjIZW5JZM9fG/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351238; c=relaxed/simple;
	bh=jCPjvFEhm6N+yBaqBfR/haCHyDeIxN7hbLEkF9mmXdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JfPVtzb30DhDBUaQF8tzjIQxVy/hzE/n7PXv6sOvJIhYv6wox9EnfXBHn6v+EVRNs0roIcX+ZvgGSTXr6wL1WZDxC3u2m6fddCO9ty4fmDTc+3PZ4rhYgDXEwt1iLTazkm0Rd8c5ZMuIfTVCvyH6hWWEs5kh3z0oZzV3R68gFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wFUeloro; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5WlU63B0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wFUeloro; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5WlU63B0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wFUeloro";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5WlU63B0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wFUeloro";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5WlU63B0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEB151F388;
	Tue,  1 Jul 2025 06:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BHM3uYRXqEmbM/spMvfIpwmFMlGrutZZ3mmiSQyntA=;
	b=wFUeloroQcU8a0K+dKZlXsMR5UoIWd9GJpQll7ZxqjwD/E/NxYmWcRsBJARFb9wMm6YK6z
	m/G35qZZL/vpmp161C+lNXv5SCGEKPcz3xcajFYkIHaCoZADXfZxxT29rzW8V/3SKHW6sw
	CQh8TRoYHmYjhPBR1EXHK6CYnHQsVXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BHM3uYRXqEmbM/spMvfIpwmFMlGrutZZ3mmiSQyntA=;
	b=5WlU63B025925SZzCFgLxA50VOOILJj8x3h/Kl6xRnod2fAGS3pJzLlehWMwYv8Zz2SptF
	AYxiQfussQ8BS2AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BHM3uYRXqEmbM/spMvfIpwmFMlGrutZZ3mmiSQyntA=;
	b=wFUeloroQcU8a0K+dKZlXsMR5UoIWd9GJpQll7ZxqjwD/E/NxYmWcRsBJARFb9wMm6YK6z
	m/G35qZZL/vpmp161C+lNXv5SCGEKPcz3xcajFYkIHaCoZADXfZxxT29rzW8V/3SKHW6sw
	CQh8TRoYHmYjhPBR1EXHK6CYnHQsVXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BHM3uYRXqEmbM/spMvfIpwmFMlGrutZZ3mmiSQyntA=;
	b=5WlU63B025925SZzCFgLxA50VOOILJj8x3h/Kl6xRnod2fAGS3pJzLlehWMwYv8Zz2SptF
	AYxiQfussQ8BS2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6350E1364B;
	Tue,  1 Jul 2025 06:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qKn2E8B/Y2hmbwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 06:27:12 +0000
Message-ID: <debe65e3-eb9c-465c-8568-618dcda5219b@suse.de>
Date: Tue, 1 Jul 2025 08:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] ata: libata_eh: Add debug messages to
 ata_eh_link_set_lpm()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-11-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630062637.258329-11-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 6/30/25 08:26, Damien Le Moal wrote:
> To facilitate field debugging of link power management related issues,
> add a debug message to ata_eh_link_set_lpm() to easily track LPM policy
> changes done from EH context, that is, during device scan and
> revalidation, error handling, and when a policy change is issued through
> a host sysfs link_power_management_policy attribute.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-eh.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7f5d13f9ca73..7134a4ff6535 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2140,6 +2140,9 @@ static int ata_eh_link_set_lpm(struct ata_link *link,
>   	if (WARN_ON_ONCE(policy == ATA_LPM_UNKNOWN))
>   		return 0;
>   
> +	ata_link_dbg(link, "Set LPM policy: %d -> %d\n",
> +		     old_policy, policy);
> +
>   	/*
>   	 * DIPM is enabled only for ATA_LPM_MIN_POWER,
>   	 * ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MED_POWER_WITH_DIPM, as

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
