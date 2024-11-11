Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDD13E41A
	for <linux-ide@vger.kernel.org>; Mon, 11 Nov 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319223; cv=none; b=DbtFq7IYVbAmVH5nXGGDm4iOEdjiLy+hj4jyN2KeqrWRPr2Wip2DmvECZV8vfjKq14mNWTy9ro9ps/fizhj6AOmcptK3hsm2wTyQLBWin5td3NxEZfi+HPHYYwh/wk5yLFSdHHvqxHZHA8PDt7Ry1Y2T1I/lTLmL6/q/QkILUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319223; c=relaxed/simple;
	bh=3HD5X3K/f4VKIxs9DycdODfg1YQenAFP+eJOSOTW1MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnMW2pv694dlyJps9B77/PnNKdWxi6icDo0pCNjWkx9VIQHkXoC/46SSF5LdZcM3/PKLGZPCsMggkJxg767j3+kZwOYTZQBPNm3QgQ8wub+GiWK27sKnijrReCPUpFrDMsfWrO/+kDf/9ZWpOYmKD01N2X+7okPMqCFZnj9wHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qeepd2FB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/402331H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RyLjNnNy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lKweP9DU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qeepd2FB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/402331H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RyLjNnNy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lKweP9DU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D9771F38F;
	Mon, 11 Nov 2024 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jI+71fN2L00vmJlKvwSu2tqa8MJPkrvbXlX801H3CQ=;
	b=qeepd2FBVbfIJRnDDGmojM0iyTZnn4a8A7hsV0XQuE5TaKD37a4Kw+y/VH27G8IK2E9Uw2
	WKr5mYYdv3x4K+bWOdvbXh3rYr7hDE0fUV4XNe8crwP0TWhA08qvx+mdI0HLZZ76h9X6h2
	j9GbSAfzL7aEX87nZVFbCh+P0POglbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jI+71fN2L00vmJlKvwSu2tqa8MJPkrvbXlX801H3CQ=;
	b=/402331HrHIWlS6ZUoWhFOqXhyYWfLl3tC47e2q/aeXDfrrkjPKfuT0bb+jNzCXnpJ3ov1
	voEcryamYFdw8YCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731319219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jI+71fN2L00vmJlKvwSu2tqa8MJPkrvbXlX801H3CQ=;
	b=RyLjNnNyCWTuVg36u+gzouX1ZfwNH3hTaS/YGvn7754nUUS/MTn2/6YYIAYa5gsCRvJXvb
	bd934Puva6T9ji2tUuTqPuyZb0r3j/J291NxIbsxR1Bnei3j+K0Lh6IXK3cT1KwH/VaXcD
	7yL9olWF8Fz81Wtiy5wmzADuVMwiHmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731319219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jI+71fN2L00vmJlKvwSu2tqa8MJPkrvbXlX801H3CQ=;
	b=lKweP9DU71mOdAzPzo3nHCQ3H1IVSB4i3ARMfc/zk48ZnNwRvbzznzdmbPc5yA4W8xvajI
	VYs/HHkDcnDrXcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AD5813301;
	Mon, 11 Nov 2024 10:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HhuKFbPVMWdhDwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 11 Nov 2024 10:00:19 +0000
Message-ID: <3d66b027-b774-4468-96e4-4161e65ebcc8@suse.de>
Date: Mon, 11 Nov 2024 11:00:19 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] ata: ahci: use dev_info() instead of
 printk(KERN_INFO)
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Sergey Shtylyov <sergei.shtylyov@gmail.com>
References: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
 <98cac57e-de28-48f2-99a8-a6d1afae1610@omp.ru>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <98cac57e-de28-48f2-99a8-a6d1afae1610@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 11/8/24 21:17, Sergey Shtylyov wrote:
> The AHCI PCI device driver still calls printk(KERN_INFO, ...) in
> ahci_mcp89_apple_enable() and ahci_init_msi() -- convert them to
> calling dev_info(), somewhat rewording the messages themselves...
> 
> This helpfully fixes the following complaint from scripts/checkpatch.pl:
> 
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
> dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
> 
> Signed-off-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
> 
> ---
>   drivers/ata/ahci.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 2d3d3d67b4d9..32c79b41ddea 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1141,7 +1141,7 @@ static void ahci_mcp89_apple_enable(struct pci_dev *pdev)
>   {
>   	u32 val;
>   
> -	printk(KERN_INFO "ahci: enabling MCP89 AHCI mode\n");
> +	dev_info(&pdev->dev, "enabling MCP89 AHCI mode\n");
>   
>   	pci_read_config_dword(pdev, 0xf8, &val);
>   	val |= 1 << 0x1b;
> @@ -1692,8 +1692,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>   			 * Fallback to single MSI mode if the controller
>   			 * enforced MRSM mode.
>   			 */
> -			printk(KERN_INFO
> -				"ahci: MRSM is on, fallback to single MSI\n");
> +			dev_info(&pdev->dev, "AHCI MRSM is on, fallback to single MSI\n");
>   			pci_free_irq_vectors(pdev);
>   		}
>   	}

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
