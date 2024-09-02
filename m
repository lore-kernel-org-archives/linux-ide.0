Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B62AE99
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258112; cv=none; b=QnmRdRBg7PDNgeQDKOAJmR8p/yezhsEt4B0QBMxRhsOIjlFoO75KmP5YUKjOiqVR/Q8RWZ7uAuYIjLgMtCALSn32YVLucsdIdlAIlA+6DaSCzkJdWYe5O8q7HX/zo1lQf+j9bqe153ZOJPNG5aQ7B8Iefjd9LyUV041DvZIUlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258112; c=relaxed/simple;
	bh=V3nLBZXcJNRLfmj63GXU7NmO4JtCTAmDyQwCfXBtpwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PsbW0eNv2+MW7l7OYXgSyA4TZlQbYqOWUw+cLeQ+f8OtMiCVmjlGUv/uKSQgwUftvcni8j6JBcOM4vTN7au/AMrSaF9WH5Oc1tYtRwkjXfCJ6oVC+4l5tQAcciVCS84TQYxf9fmD06HescC7Tp6k+h+o3RNpOkCu5t1FaHt218s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tDkb+v2V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s5CnKiuE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tDkb+v2V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s5CnKiuE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tDkb+v2V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s5CnKiuE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tDkb+v2V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s5CnKiuE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50C591FB99;
	Mon,  2 Sep 2024 06:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725258109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFgj49waIhcCFif5ogoNVBglJO+k8cjbWYpd+Bd/YUs=;
	b=tDkb+v2VhwCd71HRAoCXEfGIkNltpZglecu/lEqWzCqSNYaUnIxaGMMkCngSj1PrdSvQoX
	Br4eTK+dYZtQ6URGe1ff9dp1cRfjcyIkzckvdOyA/wTGnm9vwckjBo5uwHQ6MqPLw++qlc
	VVBfjnlHGYeu58Cw7xP8rEV96nzekXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725258109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFgj49waIhcCFif5ogoNVBglJO+k8cjbWYpd+Bd/YUs=;
	b=s5CnKiuE+2fligx6EXdHVavoSm4aLB39sFhfBimzc+nv3Qcq6TWuy/OYyDYzgB+BwiqOJh
	OW5rGmT4iScbtjBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725258109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFgj49waIhcCFif5ogoNVBglJO+k8cjbWYpd+Bd/YUs=;
	b=tDkb+v2VhwCd71HRAoCXEfGIkNltpZglecu/lEqWzCqSNYaUnIxaGMMkCngSj1PrdSvQoX
	Br4eTK+dYZtQ6URGe1ff9dp1cRfjcyIkzckvdOyA/wTGnm9vwckjBo5uwHQ6MqPLw++qlc
	VVBfjnlHGYeu58Cw7xP8rEV96nzekXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725258109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFgj49waIhcCFif5ogoNVBglJO+k8cjbWYpd+Bd/YUs=;
	b=s5CnKiuE+2fligx6EXdHVavoSm4aLB39sFhfBimzc+nv3Qcq6TWuy/OYyDYzgB+BwiqOJh
	OW5rGmT4iScbtjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1679A13AE5;
	Mon,  2 Sep 2024 06:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YEvEA31Z1Wa8GQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Sep 2024 06:21:49 +0000
Message-ID: <666daec5-5fe9-4956-bb72-db88e7ccecee@suse.de>
Date: Mon, 2 Sep 2024 08:21:49 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] ata: libata: Move sector_buf from struct ata_port
 to struct ata_device
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240902000043.155495-1-dlemoal@kernel.org>
 <20240902000043.155495-7-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240902000043.155495-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 9/2/24 02:00, Damien Le Moal wrote:
> The 512B buffer sector_buf field of struct ata_port is used for scanning
> devices as well as during error recovery with ata EH. This buffer is
> thus useless if a port does not have a device connected to it.
> And also given that commands using this buffer are issued to devices,
> and not to ports, move this buffer definition from struct ata_port to
> struct ata_device.
> 
> This change slightly increases system memory usage for systems using a
> port-multiplier as in that case we do not need a per-device buffer for
> scanning devices (PMP does not allow parallel scanning) nor for EH (as
> when entering EH we are guaranteed that all commands to all devices
> connected to the PMP have completed or have been aborted). However,
> this change reduces memory usage on systems that have many ports with
> only few devices rives connected, which is a much more common use case
> than the PMP use case.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c  | 63 ++++++++++++++++----------------------
>   drivers/ata/libata-eh.c    |  2 +-
>   drivers/ata/libata-pmp.c   |  3 +-
>   drivers/ata/libata-sata.c  |  2 +-
>   drivers/ata/libata-zpodd.c |  2 +-
>   include/linux/libata.h     |  4 ++-
>   6 files changed, 33 insertions(+), 43 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

