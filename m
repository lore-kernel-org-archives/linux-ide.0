Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0413AD20
	for <linux-ide@vger.kernel.org>; Mon, 11 Nov 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319352; cv=none; b=BT8c+iQ9+EUJW2+UaEmxqtP0Be8QXD5WgiNJJSpwFOE3Hyu2iHv+haAjAKFb9PVPO9JRgyJJp8IooAlnnFb+OLk56XmBDkUnhPk729Gson7+q9r+qJsc9aN8juVH9GRXCK+g0cbtDvicYZ6o+jedEQd0hJfvcbYELcA5whgXcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319352; c=relaxed/simple;
	bh=u69UuEI7s3FBJLkMJIsKKXesbPG9i1eBo08LSIhQjy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lkhNDnka0f9lpFTUcFQeyOk4f4ZJKmNB2kfpppCS4aEs0n5//RwynwWQk2kbA7Ww5sgMSlhHWP4CFJ9tS614TlvcMeJf1Rh6xbeELdcJXs2qRqBqGEsNGL3ZNflWZnr4MvAknipLut6P/JrhF37WOowV9/yAnDlpT7CwXgIvYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HukOsNsA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IUITeaNW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YzUAGtij; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oS7Xq+X/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HukOsNsA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IUITeaNW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YzUAGtij";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oS7Xq+X/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5CCE1F38E;
	Mon, 11 Nov 2024 10:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdgv5lsjmyynNwwoDQYhTP1fiiDIHmDdPS45HRi4MT4=;
	b=HukOsNsAZ/Dz9rV/NK3M6sb/G2tdmceTGiktGPWQ8K23XYjixRgu4gV59MzBxvQDrVAUwE
	hiAo6H4wJhSjFCeTw0mshAwD3Gfvd7KUusw5Aky/gZ6JniqG654BdocumGDwpUrbsEoNjZ
	Cf8rxAWr3sfO5kMfscuUCzV6XiA2mfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdgv5lsjmyynNwwoDQYhTP1fiiDIHmDdPS45HRi4MT4=;
	b=IUITeaNWLV/zwJLI7QBBuG56YwhRe/qx2itX/2SxV5njh0tmlB9c/Ex8j5M0m7w4lE6y4x
	IhYC3TRoCgvUrtAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YzUAGtij;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="oS7Xq+X/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdgv5lsjmyynNwwoDQYhTP1fiiDIHmDdPS45HRi4MT4=;
	b=YzUAGtijsgDxiq7teML6uMM8ItYsV31Jeb/+zaOri8cz8eOiq8h60bWGc0Wruy1QDjQh9J
	/kUy/pne24sLA38dgQ5Akou2uo1kDv64l2wO2byoJlael1Yvby50a92HHF5YUul5dxfiI1
	RWuSNlXkVn9I9EFe9qyJ2j0xYnAeS4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdgv5lsjmyynNwwoDQYhTP1fiiDIHmDdPS45HRi4MT4=;
	b=oS7Xq+X/QxUwGQ0m/ipPMqAiHRANB70/aR+ObYttP93RoYNn4FmRH7/iIEGiSODdz+f7bv
	X1JdgXXTtqlf2FCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB86913301;
	Mon, 11 Nov 2024 10:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ITESMTHWMWchEAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 Nov 2024 10:02:25 +0000
Message-ID: <d0abe8af-6bbd-4176-9706-920684a8935a@suse.de>
Date: Mon, 11 Nov 2024 11:02:25 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] ata: pata_optidma: use dev_warn() instead of
 printk(KERN_WARNING)
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
 <0a19e2e7-b33c-4fb2-9183-33855337097d@omp.ru>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <0a19e2e7-b33c-4fb2-9183-33855337097d@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5CCE1F38E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/8/24 21:26, Sergey Shtylyov wrote:
> The OPTi PCI device driver still calls printk(KERN_WARNING, ...) in
> optiplus_with_udma() -- convert it to calling pr_warn()...
> 
> This helpfully fixes the following complaints from scripts/checkpatch.pl:
> 
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
> dev_warn(dev, ... then pr_info(...  to printk(KERN_WARNING ...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
>   drivers/ata/pata_optidma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
> index dfc36b4ec9c6..23e2326ce31e 100644
> --- a/drivers/ata/pata_optidma.c
> +++ b/drivers/ata/pata_optidma.c
> @@ -390,7 +390,7 @@ static int optiplus_with_udma(struct pci_dev *pdev)
>   	if (r & 0x80)	/* IDEDIR disabled */
>   		ret = 1;
>   done:
> -	printk(KERN_WARNING "UDMA not supported in this configuration.\n");
> +	dev_warn(&pdev->dev, "UDMA not supported in this configuration.\n");
>   done_nomsg:		/* Wrong chip revision */
>   	pci_dev_put(dev1);
>   	return ret;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
