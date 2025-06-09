Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3019ABD8
	for <linux-ide@vger.kernel.org>; Mon,  9 Jun 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480565; cv=none; b=EkHQLhIaWRejkG/TST7gdqBYZuwb8eaxbsgMFGtlytsg6YU/0bHrKmIbhKs7pHUnsmnsWv/rP7lMh/87f8jfhE562Z/Z7V6UIISFygtfvCyuVqulHZdvTtTbIYkpt/itQf4qcTHswR7wJiFMD2TcZGGRX860iZ0MuJyS5V3y0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480565; c=relaxed/simple;
	bh=daKXwW+BJu08OEr/zgxGMldNFNXDWbPLqMciurIUmOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lz4pWfy2t4b7o0B/gk8BeUN/xX6ZoX0nsh93ggvFxxqy/AikPd5U3MGQ4Jx7EZH1GMuVRpOt3ceRYVpJKkxIc4ezx+6JFxoG5dAxUAfA9rB8i00yENHItOn3ClbwZkntMEo6QmOBZyNUY+qRN4saecATgxV+/Lv9UJ+tfepX9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NL9NnH5a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NL9NnH5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749480562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr/cb7vIXqTLUnN3MrKTcXChu8MG+duLCL6zmeO6U74=;
	b=NL9NnH5apH8PXPIM7pjrJ18ksbQgAhrrCQsO5RGDHTfZ1jkc0KXcuq1ELAnZYKg3vy2yOv
	1uQZfTMweHKzY8pyUm0up2ppWvPQSi1tPfvFs0bR5k1L5oAVkM4FT8YWWKwpyvMQTLWW6S
	xyHhEoDa+xZdTWvuPcUi9ipPysHYz4o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-vnxCeSo_NRmReLGwZIXhzQ-1; Mon, 09 Jun 2025 10:49:20 -0400
X-MC-Unique: vnxCeSo_NRmReLGwZIXhzQ-1
X-Mimecast-MFC-AGG-ID: vnxCeSo_NRmReLGwZIXhzQ_1749480560
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade70c2cfc1so22658566b.3
        for <linux-ide@vger.kernel.org>; Mon, 09 Jun 2025 07:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749480560; x=1750085360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr/cb7vIXqTLUnN3MrKTcXChu8MG+duLCL6zmeO6U74=;
        b=texXKW2JQoXNVPWhApef/Wosmk7Rk9dUvbTg6tUCuKdCM/DMRyBsDEQrpDLi32xRjq
         Fl6sAf3eZRPujdYteCF9G1NnuiKQi/o4snFZYYH2PFM/1txwlwv/AnMwjlo2lP7ltU4G
         nn4HM8VuW5qRB6cceytkqCa3dkmHVQFQh2bvUw9eDJbCWKTepIUW9PPo1/UublVCXZFH
         tZAKzrTbDCPuEYaMQmgy4NLckYjzn2s0BYT0f3sT+QC+AelLFRjYIcakFYajV+gaQtGP
         hmzPDiWmYKMWkNrQ6065B3M2U7V87kEise53ilF5QIrUOH2A61Lr9vXbtC2tW5wnSNw0
         nKng==
X-Forwarded-Encrypted: i=1; AJvYcCXXldrIFVmSQd7/QIzZDxUUUggwjSnmrCXW3ngIFi21gz9E5aIxfPvHkV9hGm+XtlIUHH9ySN9eUfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzznd0U5UFD4sbnn37v/n+rrHNuAWobKA/XsW0/E9gZy6cbqOMr
	9vvui97iY3r5XmmwClvqxf9YTip4PnpWM8Mrvzm6myh2Ng0uf4EEZl2l7xxiKqNASNu8/97VSgo
	3STrzZqNZvTyJ1wehO0/41PGpIhDo1Vnk9b9ZTWurgkaJB292dd6/jJM2LYSA3w==
X-Gm-Gg: ASbGncvSHoOshk28+ech5+G3eadTF3dS1NQI/I2jEUmmbrjKFl+KLqGEdwBi1YlG18E
	0sWWwexuX1z4UXLwb0MrwruJYCDKMnAYv+BsRbfsR7Ba6QYs9E8m5mLM5xAU3f+Lrw0Wiwc627m
	oFu5lpOtQ/eoWOQd5b4+xrjkaT/5VIo0xeaetYzJaxlqcF7S1FgeBavP8aOoKpcJRrDQRdwjWtC
	7wvh/FJEU8SwwP/JLxDICZyShTRRWnpRfsmfu6GNu73KX2vUskxcw4156HegtoK8tVI0IO3pvN3
	xkDktcWXQkhXWobKFbwXxmq3aiba110RykEHm0yndba1PvAIqTbm0Hb6gwYAwOzYBfgYvQUuwv5
	RTU0sNDW0bQdNCxY+Kokeeq0om6TWL77Rxn/086/RChOcRC6fIYwXyI7m5+bk4Q==
X-Received: by 2002:a17:907:86a8:b0:ade:9fb:b07d with SMTP id a640c23a62f3a-ade1a8e9cf8mr1377065466b.4.1749480559684;
        Mon, 09 Jun 2025 07:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi+vj8f6+0p0qzeQ+UGo7KFbmqUn1rDkUQ2q48IW1vkbnj6J3hbKIReaLKWAIbFDI+JN1eEg==
X-Received: by 2002:a17:907:86a8:b0:ade:9fb:b07d with SMTP id a640c23a62f3a-ade1a8e9cf8mr1377062766b.4.1749480559198;
        Mon, 09 Jun 2025 07:49:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7c786sm574086066b.172.2025.06.09.07.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 07:49:18 -0700 (PDT)
Message-ID: <6ea509c8-b38d-4941-8a29-c1117ff3dd5b@redhat.com>
Date: Mon, 9 Jun 2025 16:49:17 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: ahci: Refactor ahci_broken_lpm()
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20250609134539.943587-3-cassel@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250609134539.943587-3-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 9-Jun-25 3:45 PM, Niklas Cassel wrote:
> Currently, the match table in ahci_broken_lpm() contains DMI BIOS dates
> of BIOSes that are known to be working.
> 
> Having a list of known to be working versions is usually the wrong way to
> do things (as this list could theoretically be infinite).
> 
> Refactor this match table to contain DMI BIOS dates of BIOSes that are
> known to not be working, such that this list can be extended with BIOS
> versions (for other boards) that are known to not be working, where there
> is no good BIOS version (because all released versions are broken).
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 163ac909bd06..a6ce172fa928 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1411,27 +1411,39 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
>  static bool ahci_broken_lpm(struct pci_dev *pdev)
>  {
>  	static const struct dmi_system_id sysids[] = {
> -		/* Various Lenovo 50 series have LPM issues with older BIOSen */
> +		/* Table contains DMI BIOS dates of BIOSes with broken LPM. */
>  		{
>  			.matches = {
>  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X250"),
>  			},
> -			.driver_data = "20180406", /* 1.31 */
> +			/*
> +			 * 1.31, released 20180406, has working LPM, mark any
> +			 * DMI BIOS date before that as broken.
> +			 */

Note the DMI_BIOS_DATE field is the data the BIOS was build, I would avoid
the word "released" here since release-notes doucments often contain different
dates then the actual build date (e.g. see below).

> +			.driver_data = "20180405",
>  		},
>  		{
>  			.matches = {
>  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L450"),
>  			},
> -			.driver_data = "20180420", /* 1.28 */
> +			/*
> +			 * 1.28, released 20180420, has working LPM, mark any
> +			 * DMI BIOS date before that as broken.
> +			 */
> +			.driver_data = "20180419",
>  		},
>  		{
>  			.matches = {
>  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T450s"),
>  			},
> -			.driver_data = "20180315", /* 1.33 */
> +			/*
> +			 * 1.33, released 20180315, has working LPM, mark any
> +			 * DMI BIOS date before that as broken.
> +			 */
> +			.driver_data = "20180314",
>  		},
>  		{
>  			.matches = {
> @@ -1439,12 +1451,14 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>  				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W541"),
>  			},
>  			/*
> -			 * Note date based on release notes, 2.35 has been
> -			 * reported to be good, but I've been unable to get
> -			 * a hold of the reporter to get the DMI BIOS date.
> -			 * TODO: fix this.
> +			 * Note: according to release notes, version 2.35 has
> +			 * working LPM, but we do not have the DMI BIOS date for
> +			 * this version, so the date, 20180310, is based on the
> +			 * release notes. Mark any DMI BIOS date before that as
> +			 * broken.
> +			 * TODO: find with date with DMI BIOS date.
>  			 */
> -			.driver_data = "20180310", /* 2.35 */
> +			.driver_data = "20180309",

This reminds me that I did eventually got the actual BIOS date from
the reporter. After some digging I managed to find the email.

The first known working BIOS has a BIOS date of 04/09/2018 so that
would become "20180409" before your patch / "20180408" after your patch.

I guess you may want to add a prep patch before the rest of this
series before this patch to make things a bit cleaner.

Regards,

Hans





>  		},
>  		{ }	/* terminate list */
>  	};
> @@ -1458,7 +1472,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>  	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
>  	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
>  
> -	return strcmp(buf, dmi->driver_data) < 0;
> +	return strcmp(buf, dmi->driver_data) <= 0;
>  }
>  
>  static bool ahci_broken_online(struct pci_dev *pdev)

