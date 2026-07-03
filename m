Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D42382374
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061047; cv=none; b=p9KaKQPqSqp0W8DX4EKIz9VyBJ/Pdf0DhrYtmopKU1IdKaN1a4pGUu49/HmcxYECpKdIdHIPS5tu0L2+JteSSK4mc3vyysBguaUDprTwjDeHL3sxJaTgx1YmrpOWdtvK8RP8yjJZo7+pyOVRe6WXNWN2VMbZzujwMYLZtpQFFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061047; c=relaxed/simple;
	bh=83IAAx9YEqcL/MhUY1H4uMrh5x5C/LAPcqZRVSmPsA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ys0c/3QyLJ+cwtOgiRv40vWSfESYFRUz0QQBdBmMJYSzSorNr07hGx/+jx83l12lzKJ3Thm4YwYN7S5kd7Z4rNWw5QTC+Pd6sahqIzEL5StaFsWavnIuz9N/B3MzJj5J+HxV+X8qL9GIfMxD4Ll5sgOqK03U7cT71TF1PAVabnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jSvzfNHu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1V+vk0Dx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jSvzfNHu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1V+vk0Dx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jSvzfNHu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1V+vk0Dx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jSvzfNHu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1V+vk0Dx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F0F674772;
	Fri,  3 Jul 2026 06:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783061043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HrhJl18+RCV/7JYxEWUmXxsuVU+bABdMbaU9p9+skU=;
	b=jSvzfNHudYGTni1p66VNZPWBiwdGvKWnVrdoCMSGHFgvDRjluwa2M34eGsftPXpIi0Q7E+
	HRCm2kp6GmmTQ1BXdUlOE7Od/FjMCBQbg7P+pdXRxrv6t6Rk6n/mhrfqMTDhRzmhab9zo/
	NHxQT5Zl6ZokeV/kYff8cvf4gK8ec0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783061043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HrhJl18+RCV/7JYxEWUmXxsuVU+bABdMbaU9p9+skU=;
	b=1V+vk0DxuKduTe9EUtlstJqxKqNS3J7uliK/zFfo1NW/oCa5kLMMvvJBaAOiKgmcQ86cEt
	TY8fw1dtNE5ncPAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jSvzfNHu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1V+vk0Dx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783061043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HrhJl18+RCV/7JYxEWUmXxsuVU+bABdMbaU9p9+skU=;
	b=jSvzfNHudYGTni1p66VNZPWBiwdGvKWnVrdoCMSGHFgvDRjluwa2M34eGsftPXpIi0Q7E+
	HRCm2kp6GmmTQ1BXdUlOE7Od/FjMCBQbg7P+pdXRxrv6t6Rk6n/mhrfqMTDhRzmhab9zo/
	NHxQT5Zl6ZokeV/kYff8cvf4gK8ec0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783061043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HrhJl18+RCV/7JYxEWUmXxsuVU+bABdMbaU9p9+skU=;
	b=1V+vk0DxuKduTe9EUtlstJqxKqNS3J7uliK/zFfo1NW/oCa5kLMMvvJBaAOiKgmcQ86cEt
	TY8fw1dtNE5ncPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11032779AA;
	Fri,  3 Jul 2026 06:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N3W/ATNaR2qRUAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 03 Jul 2026 06:44:03 +0000
Message-ID: <63c22af2-09df-47ff-a5cd-a9165bf265fc@suse.de>
Date: Fri, 3 Jul 2026 08:44:02 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20260703040532.2152614-1-dlemoal@kernel.org>
 <20260703040532.2152614-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260703040532.2152614-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2F0F674772
X-Spam-Score: -4.51

On 7/3/26 6:05 AM, Damien Le Moal wrote:
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
> handle the VARIABLE_LENGTH_CMD/ATA_32 command which is supported and
> translated by libata-scsi. The ata_supported_cmds array includes this
> command. As commented in the code, WRITE_SAME_16 is left out of the array
> of supported command ata_scsi_write_same_xlat() prevents the use of this
> command as a passthrough command.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 201 ++++++++++++++++++++++++++++----------
>   1 file changed, 147 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a86721b5df7f..e502b8702f98 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3590,87 +3590,180 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
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
> + *
> + * Note: commands that are not fully supported may be left out of this array
> + * so that they are not reported as supported for passthrough but still
> + * available through the block layer. For now, this includes the following
> + * commands:
> + *  - WRITE_SAME_16: ata_scsi_write_same_xlat() forbids passthrough commands
> + */
> +static const struct ata_scsi_cmd ata_supported_cmds[] = {
> +	{	.op = TEST_UNIT_READY,		.cdb_len = 6	},
> +	{	.op = REZERO_UNIT,		.cdb_len = 6	},
> +	{	.op = REQUEST_SENSE,		.cdb_len = 6	},
> +	{	.op = READ_6,			.cdb_len = 6	},
> +	{	.op = WRITE_6,			.cdb_len = 6	},
> +	{	.op = SEEK_6,			.cdb_len = 6	},
> +	{	.op = INQUIRY,			.cdb_len = 6	},
> +	{	.op = MODE_SELECT,		.cdb_len = 6	},
> +	{	.op = MODE_SENSE,		.cdb_len = 6	},
> +	{	.op = START_STOP,		.cdb_len = 6	},
> +	{	.op = SEND_DIAGNOSTIC,		.cdb_len = 6	},
> +	{	.op = READ_CAPACITY,		.cdb_len = 10	},
> +	{	.op = READ_10,			.cdb_len = 10	},
> +	{	.op = WRITE_10,			.cdb_len = 10	},
> +	{	.op = SEEK_10,			.cdb_len = 10	},
> +	{	.op = VERIFY,			.cdb_len = 10	},
> +	{	.op = SYNCHRONIZE_CACHE,	.cdb_len = 10	},
> +	{	.op = MODE_SELECT_10,		.cdb_len = 10	},
> +	{	.op = MODE_SENSE_10,		.cdb_len = 10	},
> +	{
> +		.op = VARIABLE_LENGTH_CMD,	.cdb_len = 32,
> +		.sa_valid = true,
> +		.sa = ATA_32
> +	},
> +	{	.op = ATA_16,			.cdb_len = 16	},
> +	{	.op = READ_16,			.cdb_len = 16	},
> +	{	.op = WRITE_16,			.cdb_len = 16	},
> +	{	.op = VERIFY_16,		.cdb_len = 16	},
> +	{	.op = SYNCHRONIZE_CACHE_16,	.cdb_len = 16	},
> +	{
> +		.op = ZBC_OUT,			.cdb_len = 16,
> +		.sa_valid = true,
> +		.sa = ZO_CLOSE_ZONE
> +	},
> +	{
> +		.op = ZBC_OUT,			.cdb_len = 16,
> +		.sa_valid = true,
> +		.sa = ZO_FINISH_ZONE
> +	},
> +	{
> +		.op = ZBC_OUT,			.cdb_len = 16,
> +		.sa_valid = true,
> +		.sa = ZO_OPEN_ZONE
> +	},
> +	{
> +		.op = ZBC_OUT,			.cdb_len = 16,
> +		.sa_valid = true,
> +		.sa = ZO_RESET_WRITE_POINTER
> +	},
> +	{
> +		.op = ZBC_IN,			.cdb_len = 16,
> +		.sa_valid = true,
> +		.sa = ZI_REPORT_ZONES
> +	},
> +	{
> +		.op = SERVICE_ACTION_IN_16,	.cdb_len = 16,
> +		.sa_valid = true,
> +		.sa = SAI_READ_CAPACITY_16
> +	},
> +	{	.op = REPORT_LUNS,		.cdb_len = 12	},
> +	{	.op = ATA_12,			.cdb_len = 12	},
> +	{	.op = SECURITY_PROTOCOL_IN,	.cdb_len = 12	},
> +	{
> +		.op = MAINTENANCE_IN,		.cdb_len = 12,
> +		.sa_valid = true,
> +		.sa = MI_REPORT_SUPPORTED_OPERATION_CODES
> +	},
> +	{	.op = SECURITY_PROTOCOL_OUT,	.cdb_len = 12	},
> +};
> +

What an unusual formatting. I would have gone for multi-line
entries even for the simple ones to keep formatting the same
for all entries.
But hey.

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

That is confusing. You return 'true' here, yet once you break out
of the switch the function will return 'true', too.
Please stay with the 'break' here.

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

Same here.

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

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
