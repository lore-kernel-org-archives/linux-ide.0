Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF993FE5
	for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2025 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753855306; cv=none; b=ByI/2G4hF6wDq6nLoBEpZ4EqO5FQm0xdwN7kjeLjdRqjaGhOv830a6bK8PAgv1ioDOtDUqHMy8gJ0JSEHO5MF3g5SMyYqenYT5H7cbFFgQBgLlK6UBNvTlhcXxulUVw+PdwgHGMaXBJ+8NuQWe3dpSJVg/5FUcAYcpxcO1damhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753855306; c=relaxed/simple;
	bh=VjBR/rfJjvVbGw9KS+wlMF0FEAvr8tLeKiM3vrSCGwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkdKqbacWsDCUwM8gCuw5v9tpMWEOVcKjXOVtXYj/dRlrlA3LEhF3Htbv66S7ZwXpmjcRiiQ7uudjGgDrFjYyz29qzC496qcmARcFWhEvUQY+46zbTr6g/vdG5sSGrJmhbxzKKLotBu3ah0cR9dTSo3OLuTiUk9Xg6H6gDTO8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dhp5BjKS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rEsvyGMh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dhp5BjKS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rEsvyGMh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dhp5BjKS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rEsvyGMh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dhp5BjKS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rEsvyGMh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F1E421A93;
	Wed, 30 Jul 2025 06:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753855302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iflTZ/OHc/S5/x/IvOVxJRPsTiHCWnUwJ9dA8t+LKfo=;
	b=Dhp5BjKSZj7CCV0Lt54GbOGrUaz0yX8/X9epuN/EgK+Oivy2ImdBXvFgndgoZDRgGvUerQ
	+LN2cQ6wr+3mQla3jb9x/AVdGpteME4MqaklKQ+bs9DcMXiNLB9/CSrjzjuk99Jlbfimq7
	VRfZEuoWTf2HQX+m4lifsikmX1CBHaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753855302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iflTZ/OHc/S5/x/IvOVxJRPsTiHCWnUwJ9dA8t+LKfo=;
	b=rEsvyGMhjTBQusFpr0P6ff/89HMDkQ5wQeehVBKtnk3owWg/MVbPSWyI+HfDYvHGWUSFJ9
	LryUJSYd7z/xDVAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753855302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iflTZ/OHc/S5/x/IvOVxJRPsTiHCWnUwJ9dA8t+LKfo=;
	b=Dhp5BjKSZj7CCV0Lt54GbOGrUaz0yX8/X9epuN/EgK+Oivy2ImdBXvFgndgoZDRgGvUerQ
	+LN2cQ6wr+3mQla3jb9x/AVdGpteME4MqaklKQ+bs9DcMXiNLB9/CSrjzjuk99Jlbfimq7
	VRfZEuoWTf2HQX+m4lifsikmX1CBHaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753855302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iflTZ/OHc/S5/x/IvOVxJRPsTiHCWnUwJ9dA8t+LKfo=;
	b=rEsvyGMhjTBQusFpr0P6ff/89HMDkQ5wQeehVBKtnk3owWg/MVbPSWyI+HfDYvHGWUSFJ9
	LryUJSYd7z/xDVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AD871388B;
	Wed, 30 Jul 2025 06:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id igpeEEa1iWhSLQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Jul 2025 06:01:42 +0000
Message-ID: <fe63ae58-d8af-4c2a-8669-965e02e28901@suse.de>
Date: Wed, 30 Jul 2025 08:01:41 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-scsi: Fix ata_to_sense_error() status
 handling
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Lorenz Brun <lorenz@brun.one>, Brandon Schwartz <Brandon.Schwartz@wdc.com>
References: <20250730002441.332816-1-dlemoal@kernel.org>
 <20250730002441.332816-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250730002441.332816-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/30/25 02:24, Damien Le Moal wrote:
> Commit 8ae720449fca ("libata: whitespace fixes in ata_to_sense_error()")
> inadvertantly added the entry 0x40 (ATA_DRDY) to the stat_table array in
> the function ata_to_sense_error(). This entry ties a failed qc which has
> a status filed equal to ATA_DRDY to the sense key ILLEGAL REQUEST with
> the additional sense code UNALIGNED WRITE COMMAND. This entry will be
> used to generate a failed qc sense key and sense code when the qc is
> missing sense data and there is no match for the qc error field in the
> sense_table array of ata_to_sense_error().
> 
> As a result, for a failed qc for which we failed to get sense data (e.g.
> read log 10h failed if qc is an NCQ command, or REQUEST SENSE EXT
> command failed for the non-ncq case, the user very often end up seeing
> the completely misleading "unaligned write command" error, even if qc
> was not a write command. E.g.:
> 
> sd 0:0:0:0: [sda] tag#12 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> sd 0:0:0:0: [sda] tag#12 Sense Key : Illegal Request [current]
> sd 0:0:0:0: [sda] tag#12 Add. Sense: Unaligned write command
> sd 0:0:0:0: [sda] tag#12 CDB: Read(10) 28 00 00 00 10 00 00 00 08 00
> I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> 
> Fix this by removing the ATA_DRDY entry from the stat_table array so
> that we default to always returning ABORTED COMMAND without any
> additional sense code, since we do not know any better. The entry 0x08
> (ATA_DRQ) is also removed since signaling ABORTED COMMAND with a parity
> error is also misleading (as a parity error would likely be signaled
> through a bus error). So for this case, also default to returning
> ABORTED COMMAND without any additional sense code. With this, the
> previous example error case becomes:
> 
> sd 0:0:0:0: [sda] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> sd 0:0:0:0: [sda] tag#17 Sense Key : Aborted Command [current]
> sd 0:0:0:0: [sda] tag#17 Add. Sense: No additional sense information
> sd 0:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 00 00 10 00 00 00 08 00
> I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> 
> Together with these fixes, refactor stat_table to make it more readable
> by putting the entries comments in front of the entries and using the
> defined status bits macros instead of hardcoded values.
> 
> Reported-by: Lorenz Brun <lorenz@brun.one>
> Reported-by: Brandon Schwartz <Brandon.Schwartz@wdc.com>
> Fixes: 8ae720449fca ("libata: whitespace fixes in ata_to_sense_error()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 27b15176db56..9b16c0f553e0 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -859,18 +859,14 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
>   		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
>   	};
>   	static const unsigned char stat_table[][4] = {
> -		/* Must be first because BUSY means no other bits valid */
> -		{0x80,		ABORTED_COMMAND, 0x47, 0x00},
> -		// Busy, fake parity for now
> -		{0x40,		ILLEGAL_REQUEST, 0x21, 0x04},
> -		// Device ready, unaligned write command
> -		{0x20,		HARDWARE_ERROR,  0x44, 0x00},
> -		// Device fault, internal target failure
> -		{0x08,		ABORTED_COMMAND, 0x47, 0x00},
> -		// Timed out in xfer, fake parity for now
> -		{0x04,		RECOVERED_ERROR, 0x11, 0x00},
> -		// Recovered ECC error	  Medium error, recovered
> -		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
> +		/* Busy: must be first because BUSY means no other bits valid */
> +		{ ATA_BUSY,	ABORTED_COMMAND, 0x00, 0x00 },
> +		/* Device fault: INTERNAL TARGET FAILURE */
> +		{ ATA_DF,	HARDWARE_ERROR,  0x44, 0x00 },
> +		/* Corrected data error */
> +		{ ATA_CORR,	RECOVERED_ERROR, 0x00, 0x00 },
> +
> +		{ 0xFF, 0xFF, 0xFF, 0xFF }, /* END mark */
>   	};
>   
>   	/*

Yeah, I think the translation to 'unaligned write command' was from the
very early days of SMR development.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
