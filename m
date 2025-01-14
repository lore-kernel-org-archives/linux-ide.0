Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC15215059
	for <linux-ide@vger.kernel.org>; Tue, 14 Jan 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877875; cv=none; b=KewEX9U0BRJSW83GHlQyhNeL4PkBMxXVnfkWb9pF4w0tcX42BSYa6et+QGOLe3wAZMeFiEN9AMhLR/Pc0WE3EtW/05nMcqoVcORG8x3PTrTK5WDREREIizr66QvSoY6a6Mi9j6ECzpkiquoMnV9hq5lvTxqT8mGy1tTOHBz9YlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877875; c=relaxed/simple;
	bh=/76MFp8+ELc76b9WkGApPac7KL4n08mhVwBhhtcc6TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/vjYA///QdL+vNM8jsui9NMqP7RMAJA3qjJe9w33jcp/0gVgOexuirIZxi0Rp/xhBGTYRj1a9DQill/W6iwVk0VKpMhsv2OQBjwXaMKyfwF18yNE53qopcgfyscjroXXdsZ9YJyrgnKs68EZo/1Ww9Oso8+h22TqlM2SmSVme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ok7DtQ05; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok7DtQ05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736877872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkSv8dzzOzHq5nzalhOvIVJZ0jUdhm2v/a+p0Jga0iw=;
	b=Ok7DtQ05FpAzZCC8lAo6ZKLataP3k/h2DXSKl5A8mWQJxRKWcUyKmeIzKdQIYEwf7dZW/y
	N4wIs6FdrykTtaphlDuys46OPdFIM6eHNuaEQnpx4NDecxtOYevLXkhp/k9Whcw6qy/qhH
	eUFI7xZhyfNQaW/eeJW+AjtTDM0fx7s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-tTYkk7DaPtuC7ByoTjRvuA-1; Tue, 14 Jan 2025 13:04:31 -0500
X-MC-Unique: tTYkk7DaPtuC7ByoTjRvuA-1
X-Mimecast-MFC-AGG-ID: tTYkk7DaPtuC7ByoTjRvuA
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aab954d1116so619671366b.3
        for <linux-ide@vger.kernel.org>; Tue, 14 Jan 2025 10:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736877869; x=1737482669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkSv8dzzOzHq5nzalhOvIVJZ0jUdhm2v/a+p0Jga0iw=;
        b=xITjijBfd2c0oP5wJb61kadUMU2nLk2nWJ0zJHmhn5VqHmNTj8NvjI8wv+WRjPLmyE
         ao33uO3dD4/SkPH0VNWNms7vXDrY6Omt6RHQ8QrTJAQyvCSatnEactCx1qKKypszAps3
         A9Tnk5TShpNUUdPDDc5VgHIQqGBPmckg5Bcjw4WzbX4rFb0eP4K41DkNeOwN3lnNFF89
         YtaJa7vSd7OnfbzVyszUAtLZxANkrTZy2fV+l5BLYENsmBpS6JDYyafnAIH4K41xNYJB
         luo4Gmtx/NmPTyADLzs0FzVTgU7YDNOJWLiGViEwCntxNupP2mRFbSVqmVZkl0G4M1Ab
         R35A==
X-Forwarded-Encrypted: i=1; AJvYcCXJkiuJzCnpMvQ4uj8oXRmSGcPOvzIlflqalUV44GQrNuquYmUxtpN3Gp181cwE+TTz4DzmrcYDmr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze0PMTErVjwTMYQxK1BeJbmY601vzNOts2snDsYBXEU6yH52Eh
	0Ja84ZdntZ/8DP4ja+kjGLsp03lvA6tvE+YYKjvNYPRsnHOXzE1mW4mIbWskiR7WRNT7Av4s+tX
	68zj9YASC91JksobsySj5MqKistVn33OYWsBDHAzh6cebJFpo/n/t7b1oQ0Y+79QsLg==
X-Gm-Gg: ASbGncsRGwjt5mIqYPN226jvj6ln63BBcZYIniJQT+sdn0LqQtgmEvs/eaqhCu8cIE8
	5DavqIpux+zNLmss/i8c+X0q62w/RlmP57rRehnRHo7Ild48SudrnMstua+wGLEgZ35j8ifIW/J
	CrOXsROiXCCPWdeTJgPPoudadHr11MSYKddAPKeyvizSzrFtZ832VBoAXTcypvUYWYTPSiAPX6/
	v4yey4xIscCodfu18eevzMKIZdXSK0S8QIcDl5B3mPnR4wgOBRJDHEP1RJ4ShGwTGMyfgFqrBHK
	2BrsFNgeazKf
X-Received: by 2002:a17:907:daa:b0:aa6:9ee3:e51f with SMTP id a640c23a62f3a-ab2abc6f09fmr2900378866b.41.1736877869481;
        Tue, 14 Jan 2025 10:04:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYVUSskjoQsDAe0lp0zquG8nvqbhZGtYQfG9CsfrwZCpLY/siZFipAEq4heCdU8HTptziTbA==
X-Received: by 2002:a17:907:daa:b0:aa6:9ee3:e51f with SMTP id a640c23a62f3a-ab2abc6f09fmr2900371466b.41.1736877868743;
        Tue, 14 Jan 2025 10:04:28 -0800 (PST)
Received: from [192.168.0.111] (78-80-81-245.customers.tmcz.cz. [78.80.81.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d5c9asm653859766b.45.2025.01.14.10.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 10:04:28 -0800 (PST)
Message-ID: <8e48dd5f-16c8-483e-87fc-c53100c2b02b@redhat.com>
Date: Tue, 14 Jan 2025 19:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] simplify init function
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Niklas.Cassel@wdc.com
References: <20250113163401.35969-1-thenzl@redhat.com>
 <2826e5d0-e4d9-4aaf-aab6-4d36a9f2e73d@kernel.org>
Content-Language: en-US
From: Tomas Henzl <thenzl@redhat.com>
In-Reply-To: <2826e5d0-e4d9-4aaf-aab6-4d36a9f2e73d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 2:03 AM, Damien Le Moal wrote:
> On 1/14/25 01:34, Tomas Henzl wrote:
>> by removing few lines. No functional change.
> 
> Looks OK to me, but:
> 
> The patch title should be: "ata: ahci: simplify init function"
> 
> And the commit message should also describe why it is OK to change
> ahci_init_irq() to be a void function. Can you send a V3 with that addressed
> please ?
sure
> 
>>
>> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
>> ---
>> V2: ahci_init_irq is now a void function
>>
>>  drivers/ata/ahci.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 8d27c567be1c..3ea2f3adf354 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1665,13 +1665,15 @@ static int ahci_get_irq_vector(struct ata_host *host, int port)
>>  	return pci_irq_vector(to_pci_dev(host->dev), port);
>>  }
>>  
>> -static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>> +static void ahci_init_irq(struct pci_dev *pdev, unsigned int n_ports,
>>  			struct ahci_host_priv *hpriv)
>>  {
>>  	int nvec;
>>  
>> -	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
>> -		return -ENODEV;
>> +	if (hpriv->flags & AHCI_HFLAG_NO_MSI) {
>> +		pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
>> +		return;
>> +	}
>>  
>>  	/*
>>  	 * If number of MSIs is less than number of ports then Sharing Last
>> @@ -1685,7 +1687,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>>  			if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
>>  				hpriv->get_irq_vector = ahci_get_irq_vector;
>>  				hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
>> -				return nvec;
>> +				return;
>>  			}
>>  
>>  			/*
>> @@ -1700,12 +1702,13 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>>  
>>  	/*
>>  	 * If the host is not capable of supporting per-port vectors, fall
>> -	 * back to single MSI before finally attempting single MSI-X.
>> +	 * back to single MSI before finally attempting single MSI-X or
>> +	 * a legacy INTx.
>>  	 */
>>  	nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
>>  	if (nvec == 1)
>> -		return nvec;
>> -	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
>> +		return;
>> +	pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_INTX);
>>  }
>>  
>>  static void ahci_mark_external_port(struct ata_port *ap)
>> @@ -1985,10 +1988,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  	}
>>  	host->private_data = hpriv;
>>  
>> -	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
>> -		/* legacy intx interrupts */
>> -		pci_intx(pdev, 1);
>> -	}
>> +	ahci_init_irq(pdev, n_ports, hpriv);
>> +
>>  	hpriv->irq = pci_irq_vector(pdev, 0);
>>  
>>  	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
> 
> 

