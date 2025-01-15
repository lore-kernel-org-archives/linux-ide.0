Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99C7711F
	for <linux-ide@vger.kernel.org>; Wed, 15 Jan 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953722; cv=none; b=LgslJBDlBdU68Aaz0AB7fJBGLnwZ2r7v1IbLD6c+CPXpGP2LSWQ4pHJygtcCcoyi7VdxiPRiINKqhBW5t0BnXulBmgOeODOLWlDAGrAfh5Q+gHbs0i7wtllqJd/FycUfUDdn63dw5MFBBM4pOKnimM2qVTsuRB7y3k9RblGWiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953722; c=relaxed/simple;
	bh=RbbaQKVG9c1UHxGK7MFxG7vmnSIjLk5K2scaggLkS2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qe2YEy+0nMEFfd82/ev1TjuxezoBnUnTpyiCFmhUOvh6/6f/kjS866HniHvGQJbrh94AsFcZfZf66d2K7ZuxV2VrkkbxGUFbXOZHxaTJBkwGmmGqFw30w8DjAuLQ/SQXnx4NQyrs1fDQQdWiHMNAsu+cIDU1+cPUA+QjtdW3r1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJ4QOc/j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJ4QOc/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736953719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLlYMFAUt6fN4vleEPJx/SBM2qeoBrAFUgxa8TIxOzA=;
	b=LJ4QOc/jOEvzLpXRG17x1T2RWQ4la7JUZBGtJ8zIHYuW99g8srbJmf+3l9k8UhJSEobUQ2
	roKTbqEy9azP/1r4nNwdZg2zD4qftGJfN6azbGbFOLoom0t11n4B/6U3LgXnvorxdhNVal
	gTdXA9SKkVe3x6F6ifcOz544BNqMvow=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-vpGfWf_YPp2jqEo8pFQaSQ-1; Wed, 15 Jan 2025 10:08:38 -0500
X-MC-Unique: vpGfWf_YPp2jqEo8pFQaSQ-1
X-Mimecast-MFC-AGG-ID: vpGfWf_YPp2jqEo8pFQaSQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aafba50f3a6so72345466b.2
        for <linux-ide@vger.kernel.org>; Wed, 15 Jan 2025 07:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736953716; x=1737558516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLlYMFAUt6fN4vleEPJx/SBM2qeoBrAFUgxa8TIxOzA=;
        b=Z8F4Xw4Eyb56ppCylz7epU68TzlRtrgbBfHaEO+tRBK20jjza0clLZy0kzE35kl4kF
         wOmBSw3GTx1ehMF9RcIMYw+MkWDq7AN98i5lQGDVh47eAWrK//9gcw937aZGShKESFAt
         2YGQ50w7hCn+/+/wRfvs4ZpLkiyh38HiyrmGdwCiPT2g53JKQidKz7WPqSCnbFqwAWM1
         R+jW5fzkW1VrObV3nEgXAFTSHrE1Ps78QKDKNdDJFBet21nFzns/ExjTgF6KVVWFyWOb
         BwVoNklVMAQte6IV1XTr2PsU/tGGHcGk+zvIKzZ0h9xtG53bhBxerk/PsAmBxRXYJ/Kj
         wsWw==
X-Forwarded-Encrypted: i=1; AJvYcCX0SoLUOtiAaOmsoF+mpZzGIyh01li6SctEfZSnBW6n3zWshhNh25ra5x2QDUbe5JK2mNCz0mM44n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhmg56FTwdb6SHYd1V8jZNj5fNhg3tKGnPk0jMRtgrEnKQLb4
	7jNrpp2DEYaYoPciKUBfdGz6kftTAozbReQ0s6XXq3WtCNWT0C7ASGirVXYIUbmFKnsEUMLoEpR
	FQV5Eou6K80puu1gJWcTruicyTDaEV3pVv6YMq+4BfJbr1IiTu1H/BXvsHuiaUzylgg==
X-Gm-Gg: ASbGncsqJwrYNi1azA91f80fcR3/xwHrkS6KOF86WumKV1VFFRsgnl2BFI4QE3leS7T
	eLg7KzHIsc4S/ITAfs2WdDusetzZfaoB3dxIT6X2ia8lhF1AdCr+znqeW00vMCf0R/X/gGNkg0d
	R5emnpGfCK2vfD6h/xoouapskkIbGbHZFfozOHHzOtVWHSs7YgHhLFeJLCdTLVb9vPucufWeQzE
	tPL+yWWz+SdWkErHWHsxJ82gyw0wPdpHBRGryMzqZ/D4jQKym/5HaP+TFO+8vAfwVOOJGgbTDHN
	Bsq2j2l0bvl2
X-Received: by 2002:a17:907:d87:b0:aa6:7ec4:8bac with SMTP id a640c23a62f3a-ab2ab709c68mr2869315466b.17.1736953716189;
        Wed, 15 Jan 2025 07:08:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEo3B4auGVkML9MNx7ff+RQl71/Gqsvvr+3W1narl3tEtgeV1kwkJvRWIk8uMfAs4Cd7XRtw==
X-Received: by 2002:a17:907:d87:b0:aa6:7ec4:8bac with SMTP id a640c23a62f3a-ab2ab709c68mr2869307066b.17.1736953715414;
        Wed, 15 Jan 2025 07:08:35 -0800 (PST)
Received: from [192.168.0.111] (78-80-81-245.customers.tmcz.cz. [78.80.81.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905cd15sm766979166b.5.2025.01.15.07.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 07:08:34 -0800 (PST)
Message-ID: <be4fb93d-ab73-47d1-bbd9-1ac098b23ca3@redhat.com>
Date: Wed, 15 Jan 2025 16:08:34 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] ata: ahci: simplify init function
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Niklas.Cassel@wdc.com
References: <20250114182956.40923-1-thenzl@redhat.com>
 <0e2a0f69-7b98-4b48-8a68-6a554cbbec09@kernel.org>
Content-Language: en-US
From: Tomas Henzl <thenzl@redhat.com>
In-Reply-To: <0e2a0f69-7b98-4b48-8a68-6a554cbbec09@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 3:30 AM, Damien Le Moal wrote:
> On 1/15/25 03:29, Tomas Henzl wrote:
>> by removing few lines. No functional change.
>>
>> The main part of this change is done by adding a PCI_IRQ_INTX flag into
>> an already existing pci_alloc_irq_vectors invocation.
>> In the current implementation of the pci_alloc_irq_vectors is the sequence of calls
>> msi-x -> msi -> legacy irq and whatever there succeeds stops the
>> call chain. That makes it impossible to merge all instances into as a single call
>> to pci_alloc_irq_vectors since the order of calls there is:
>> multiple msi-x
>> a single msi
>> a single msi-x
>> a legacy irq.
>> but the two last steps can be merged into one which are the msi-x and legacy
>> irq option. With this change we remove a pci(m)_intx call.
>> When PCI_IRQ_INTX flag is set the pci_alloc_irq_vectors succeeds in almost
>> all cases - that makes it possible to convert ahci_init_irq(msi) into a void function.
>> The exception is when dev->irq is zero then the pci_alloc_irq_vectors
>> may return with an error code also pci_intx isn't called from  pci_alloc_irq_vectors
>> and thus certain pci calls aren't performed.
>> That's just a negligible issue as later in ahci_init_one the (zero)
>> value of dev->irq is via pci_irq_vector assigned to hpriv->irq.
>> That value is then later tested in ahci_host_activate->ata_host_activate where
>> it is welcomed with a WARN_ON message and fails with setting up irq and
>> then the probe function (ahci_init_one) fails. The special zero value's
>> meaning is that polling mode is being be set up which isn't the case.
>>
> 
> Extra blank line not need here.
> 
> Beside that, looks OK now. But as Niklas pointed out, this conflicts with a
> patch in the PCI tree. And given that it is too late to queue that for 6.14, can
> you resend a rebased version once 6.14-rc1 is out in a couple of weeks ?

I can do that, thanks.

> 
> Thanks !
> 
>>
>> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
>> ---
>> V2: ahci_init_irq is now a void function
>> V3: a) added an explanation of why we may convert ahci_init_irq into
>> 	a void function
>>     b) fixed the subject line
>>     c) added an explanation of why calling pci_alloc_irq_vectors instead
>> 	of pci_intx is safe
>>     d) rebased to latest code state (pci_intx->pcim_intx)
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
>> -		pcim_intx(pdev, 1);
>> -	}
>> +	ahci_init_irq(pdev, n_ports, hpriv);
>> +
>>  	hpriv->irq = pci_irq_vector(pdev, 0);
>>  
>>  	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
> 
> 

