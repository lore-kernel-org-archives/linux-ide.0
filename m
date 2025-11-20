Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034C2BE051
	for <linux-ide@vger.kernel.org>; Thu, 20 Nov 2025 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623500; cv=none; b=DqJ7Yhva3+7GET5DfnKi9YDG+D2qMgp5QTqgI7rOd7KjCMCRzxig4T78kTI83q+pkhAEcMbF3s5TmoiS9zyaVLGsBxP03QjqGoCkiltn5twcMYmwFDxivaMc/bVHXve4rbvHbeCrtQLAzrBcviELW2r2YxueVk2ENmv1D5AEhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623500; c=relaxed/simple;
	bh=a/5KjtR6Sz+vxOpfLdTWkuRow3sGA/2jQqH2da+5bFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=parvlnHfqaDep7mU35Q2X4EBUfEp3fN/Ab5JUEF+jRsmZ2HfuI+oGDbVvO8PliRRsppwglFohTJ7wUDvlaUosEA1zFpzNXJ73zzvioWdDEm4MKRzB0IQ/lw/wZSu5+98gUzN2HnVDdHEcahSWw9y3ZuR9ZZvaTVLgofi7FRjsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IkuIgbbm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QyWXbMgX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IkuIgbbm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QyWXbMgX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IkuIgbbm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QyWXbMgX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IkuIgbbm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QyWXbMgX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E319208DE;
	Thu, 20 Nov 2025 07:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763623496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiCbIrx27f6rMVSsZUylyJ9kgI1lk9zKh6ILNLG0VlE=;
	b=IkuIgbbmU3XttPKVlrSohoC0QniFWhccVPG50HqtErgQ4bipjlcLceupEJZfOxON9C6jfo
	Z7z+4AQhZCNYl2uQP70cu++7+qWq5+ErTi9UQsGeN4K5euZrrIOSKybfCeNWnc6nbFCUqS
	Y+2d2W2yl6fAN8W2QMTpZBWsHJ1uaxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763623496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiCbIrx27f6rMVSsZUylyJ9kgI1lk9zKh6ILNLG0VlE=;
	b=QyWXbMgXj699aXoL1yzmRVsFaVZl1ZG/gW9RGOtLHr8LLUZnKYp7pgKyNpCf/d0xU+bHAi
	ImdT/lIhs0sxQLBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IkuIgbbm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QyWXbMgX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763623496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiCbIrx27f6rMVSsZUylyJ9kgI1lk9zKh6ILNLG0VlE=;
	b=IkuIgbbmU3XttPKVlrSohoC0QniFWhccVPG50HqtErgQ4bipjlcLceupEJZfOxON9C6jfo
	Z7z+4AQhZCNYl2uQP70cu++7+qWq5+ErTi9UQsGeN4K5euZrrIOSKybfCeNWnc6nbFCUqS
	Y+2d2W2yl6fAN8W2QMTpZBWsHJ1uaxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763623496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiCbIrx27f6rMVSsZUylyJ9kgI1lk9zKh6ILNLG0VlE=;
	b=QyWXbMgXj699aXoL1yzmRVsFaVZl1ZG/gW9RGOtLHr8LLUZnKYp7pgKyNpCf/d0xU+bHAi
	ImdT/lIhs0sxQLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 210D23EA61;
	Thu, 20 Nov 2025 07:24:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pA/gBUjCHmmdKQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 20 Nov 2025 07:24:56 +0000
Message-ID: <dd977220-710d-4c8b-af89-b8de1a49c408@suse.de>
Date: Thu, 20 Nov 2025 08:24:55 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-core: Set capacity to zero for a security
 locked drive
To: Niklas Cassel <cassel@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: Ilia Baryshnikov <qwelias@gmail.com>, linux-ide@vger.kernel.org
References: <20251119141313.2220084-3-cassel@kernel.org>
 <20251119141313.2220084-4-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251119141313.2220084-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5E319208DE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 11/19/25 15:13, Niklas Cassel wrote:
> For Security locked drives (drives that have Security enabled, and have
> not been Security unlocked by boot firmware), the automatic partition
> scanning will result in the user being spammed with errors such as:
> 
>    ata5.00: failed command: READ DMA
>    ata5.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 7 dma 4096 in
>             res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>    ata5.00: status: { DRDY ERR }
>    ata5.00: error: { ABRT }
>    sd 4:0:0:0: [sda] tag#7 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>    sd 4:0:0:0: [sda] tag#7 Sense Key : Aborted Command [current]
>    sd 4:0:0:0: [sda] tag#7 Add. Sense: No additional sense information
> 
> during boot, because most commands except for IDENTIFY will be aborted by
> a Security locked drive.
> 
> For a Security locked drive, set capacity to zero, so that no automatic
> partition scanning will happen.
> 
> If the user later unlocks the drive using e.g. hdparm, the close() by the
> user space application should trigger a revalidation of the drive.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-core.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2a210719c4ce..f48fb63d7e85 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3006,6 +3006,16 @@ int ata_dev_configure(struct ata_device *dev)
>   		}
>   
>   		dev->n_sectors = ata_id_n_sectors(id);
> +		if (ata_id_is_locked(id)) {
> +			/*
> +			 * If Security locked, set capacity to zero to prevent
> +			 * any I/O, e.g. partition scanning, as any I/O to a
> +			 * locked drive will result in user visible errors.
> +			 */
> +			ata_dev_info(dev,
> +				"Security locked, setting capacity to zero\n");
> +			dev->n_sectors = 0;
> +		}
>   
>   		/* get current R/W Multiple count setting */
>   		if ((dev->id[47] >> 8) == 0x80 && (dev->id[59] & 0x100)) {

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
