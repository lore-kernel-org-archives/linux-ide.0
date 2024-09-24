Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD5182A0
	for <linux-ide@vger.kernel.org>; Tue, 24 Sep 2024 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160284; cv=none; b=CLMDvjCbnZHc/shiJQ8hkuZVCiTs7JyDv7j8xBP4FknTdrOdNLyZ4fNDZ14JAUIOSbICDHkylr3O0cOxfQrfVJO0H0XVDvNlf3kb4NPW6iKdQHenN+bSKi3SJS4MrBOt85YZwijFWmBOKBBCkHaJ1YvEoq76T+xKNoXVhIh7+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160284; c=relaxed/simple;
	bh=bB8UBbcikaJYUZk9HLeSThDG+4qob58Zi561AgHYVPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hcQPI+XrHa2cni5D17muy9cUFrztBSEDliYo6+SHoEpQqQPvaPAm+U6vku7Iv42Jha4Pcz5NxLEwCB2bN3yhsOdGmCJ0V3SkFMuRhtB5sXu7O4uzgB4T3nb8gmHYKlDhe7JSGa0Ouuu+jb5yDObXBfhx4uQ6U4dONwKAtzQeO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bQ/uARU3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N7aL6dyc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bQ/uARU3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N7aL6dyc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bQ/uARU3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N7aL6dyc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bQ/uARU3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N7aL6dyc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 008CD1F78B;
	Tue, 24 Sep 2024 06:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727160281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5oDQYzd4wV23qft3PGw38wstta/uf90eMnOMaBeHoc=;
	b=bQ/uARU3V5mk/4NMNqeVI9mZ2528Xfp1zH/UBiksy+v+/1sgvau9lO4wGImRyWpa6Lj92N
	jrHdN+W7OKIT/BHBh1DixwRYCpY6IMV2+whX4vNp7hY//I2Smo9JZNXbPoCoRqLEbafsBb
	c4lzcqqqJC92dqSOSoK8KIDUZVI/OMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727160281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5oDQYzd4wV23qft3PGw38wstta/uf90eMnOMaBeHoc=;
	b=N7aL6dycPsFWN4kxQn38gFG4YKgGJKtH8r8/ZecV+ajQGS7inrfmGZPd8Phb3GgzQQPQB6
	YD9iXr+dUxGYhCDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="bQ/uARU3";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N7aL6dyc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727160281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5oDQYzd4wV23qft3PGw38wstta/uf90eMnOMaBeHoc=;
	b=bQ/uARU3V5mk/4NMNqeVI9mZ2528Xfp1zH/UBiksy+v+/1sgvau9lO4wGImRyWpa6Lj92N
	jrHdN+W7OKIT/BHBh1DixwRYCpY6IMV2+whX4vNp7hY//I2Smo9JZNXbPoCoRqLEbafsBb
	c4lzcqqqJC92dqSOSoK8KIDUZVI/OMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727160281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+5oDQYzd4wV23qft3PGw38wstta/uf90eMnOMaBeHoc=;
	b=N7aL6dycPsFWN4kxQn38gFG4YKgGJKtH8r8/ZecV+ajQGS7inrfmGZPd8Phb3GgzQQPQB6
	YD9iXr+dUxGYhCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAF211386E;
	Tue, 24 Sep 2024 06:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NIlZJdhf8ma4VwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Sep 2024 06:44:40 +0000
Message-ID: <a107b642-e187-4efa-872b-8e42733de337@suse.de>
Date: Tue, 24 Sep 2024 08:44:40 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-scsi: Fix ata_msense_control() CDL page
 reporting
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240923133949.286295-1-dlemoal@kernel.org>
 <20240923133949.286295-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240923133949.286295-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 008CD1F78B
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 9/23/24 15:39, Damien Le Moal wrote:
> When the user requests the ALL_SUB_MPAGES mode sense page,
> ata_msense_control() adds the CDL_T2A_SUB_MPAGE twice instead of adding
> the CDL_T2A_SUB_MPAGE and CDL_T2B_SUB_MPAGE pages information. Correct
> the second call to ata_msense_control_spgt2() to report the
> CDL_T2B_SUB_MPAGE page.
> 
> Fixes: 673b2fe6ff1d ("scsi: ata: libata-scsi: Add support for CDL pages mode sense")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 97c84b0ec472..ea7d365fb7a9 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2350,7 +2350,7 @@ static unsigned int ata_msense_control(struct ata_device *dev, u8 *buf,
>   	case ALL_SUB_MPAGES:
>   		n = ata_msense_control_spg0(dev, buf, changeable);
>   		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2A_SUB_MPAGE);
> -		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2A_SUB_MPAGE);
> +		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2B_SUB_MPAGE);
>   		n += ata_msense_control_ata_feature(dev, buf + n);
>   		return n;
>   	default:
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

