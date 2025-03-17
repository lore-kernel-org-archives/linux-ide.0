Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD23199E8D
	for <linux-ide@vger.kernel.org>; Mon, 17 Mar 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211519; cv=none; b=hlhaUvWxCQKLjt016iImwyxFphANogZTkPjpaSDVfimnUhdBkFLPw2d5c5gP2EJv4Mor0GJetc/GDnhiJXB0zx5GRBQpLK3CABGG4FWiBFydek0QPCGyw1LE0SVUrX7Xv1hJCsxuIKaZF4GCpSf7xSMua6h0IN9yIZLMCto/ZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211519; c=relaxed/simple;
	bh=1Yor08hmBReW8kIED0Yw4s4I4PhyNdLAQTt49zRIxp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyDiuK+NnlZHxpT8F3gFkGy5/2Tq7CwDex+OT/ucjUPKRgdNRTdfX83JQsjaZDIZM0E71wWcHDSTEZJ2DjNmFcaqeBnar0RJRoZI/Q1mvoITZLaY212ZItKeTtNx25qAtAucj9rZuYJpkMDaY6w6eRh6NLDeD2kZekoSITrODC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QrVFSYGv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+NzTFZnM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fse4+k8g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eTQkzS8g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QrVFSYGv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+NzTFZnM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fse4+k8g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eTQkzS8g"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D976C21BCB;
	Mon, 17 Mar 2025 11:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742211516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+f37SlrTSS9+rZB+EFxJGz8Pt3r7L4HX/5HvvgL9Gfo=;
	b=QrVFSYGvY3ngqYe6KhJLpJr47JrZqrHP/a91efHG0NoJcYiYkW2hU9I9ZIRMVvaSmOfge+
	NI4n+Kd1NflWLEz4sucErUFTXUaRRF5R0wA3Nt+qfAXxUmLlFyunq+4H17nUBgAm390p0K
	pbhGCiRtLHTTfz5sN5GH3tGrFamRoKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742211516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+f37SlrTSS9+rZB+EFxJGz8Pt3r7L4HX/5HvvgL9Gfo=;
	b=+NzTFZnMbZcBCYDoyvJUskXuRhT0VDX7B5XdfDu8gTcV8A5plPZax3dQkhrXe6BKKGsByw
	t4ZlgbFZDA55CdDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fse4+k8g;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eTQkzS8g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742211515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+f37SlrTSS9+rZB+EFxJGz8Pt3r7L4HX/5HvvgL9Gfo=;
	b=fse4+k8g+mCo+O2Oe07xqggZQBg3Q+lI53CUKITXv7nLYldHqX/WXh7HM+hHO7FCtEIpi7
	TqvQ1/xIaYwGAR2e0rwxr560Lh+YOj5rgNmzuHknUMKIu6eF9r0X6iK19DDldBA+hbjYo0
	CBSgRmIFocckpuVh0Idmq1EtpVNyC/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742211515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+f37SlrTSS9+rZB+EFxJGz8Pt3r7L4HX/5HvvgL9Gfo=;
	b=eTQkzS8gZov/VE7TQLY8LD3lje4B9s51sEnrH/GD4oVB0A924uKR1grgNdwfF2GHcExcbG
	8P5CgysA9T54QhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2BF6132CF;
	Mon, 17 Mar 2025 11:38:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +38tLrsJ2Ge1OAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 17 Mar 2025 11:38:35 +0000
Message-ID: <be6ed8ef-4f34-45a1-a18a-9504d0a7b809@suse.de>
Date: Mon, 17 Mar 2025 12:38:35 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: Fix NCQ Non-Data log not supported print
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20250317111754.1666084-2-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250317111754.1666084-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D976C21BCB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/17/25 12:17, Niklas Cassel wrote:
> Currently, both ata_dev_config_ncq_send_recv() - which checks for NCQ
> Send/Recv Log (Log Address 13h) and ata_dev_config_ncq_non_data() -
> which checks for NCQ Non-Data Log (Log Address 12h), uses the same
> print when the log is not supported:
> 
>    "NCQ Send/Recv Log not supported"
> 
> This seems like a copy paste error, since NCQ Non-Data Log is actually
> a separate log.
> 
> Fix the print the reference the correct log.
> 
> Fixes: 284b3b77ea88 ("libata: NCQ encapsulation for ZAC MANAGEMENT OUT")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 193fc3942fd3a..e17e16706db70 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2274,7 +2274,7 @@ static void ata_dev_config_ncq_non_data(struct ata_device *dev)
>   
>   	if (!ata_log_supported(dev, ATA_LOG_NCQ_NON_DATA)) {
>   		ata_dev_warn(dev,
> -			     "NCQ Send/Recv Log not supported\n");
> +			     "NCQ Non-Data Log not supported\n");
>   		return;
>   	}
>   	err_mask = ata_read_log_page(dev, ATA_LOG_NCQ_NON_DATA,

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
