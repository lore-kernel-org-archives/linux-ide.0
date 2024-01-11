Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BC152F90
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVlxX+72"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd928a1d58so5004251fa.3
        for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2024 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704996647; x=1705601447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8MzGwjS7UwP3U91XL/YsEQzbL7bGEpHB7jHf4hs7+U=;
        b=GVlxX+72FXjy6L5/rnEQE5S+zMx4KIyPNz2K8/AI88hmbYwPS2LF72B1DydLCRP0lr
         NJepZWhfItfiiSs6tmW3yNjXd9fN+N60ydTQVoB0h6tJrbjbGMqpbK6tu19RQ70kMQss
         Ir82+IMej+BzEAxA1wkhD7fojhKOcSyqiuWHo/IXZPpqsFlmrTwVChAc8opCVtYVrN4q
         fn2f0PKcVHhNIvaJWBfLt+raaQdg99/6ksfXSb9G33h1kGyLSt6wujwhTvJ2EYR4MaoT
         Z9fKq4KfjcIH3+wJ4poZYKQjiL46qmavWx6secGWfRVQuE/30pccyvehaxcyqJ4KPVRA
         +JkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704996647; x=1705601447;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8MzGwjS7UwP3U91XL/YsEQzbL7bGEpHB7jHf4hs7+U=;
        b=F7zMv75B199StAqewY52gw94/tMZkNH7QgUxo4Cb/dRl8BUVhWD5o13XKHWy5lGDv2
         WaMOu8fivSPoHZ5Y3lmvu6f763iozmAk4bpABoXX8AR672dPz/QdYHQI4xg3ZqvfIQHd
         sZiodVOafeMLBzPSQWji5hkFsdYzI10lqLWNj0EdpnQ+VA14H5CktuaPRrm2ixe8Xkr6
         MRmNze06rpq8Rz2RBTLPSH2b+QtuKkDe9jDvDfVzrsgwxdjfemJIcm5opAaCZNWf6DXB
         qolYmHqkeNq3cKyNgoWsy42iu0Ref3WEqaAEjT7wdIty2VBiVn6dbQDFbB5fxfiQ0HVv
         8V0A==
X-Gm-Message-State: AOJu0Yz9SsAN/R9oaq1Ghzg0Rx+cIqc2b6IA5YxLAMCp1PzxsNlGkObp
	3SXIYdY8DqrU6ogMbSVQfuO6ephPDfc=
X-Google-Smtp-Source: AGHT+IEaMU/qyfvNK/VzMyGaINb1ldwY/ECFlo1I7A3qy8ZZY1ib6x75XnqVWaRgFESEoBAGDlvQyA==
X-Received: by 2002:a2e:9c09:0:b0:2cc:8dda:c96d with SMTP id s9-20020a2e9c09000000b002cc8ddac96dmr62223lji.28.1704996646631;
        Thu, 11 Jan 2024 10:10:46 -0800 (PST)
Received: from [192.168.1.105] ([31.173.82.245])
        by smtp.gmail.com with ESMTPSA id b15-20020a2e894f000000b002cd5b233861sm201538ljk.60.2024.01.11.10.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 10:10:46 -0800 (PST)
Subject: Re: [PATCH 2/2] ata: libata-core: Revert "ata: libata-core: Fix
 ata_pci_shutdown_one()"
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>,
 Wang Zhihao <wangzhihao9@hotmail.com>,
 linux-regressions <regressions@lists.linux.dev>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <20240111115123.1258422-3-dlemoal@kernel.org>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <d63a7b93-d1a3-726e-355c-b4a4608626f4@gmail.com>
Date: Thu, 11 Jan 2024 21:10:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240111115123.1258422-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 1/11/24 2:51 PM, Damien Le Moal wrote:

> This reverts commit fd3a6837d8e18cb7be80dcca1283276290336a7a.
> 
> Several users have signaled issues with commit fd3a6837d8e1 ("ata:
> libata-core: Fix ata_pci_shutdown_one()") which causes failure of the
> system SoC to go to a low power state. The reason for this problem
> is not well understood but given that this patch is harmless with the
> improvements to ata_dev_power_set_standby(), restore it to allow system
> lower power state transitions.
> 
> For regular system shutdown, ata_dev_power_set_standby() will be
> executed twice: once the scsi device is removed and another when
> ata_pci_shutdown_one() executes and EH completes unloading the devices.
> Make the second call to ata_dev_power_set_standby() do nothing by using
> ata_dev_power_is_active() and return if the device is already in
> standby.
> 
> Fixes: fd3a6837d8e1 ("ata: libata-core: Fix ata_pci_shutdown_one()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c | 75 +++++++++++++++++++++++----------------
>  1 file changed, 45 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d9f80f4f70f5..20a366942626 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2001,6 +2001,33 @@ bool ata_dev_power_init_tf(struct ata_device *dev, struct ata_taskfile *tf,
>  	return true;
>  }
>  
> +static bool ata_dev_power_is_active(struct ata_device *dev)
> +{
> +	struct ata_taskfile tf;
> +	unsigned int err_mask;
> +
> +	ata_tf_init(dev, &tf);
> +	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;

   Why set ATA_TFLAG_ISADDR, BTW? This command doesn't use any taskfile
regs but the device/head reg. Material for a fix, I guess... :-)

> +	tf.protocol = ATA_PROT_NODATA;
> +	tf.command = ATA_CMD_CHK_POWER;
> +
[...]

MBR, Sergey
