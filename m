Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEB1E8342
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489584; cv=none; b=haBc2pDR3kh2HL6vC67q26kN/Ip9jDeNGYpcArbGOIVQ7NjQd4xMI87pT86aYmLO1xcw94MqVwHrn07HEw5LDnzz2BBktZimuAWhwCXrQbMDvl4zOijCIoDG7FHryQ0JHV89pF2lAW5iBNLBqiRp5OCO3DcFDGSvXZaI9vDTdrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489584; c=relaxed/simple;
	bh=5xnPXG39nLMj5kaxXyv2GhJuUKUEtWDJ5SiitjxOjlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cPmi0q7Bi4Xpr4NW4WCRmUchVWz/1uRfBnb8LY1dWnaDgiibH8e4h5VGdnXFrXz1yLfFLziuOQEwc0CgzWgDe0kI9HYyM89p0aCsDjFwlrhkE76fE7AEAlAjcfG0bTXbrZ62Bckrgu/v+RFAnKJBzXAoSU077kn9jK/dW8FKGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lhPiaPz9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=340Mpk1R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lhPiaPz9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=340Mpk1R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lhPiaPz9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="340Mpk1R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lhPiaPz9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="340Mpk1R"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B11803E6ED;
	Thu, 19 Feb 2026 08:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771489581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI9mSV9/zB7TsWWs7IfNrtIGzzncq1XIsqhouk51pWw=;
	b=lhPiaPz93ifpWS+wjXXJ7TZGvcedCy7xYBo/DR3TKUc3HSWmjdy7KoT89WXxjeLlUW2vW9
	W9Ywy3K8tXNkJmK3iJQVOuzLk/r8KDuI+sxItC2mKTVizeTKzNDWYZ6ZYBx1RO1xLJixy8
	TctivUZM6kohg0/1vmacilxQjregqmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771489581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI9mSV9/zB7TsWWs7IfNrtIGzzncq1XIsqhouk51pWw=;
	b=340Mpk1Rc7OgDl4BZPjy/u+6Cyz5HW/1KWtqlKTTAO4CAsYb4Kt+SmkYPM1zu81RBtw0g4
	hHN3hC9HloMkMVDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lhPiaPz9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=340Mpk1R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771489581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI9mSV9/zB7TsWWs7IfNrtIGzzncq1XIsqhouk51pWw=;
	b=lhPiaPz93ifpWS+wjXXJ7TZGvcedCy7xYBo/DR3TKUc3HSWmjdy7KoT89WXxjeLlUW2vW9
	W9Ywy3K8tXNkJmK3iJQVOuzLk/r8KDuI+sxItC2mKTVizeTKzNDWYZ6ZYBx1RO1xLJixy8
	TctivUZM6kohg0/1vmacilxQjregqmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771489581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI9mSV9/zB7TsWWs7IfNrtIGzzncq1XIsqhouk51pWw=;
	b=340Mpk1Rc7OgDl4BZPjy/u+6Cyz5HW/1KWtqlKTTAO4CAsYb4Kt+SmkYPM1zu81RBtw0g4
	hHN3hC9HloMkMVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 855493EA65;
	Thu, 19 Feb 2026 08:26:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uA8MHy3JlmkGaQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 19 Feb 2026 08:26:21 +0000
Message-ID: <04c67be2-b45d-44ce-a58a-d47e67078751@suse.de>
Date: Thu, 19 Feb 2026 09:26:17 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ata: libata-scsi: rename and improve ata_qc_done()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
 <20260219062312.1030867-6-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260219062312.1030867-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B11803E6ED
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/19/26 07:23, Damien Le Moal wrote:
> Rename ata_qc_done() to ata_scsi_qc_done() and allow to pass a scsi
> command result value to set for the completed command to simplify the
> caller sites.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
