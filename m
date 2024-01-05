Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3622316
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVc54dGF"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so1709662e87.2
        for <linux-ide@vger.kernel.org>; Fri, 05 Jan 2024 00:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704445064; x=1705049864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JamPgMG/L41NlkUbMkzq9RLf2HYV3ezJt3uDw4u+NoE=;
        b=FVc54dGF+lb1ggC1/vIjniQkfWfqMttr1UuTBQb6v6JQvtXDugXUpmvugnQKW9Vw1+
         2MgDJswxHyIavWIDHTf2tEbnoEdZmzp/DRn5aZ1hgvfBju1PVWdhyI3ezw5jOEhmseXl
         TYcYkoWAlr37Jzzc2Y2VsIAG2Z7zXBNqESM/Cz9StUSIbzSQgGz4a98LuC2snhNNLVuH
         xQsKAdZlAPh9fveRcLMaGU0Ef9tZely5JpMrX9aZA8N9XVpQXNJUSCQbyNiaaQTjZudQ
         Tnn2TjnWo5QsSiOa9yjnf5HAdGejSs6TGAo+zJd1aU2MqHDhN/WiBzmHAJDT6ubrdPSX
         GdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704445064; x=1705049864;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JamPgMG/L41NlkUbMkzq9RLf2HYV3ezJt3uDw4u+NoE=;
        b=W5K3bDOQNPVd6eVNdO2SzBv9ODFEzlbf+BmJQeqamfavXPbIXAG/q2413yv0ReewDZ
         EUCP1OGUYFM2//t5ggF+QbePqgNXWW3q29/6UlPvaI0BTBagkPWyxy7dskVVr7KblRXy
         UDi31/orfXRLlwl0xxyhB+EfHe1vnFMteX1acZcUrlYPjgt0vuN1dbkvr4vfZeZTfSiL
         duFUDdrKBzuz6xds8s1RqJxAbWlzUEwdK2/f1IgKV5UzkA5c9gkpm5BEK5MEN1Y60Qil
         h/2h6RQ7BGtB553jsA5yAaeHKBGbgiONBtjuCabOTPecFLkN0JvopDkTFr3rbvaNBFS2
         iwrw==
X-Gm-Message-State: AOJu0Yw1p+dy26AysxU+aJhRacn79ZaUcjSdG3AEEzZuhEFlRXlNQCF4
	n6hYSavVCEnrJ1yy1RqQEvzPOITCjC8=
X-Google-Smtp-Source: AGHT+IEhfHdSnt7MXPyc7g8j5s6ZcmhNsicUbPO1XiOyXw0I5ZFO5MMC8qYaIjALMji/miXlRIJh8g==
X-Received: by 2002:ac2:5f57:0:b0:50e:7281:6e72 with SMTP id 23-20020ac25f57000000b0050e72816e72mr859036lfz.109.1704445063753;
        Fri, 05 Jan 2024 00:57:43 -0800 (PST)
Received: from [192.168.1.104] ([178.176.73.147])
        by smtp.gmail.com with ESMTPSA id p10-20020ac24eca000000b0050e84c6bf99sm178656lfr.249.2024.01.05.00.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 00:57:43 -0800 (PST)
Subject: Re: [PATCH 4/4] libata: don't start PuiS disks on resume
To: Phillip Susi <phill@thesusis.net>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-4-phill@thesusis.net>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <5f450363-0518-7559-34ca-7c22b32746bb@gmail.com>
Date: Fri, 5 Jan 2024 11:57:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240104223940.339290-4-phill@thesusis.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 1/5/24 1:39 AM, Phillip Susi wrote:

> Disks with Power Up In Standby enabled that required the
> SET FEATURES command to start up were being issued the
> command during resume.  Suppress this until the disk
> is actually accessed.
> ---
>  drivers/ata/libata-core.c | 24 ++++++++++++++++++++++--
>  drivers/ata/libata-eh.c   | 12 +++++++++++-
>  drivers/ata/libata.h      |  1 +
>  include/linux/libata.h    |  1 +
>  4 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d9e889fa2881..3f6187c75b16 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1912,7 +1912,25 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
>  			goto err_out;
>  	}
>  
> -	if (!tried_spinup && (id[2] == 0x37c8 || id[2] == 0x738c)) {
> +	if (flags & ATA_READID_NOSTART && id[2] == 0x37c8)
> +	{
> +		/*
> +		 * the drive has powered up in standby, and returned incomplete IDENTIFY info

   s/the/The/.

> +		 * so we can't revalidate it yet.  We have also been asked to avoid starting the
> +		 * drive, so stop  here and leave the drive asleep and the EH pending, to be

   Double space...

> +		 * restarted on later IO request

   I think more common form is I/O.

[...]
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 799a1b8bc384..74e0d54a204e 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
[...]
> @@ -3075,9 +3078,16 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  			ata_eh_about_to_do(link, dev, ATA_EH_REVALIDATE);
>  			rc = ata_dev_revalidate(dev, ehc->classes[dev->devno],
>  						readid_flags);
> -			if (rc)
> +			if (rc == -EAGAIN) {
> +				rc = 0; /* start required but suppressed, handle later */
> +				ehc->i.dev_action[dev->devno] &= ~ATA_EH_SET_ACTIVE;
> +				ata_dev_warn(dev, "Leaving PuiS disk asleep for now");
> +				continue;
> +			}
> +			else if (rc)

			} else if (rc) {

>  				goto err;

			}

   You need {} on all *if* branches if at least one has it, as dictated
by the kernel coding style...

[...]

MBR, Sergey
