Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB35279336
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989616; cv=none; b=FpHBXagQ0LNk+Lxvvm2AzaGk23MzTgJdCK00reKa7Vea+Gvap5LfPTxBoe0PRgr/3lPWFv2Fiv2kL+0SySJuZI6p8cFCfJG83IGQDWCxL5KA8nSrm81JeRRWMheKnK0a0s4k69fDmfWCnl/2/2ZomyiPh1lKvNFjKh5uLfKmYN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989616; c=relaxed/simple;
	bh=6LYqfm1ZBS56hiKZhZg853pgY97IS9U6Kp6PHm1gc/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txL5FIVyzQYgnOF8uG9LnNoGyKYPk+YyNne05nhxsUY5fULucQHaNg7Ja/2pcT76ixpQg6qKEaNRaoWH18nRNqI/wFeTz/QGtfa4TmG6SIlqiuHUf24lSH/NNdbXG5o0jvxG21aiYiRcwWXTnGdI+8VDrlYdxfjrieTieNN2XEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gdI65Oyg; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gdI65Oyg"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gRD9V2HTtzlgy21;
	Thu, 28 May 2026 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779989611; x=1782581612; bh=1lv3A6muu3gmhJVRXlkokB6M
	DGT+9v4BmwSXg2fjtaI=; b=gdI65OygOT/ffNtXaYHW/74Opxl9p7kmFLGRmuaO
	dTcfVpCdkO0N0m9J79PmtLG1CBk0FsiUU1vaEsCE5zf9zI6xFynemPYNM1cgOKJd
	U9N6G8rrRIw7YYsoodZ+A3DojFFIv5a+tLw2BNZHP3R8TgIkEqbB1QxxPv72I8HZ
	8uqigRQfV2vGzSrZZFhiwJcDmh8N1nH1wHovUs2PDs842MnLYYdUT4bcXcFmbwEV
	PjVCq6y4U8hY2UQbMSlmV032Ex7gnHlN6VlVZTCPT8LxQ9qkDxjP0y12oJIzUIO+
	gsYNOOx32BY3iTLQ5LJnEOMpQVr3QzThJPefNEAQ9HNtgw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AjSfvZOKQMCq; Thu, 28 May 2026 17:33:31 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gRD9R0GG8zlgy9k;
	Thu, 28 May 2026 17:33:30 +0000 (UTC)
Message-ID: <b4023c30-881b-4bac-9543-b14646c8d49c@acm.org>
Date: Thu, 28 May 2026 10:33:30 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: libata-scsi: Remove lockdep_assert_held() in
 ata_scsi_translate()
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Marco Elver <elver@google.com>, linux-ide@vger.kernel.org
References: <20260528172855.703631-5-cassel@kernel.org>
 <20260528172855.703631-6-cassel@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260528172855.703631-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/26 10:28 AM, Niklas Cassel wrote:
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 6733f2b14521..8bfd3ffd8b89 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1852,8 +1852,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>   	struct ata_port *ap = dev->link->ap;
>   	struct ata_queued_cmd *qc;
>   
> -	lockdep_assert_held(ap->lock);
> -
>   	/*
>   	 * ata_scsi_qc_new() calls scsi_done(cmd) in case of failure. So we
>   	 * have nothing further to do when allocating a qc fails.

This patch removes a useful runtime check. I think it is better to
add the following annotation to ata_scsi_translate() if the goal is
to make the compiler check that all callers hold ap->lock:

__must_hold(dev->link->ap->lock)

Thanks,

Bart.
