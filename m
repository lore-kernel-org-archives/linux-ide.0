Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F263450F2
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351093; cv=none; b=np/X93OhyGc401Pqiuc7we15yNse87lN4pHo4t+iwoGmzTnMoiihZEsORWY9BWFoJcCp7fd1nYuDoaBLjqrOQWYXTPwy2X9zOP1L+19pBPadjxXZfQ2MxlqyMspYOvkIuKEir3Yj3jVbL3vu8L5jczx3QTz9Gt/5jXRym651vO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351093; c=relaxed/simple;
	bh=rfbzgmzyl2dR1Db4M9uobViaqldoFfrzjx4h9/o7g9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OINHOeW6FR+JjudK0oNYcx0Cx2wlPcomp8mbUwqriwODoxpyVU3wPUpUkaXg0G17Br9PAfVF7tddFOcoekKCk/nYRReii/AcCflWn44n34QOQMJbrRQKLoNNyEov3IBG+4Gl9S2B3e9Z7FDxk8eFyHcCpw8NmWhDZCdOgLDsS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tbsk8y8z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PDe1JqDp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tbsk8y8z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PDe1JqDp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tbsk8y8z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PDe1JqDp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tbsk8y8z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PDe1JqDp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A06C121162;
	Tue,  1 Jul 2025 06:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTqRwlWSDCQhbxHTPyDwdxo9ooVAp3FLDNDEKzzI7s0=;
	b=tbsk8y8ztuDkS0vqPNnyNSm9fSEobSdHgSqy57zfztGJ/7R9haPrk1J/Wn64yX4qdA11Sw
	H2aXaK+olLu0C4k6Wa5VtsAapJZWOy1pAUrN6TbVU5pxx/UfrwOKdGdQGmoU1f6dCdrR5c
	pMq4mjCPjE5QDm30WZvWW8WoqwC7ZWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTqRwlWSDCQhbxHTPyDwdxo9ooVAp3FLDNDEKzzI7s0=;
	b=PDe1JqDpr1D8S0WNrlRDFfXaviPyhZ7UBLWFcoJ9R6UHQ8aZSRsHRVii2xsKpCS36I44YO
	TMcog6JUPhqWCBDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tbsk8y8z;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PDe1JqDp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTqRwlWSDCQhbxHTPyDwdxo9ooVAp3FLDNDEKzzI7s0=;
	b=tbsk8y8ztuDkS0vqPNnyNSm9fSEobSdHgSqy57zfztGJ/7R9haPrk1J/Wn64yX4qdA11Sw
	H2aXaK+olLu0C4k6Wa5VtsAapJZWOy1pAUrN6TbVU5pxx/UfrwOKdGdQGmoU1f6dCdrR5c
	pMq4mjCPjE5QDm30WZvWW8WoqwC7ZWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTqRwlWSDCQhbxHTPyDwdxo9ooVAp3FLDNDEKzzI7s0=;
	b=PDe1JqDpr1D8S0WNrlRDFfXaviPyhZ7UBLWFcoJ9R6UHQ8aZSRsHRVii2xsKpCS36I44YO
	TMcog6JUPhqWCBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E6211364B;
	Tue,  1 Jul 2025 06:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2eoHFTJ/Y2i2bgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 06:24:50 +0000
Message-ID: <12b2e64c-3c8c-48f6-bfc4-c3732deb06df@suse.de>
Date: Tue, 1 Jul 2025 08:24:49 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] ata: ahci: Disallow LPM policy control for external
 ports
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-8-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630062637.258329-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A06C121162
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Level: 

On 6/30/25 08:26, Damien Le Moal wrote:
> Commit ae1f3db006b7 ("ata: ahci: do not enable LPM on external ports")
> added an early return in ahci_update_initial_lpm_policy() for all
> ports flagged as external with the ATA_PFLAG_EXTERNAL port flag (e.g.
> eSATA ports or hotplug capable ports) so that the target_lpm_policy of
> these ports is unchanged and set to ATA_LPM_UNKNOWN. thus forcing libata
> EH to not be called for external port. The goal of this change is to
> preserve the initial power management policy to not break the hotplug
> capability of external ports.
> 
> However, this change is incomplete as users or system daemon (e.g.
> systemd-udevd) can still apply the system preferred power management
> policy through sysfs, thus potentially unknowingly breaking the port
> hotplug capability.
> 
> Modify ahci_update_initial_lpm_policy() to flag external ports with
> ATA_FLAG_NO_LPM to prevent changes to the LPM policy by users through
> the sysfs link_power_management_policy host attribute. Also set the
> target_lpm_policy of external ports to ATA_LPM_MAX_POWER to ensure
> that the port is not in a low power state preventing hotplug operations.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/ahci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 0760fa47d90e..34698ae39f55 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1776,7 +1776,9 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>   	 * LPM if the port advertises itself as an external port.
>   	 */
>   	if (ap->pflags & ATA_PFLAG_EXTERNAL) {
> -		ata_port_dbg(ap, "external port, not enabling LPM\n");
> +		ata_port_warn(ap, "External port, forcing LPM max_power\n");
> +		ap->flags |= ATA_FLAG_NO_LPM;
> +		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
>   		return;
>   	}
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
