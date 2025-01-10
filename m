Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BA212D6C
	for <linux-ide@vger.kernel.org>; Fri, 10 Jan 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525680; cv=none; b=h1ZJT8qRTmhbDHhMEpeR/gl0TBxjKLAXovdSiD9RN7ocGlptyf4z4CRXI0+/1Lt4ovxLMU4KCNVsPHtsPGygpaN/NL7nbl9cFj70Cb5+ZuerDFkd/6MJ+qb4Z59LRbFShFipNouIp+npi94bgDXX/szm6Ix8yZyY4rUsE1bro68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525680; c=relaxed/simple;
	bh=ZbPQpMiOmFNu9Gb6ORjjiTatqB/B09gNf2FWC4q9UEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OhpsnrS3tFBLK4WYK4TEk1w975qBGlLlWyqCGFaMC5+mJEo4Id0IWir4yw6RgWcmvfdPzuURaMUJlenLdjzoW4zBbO0ZdzH9DOx/88s+G8on2vdcWRpLliLKU9FzSc3pTh7AFR8QSDtxuxLBCpQO+78yY7vfqOaytMOrHLGcrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Me0FyCsK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Me0FyCsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736525677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnUcFIXZpfnu0HUxxB4brL2dWNN7A97oYUjqFrGCKvk=;
	b=Me0FyCsKFbnv58fEi3S9fpPUfVyr8dz4uvxGv1fFHY7TzziNj1gSv2/sqqeaAiv0lpQm/Z
	fr4lV9NtPNP0cz0II0sbNBmuoII2g79EErdAwBOSbe5P266PlxQzyh6fASH4G1OMcCkDtS
	5JoZdJ2h351XxVx3LEuF1FASOuSotRE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Ytjiz4olNtOmhEBoNgf0Jw-1; Fri, 10 Jan 2025 11:14:35 -0500
X-MC-Unique: Ytjiz4olNtOmhEBoNgf0Jw-1
X-Mimecast-MFC-AGG-ID: Ytjiz4olNtOmhEBoNgf0Jw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362f893bfaso12062735e9.1
        for <linux-ide@vger.kernel.org>; Fri, 10 Jan 2025 08:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525674; x=1737130474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnUcFIXZpfnu0HUxxB4brL2dWNN7A97oYUjqFrGCKvk=;
        b=voVhH6dUqgbLyyzieAGQZZIA39HwGICdVUxeF3tGVQkxJyqli6tPwXW1YQ05gFiU9j
         AWc/YJxD1QGpRIrMO+SS2XTj2is+Jaop6MECPtrVzG+YHXVGf7snLjwzWkE7xMu+MmOp
         ghIchZCdfJlcaFROvsgE5KrFbBoYMbG/tka6LM8auCexCqSrAd062b5PRGiVIWqmu8vq
         cUOodk4pV+16Njtz1+Sdhrmj4ic1BKhYYyHvhHl3Xh/nL5KqOQQQFxGDp2mCpb4C5Vyd
         5qiL3IoYf1wSfTQcPSUWAMKs1YhvVYF2urO3RnyMAbag4vlkWgtxaRSrRrDpAf5TCYWz
         kq6A==
X-Forwarded-Encrypted: i=1; AJvYcCXdKh93l/w5WQ+axiuGS2rOSynzJ7i7d8LQ9RNzM979zB3Vv4IRPgUuNMJycxn2+hEGhBc9J6SxAWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydg+N54vKn2LjWcnUgPj3jwENS+vzcS0QqxfenSltKxolqg268
	F1VLvu7KxmuRLG14Tlxpk1POaoR3L2A6KpqUAqumiU+wbSL1CrFfTtuMpxS1bwg4/4+jrR7qCCv
	GWn6yc78FVj9cUC6I3p9n4LjARBSi9VG7myuBOUADWvkvdxn0VpdVePW1yw==
X-Gm-Gg: ASbGncvSRuKf5D48Za5q4S2foxCyIHj+Gv22qfpyPF7tk7sO6tSQLLLI+PJV8fO3SLs
	iF1qk/CKPl5wCh9BpplUbkAAGKDd7FhZkPYrh5zG3PGDz6fyXJGS/8+Fi+RbgpOwRUFmHJRK8bX
	9gHRQH7MvN6f4+KFoi+Pv0LXOx3cYSiFTMIksJnXzeWBo2cpR/TjdAS3biS8aKFN5CK/uE7BdKq
	rF0Sgo8HdFIqkjqGPbrEbe78Ml7/sLsulXN2tl+aSuiTDhK1pFKkMFBnfjz0wNbJmL+iFHbd1wl
	fCba846DiA==
X-Received: by 2002:a05:600c:1386:b0:434:f8e5:1bb with SMTP id 5b1f17b1804b1-436e26aeb43mr113475605e9.12.1736525674007;
        Fri, 10 Jan 2025 08:14:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU0wkkP9WUWFTN9gP4O//C0qy9q179xqHkUS2aBvi9r64g1KXifvVjg7YFpH+5nhW7XntfGQ==
X-Received: by 2002:a05:600c:1386:b0:434:f8e5:1bb with SMTP id 5b1f17b1804b1-436e26aeb43mr113475115e9.12.1736525673308;
        Fri, 10 Jan 2025 08:14:33 -0800 (PST)
Received: from [192.168.0.109] (78-80-81-76.customers.tmcz.cz. [78.80.81.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37d69sm55993065e9.30.2025.01.10.08.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 08:14:32 -0800 (PST)
Message-ID: <9bfb0fb9-c395-4c64-beca-6d48819c5605@redhat.com>
Date: Fri, 10 Jan 2025 17:14:32 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: simplify init function
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20241230121548.11911-1-thenzl@redhat.com>
 <70664fc3-90ef-4d29-9efb-f1cf9e1a507e@kernel.org>
Content-Language: en-US
From: Tomas Henzl <thenzl@redhat.com>
In-Reply-To: <70664fc3-90ef-4d29-9efb-f1cf9e1a507e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/25 9:32 AM, Damien Le Moal wrote:
> On 12/30/24 21:15, Tomas Henzl wrote:
>> by removing few lines. No functional change.
>>
>> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
> 
> Please send patches to the maintainers as well.
> 
>> ---
>>  drivers/ata/ahci.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 8d27c567be1c..66c19039449d 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1665,7 +1665,7 @@ static int ahci_get_irq_vector(struct ata_host *host, int port)
>>  	return pci_irq_vector(to_pci_dev(host->dev), port);
>>  }
>>  
>> -static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>> +static int ahci_init_irq(struct pci_dev *pdev, unsigned int n_ports,
>>  			struct ahci_host_priv *hpriv)
>>  {
>>  	int nvec;
>> @@ -1700,12 +1700,13 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>>  
>>  	/*
>>  	 * If the host is not capable of supporting per-port vectors, fall
>> -	 * back to single MSI before finally attempting single MSI-X.
>> +	 * back to single MSI before finally attempting single MSI-X or
>> +	 * a legacy INTx.
>>  	 */
>>  	nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
>>  	if (nvec == 1)
>>  		return nvec;
>> -	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
>> +	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_INTX);
>>  }
>>  
>>  static void ahci_mark_external_port(struct ata_port *ap)
>> @@ -1985,10 +1986,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  	}
>>  	host->private_data = hpriv;
>>  
>> -	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
>> -		/* legacy intx interrupts */
>> -		pci_intx(pdev, 1);
>> -	}
>> +	ahci_init_irq(pdev, n_ports, hpriv);
> 
> I think this needs error return check, unless we are guaranteed that
> pci_alloc_irq_vectors() always return success when PCI_IRQ_INTX is set. If that
> is the case, we can make ahci_init_irq() a void function. Please check.

With parameters we use the pci_alloc_irq_vectors won't fail.
I'll post a corresponding V2

> 
>>  	hpriv->irq = pci_irq_vector(pdev, 0);
>>  
>>  	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
> 
> 

