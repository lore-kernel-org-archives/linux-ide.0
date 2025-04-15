Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19301F55F8
	for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744699782; cv=none; b=seFceaXS0HeFQxI0GUeU3VJwtTOX+ZbjusfggFFUj5XzKZayL5VKISORBJIkIsO7+hx4NhNgKQYmWF+056t0JOSbXaEy15r8/zSVN9Jk/ADp6ExC5DI8LEZAozreUS3gDABeCAuxAukXeJdNHcE+jp2aodd49TnlVu5d5FHjWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744699782; c=relaxed/simple;
	bh=fbCmGJluCncsPZGb+cNSyFd+b+h6AT4h0Vnx+9x581U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMt+LJh52SMW7Q72fbtLjTRjI0OwWbGt8yblaVeEi6kRClBQsQZV7j3Z/QTB2PYFHcLQkpLUryoXu4wIPWHuARFHKfeaWA9sOTsLTJXvNecN7vtCZbfbw7WrZB+q5sSZdv8q8+WnoI8wW8dgexevRCwGPaXqpq+hQMrGuRBFyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tpF3cpP6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l1WRBwY6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XVhdlwVf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BZuUQFLH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tpF3cpP6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l1WRBwY6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XVhdlwVf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BZuUQFLH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73EE82117C;
	Tue, 15 Apr 2025 06:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744699778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk45J37jKjGd3p8vAoniuezEN20j87pJZkCfigKIRDU=;
	b=tpF3cpP6m0V50V5xNi7cj/XRRvCrYl2AFEvS/m0iVYAmjU5nmQPLjRyzM9Xu3fvQGfyYvN
	cRN3pVCF1A28U3Y499qf6zYDRaNKWjuj5FQIcEGuUoioyBlxy+G8/hc81FpOic+96YL2xn
	1STuZT/aFWmAtwAW3n1ILe5rlbaBLCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744699778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk45J37jKjGd3p8vAoniuezEN20j87pJZkCfigKIRDU=;
	b=l1WRBwY6QxHVUbP2wAreLgnCddWNRy6n8eN875YB9XIQzx9eT83wzh9s+0vY/o+XvfkBHL
	7H/1bK5OrAYpL7CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744699777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk45J37jKjGd3p8vAoniuezEN20j87pJZkCfigKIRDU=;
	b=XVhdlwVfnyhKqUARPdE+Ce90fOxfj5qLjsY2w5wLkxNxSuP2jP2bJ35izZ7B2TN3y8vdL0
	jLoxxlNzIDG+Pp3WZrw7GGghjOxvDPiX5H7npFsvD1m4fKALGFuzWYy0FJzz0Anhl/4++p
	diyGbD1Jg+n8OjtGrjS3OInQ8Iv1iPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744699777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk45J37jKjGd3p8vAoniuezEN20j87pJZkCfigKIRDU=;
	b=BZuUQFLHeVgcKAXmrK5WqS5cuMdn5BKD/sioOGmehCPlYzvTuQkZP5nZ7oGFCSejNDSHlk
	OhIKYU+cxL1ZIyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A8D0137A5;
	Tue, 15 Apr 2025 06:49:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P1GvEIEB/mfoJAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 15 Apr 2025 06:49:37 +0000
Message-ID: <d8e38388-caea-4b7e-90cf-1c071d7421b6@suse.de>
Date: Tue, 15 Apr 2025 08:49:36 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-sata: Save all fields from sense data
 descriptor
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
References: <20250411132522.126316-3-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250411132522.126316-3-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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

On 4/11/25 15:25, Niklas Cassel wrote:
> When filling the taskfile result for a successful NCQ command, we use
> the SDB FIS from the FIS Receive Area, see e.g. ahci_qc_ncq_fill_rtf().
> 
> However, the SDB FIS only has fields STATUS and ERROR.
> 
> For a successful NCQ command that has sense data, we will have a
> successful sense data descriptor, in the Sense Data for Successful NCQ
> Commands log.
> 
> Since we have access to additional taskfile result fields, fill in these
> additional fields in qc->result_tf.
> 
> This matches how for failing/aborted NCQ commands, we will use e.g.
> ahci_qc_fill_rtf() to fill in some fields, but then for the command that
> actually caused the NCQ error, we will use ata_eh_read_log_10h(), which
> provides additional fields, saving additional fields/overriding the
> qc->result_tf that was fetched using ahci_qc_fill_rtf().
> 
> Fixes: 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL commands using policy 0xD")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> This is basically v3 of the patch that was previously sent out here:
> https://lore.kernel.org/linux-ide/20250409084546.121694-2-cassel@kernel.org/
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
