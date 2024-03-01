Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BB6A351
	for <linux-ide@vger.kernel.org>; Fri,  1 Mar 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285577; cv=none; b=oTIm0fUBkjNeAW0UTk6wuwpxt7avN3yls3HAYA9ldF3ZRLhv+JQPOG+7rihN8WKYUhYr4fyaxq1JB0fGTfcku0ajqU0HxJb2592Zajwi3MrMXVBByqG2ogIKGq9x5JlRMNT8YQmh739hzqS/alS78o0Lt/yH70gRbLvZYxYuR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285577; c=relaxed/simple;
	bh=Ge/nLoDJwKBTNn89sfF75oEYy19UNAoTfTFaHEVsAj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juWuqH8v0f+sHlhKNKsLIZNzbN9dem5Z4mCaiLWdX24RBPzpM8U8tVSN4jt3KwbUQzo+y1gTykReGi/GnA/8xKb21AEWoRyg8DbienHcVora0AnXO7tHxiQKSVVgdv5WAO7zPvuQ0OwKpyBQsdsxjcV+74CpVwwbqmWEHdXw+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5ote/Rr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5ote/Rr"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5131316693cso2370827e87.0
        for <linux-ide@vger.kernel.org>; Fri, 01 Mar 2024 01:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709285574; x=1709890374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrqtIe3UQ8Q3eBCOxPPS34n+kTZG+hv0uBlFFT4E78I=;
        b=O5ote/RrEBtjYP13v92WmmO7l/BgnkBN77y/qGh2ISu/jd4hV0XdiBMu1GW10YdRW7
         U8jGqDSL1l59nCIAMJU5Bx9ly87UytEuostqAdfArGPJwWABKM8WfZ0PKtpnCwLjalgX
         U+PQl7FzUuRhe394t5kRVTCFWSJ3OjDzcZrmANYaGvxCJT3axjlY/XgayJAb8kf+iymP
         lYkKzvOiHTOpgjG0Bc0/gcIdln/TEB1W4tgoYuU173egj8B8PYGFP0YECnUqnJK0TaoH
         fTeg71hPSyOuGyUR0vUCBksiCNOJq2awZ6EMCoLsou1yMipl3TqBGvEXWrhvWVeBKYIe
         PrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285574; x=1709890374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrqtIe3UQ8Q3eBCOxPPS34n+kTZG+hv0uBlFFT4E78I=;
        b=bhNDW+HeL3klPspx6ubd5Q3tz/ybQfpthq+O+kXlgXDxUTyZV6lBn9jh9LOZw8osqs
         k+yl/HSrG7gYDZkmnl/rtc7/SNAEjCdHR2xw4bQmpJbDX9z3ehM0MqSmcd8b/x0HQ7PU
         olZQazduhTxIDpIBqpyMuVu4t9lDUW18zzClEELMA6DaAJqrpyXYJY3j0lItZR9sh9xK
         4KCnUn0dYUwRSB1bJDmEYMze3oLn3xovVo0Cd3v1PdcC/NU3r0Hb7YK9IGM1AgoWq28p
         /4sI97JIAz3Kgfc/csCGXfd43AmW8nDQX9IsHmoBIPXjgG/y9U0nmG0Yhm/ZjZW8/8UL
         zcrA==
X-Forwarded-Encrypted: i=1; AJvYcCXVZpCuc420CTKlq/F7Km+B591l1b4c2rd28bzqaeH/jEMIdGQgjEX2b4VywEwkY7hvuDkHH1u84yT8ws4M+On1ExbnMLZYtihL
X-Gm-Message-State: AOJu0YwMO/1/H5qQsAveNM0ViVFdg6XxhWtc0QMNnt8zzFiMVNoTecNv
	02mmv1mutRGy3moMtnc1LAOcyAC8tjtigoC54KDMH3kmqe4tx54C
X-Google-Smtp-Source: AGHT+IG9BYElqH2Dj6D1DMsCIRftpEhINoWURWeE4dXzFtzNS2GO9rub9sy6kHFfilhQWW+9K/1Efg==
X-Received: by 2002:a05:6512:3ba8:b0:513:1e8a:f1a5 with SMTP id g40-20020a0565123ba800b005131e8af1a5mr1146082lfv.5.1709285573643;
        Fri, 01 Mar 2024 01:32:53 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id ep2-20020a056512484200b005131434454bsm551352lfb.228.2024.03.01.01.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:32:53 -0800 (PST)
Date: Fri, 1 Mar 2024 12:32:50 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Niklas Cassel <cassel@kernel.org>, 
	"Andrey Jr. Melnikov" <temnota.am@gmail.com>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: stop using saved_port_map for quircks
Message-ID: <uu2exwldqvbdjus6t4r3cxuto5jpeqtjfvc7qiikulfwiyntf3@j4btf2bt23ld>
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

Hi Niklas, Andrey

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

Absolutely right. The change breaks the saved_port_map semantics. The
main purpose of all the ahci_host_priv::saved_* fields is to
save-restore the controller capabilities across device resets
(suspend/resume). About two years ago the semantics of
ahci_host_priv::{saved_cap,saved_port_map,saved_port_cap[*]} was
extended so the fields could be pre-initialized with data by the
low-level drivers thus overriding malfunction or uninitialized
controller ports mapping and capabilities. Andrey's patch breaks the
last part by force-writing to the ahci_host_priv::saved_port_map not
taking into account that it could have been pre-initialized. Moreover
ahci_host_priv:mask_port_map semantics is different from what is
implied by ahci_host_priv::saved_port_map:
1. saved_port_map defines the ports actually available on the host
controller.
2. mask_port_map masks out the unused ports if it's initialized,
otherwise all available ports will be initialized and utilized.

So the later field can't be that easily replaced with the former one.
Thus if this patch is applied:

1. The "ports-implemented" DT-property will no longer work since it's
primary goal is to override the data in normal circumstance retrieved
from the PI register.

2. The ahci_pci_save_initial_config() will be broken for Asmedia and
JMicron, since the number of available ports will be retrieved from
the PI register while the original semantics implied forcing it to a
particular value.

-Serge(y)

> 
> 
> Kind regards,
> Niklas
