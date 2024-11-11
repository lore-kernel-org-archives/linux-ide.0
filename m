Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2020B22
	for <linux-ide@vger.kernel.org>; Mon, 11 Nov 2024 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319257; cv=none; b=UnGlXM8EmecpjBZzqwAZgzPcdhnuD/mycsRaMbAiyaA+Um3J3cxjLDJ+6P0mWEC0Bnbaj6jiqMQokeQBhoPm57d2Y/+jgEaArTWqs90RXut2fYVeBk1EjkPbm9rnaKl5wu9hHikkGi0DPhQkfnOTpHPvXCO0mEZGRvtzeQcXC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319257; c=relaxed/simple;
	bh=ix2g+FBOAdV00cCZjtTV0ChmS3JzXE6f6lqxFPQDi90=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fq7fjXDbtryQn45qmE5KtUnHYVcjLknpN7Eb+XTqNp+o31bVoZ7W5jQokdxNQjpzF6lpNM/b9j+0TfnmszGjKAOU8kfR1C0caxBLM6JqlojNxYR7iNVbbHrq7aCaMHEyCBg1uxr7wrVn99bGqMHeRzwEsMEhc3bFZ6wNJYYSEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h/QEvV5J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6vzbSw2s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h/QEvV5J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6vzbSw2s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h/QEvV5J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6vzbSw2s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h/QEvV5J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6vzbSw2s"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C16D1F38F;
	Mon, 11 Nov 2024 10:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSSCWbNx3vcgj938fd/u8OwqXuuvX/BA+xEvv69CFhc=;
	b=h/QEvV5JM//RwEPg/43kYLmKEmptFoVGG41OwIexCTPR3iI1g2hTpM2GNeHKI/hcQPlquk
	AxkpbEcXlA01lQBYYMVUxbWVhc4O5JVaDC//WTvc/uLaENpSahrgYeX4TPgTazJ7L61eKv
	gu9gu2WCWt8QfDw6+SNdYLPRI/V1cMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSSCWbNx3vcgj938fd/u8OwqXuuvX/BA+xEvv69CFhc=;
	b=6vzbSw2s01Gwm+TtShMukAifyl+mdL6o7C0qpdIjohk57jOV5+y3njInFoSP3mQuWcNbKr
	9rys5XTLgd2rNcBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSSCWbNx3vcgj938fd/u8OwqXuuvX/BA+xEvv69CFhc=;
	b=h/QEvV5JM//RwEPg/43kYLmKEmptFoVGG41OwIexCTPR3iI1g2hTpM2GNeHKI/hcQPlquk
	AxkpbEcXlA01lQBYYMVUxbWVhc4O5JVaDC//WTvc/uLaENpSahrgYeX4TPgTazJ7L61eKv
	gu9gu2WCWt8QfDw6+SNdYLPRI/V1cMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSSCWbNx3vcgj938fd/u8OwqXuuvX/BA+xEvv69CFhc=;
	b=6vzbSw2s01Gwm+TtShMukAifyl+mdL6o7C0qpdIjohk57jOV5+y3njInFoSP3mQuWcNbKr
	9rys5XTLgd2rNcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E74FF13301;
	Mon, 11 Nov 2024 10:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r3WhN9XVMWenDwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 Nov 2024 10:00:53 +0000
Message-ID: <61c90192-9d67-4588-8ce8-00796e5f5891@suse.de>
Date: Mon, 11 Nov 2024 11:00:53 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ata: libata-core: use pr_warn() instead of
 printk(KERN_WARNING)
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
 <813b22ec-a16d-4598-8c61-6522ced1116e@omp.ru>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <813b22ec-a16d-4598-8c61-6522ced1116e@omp.ru>
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

On 11/8/24 21:20, Sergey Shtylyov wrote:
> ata_parse_force_param() still calls printk(KERN_WARNING, ...) -- convert
> it to calling pr_warn(), also joining the broken up message strings...
> 
> This helpfully fixes the following complaints from scripts/checkpatch.pl:
> 
> WARNING: Prefer [subsystem eg: netdev]_warn([subsystem]dev, ... then
> dev_warn(dev, ... then pr_warn(...  to printk(KERN_WARNING ...
> 
> WARNING: quoted string split across lines
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
>   drivers/ata/libata-core.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index cdb20a700b55..47f652981043 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6443,8 +6443,7 @@ static void __init ata_parse_force_param(void)
>   
>   	ata_force_tbl = kcalloc(size, sizeof(ata_force_tbl[0]), GFP_KERNEL);
>   	if (!ata_force_tbl) {
> -		printk(KERN_WARNING "ata: failed to extend force table, "
> -		       "libata.force ignored\n");
> +		pr_warn("ata: failed to extend force table, libata.force ignored\n");
>   		return;
>   	}
>   
> @@ -6455,9 +6454,8 @@ static void __init ata_parse_force_param(void)
>   
>   		next = cur;
>   		if (ata_parse_force_one(&next, &te, &reason)) {
> -			printk(KERN_WARNING "ata: failed to parse force "
> -			       "parameter \"%s\" (%s)\n",
> -			       cur, reason);
> +			pr_warn("ata: failed to parse force parameter \"%s\" (%s)\n",
> +				cur, reason);
>   			continue;
>   		}
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
