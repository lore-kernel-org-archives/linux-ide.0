Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031813BAEE
	for <linux-ide@vger.kernel.org>; Mon, 11 Nov 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319285; cv=none; b=gttoJ3ZuumVBNlBdgM99bS+rKrQ+KGdWIavvSs7yBkkhwCJfDXa1wilfT1MB3urnQ/MH6WhEIjn1WrIpOUwtP2vTr2HJE5eMroeVGqN/54ji13WxPgySWbTgOCf5bPAc4cTouSoWSnqJK9td7UmG0z6wJHobOEm+CCEpg8Z/axM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319285; c=relaxed/simple;
	bh=aklsb0FcICJvqRhYWVWmAaZCB8sGB+IFNizswaN+kXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jg83ar2XABqwvor8w6BQu5DK1ulYlyL0rEzaTuj+eQJ9d8NfAuuCWYGHArvseYUQWtPKFIZ+VD6XDtABXuSc8pnyOuoRS+FG9DnzfqWqRUzffml1MU6C6Gmapcyq0lXWb17SEwHJUKIbG7+S+VEAkrqT3C63QyhynUx5EzwRzK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kYG2w1FT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JKGpB4Lo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kYG2w1FT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JKGpB4Lo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kYG2w1FT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JKGpB4Lo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kYG2w1FT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JKGpB4Lo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4F181F38E;
	Mon, 11 Nov 2024 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBi0JrjZprabeQM3O2jgdQIzrQgPeJQF2K25sEb0+pc=;
	b=kYG2w1FTSSAS2sqKEcycI0EVp/28XLGmkrR6Gb5QmInEy73RAyuN+//SvQCEPY+zzGi8nW
	nxNLsW6T94lHWguBEqEgQpU8w3EvUaGq6jxBcao9YirG3MUx1gFJLHXgy0zDJgxFLb7+f9
	pPqcAs4e1IEGSu1XmnDCa0+Rxmc0RY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBi0JrjZprabeQM3O2jgdQIzrQgPeJQF2K25sEb0+pc=;
	b=JKGpB4LowI30o7TQJQCf7+OZ4k4r3//GxHNF1uGYPz+KAUhWlmCVaM0+W6D1Su8f11MRcK
	+crR94KnBO9BnYBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBi0JrjZprabeQM3O2jgdQIzrQgPeJQF2K25sEb0+pc=;
	b=kYG2w1FTSSAS2sqKEcycI0EVp/28XLGmkrR6Gb5QmInEy73RAyuN+//SvQCEPY+zzGi8nW
	nxNLsW6T94lHWguBEqEgQpU8w3EvUaGq6jxBcao9YirG3MUx1gFJLHXgy0zDJgxFLb7+f9
	pPqcAs4e1IEGSu1XmnDCa0+Rxmc0RY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBi0JrjZprabeQM3O2jgdQIzrQgPeJQF2K25sEb0+pc=;
	b=JKGpB4LowI30o7TQJQCf7+OZ4k4r3//GxHNF1uGYPz+KAUhWlmCVaM0+W6D1Su8f11MRcK
	+crR94KnBO9BnYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D300413301;
	Mon, 11 Nov 2024 10:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id naCJMfHVMWfIDwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 Nov 2024 10:01:21 +0000
Message-ID: <42a81ca2-01b5-42b6-b441-42b0a552b0ca@suse.de>
Date: Mon, 11 Nov 2024 11:01:21 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ata: pata_cs5530: use pr_*() instead of
 printk(KERN_*)
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
 <0d4048ed-8256-4c5f-9b6d-7e68786fa7cd@omp.ru>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <0d4048ed-8256-4c5f-9b6d-7e68786fa7cd@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/8/24 21:21, Sergey Shtylyov wrote:
> The CS5530 PCI device driver still calls printk(KERN_INFO, ...) in
> cs5530_is_palmax() and printk(KERN_ERR, ...) in cs5530_init_chip() --
> convert them to calling pr_info() and pr_err() respectively...
> 
> This helpfully fixes the following complaints from scripts/checkpatch.pl:
> 
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
> dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
> 
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
> dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
>   drivers/ata/pata_cs5530.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
> index 1e67b0f8db43..4ff98c4722e9 100644
> --- a/drivers/ata/pata_cs5530.c
> +++ b/drivers/ata/pata_cs5530.c
> @@ -177,7 +177,7 @@ static const struct dmi_system_id palmax_dmi_table[] = {
>   static int cs5530_is_palmax(void)
>   {
>   	if (dmi_check_system(palmax_dmi_table)) {
> -		printk(KERN_INFO "Palmax PD1100: Disabling DMA on docking port.\n");
> +		pr_info("Palmax PD1100: Disabling DMA on docking port.\n");
>   		return 1;
>   	}
>   	return 0;
> @@ -206,11 +206,11 @@ static int cs5530_init_chip(void)
>   		}
>   	}
>   	if (!master_0) {
> -		printk(KERN_ERR DRV_NAME ": unable to locate PCI MASTER function\n");
> +		pr_err(DRV_NAME ": unable to locate PCI MASTER function\n");
>   		goto fail_put;
>   	}
>   	if (!cs5530_0) {
> -		printk(KERN_ERR DRV_NAME ": unable to locate CS5530 LEGACY function\n");
> +		pr_err(DRV_NAME ": unable to locate CS5530 LEGACY function\n");
>   		goto fail_put;
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
