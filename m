Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA924503F
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351020; cv=none; b=uAuummAl1beqPwZ7V0VdxQtpwowfrMySPlcH8Zse6sEglZnf/dDOUb5T+N2xs+D/+ZnZTHlBhX16JzfFBt2BwleEpnzgp8SuOtDFWaV6sokItJxAUaNKAkHAyCeYXypH8+7N7MvyR60mzBtFN+BDlEui3L2dUXt8jzYtAxTn9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351020; c=relaxed/simple;
	bh=FPLO3wY3CJEq+wwK2hV1tOtuqCaFmrvqSUOsBdgzTM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rk9xOLl35dZFX2HoLc1+ZoIbkorHbXngepqzSbdkaJforLbR83syH64Z91QXf3+9AxEN4F631LGKLUG1m7oYau5oXUO6CR+2xGFYa+w85ToVqsNpG4sp8kdTl40osXe5GMVqufil/NbrGzoGFrsPC2EM0SQT1YcDgfe9MvWx/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J14tDEx0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q+VPf/S3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TkVFkQQs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=88s02OSB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J14tDEx0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q+VPf/S3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TkVFkQQs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="88s02OSB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4BA621162;
	Tue,  1 Jul 2025 06:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBjTg8X5xfpeBqaMGfOqFwC4JyVKmyL1vpyrXVA9ITY=;
	b=J14tDEx0SOk4gfLPwuoEUHk1sKXTmII0gIBeqvVJYtFZFefOoGIlkl442/oa/rCjOS8p7i
	VVSeG3R4HwfFc3h+a4NobhkG03NY3g8S/Aak+SotdNXkjs9G6mqLxhSDBXBMkYtQ0a/mt/
	ML/L7LyqKw6kstPhJL/+4iNw2Me/mPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBjTg8X5xfpeBqaMGfOqFwC4JyVKmyL1vpyrXVA9ITY=;
	b=Q+VPf/S3Sp8ukdOdS/iRr60J+ISjM932d3SOPGcIkYwsJKRwXTE52R/znz+SDYJZPRwTpU
	8OFwXy6xbW7DVuAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TkVFkQQs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=88s02OSB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751351013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBjTg8X5xfpeBqaMGfOqFwC4JyVKmyL1vpyrXVA9ITY=;
	b=TkVFkQQswctZX1uE/QTyHB/av0Md1AI/aH+pDxBUBiXgglnNfWOPagRPs0FCopHSGPUKq3
	OQqL0FOF7s9jWpZTOy7IgAfvCoCWgujX7DQs0zo/HgNs0EpTASDCtOeGaaYODQTUS6yLf9
	SLWtgSWe37pWBzcp57VbcRLQ2Pz9HpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751351013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBjTg8X5xfpeBqaMGfOqFwC4JyVKmyL1vpyrXVA9ITY=;
	b=88s02OSBxGOlubTth6J2NRMzQylaCgoHHHfIieBpAjLVVM15EkLwpsGUOYsfTN0eCOuX7s
	gB0dF6uB+cmxJGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 847BB1364B;
	Tue,  1 Jul 2025 06:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FWfBHeV+Y2hQbgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Jul 2025 06:23:33 +0000
Message-ID: <c85cbb55-0b68-4315-b3b4-e6d6e04b3c23@suse.de>
Date: Tue, 1 Jul 2025 08:23:33 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] ata: libata-sata: Disallow changing LPM state if
 not supported
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-6-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630062637.258329-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A4BA621162
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 6/30/25 08:26, Damien Le Moal wrote:
> Modify ata_scsi_lpm_store() to return an error if a user attempts to set
> a link power management policy for a port that does not support LPM,
> that is, ports flagged with ATA_FLAG_NO_LPM.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-sata.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index cb46ce276bb1..47169c469f43 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -924,6 +924,11 @@ static ssize_t ata_scsi_lpm_store(struct device *device,
>   
>   	spin_lock_irqsave(ap->lock, flags);
>   
> +	if (ap->flags & ATA_FLAG_NO_LPM) {
> +		count = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}
> +
>   	ata_for_each_link(link, ap, EDGE) {
>   		ata_for_each_dev(dev, &ap->link, ENABLED) {
>   			if (dev->quirks & ATA_QUIRK_NOLPM) {

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
