Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182023168E6
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974662; cv=none; b=gBRxVChTclL1siKLLF00D7kV3ii/BGvaFoCbs3v8I/V8jFXu03oc23IDnRG+alV8VJMKbJsbGWIyetrn/hj+CI7pRx1u2BxFsZ9F35ku3f5ICNM03YmgAHpyinILEJV4UAaRQO5zOv0NbsgNJBOD2xq8T8oKOydDkuCeRbrcrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974662; c=relaxed/simple;
	bh=/GfJnI8KRDNjNxsDYmaiifjA1x4wvaqE+CZfFk/QxDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jaTv3AMf/oPlVvpEINm4YaXGlhCNzfNzXVmXxRGSF/4LPn7JtXzaPv6aWxsiQHmVcL8t+GH/4WMtsXXhAx2KpEggHaXntGPdhggHpMYgUGkB3c8NwpiPMf1J0n7wtoYu5dQOhc7kJUsc5p3Ztnb9hkn+FQ9cUMhwJqHfLdc0RY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WTOVuatM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kvZoeQw6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WTOVuatM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kvZoeQw6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WTOVuatM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kvZoeQw6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WTOVuatM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kvZoeQw6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 719F972E42;
	Thu,  2 Jul 2026 06:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4c+cDQeQ1+9/3/aB0jNL+bG8y7yNhV/bRqceaWY5/E0=;
	b=WTOVuatMMDNVScQTaNIhaWEJ1TWL36mBlxhCirxS8jFE5YtyCydwXnmiuylRQSMcJtVTsL
	k5/qpCF1cIoRtn2Tp2ztSmOFRkRDCp5uV1Rcouuh3Yy8+x+UWtmKCktTTL2EUyMJEEiVJz
	09HI1inql0MvbQ2SBCft+NIHUoIwpxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4c+cDQeQ1+9/3/aB0jNL+bG8y7yNhV/bRqceaWY5/E0=;
	b=kvZoeQw6DjHTV9uzYROt6GHcFflRV/f7HnNufWGIysZtYQMrBtBzzCjeJ8RISbTjN0InNI
	RoZiYdXhKh5NryCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4c+cDQeQ1+9/3/aB0jNL+bG8y7yNhV/bRqceaWY5/E0=;
	b=WTOVuatMMDNVScQTaNIhaWEJ1TWL36mBlxhCirxS8jFE5YtyCydwXnmiuylRQSMcJtVTsL
	k5/qpCF1cIoRtn2Tp2ztSmOFRkRDCp5uV1Rcouuh3Yy8+x+UWtmKCktTTL2EUyMJEEiVJz
	09HI1inql0MvbQ2SBCft+NIHUoIwpxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4c+cDQeQ1+9/3/aB0jNL+bG8y7yNhV/bRqceaWY5/E0=;
	b=kvZoeQw6DjHTV9uzYROt6GHcFflRV/f7HnNufWGIysZtYQMrBtBzzCjeJ8RISbTjN0InNI
	RoZiYdXhKh5NryCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AF25779AA;
	Thu,  2 Jul 2026 06:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 10lgDsMIRmqaVAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 06:44:19 +0000
Message-ID: <7bbaa305-1b0d-41d0-a297-7159a8db15d5@suse.de>
Date: Thu, 2 Jul 2026 08:44:18 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260702063412.1892584-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 7/2/26 8:34 AM, Damien Le Moal wrote:
> ata_scsi_report_supported_opcodes() is very limited in functionality as it
> lacks support for the all command format and also does not handle
> correctly commands that have a service action.
> 
> In preparation for adding these missing features, refactor how
> ata_scsi_report_supported_opcodes() operates to make modifications and
> extensions easier. To do so, introduce the array of supported commands
> ata_supported_cmds. This array entries are of type struct ata_scsi_cmd.
> This structure stores the operation code, CDB length, and the service
> action of a supported SCSI command that libata SAT can translate or
> emulate. Since some service actions (e.g. ZI_REPORT_ZONES) can have a
> value of 0, the field sa_valid of struct ata_scsi_cmd is used to indicate
> if the sa field is valid, or if it should be ignored.
> 
> The helper function ata_scsi_get_supported_cmd() is implemented to search
> for a particular command by opcode in this array. This function is used in
> ata_scsi_cmd_is_supported() together with a struct ata_scsi_cmd_support to
> check based on the target device features if the specified command is
> supported.
> 
> ata_scsi_cmd_is_supported() is used as the main function in
> ata_scsi_report_supported_opcodes() to determine if a particular command
> is supported and fill the command reply rbuf as needed. In the case of a
> command that is not supported, the support field is set to 1 as specified
> in SPC, indicating that the command is not supported.
> 
> Of note is that the old ata_scsi_report_supported_opcodes() code did not
> handle the WRITE_SAME_16 and VARIABLE_LENGTH_CMD commands which are both
> supported and translated by libata-scsi. The ata_supported_cmds array
> includes these commands.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 164 +++++++++++++++++++++++++-------------
>   1 file changed, 110 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 8811bfc37369..4f0ae44f59dd 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3590,87 +3590,143 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>   	return 1;
>   }
>   
> -static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
> -						      struct scsi_cmnd *cmd,
> -						      u8 *rbuf)
> +struct ata_scsi_cmd {
> +	u8 op;
> +	u8 cdb_len;
> +	bool sa_valid;
> +	u16 sa;
> +};
> +
> +/*
> + * Array of commands supported with translation or emulation, sorted in
> + * ascending opcode and service action order. All of these commands are
> + * processed either in ata_xlat_func() or in ata_scsi_simulate();
> + */
> +static const struct ata_scsi_cmd ata_supported_cmds[] = {
> +	{ TEST_UNIT_READY,	 6,	false,	0 },
> +	{ REZERO_UNIT,		 6,	false,	0 },
> +	{ REQUEST_SENSE,	 6,	false,	0 },
> +	{ READ_6,		 6,	false,	0 },
> +	{ WRITE_6,		 6,	false,	0 },
> +	{ SEEK_6,		 6,	false,	0 },
> +	{ INQUIRY,		 6,	false,	0 },
> +	{ MODE_SELECT,		 6,	false,	0 },
> +	{ MODE_SENSE,		 6,	false,	0 },
> +	{ START_STOP,		 6,	false,	0 },
> +	{ SEND_DIAGNOSTIC,	 6,	false,	0 },
> +	{ READ_CAPACITY,	10,	false,	0 },
> +	{ READ_10,		10,	false,	0 },
> +	{ WRITE_10,		10,	false,	0 },
> +	{ SEEK_10,		10,	false,	0 },
> +	{ VERIFY,		10,	false,	0 },
> +	{ SYNCHRONIZE_CACHE,	10,	false,	0 },
> +	{ MODE_SELECT_10,	10,	false,	0 },
> +	{ MODE_SENSE_10,	10,	false,	0 },
> +	{ VARIABLE_LENGTH_CMD,	32,	true,	ATA_32 },
> +	{ ATA_16,		16,	false,	0 },
> +	{ READ_16,		16,	false,	0 },
> +	{ WRITE_16,		16,	false,	0 },
> +	{ VERIFY_16,		16,	false,	0 },
> +	{ SYNCHRONIZE_CACHE_16,	16,	false,	0 },
> +	{ WRITE_SAME_16,	16,	false,	0 },
> +	{ ZBC_OUT,		16,	true,	ZO_CLOSE_ZONE },
> +	{ ZBC_OUT,		16,	true,	ZO_FINISH_ZONE },
> +	{ ZBC_OUT,		16,	true,	ZO_OPEN_ZONE },
> +	{ ZBC_OUT,		16,	true,	ZO_RESET_WRITE_POINTER },
> +	{ ZBC_IN,		16,	true,	ZI_REPORT_ZONES },
> +	{ SERVICE_ACTION_IN_16,	16,	true,	SAI_READ_CAPACITY_16 },
> +	{ REPORT_LUNS,		12,	false,	0 },
> +	{ ATA_12,		12,	false,	0 },
> +	{ SECURITY_PROTOCOL_IN,	12,	false,	0 },
> +	{ MAINTENANCE_IN,	12,	true,	MI_REPORT_SUPPORTED_OPERATION_CODES },
> +	{ SECURITY_PROTOCOL_OUT, 12,	false,	0 },
> +};

This probably is a tough ask, but wouldn't it be better to
move to named initializer?
IE things like

  { .op = TEST_UNIT_READY, .cdb_len = 0, .sa_valid = false, .sa = 0 },

that will not only make it easier to read, but will also be
more user friendly if someone needs to expand the structure.

> +
> +static const struct ata_scsi_cmd *ata_scsi_get_supported_cmd(u8 op)
>   {
> -	u8 *cdb = cmd->cmnd;
> -	u8 supported = 0, cdlp = 0, rwcdlp = 0;
> +	const struct ata_scsi_cmd *cmd;
> +	int i;
>   
> -	if (cdb[2] != 1 && cdb[2] != 3) {
> -		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
> -		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
> -		return 0;
> +	for (i = 0; i < ARRAY_SIZE(ata_supported_cmds); i++) {
> +		cmd = &ata_supported_cmds[i];
> +		if (cmd->op == op)
> +			return cmd;
>   	}
>   
> -	switch (cdb[3]) {
> -	case INQUIRY:
> -	case MODE_SENSE:
> -	case MODE_SENSE_10:
> -	case READ_CAPACITY:
> -	case SERVICE_ACTION_IN_16:
> -	case REPORT_LUNS:
> -	case REQUEST_SENSE:
> -	case SYNCHRONIZE_CACHE:
> -	case SYNCHRONIZE_CACHE_16:
> -	case REZERO_UNIT:
> -	case SEEK_6:
> -	case SEEK_10:
> -	case TEST_UNIT_READY:
> -	case SEND_DIAGNOSTIC:
> -	case MAINTENANCE_IN:
> -	case READ_6:
> -	case READ_10:
> -	case WRITE_6:
> -	case WRITE_10:
> -	case ATA_12:
> -	case ATA_16:
> -	case VERIFY:
> -	case VERIFY_16:
> -	case MODE_SELECT:
> -	case MODE_SELECT_10:
> -	case START_STOP:
> -		supported = 3;
> -		break;
> +	return NULL;
> +}
> +
> +struct ata_scsi_cmd_support {
> +	u8 cdlp;
> +	u8 rwcdlp;
> +};
> +
> +static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op,
> +				      struct ata_scsi_cmd_support *sup)
> +{
> +	const struct ata_scsi_cmd *cmd;
> +
> +	/* First, see if we support the command. */
> +	cmd = ata_scsi_get_supported_cmd(op);
> +	if (!cmd)
> +		return false;
> +
> +	/* Now refine the support report depending on the device features. */
> +	memset(sup, 0, sizeof(*sup));
> +	switch (op) {
>   	case READ_16:
> -		supported = 3;
>   		if (dev->flags & ATA_DFLAG_CDL) {
>   			/*
>   			 * CDL read descriptors map to the T2A page, that is,
>   			 * rwcdlp = 0x01 and cdlp = 0x01
>   			 */
> -			rwcdlp = 0x01;
> -			cdlp = 0x01 << 3;
> +			sup->rwcdlp = 0x01;
> +			sup->cdlp = 0x01;
>   		}
> -		break;
> +		return true;
>   	case WRITE_16:
> -		supported = 3;
>   		if (dev->flags & ATA_DFLAG_CDL) {
>   			/*
>   			 * CDL write descriptors map to the T2B page, that is,
>   			 * rwcdlp = 0x01 and cdlp = 0x02
>   			 */
> -			rwcdlp = 0x01;
> -			cdlp = 0x02 << 3;
> +			sup->rwcdlp = 0x01;
> +			sup->cdlp = 0x02;
>   		}
> -		break;
> +		return true;
>   	case ZBC_IN:
>   	case ZBC_OUT:
> -		if (ata_dev_is_zoned(dev))
> -			supported = 3;
> -		break;
> +		return ata_dev_is_zoned(dev);
>   	case SECURITY_PROTOCOL_IN:
>   	case SECURITY_PROTOCOL_OUT:
> -		if (dev->flags & ATA_DFLAG_TRUSTED)
> -			supported = 3;
> -		break;
> +		return dev->flags & ATA_DFLAG_TRUSTED;
>   	default:
>   		break;
>   	}
>   
> +	return true;
> +}
> +
> +static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
> +						      struct scsi_cmnd *cmd,
> +						      u8 *rbuf)
> +{
> +	struct ata_scsi_cmd_support sup;
> +	u8 *cdb = cmd->cmnd;
> +
> +	if (cdb[2] != 1 && cdb[2] != 3) {
> +		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
> +		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
> +		return 0;
> +	}
> +
>   	/* One command format */
> -	rbuf[0] = rwcdlp;
> -	rbuf[1] = cdlp | supported;
> +	if (ata_scsi_cmd_is_supported(dev, cdb[3], &sup)) {
> +		rbuf[0] = sup.rwcdlp;
> +		rbuf[1] = (sup.cdlp << 3) | 0x03;
> +	} else {
> +		rbuf[1] = 0x01;
> +	}
>   
>   	return 4;
>   }

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
