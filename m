Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5257875
	for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943458; cv=none; b=UnjPeUhZi0AkRx0j+v+C/F4J2ADP3JZcpXb5d5OTjalLFu1NT51VL8hQm2dodDTbwMYqD8j7tX2KXY9Q5Jn94Iy9gztVjx/ArH4/oSSHS6Y+L02B90e5iLyERnqhMcmUmzCag0Vs+xlnABFThKf3G74ez1tDeYhScPQfdKZu20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943458; c=relaxed/simple;
	bh=c7CEL1KsLmCAKCrRH2esptiLB0Mh8w88ZY5hcuib5fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfGU8RjTC6jLESEfQb0dzPUox/B5EkOlNlJF1xLLHgtdKdlKFqGFTPWZU9OrV/MwiyOTAdLLi/8Kb68cs1FrKIRl7pOPUIMN7BuFvuRQKa+23bs2i3iYdDAALxqbesi6LNdUct5wmnWdSIwRFKG9/KWJ06hoYikXaLiZZwZWDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDDKLLA/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDDKLLA/"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512f89250d6so958203e87.2
        for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2024 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708943455; x=1709548255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCWlyUKUiZ1t2SKiYeflvv+/+cNGnMdT/sg75HezJU0=;
        b=eDDKLLA/Hlur9UNGnJQngxVTMe1K682NG4LvJw1wNvvTPySzsoJOOP6rUWGk158F43
         s9zggXN+2GuLqds/qE0CaLvCwT/9oOE2c8jIxbdLc/2VDxs8Ese9X3cJ+MuDppp5LlL7
         YKORETVI1ecweV6WfjM0ZmP9iFNFoggSohhslbFG2E0yEPxzmia8H8MSzzthE8mCKbTv
         8vtuY7w131oULMEHWNdN7ajclV5sMn4HLEkEwe3+Qys9PaP0a9Op/+5AmldvAyxPsV1j
         RGUxOyp8nSTTRpF7mRF4enfZYxyDF6HYCFwMdEwgf8eaJ0thkIwxRD/rOt2r9BrqZ5kX
         d5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708943455; x=1709548255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCWlyUKUiZ1t2SKiYeflvv+/+cNGnMdT/sg75HezJU0=;
        b=r3ODMnQzAHUg/DVh5srIzrBsbz6WsRt/cv4qfZWVoA1pY4NEFHXvSMAwGAW0M6A9jP
         OryItF8iQdRrIv56N6hJg5qWGMXrTTiX3WJ2fo5LjAc+CMUXvvCCT5BzGbaioZzBTL3R
         AkPUtNN/ljYTr4VNNU81BdTWJBhwSGoq6gBTvUGKSqGNL+VOksBGAf/LGbBS/iWEcc3j
         0q8x9ycCEqPHYKIfQxjR/GbQQpUDMWQ2UyV2hPlFL279HvKWcfi1yPSosr49BUhkE7Ho
         0BaXbDixOKHyGN2WVJoiOsiyXYgxe9xHh2YvsQQoI7mIawgdyGMHdCJ/kRBE8zhJI3mU
         URAw==
X-Forwarded-Encrypted: i=1; AJvYcCV1o8k3AIQ6tfy8x7pfS/U2mqHzal6GoSwuX1U2BeoDYBBA/4T2+xXIphn1ei2o63vW3ZHn2E09r+H+zK5EgU9ICr3wBVp032ar
X-Gm-Message-State: AOJu0YyjGsAuJUzzAVSpq6DIQyI1k5/GV1bzA2bM64WLmIqTmjVECIJ+
	6xIUdM4Sz8yRGcc5iqHtP+aCSi3Qei1FXIuvpruIw+WBdSoTaK2e
X-Google-Smtp-Source: AGHT+IF+85Ra2z7cQuqf/YiwJQhvwWBdGL7qrPsTo9A1DBttVpITaRAN0pVgbDiUy2MFUbmrQCivNQ==
X-Received: by 2002:a19:700e:0:b0:512:d91f:2e57 with SMTP id h14-20020a19700e000000b00512d91f2e57mr3500251lfc.55.1708943455011;
        Mon, 26 Feb 2024 02:30:55 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i19-20020a056512007300b00512dec300desm799084lfo.96.2024.02.26.02.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:30:54 -0800 (PST)
Date: Mon, 26 Feb 2024 13:30:51 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: "Andrey Jr. Melnikov" <temnota.am@gmail.com>, 
	Serge Semin <Sergey.Semin@baikalelectronics.ru>, Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: stop using saved_port_map for quircks
Message-ID: <7dqno5cm5tpybmynflxc6pvkrhjgiccpwqnxmfcbvdz2lxna5u@hdnmazlsapbq>
References: <bc76towgdmpv3xilmhlerrshpubrd7feecl2tu6xanwtbkv3ze@zwizzrmcu43w>
 <ZdxgdOTtoqNF2ch7@fedora>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdxgdOTtoqNF2ch7@fedora>

Hi Niklas

On Mon, Feb 26, 2024 at 10:57:08AM +0100, Niklas Cassel wrote:
> Hello Andrey,
> 
> On Sun, Feb 25, 2024 at 12:55:42PM +0300, Andrey Jr. Melnikov wrote:
> > 
> > Stop using saved_port_map for masking port quirks, use force_port_map
> > instead.
> > 
> > Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
> > 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index 682ff550ccfb..066e3118801c 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -675,18 +675,18 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
> >  		switch (pdev->device) {
> >  		case 0x1166:
> >  			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> > -			hpriv->saved_port_map = 0x3f;
> > +			hpriv->mask_port_map = 0x3f;
> >  			break;
> >  		case 0x1064:
> >  			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
> > -			hpriv->saved_port_map = 0xf;
> > +			hpriv->mask_port_map = 0xf;
> >  			break;
> >  		}
> >  	}
> >  
> >  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
> >  		dev_info(&pdev->dev, "JMB361 has only one port\n");
> > -		hpriv->saved_port_map = 1;
> > +		hpriv->mask_port_map = 1;
> >  	}
> >  
> >  	/*
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index 1a63200ea437..cc705d3bdc50 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -531,16 +531,10 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
> >  		cap &= ~HOST_CAP_SXS;
> >  	}
> >  
> > -	/* Override the HBA ports mapping if the platform needs it */
> >  	port_map = readl(mmio + HOST_PORTS_IMPL);
> > -	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
> > -		dev_info(dev, "forcing port_map 0x%lx -> 0x%x\n",
> > -			 port_map, hpriv->saved_port_map);
> > -		port_map = hpriv->saved_port_map;
> > -	} else {
> > -		hpriv->saved_port_map = port_map;
> > -	}
> > +	hpriv->saved_port_map = port_map;
> >  
> > +	/* Override the HBA ports mapping if the platform needs it */
> >  	if (hpriv->mask_port_map) {
> >  		dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",
> >  			port_map,
> >  
> 
> Before this patch, if there was a quirk, e.g. saved_port_map was set in
> ahci_pci_save_initial_config():
> 
> then in ahci_save_initial_config(),
> we would not store/overwrite saved_port_map with readl(HOST_PORTS_IMPL).
> 
> After this patch, saved_port_map will contain ports that might
> have been "disabled" by a quirk.
> 
> 
> Have you verified that this logical change is okay in all the
> places where saved_port_map is used?
> 
> E.g.
> drivers/ata/ahci_dwc.c:ahci_dwc_check_cap() seems to iterate over:
> unsigned long port_map = hpriv->saved_port_map | hpriv->mask_port_map;
> 
> which would be different before and after this patch.
> 
> Serge, any comment?
> 
> 
> 
> Also ahci_platform_get_firmware() seems to set
> saved_port_map based of device tree property "ports-implemented".
> 
> Before this patch, saved_port map would still contain that value from
> device tree, after this patch, that saved_port_map will be overwritten
> with readl(HOST_PORTS_IMPL).
> 
> Again, this code is authored by Serge. Serge, comments?

Thanks for Cc-ing me. Sorry, I am a bit busy right now. I'll have a
closer look on this patch later on this week.

-Serge(y)

> 
> 
> Kind regards,
> Niklas
