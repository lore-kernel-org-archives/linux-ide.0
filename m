Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328D1DEFE8
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 06:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004107; cv=none; b=bghYc7P1NHdDk5iwK2RRIAd08Ppp7/SzdTZJs00vMBY28YivM/AtA/5fM9rkwM6pGMbv1m+BB/M774KF4uPm6l9xpajYcvmayOLKHR/mQufaPpIBubJOOX1RiSg21BMkYK+lsukmv9qhJ5GHk2OhBfMMnQf9zLySpsWqmB44Y4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004107; c=relaxed/simple;
	bh=95H3boHA6/AhLZa6ocgDB0NDEQRTMJAn356LuxCpCLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qLFRhsRnAMLAYFP6Bk2okSEtxKwbBfsasY8pvPBWrkEKeD36gkCPq9ntlKVoVIcmOD1i6oO7TSxXOooSjlrkjKq5lX65PtfsJmNw+wYF7DBisn+qqlEdglVXEu/rP7D0+HmtxOy5fdvufb1+HAHgHZdgW5wUVeXy+X3NMqBIJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gCblKPYU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yhGP1TgG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SQYyetNu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jJiDzgyJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gCblKPYU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yhGP1TgG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SQYyetNu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jJiDzgyJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9E0D2116D;
	Fri, 27 Jun 2025 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2ivPQohFZ7uvRNEC2o2PWuxDfxELcFYMWpO4dPR6u8=;
	b=gCblKPYUI75GX3OcKmmaoBStnw5eJsz4isM/RPRwp8ma/XPwVdZZXgFG0M0VyGnhiVV1k9
	Lgq1qkPsjpQTWQvYV5HlcYPoukgZ4K68ZdPjSryalbuw3agrny+8rT9HzUP5iGmfCg3t1v
	evgJzen64xA/1zZoQ0pWrtR0j9PNgRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2ivPQohFZ7uvRNEC2o2PWuxDfxELcFYMWpO4dPR6u8=;
	b=yhGP1TgGSRIhUO6F17xg9jOluo9TYtILCwLEW5Mg1VsN8wqsksGTQBB2VcsGpmwAH6sFB7
	hal1EezqnqXUtnCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751004103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2ivPQohFZ7uvRNEC2o2PWuxDfxELcFYMWpO4dPR6u8=;
	b=SQYyetNuuYIw5MydZxwPSiEdH+Fl3+UUgjF6w7AZqvsVe7t8MqX8STgTnoU9oz+lThSEYp
	/bXtyrrP7c/xiiYYJrVqwlwCrnC07C3LpoaXfzxCpyTrb+CTYaL2CpZOiGTflbN4wR4Xa6
	J7p4YTcBjXyFip4vQf7q/d8A98ppvw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751004103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2ivPQohFZ7uvRNEC2o2PWuxDfxELcFYMWpO4dPR6u8=;
	b=jJiDzgyJS3dOBOKHDKXOiYOwILVTZRMt7YyMGsx/Jw94I25QQvVChtl1n7vnq2/+N1QM0M
	/MP/qcv+Npn7FcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6EED13786;
	Fri, 27 Jun 2025 06:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rGWDLsczXmj0MAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Jun 2025 06:01:43 +0000
Message-ID: <b307707e-66d7-4192-889a-7a5fc75fcd48@suse.de>
Date: Fri, 27 Jun 2025 08:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] ata: libata-scsi: Cleanup ata_scsi_offline_dev()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
 <20250627011155.701125-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250627011155.701125-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 6/27/25 03:11, Damien Le Moal wrote:
> Change the function ata_scsi_offline_dev() to return a bool and change
> this function kdoc comment to have the correct mention of its call site.
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 15 +++++++--------
>   drivers/ata/libata.h      |  2 +-
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
