Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D7143889;
	Tue, 25 Jun 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296823; cv=none; b=VeZKB5yVp+26tZcFFqalGithawpa+6M4NtNRvavbX7S9UBvpOHwbDfU2n5NxJOavMRJ+CT5VbcaI4uYc2Ro7Dsew1Ie3J+ghXT4u65EMSg1mWDVXaQ8RDqqmkfju97mxdfGEpgAJ6mzYsGQvtAViAkuZ8jS72NPpAnhTZhMMGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296823; c=relaxed/simple;
	bh=wXZABQ4cqUFtgEDkeGVzdak3FIteL0X3fHifM/PA+vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubLLc4ZjkoVEpsdz2YYa9ZV5mNghJVqCe7fMVTdVroKyK0bqcgrH2KZaTsJBztFuNUPLfZj07WHJSXRVg8dZ70PjDlIOgKAYbPbHH/zaz8Xz0Z8UL5FjKx/KCdlWeNIGqlOcjNmxhu8zXanlSL2JcPbHpQdyaXGLm0zWnH80InU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dFyRqiH5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D+IEHyeS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dFyRqiH5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D+IEHyeS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dFyRqiH5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D+IEHyeS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dFyRqiH5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D+IEHyeS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 818411F84C;
	Tue, 25 Jun 2024 06:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iaSqqyyYSF24gyI1HyCo8/f3x0ZpNtaz9d5la+U8mw=;
	b=dFyRqiH5cnMjN87M2Oks6jAe9IcHx6qOStJwSLoh/T9/f37pfBYMdct8hZtjn6ujCLvSb9
	L/c5GCXwlliAabE/49lJU3Gi0RJdyhVMoYLmrhsHELQarQO531uSvj5aNjffnytNY8H5uq
	GrJgnSLcB12shvkeHqHRfUqp6X2W/QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iaSqqyyYSF24gyI1HyCo8/f3x0ZpNtaz9d5la+U8mw=;
	b=D+IEHyeSvqQp9Zer2IfL+s3Rw4N9aDQovid6LlXo4Dz7lXr2pzLgisx5yf403EMZn5YfX7
	M/Gcgh1eRcGeQHCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dFyRqiH5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D+IEHyeS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iaSqqyyYSF24gyI1HyCo8/f3x0ZpNtaz9d5la+U8mw=;
	b=dFyRqiH5cnMjN87M2Oks6jAe9IcHx6qOStJwSLoh/T9/f37pfBYMdct8hZtjn6ujCLvSb9
	L/c5GCXwlliAabE/49lJU3Gi0RJdyhVMoYLmrhsHELQarQO531uSvj5aNjffnytNY8H5uq
	GrJgnSLcB12shvkeHqHRfUqp6X2W/QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iaSqqyyYSF24gyI1HyCo8/f3x0ZpNtaz9d5la+U8mw=;
	b=D+IEHyeSvqQp9Zer2IfL+s3Rw4N9aDQovid6LlXo4Dz7lXr2pzLgisx5yf403EMZn5YfX7
	M/Gcgh1eRcGeQHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08AC01384C;
	Tue, 25 Jun 2024 06:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wG8YOjNjemZbDAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Jun 2024 06:26:59 +0000
Message-ID: <7d085940-2ad1-4f44-83bb-33d852e80da0@suse.de>
Date: Tue, 25 Jun 2024 08:26:59 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-7-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240624221211.2593736-7-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 818411F84C
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 

On 6/25/24 00:12, Igor Pylypiv wrote:
> qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> 
> For ATA errors and ATA PASS-THROUGH commands the ATA_QCFLAG_RTF_FILLED
> flag should be always set. Added WARN_ON_ONCE() checks to generate
> a warning when ATA_QCFLAG_RTF_FILLED is not set and libata needs to
> generate sense data.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/ata/libata-scsi.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index e5669a296d81..7a8a08692ce9 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -246,6 +246,9 @@ static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
>   	struct ata_taskfile *tf = &qc->result_tf;
>   	unsigned char *sb = cmd->sense_buffer;
>   
> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> +		return;
> +
>   	if ((sb[0] & 0x7f) >= 0x72) {
>   		unsigned char *desc;
>   		u8 len;
> @@ -928,6 +931,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>   	unsigned char *sb = cmd->sense_buffer;
>   	u8 sense_key, asc, ascq;
>   
> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> +		return;
> +
>   	/*
>   	 * Use ata_to_sense_error() to map status register bits
>   	 * onto sense key, asc & ascq.
> @@ -971,6 +977,10 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>   		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
>   		return;
>   	}
> +
> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> +		return;
> +
>   	/* Use ata_to_sense_error() to map status register bits
>   	 * onto sense key, asc & ascq.
>   	 */

Hmm. Not sure if we really need the WARN_ON() here or whether a simple 
logging message wouldn't be sufficient; after all, we continue fine here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

