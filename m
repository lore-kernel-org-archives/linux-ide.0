Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D013A3F2
	for <linux-ide@vger.kernel.org>; Mon, 17 Mar 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220056; cv=none; b=Ulfp4QX1Iifqtx04FAxVjbjk4arEOxd+6d7aqfhu7Y3hkLdhtizYFu3U9jM3YFUMQWnmBmmnjnqFRgKDCIJsHXW0ZceyuYj47xTlsKC3C03q/A2ySvnf3KgCaa+6rA2hcm9F9F2NX6eaeh7wzRjcBho/bpeu0kxl9nFBxBOkLGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220056; c=relaxed/simple;
	bh=J8+XsoXrSJlO0f5ODKzIsh8r5cedmb8ya2rXZ3NHh38=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NAzukjBHy0VT27cEmsf9TgTaTpoMBXlD/j6jTilDTlhf6dwCX3wkI3LFtyj/hpMpLvMNR8VMmGAUOBRISXO+famFj9Ij/azqu0ucpvtX6bRzftfvt/RwuRv5Fn7e+fYDd+YS3jcBIvv+y7klOUmFmLgSZPHm+JxQd0mgNaSQJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yd75dXy1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd75dXy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742220054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z39YX8s7nhMNniJQHUt56CKuL8cT07xBpMzBaeGNDYI=;
	b=Yd75dXy15unaSaVbKufIGEvNxm0GmjotnBpch7IZq+f3M4jdWeG2rTc32f4KLoXN4CfiCl
	TfOfNCt9JxSgKeVrkRnLllsX6lq7evJrWlUTQ8f/28W9fAmNBirffShBDgw8yOEnBUqI+r
	ZiMNC4weNG4qssQRpuOTwTM7hGUXr0Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-adWcAPHeMZ211IeB_OGVAQ-1; Mon, 17 Mar 2025 10:00:52 -0400
X-MC-Unique: adWcAPHeMZ211IeB_OGVAQ-1
X-Mimecast-MFC-AGG-ID: adWcAPHeMZ211IeB_OGVAQ_1742220051
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac2db121f95so364460166b.1
        for <linux-ide@vger.kernel.org>; Mon, 17 Mar 2025 07:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220050; x=1742824850;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z39YX8s7nhMNniJQHUt56CKuL8cT07xBpMzBaeGNDYI=;
        b=r5qNOic8tg6K47b9cfv6qtDWizbEAAILVCFzB1wy3p/RDkI17H0Fo4T5N50Sxi/NMc
         rLi3+yE43wTron3pWUo/DkBlbj5l3KWABFvdnNMjr/i8o1rm86YHLQk4CX6J0yW/ySqK
         jFVS3fWZHuK2b2yzPIN2KSnGbwcSzrrNFRoJUrV4e3XIOznw9YCXV8E9iSW1nU5jzIjt
         EJ32HIMYd81veLKONX2KaDWO4NoR0L+LGLgEPHY3ZO4vwObQbE//bw3VYhw3ybwhKZya
         fbTdKNSAPOOmqMh9TU0EyzXz5QewNRNRa0PqTK/i5eenz1fbtKKyEv99C5jxpiobD/rI
         YFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKTAxXvahRIb4GCN3BSibiywKLFVtfvXvUJkMViJB9nK1EhH8JTYlIFLzsOzLYtQvhdvpM4bE17gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsH/VREvHByp41nwvllNlGcZU1iiP02e9/Jn9xJk66+eXsKAUI
	KmUyRJpmbsHGTrQT5yAg7lG8A0rRb8iyj/N8PfjCAaGQWhQ8URI9I5fLsFdqGsn1vCkukJeAyxz
	hB0LkhtT+p/YEVD07su19BnmDQQQwGDi/hhYe/8Xup4lIsz1QM9sQD8jF+Q==
X-Gm-Gg: ASbGncs2KKC/tuYOaZHl1t51boqqEoPMbLR6KWfTvHiFhZ9X6NNsrFlSLWOsut5dhOV
	c/1DAr2MK7x68xLpkNLyEyBCcqK2TMuWoEDQsB98Kj7icl/pCsH8UPsmoARwW7EQkhR0IdJsOsS
	RVOzeWWw0ti1Z3m4yBRD6qAEcA+XG7WCzFQIFllAzZwKRhzAvbO4a90YqMbDMWpxIS0EqoroKKD
	wTkB3WpCZXOkPu0grsNOgpB3g46qP39bb8p6Dg9Vt9FNUucNFlMKgvNcR0YlX/WD4g9OZ7KRoYc
	X9HADLVXMOunK4RYsgW1GuyEeKbXxT+xP0Ar3r92Xnovn2M=
X-Received: by 2002:a17:907:7d87:b0:ac3:26fb:f420 with SMTP id a640c23a62f3a-ac3303715c9mr1423094666b.42.1742220049790;
        Mon, 17 Mar 2025 07:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4x+7zUFztzqpazt4K0sF9BeLO+ujb518kP6OpTx3tsrCS8Qj9lD5aV42E1R97GBy/uoptxw==
X-Received: by 2002:a17:907:7d87:b0:ac3:26fb:f420 with SMTP id a640c23a62f3a-ac3303715c9mr1423083466b.42.1742220048849;
        Mon, 17 Mar 2025 07:00:48 -0700 (PDT)
Received: from [192.168.0.103] (78-80-81-238.customers.tmcz.cz. [78.80.81.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac31485896asm660633366b.84.2025.03.17.07.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:00:48 -0700 (PDT)
Message-ID: <abef767e-9479-4109-8057-d549ac999107@redhat.com>
Date: Mon, 17 Mar 2025 15:00:46 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] ata: ahci: simplify init function
From: Tomas Henzl <thenzl@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Niklas.Cassel@wdc.com
References: <20250114182956.40923-1-thenzl@redhat.com>
 <0e2a0f69-7b98-4b48-8a68-6a554cbbec09@kernel.org>
 <be4fb93d-ab73-47d1-bbd9-1ac098b23ca3@redhat.com>
Content-Language: en-US
In-Reply-To: <be4fb93d-ab73-47d1-bbd9-1ac098b23ca3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Damien,

the V3  patch applies to the for-6.15 branch with just an offset.
Can you take it as it is or do you want me to resend?

Regards,
Tomas


On 1/15/25 4:08 PM, Tomas Henzl wrote:
> On 1/15/25 3:30 AM, Damien Le Moal wrote:
>> On 1/15/25 03:29, Tomas Henzl wrote:
>>> by removing few lines. No functional change.
>>>
>>> The main part of this change is done by adding a PCI_IRQ_INTX flag into
>>> an already existing pci_alloc_irq_vectors invocation.
>>> In the current implementation of the pci_alloc_irq_vectors is the sequence of calls
>>> msi-x -> msi -> legacy irq and whatever there succeeds stops the
>>> call chain. That makes it impossible to merge all instances into as a single call
>>> to pci_alloc_irq_vectors since the order of calls there is:
>>> multiple msi-x
>>> a single msi
>>> a single msi-x
>>> a legacy irq.
>>> but the two last steps can be merged into one which are the msi-x and legacy
>>> irq option. With this change we remove a pci(m)_intx call.
>>> When PCI_IRQ_INTX flag is set the pci_alloc_irq_vectors succeeds in almost
>>> all cases - that makes it possible to convert ahci_init_irq(msi) into a void function.
>>> The exception is when dev->irq is zero then the pci_alloc_irq_vectors
>>> may return with an error code also pci_intx isn't called from  pci_alloc_irq_vectors
>>> and thus certain pci calls aren't performed.
>>> That's just a negligible issue as later in ahci_init_one the (zero)
>>> value of dev->irq is via pci_irq_vector assigned to hpriv->irq.
>>> That value is then later tested in ahci_host_activate->ata_host_activate where
>>> it is welcomed with a WARN_ON message and fails with setting up irq and
>>> then the probe function (ahci_init_one) fails. The special zero value's
>>> meaning is that polling mode is being be set up which isn't the case.
>>>
>>
>> Extra blank line not need here.
>>
>> Beside that, looks OK now. But as Niklas pointed out, this conflicts with a
>> patch in the PCI tree. And given that it is too late to queue that for 6.14, can
>> you resend a rebased version once 6.14-rc1 is out in a couple of weeks ?
> 
> I can do that, thanks.
> 
>>
>> Thanks !
>>
>>>
>>> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
>>> ---
>>> V2: ahci_init_irq is now a void function
>>> V3: a) added an explanation of why we may convert ahci_init_irq into
>>> 	a void function
>>>     b) fixed the subject line
>>>     c) added an explanation of why calling pci_alloc_irq_vectors instead
>>> 	of pci_intx is safe
>>>     d) rebased to latest code state (pci_intx->pcim_intx)
>>>
>>>  drivers/ata/ahci.c | 23 ++++++++++++-----------
>>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index 8d27c567be1c..3ea2f3adf354 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -1665,13 +1665,15 @@ static int ahci_get_irq_vector(struct ata_host *host, int port)
>>>  	return pci_irq_vector(to_pci_dev(host->dev), port);
>>>  }
>>>  
>>> -static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>>> +static void ahci_init_irq(struct pci_dev *pdev, unsigned int n_ports,
>>>  			struct ahci_host_priv *hpriv)
>>>  {
>>>  	int nvec;
>>>  
>>> -	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
>>> -		return -ENODEV;
>>> +	if (hpriv->flags & AHCI_HFLAG_NO_MSI) {
>>> +		pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
>>> +		return;
>>> +	}
>>>  
>>>  	/*
>>>  	 * If number of MSIs is less than number of ports then Sharing Last
>>> @@ -1685,7 +1687,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>>>  			if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
>>>  				hpriv->get_irq_vector = ahci_get_irq_vector;
>>>  				hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
>>> -				return nvec;
>>> +				return;
>>>  			}
>>>  
>>>  			/*
>>> @@ -1700,12 +1702,13 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>>>  
>>>  	/*
>>>  	 * If the host is not capable of supporting per-port vectors, fall
>>> -	 * back to single MSI before finally attempting single MSI-X.
>>> +	 * back to single MSI before finally attempting single MSI-X or
>>> +	 * a legacy INTx.
>>>  	 */
>>>  	nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
>>>  	if (nvec == 1)
>>> -		return nvec;
>>> -	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
>>> +		return;
>>> +	pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_INTX);
>>>  }
>>>  
>>>  static void ahci_mark_external_port(struct ata_port *ap)
>>> @@ -1985,10 +1988,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>  	}
>>>  	host->private_data = hpriv;
>>>  
>>> -	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
>>> -		/* legacy intx interrupts */
>>> -		pcim_intx(pdev, 1);
>>> -	}
>>> +	ahci_init_irq(pdev, n_ports, hpriv);
>>> +
>>>  	hpriv->irq = pci_irq_vector(pdev, 0);
>>>  
>>>  	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>>
>>
> 

