Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079E82AE99
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257979; cv=none; b=P917s3rQLgHsxB9CwXhAPOtT9r1jsPk0cYZNm6fTdW7rbbH4kZU0Mwf3nm2PKRt266uGypdBVnGLFT8nzxGqjvx7Kgbboxj9Qi5dD5tkD6SR/f4HNFdPytddCGa572FyOEarNyzZD2F3zyFmcv8DKp/wVTX+OxtKiBhTubsPEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257979; c=relaxed/simple;
	bh=JUSzcAxOeKeM6l3CCgdrMmgTzyBaKU8/qbMFEynfqCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JWUOle68rj8icEhcbmHOSeHhXhJFzj+1MO4xgx1kCH6nhr+E0bpA5/K0YxwP4Q5GtQ7JHGAl11TbOT4k1Zr4oiTn8x4llEwjY0rRCzLhdKdvquebR51qYmkhnJ23E/+MXfd8vPCLXzssqJYyl1VhWXbBT/tou7vBVPYgUm5gELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DRMuZPRv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tZX+RARR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DRMuZPRv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tZX+RARR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DRMuZPRv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tZX+RARR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DRMuZPRv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tZX+RARR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CA72219D7;
	Mon,  2 Sep 2024 06:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725257976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySzAlTUe/5GKjX/BBvIQzPV2XB13/aiYLiMPp8zLPqY=;
	b=DRMuZPRvGaoZuvq8Or4m6Nh99aOgrnsnVFwl7H8hoxAqju2GaAnqnGg2W8TGmFE7GEZiNS
	KTX3n1Qe1EdvmqNvaFVpbkYCBCvwymIe0aeUrTg64lkPIJ47s3S3PWGEUJJzHYothGrBRP
	S+nzFgUEQ0uYuI20uYXfgRCpQ2Wzzl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725257976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySzAlTUe/5GKjX/BBvIQzPV2XB13/aiYLiMPp8zLPqY=;
	b=tZX+RARR1004VwKec/t4RhiS1I4IFP+PO8/BXyz3cr6K7idEM8IzTccBIMOyMS/cA/tdLV
	tpt+QE2qB9snYACw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DRMuZPRv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tZX+RARR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725257976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySzAlTUe/5GKjX/BBvIQzPV2XB13/aiYLiMPp8zLPqY=;
	b=DRMuZPRvGaoZuvq8Or4m6Nh99aOgrnsnVFwl7H8hoxAqju2GaAnqnGg2W8TGmFE7GEZiNS
	KTX3n1Qe1EdvmqNvaFVpbkYCBCvwymIe0aeUrTg64lkPIJ47s3S3PWGEUJJzHYothGrBRP
	S+nzFgUEQ0uYuI20uYXfgRCpQ2Wzzl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725257976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySzAlTUe/5GKjX/BBvIQzPV2XB13/aiYLiMPp8zLPqY=;
	b=tZX+RARR1004VwKec/t4RhiS1I4IFP+PO8/BXyz3cr6K7idEM8IzTccBIMOyMS/cA/tdLV
	tpt+QE2qB9snYACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA08C13AE5;
	Mon,  2 Sep 2024 06:19:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AAIhMvdY1Wa8GQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Sep 2024 06:19:35 +0000
Message-ID: <015ee321-1047-41ea-9350-1057ddec9471@suse.de>
Date: Mon, 2 Sep 2024 08:19:35 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] ata: libata: Move sata_std_hardreset() definition
 to libata-sata.c
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240902000043.155495-1-dlemoal@kernel.org>
 <20240902000043.155495-5-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240902000043.155495-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CA72219D7
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On 9/2/24 02:00, Damien Le Moal wrote:
> Unlike ata_std_prereset() and ata_std_postreset(), the function
> sata_std_hardreset() applies only to SATA devices, as its name implies.
> So move its definition to libata-sata.c.
> 
> Together with this, also move the definition of sata_port_ops to
> libata-sata.c, where it belongs.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-core.c | 35 -----------------------------------
>   drivers/ata/libata-sata.c | 36 ++++++++++++++++++++++++++++++++++++
>   include/linux/libata.h    |  9 +++++++--
>   3 files changed, 43 insertions(+), 37 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

