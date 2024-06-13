Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABE82F34
	for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305236; cv=none; b=VXcElQSwtjVp8P9JOdt/pXa8JWfKiriUndesbuBSmRBZM65uin24/WHMW/fY9DhV0FBh5+d2gffPfcMs3P47dc21stO4BQAKf5TIxRuKfY6e58X4J7ISTyLN9bvHdlbk2EHQJwC6/4pfznlV4UkqoLRKiCn3rpQXgdT26JoT3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305236; c=relaxed/simple;
	bh=ow/EwiTIKLTuAul3izACDe2m2JBIiyph/1i6pFb5ORI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CAyg5EiMekTH1AuT6PSyJhYpzMMadxH89aCH3cWL5OqHlJp8QBmy/bFJQb9qaem9T6b4pRsy2Cl5PD2TnBM2FuV68/q+pqn2wh8R6qmYX9cVcd/DDEz4QDbR7vh3AZdwht/7ZqjINHbVhQHAJo21CeTuYShZOnB0T+e71foLcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzOUpCON; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzOUpCON"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c32d934c2so1568074e87.2
        for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718305233; x=1718910033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZL9eSiHhLQBV2q8cmfyXzXkVQ+5oeN6uhY/avf4ev6I=;
        b=IzOUpCONrbGiyWwQqdbAtpqyxbostYnnJVcp5a6vshd6+vFlj40VeHKIFyRi1xCrZr
         f7zgcX2xe9zBmm/Go1Tix/5PDDmcktg6eUmr67pNvkd4f0beWZSSn5Ej/QeRmK/Rh1fm
         CwJQKK6JSl+IFbj9ksql7gWWX8U+4DFDIZG2uNpmB0IsOkh6wdnibVe03IZChv3g2uj7
         TFc8KJpi9awyFLTEEDPABf7mfjyFHuceyidwLnR6N6wMlWHNUtrcbqeUaqX247rK/zn3
         KAgFW+wLFLUM0KkZlarje4yLri+mvlZIbZj9LUv054XySejWAnQHUywDmmZYgG4I1PiU
         CFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718305233; x=1718910033;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL9eSiHhLQBV2q8cmfyXzXkVQ+5oeN6uhY/avf4ev6I=;
        b=jAQSzgU4IlZesN6e0GG9RDPKyPH3h9Shr/w+lkuirWJcXZkrZDEDKPNlkCIcZrFXxT
         y7iHXG1v8RR5PqeLIHIWfwIhYffykS/TzV4On1xR9CKjr/bY02ABJMERfjjfQLw5mPWs
         d4/uKJ5aeUr6MGXWX3RVius1KpL2cFU4fVqannS15rzwQ2zfjVInWYJB3RY+/gHGlDtY
         dtna5LXjP7OYlyrB+khqEHpJKj88vbXBKYMBfLhpyPuFBQGolmYJBa80t6oyRskjb0v4
         O9wOw5lRDyCg8p+tp1l/EKbFqeMCw6Ae8QCyiGO5I6Q/7SIshayn8syuFdV9RjR46ymN
         LYHw==
X-Forwarded-Encrypted: i=1; AJvYcCUywU6pE7GTdyHs2o5BIdPoD8t5gQ/Da/q3NYTjH37+XZJCPuF46v9yC7/jFgIuMp98FMfPfY7XDfuoipcJDmXit7Ib3kjCoUXR
X-Gm-Message-State: AOJu0YzarQ02+XtsyicpPSxA7DnndwGail4FYK5+Y8SOvBRpBvg2dqiz
	yp6VtPjCjifoaAkidEhbFOk9LrdICfOp3zHTene0gn2JBCeUlZNoUCO5iQ==
X-Google-Smtp-Source: AGHT+IEMrObdeGUtW99iTIbf/pjSOA8yuKiohgSUKEB3eMmrLTAn2z9TUhb5/c4cPzzd+/gaHVmsIg==
X-Received: by 2002:ac2:5324:0:b0:52c:a465:c61f with SMTP id 2adb3069b0e04-52ca6e987b7mr384156e87.56.1718305232430;
        Thu, 13 Jun 2024 12:00:32 -0700 (PDT)
Received: from [192.168.1.105] ([178.176.78.157])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f3e4sm319562e87.93.2024.06.13.12.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 12:00:32 -0700 (PDT)
Subject: Re: [PATCH] ata: libata-scsi: Set the RMB bit only for removable
 media devices
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
 linux-ide@vger.kernel.org
References: <20240613173352.1557847-2-cassel@kernel.org>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <60f1465f-c4da-5d0f-e395-8457a9287996@gmail.com>
Date: Thu, 13 Jun 2024 22:00:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240613173352.1557847-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 6/13/24 8:33 PM, Niklas Cassel wrote:

> From: Damien Le Moal <dlemoal@kernel.org>
> 
> The SCSI Removable Media Bit (RMB) should only be set for removable media,
> where the device stays and the media changes, e.g. CD-ROM or floppy.
> 
> The ATA removable media device bit is currently only defined in the CFA
> (CFast) specification, to indicate that the device can have its media
> removed (while the device stays).
> 
> Commit 8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as
> removable") introduced a change to set the RMB bit if the port has either
> the eSATA bit or the hot-plug capable bit set. The reasoning was that the
> author wanted his eSATA ports to get treated like a USB stick.
> 
> This is however wrong. See "20-082r23SPC-6: Removable Medium Bit
> Expectations" which has since been integrated to SPC, which states that:
> 
> """
> Reports have been received that some USB Memory Stick device servers set
> the removable medium (RMB) bit to one. The rub comes when the medium is
> actually removed, because... The device server is removed concurrently
> with the medium removal. If there is no device server, then there is no
> device server that is waiting to have removable medium inserted.
> 
> Sufficient numbers of SCSI analysts see such a device:
> - not as a device that supports removable medium;
> but
> - as a removable, hot pluggable device.
> """
> 
> The definition of the RMB bit in the SPC specification has since been
> clarified to match this.
> 
> Thus, a USB stick should not have the RMB bit set (and neither shall an
> eSATA nor a hot-plug capable port).
> 
> Commit dc8b4afc4a04 ("ata: ahci: don't mark HotPlugCapable Ports as
> external/removable") then changed so that the RMB bit is only set for the
> eSATA bit (and not for the hot-plug capable bit), because of a lot of bug
> reports of SATA devices were being automounted by udisks. However,
> treating eSATA and hot-plug capable ports differently is not correct.
> 
> From the AHCI 1.3.1 spec:
> Hot Plug Capable Port (HPCP): When set to '1', indicates that this port's
> signal and power connectors are externally accessible via a joint signal
> and power connector for blindmate device hot plug.
> 
> So a hot-plug capable port is an external port, just like commit
> 45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
> claims.
> 
> In order to not violate the SPC specification, modify the SCSI INQUIRY
> data to only set the RMB bit if the ATA device can have its media removed.
> 
> This fixes a reported problem where GNOME/udisks was automounting devices
> connected to hot-plug capable ports.
> 
> Fixes: 45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
> Tested-by: Thomas Weißschuh <linux@weissschuh.net>
> Reported-by: Thomas Weißschuh <linux@weissschuh.net>
> Closes: https://lore.kernel.org/linux-ide/c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de/
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> [cassel: wrote commit message]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-scsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index cdf29b178ddc..e231ad22f88a 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1831,11 +1831,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
>  		2
>  	};
>  
> -	/* set scsi removable (RMB) bit per ata bit, or if the
> -	 * AHCI port says it's external (Hotplug-capable, eSATA).
> +	/*
> +	 * Set the SCSI Removable Media Bit (RMB) if the ATA removable media
> +	 * device bit (which is only defined in the CFA specification) is set.

   It used to be defined since ATA-1; I think it was only obsoleted by ATA-8 ACS...

[...]

MBR, Sergey
