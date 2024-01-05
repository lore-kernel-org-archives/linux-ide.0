Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE3219FE
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX5iG7jE"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd053d5683so15959491fa.2
        for <linux-ide@vger.kernel.org>; Fri, 05 Jan 2024 00:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704444366; x=1705049166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+IddIIw8i9dtTHBTN43F9n5BL4Go10LXOdXLOP+AkM=;
        b=JX5iG7jEY8vw8oA1JhpF0Nfic4VU47mnGtpMRZ0UEbF3m2ay7oOqX0AJ4uIDgYtzsr
         0MBpHiknQjIWUqrIg0I0irDahliho1Ih1LJztKy1lOWpmXE5fJk8IX/nhLrIlzIFlErM
         52wO7aDOSUWGaqrQZA5BfWCmho2+uoy5LWdVCRBoO4JjPym5q7189WwcJc84R1Pd8iyg
         aWqnbbvx/sc206K0AwBQj85jH+fHdAGvodnEUCGCjvp7XFTkfxAH4D+l/F3XMVY28dRg
         j91zE/CmWKN6eBdaM5Fmd/ayajriQIR7Hq5io9AqjnFOOrARDyCWqzdHeC3RHFt8/FkV
         r2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704444366; x=1705049166;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+IddIIw8i9dtTHBTN43F9n5BL4Go10LXOdXLOP+AkM=;
        b=SuZlo4nIKVPObqycqnV0VWBcppjlQEAUhFOZV7Oy/PU035l5XvffmoVGbkkFNchutP
         dWcvkfvWTOet19aYRkj8oWzdMMV6CcIjQJk2FN0SWYH+k9HpBq6kgG0fcS4nxJfnLJ7I
         8Xi7/rZLOdHla/52+75eMf/YLYYULqoWyUq4UzDwLkPqIhGi52BsZBBK3T72zYOYT7Qr
         Kod6u4xDmebukSmv7jdn0M0ORr6T/ylwPV6FtpmlRy5NT82zU/2bmqYLbJ2sNNeCTBUu
         7/WI2B6Hnqovi3Uf2iH2bk8ogC/JOpinVbLU17HpPS8IhYVltRgO/gBU3GUlKRCtmcds
         +9bg==
X-Gm-Message-State: AOJu0Yw9vmuCWdXQCw90KRnCADE3hNZQyH2G/qs/y5yHRPHaGfEjr/j0
	O41uV8QMjwLyQ5V0MBmX4pudm3x7GX8=
X-Google-Smtp-Source: AGHT+IE8OgjG0fyhzyiv3xBMnUiFjNMOp4LDoSA5Vrmh+PqpgRCvznKLEKBucK13nd//QNKXurQ3Jg==
X-Received: by 2002:a2e:9d81:0:b0:2c8:39fc:acf5 with SMTP id c1-20020a2e9d81000000b002c839fcacf5mr869312ljj.2.1704444365967;
        Fri, 05 Jan 2024 00:46:05 -0800 (PST)
Received: from [192.168.1.104] ([178.176.73.147])
        by smtp.gmail.com with ESMTPSA id t16-20020a05651c205000b002cd12db0546sm236910ljo.117.2024.01.05.00.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 00:46:05 -0800 (PST)
Subject: Re: [PATCH 3/4] libata: avoid waking disk for several commands
To: Phillip Susi <phill@thesusis.net>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-3-phill@thesusis.net>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <13374917-5c23-1cb4-8484-479cc7d20e7b@gmail.com>
Date: Fri, 5 Jan 2024 11:46:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240104223940.339290-3-phill@thesusis.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hello!

On 1/5/24 1:39 AM, Phillip Susi wrote:

> When a disk is in SLEEP mode it can not respond to any
> commands.  Instead of waking up the sleeping disk, fake the
> commands.  The commands include:
> 
> CHECK POWER

  This command is "officially" called CHECK POWER MODE... 

> FLUSH CACHE
> SLEEP
> STANDBY IMMEDIATE
> IDENTIFY
> 
> If we konw the disk is sleeping, we don't need to wake it up

   Know.

> to to find out if it is in standby, so just pretend it is in

   Double "to".

> standby.  While alseep, there's no dirty pages in the cache,

   Asleep.

> so there's no need to flush it.  There's no point in waking
> a disk from sleep just to put it back to sleep.  We also have
> a cache of the IDENTIFY information so just return that
> instead of waking the disk.
> ---
>  drivers/ata/libata-core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 1244da8f77e2..d9e889fa2881 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5045,6 +5045,22 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
>  
>  	/* if device is sleeping, schedule reset and abort the link */
>  	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
> +		if (unlikely(qc->tf.command == ATA_CMD_CHK_POWER ||
> +			     qc->tf.command == ATA_CMD_SLEEP ||
> +			     qc->tf.command == ATA_CMD_FLUSH ||
> +			     qc->tf.command == ATA_CMD_FLUSH_EXT ||
> +			     qc->tf.command == ATA_CMD_STANDBYNOW1 ||
> +			     (qc->tf.command == ATA_CMD_ID_ATA &&
> +			      !ata_tag_internal(qc->tag))))

   How about a *switch* instead?

> +		{
> +			/* fake reply to avoid waking drive */
> +			qc->flags |= ATA_QCFLAG_RTF_FILLED;
> +			qc->result_tf.nsect = 0;
> +			if (qc->tf.command == ATA_CMD_ID_ATA)
> +				sg_copy_from_buffer(qc->sg, 1, qc->dev->id, 2 * ATA_ID_WORDS);
> +			ata_qc_complete(qc);
> +			return;
> +		}
>  		link->eh_info.action |= ATA_EH_RESET;
>  		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
>  		ata_link_abort(link);
> 

MBR, Sergey
