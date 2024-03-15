Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47E210E8
	for <linux-ide@vger.kernel.org>; Fri, 15 Mar 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514875; cv=none; b=uB+BPtbC5gkVEYs3G3xIX1kI3XI3MoasYHxoVOPEYuJGwhbWZ4BNPFkOKAv5y9WXnEP5KY5kphBKzd7FEf/P9BPdNI8T3KG6FjipAzXWo1Itsqc6sxCZRSjdrKEqBiziMjBW1IqXykP9zdsweqbxga/ML/jTaSexaW1Bm1CAa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514875; c=relaxed/simple;
	bh=UUsUxBD/6QzIfp7kEe2itJNJlI4JEMgXwhK/VywJFLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dp2+hMxYKiatYoCamkK9jBRa0bbJswxGE9Z9/lgT4YqNNgHNziPenKVenwQo0GEHRUd7bk29OgSPoAflkKgUHR9jIpna6VDdA5q6S8V7VkL5qexv7J6Mg88bDAZWPvzs8JStuzq/9l6ZHQafT0x/W71/iq5YyPGJG2FJT9q8jdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSRJnsM+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSRJnsM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710514872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yOXzge4tJmlxIy71RujpcXANzSUoptuUCad9eifUwg=;
	b=GSRJnsM++72Ow7RciqxoioS/emv/BfZRNmMBluZTDlrBVXGYMd3TkOTlopjEPr4ICkUvzy
	XCjWuqwnyFgR7XhYZugv1ximBZnQpX/AIMcIMqRDI46H7/xIS7QaLzPDD0U1QPcFtV4QMj
	5Yfxa7xmX0T1KSrDH+m+2cwfB+HgGzM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-OtifrP7QOBitzBbrQxzZYA-1; Fri, 15 Mar 2024 11:01:09 -0400
X-MC-Unique: OtifrP7QOBitzBbrQxzZYA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5684b963708so1542378a12.0
        for <linux-ide@vger.kernel.org>; Fri, 15 Mar 2024 08:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710514868; x=1711119668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yOXzge4tJmlxIy71RujpcXANzSUoptuUCad9eifUwg=;
        b=h4fY5bBDfqj6lYELGHy7egoatKRsZRbDqUI5qmCKvkYPBTghpLCABxEF6nmAapCWWB
         mkCnSvwTXHLAsi2sSWweB/IdDKD6t5c41aTeVcz5ILRspOvn0GB+qUrnhG7wQ0dqZfLr
         HWAvPNspa/4eLzGsB7JOZ84SFHlUTArUQGNs+RPt21nhpp4cVHCPiyDCyW1CcrfKSVUm
         6NY76wsSTuBbQlo3WZhcTdj6ebNNE/NpfejfZk7xn/r83jXgKCRs5LHASLYHHQLTtDFX
         FILnUgTVs9ugIlJCGDA8bqq5BKGCNitkQHRBK/s/RpfW2rVKyn4J2WEpi+/9Q1TrLIq3
         DYQA==
X-Forwarded-Encrypted: i=1; AJvYcCXXMWHaGlSwSGhvioWrLeKBzZbcFpwW3MLfUjcHKbYu206Qa5JdlJxk1LoJAfOHxllW9lAYabm3T6GtBPi+zXu9DyR3Ln9Q/upT
X-Gm-Message-State: AOJu0YznMxEV61pL15ZfOdJ3AtPVaPKZVnVvu/yupIRKDbr+j+FWSbZL
	lk45SCDpgf7LAQn0OnolkaOxovPrNJIOg0a4Sg8Hr2UcvF/EmMwLHCc8RVDYNA3H2JT+xZGU2rR
	0uY+dalUNm5ZXtGutOZO2AmAbGNOyOXYs/Hl7z8M4FfkOTtt8S59+bu67OQ==
X-Received: by 2002:a05:6402:e94:b0:565:665b:9c82 with SMTP id h20-20020a0564020e9400b00565665b9c82mr3341801eda.8.1710514868612;
        Fri, 15 Mar 2024 08:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+ry02bJrBW1GQzoqnfCnfcRjAh7J3ne30QAXT/n1QILUWxrP+S3D9mKfy+yLZlMRGdzR+fg==
X-Received: by 2002:a05:6402:e94:b0:565:665b:9c82 with SMTP id h20-20020a0564020e9400b00565665b9c82mr3341772eda.8.1710514868185;
        Fri, 15 Mar 2024 08:01:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ig15-20020a056402458f00b005681599a033sm1743702edb.13.2024.03.15.08.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 08:01:07 -0700 (PDT)
Message-ID: <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
Date: Fri, 15 Mar 2024 16:01:07 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ASMedia ASM1166/ASM1064 port restrictions will break cards with
 port-multipliers
Content-Language: en-US, nl
To: Niklas Cassel <cassel@kernel.org>, Cryptearth <cryptearth@googlemail.com>
Cc: Andrey Melnikov <temnota.am@gmail.com>, linux-ide@vger.kernel.org,
 conikost@gentoo.org
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <ZfMerqAmWoyu66/5@x1-carbon>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZfMerqAmWoyu66/5@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 3/14/24 4:58 PM, Niklas Cassel wrote:
> Hello Matt,
> 
> On Wed, Mar 13, 2024 at 06:37:56PM +0100, Cryptearth wrote:
>>
>> As for why the ASM chips report 30+ ports: A wild guess in the blue:
>> They were designed with port multipliers in mind and likely report the
>> max number of drives they can handle when combined with multipliers.
>> From what I get the "fix" is supposed to reduce boot time - well, from
>> my logs I see it's not the enumeration of the empty ports which takes
>> time but of course the initialization of the detected drives.
>> To me the initial report that lead to this changed just should had
>> been marked as won't fix or even as invalid - as looking thru the
>> history of ahci.c litterally noone seem to have bothered about it
>> since the ASM IDs were added.
> 
> Well, that is simply not how PMP works.

Did you see my analysis of this problem here:

https://lore.kernel.org/linux-ide/066b051d-f092-4ba2-9a26-1c73f3df4252@redhat.com/

It seems that the ASM1166/ASM1064 sata controllers transparently handle
attached PMP-s of up to 4 ports per PMP which is why the 4 port ASM1064
advertises 16 (4x4) extra "virtual" ports and the 6 port advertises
24 (6x4) extra "virtual" ports.

When a PMP is attached then this is handled inside the controller and
the attached disks show up on the extra port numbers 8-23 / 8 - 31
(and nothing shows on the actual port numbers 0-3 / 0-5).

So the "fix" to get the boards with PMP to work again is to drop
the quirk restricting the number of ports to the number of physical
ports, so that Linux probes the virtual-ports again and then everything
works again as before, with the downside of probing the virtual ports
slowing down the boot.






> 
> For PMP to be supported the HBA needs to set CAP.SPM (Supports Port Muliplier).
> (This also implies Command-based switching is supported.)
> 
> The HBA can additionally set CAP.FBSS (FIS-based Switching Supported),
> if CAP.SPM is set.
> 
> If CAP.SPM is set, you can plug in a PMP to each of the ports.
> Each PMP can support a max of 15 ports.
> 
> If PMP is enabled, you fill in the port number behind the port when
> queuing the command:
> https://github.com/torvalds/linux/blob/v6.8/drivers/ata/libahci.c#L1424
> https://github.com/torvalds/linux/blob/v6.8/drivers/ata/libata-sata.c#L154
> 
> 
> Looking at your SATA HBA:
>> [    0.608537] ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
>> [    0.608540] ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> 
> We can see that it does not support PMP at all.
> There is no "pmp" in print, which means that CAP.SPM was not set.
> 
> So your HBA does not support PMP, sorry.
> 
> 
> Yes, we can see that it claims that it has 24 ports from the print, so it
> appears that they have implemented their own version of PMP that is not
> compatible with AHCI. Lovely :)
> 
> 
> 
> I think this brings more questions than answers...
> 
> What is the PCI device and vendor ID for this device?
> 
> You said that this is a PCIe card with a ASM1064 and two port multipliers
> on the same PCIe card?
> 
> From what we've heard before, a ASMedia card with 4 physical slots,
> like this card:
> https://www.newegg.com/p/17Z-0061-000B5
> 
> Has PCIe device and vendor ID:
> { PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },   /* ASM1064 */
> 
> But you have a PCIe card with the same device and vendor ID,
> but your card also has 2 port multipliers with 4 ports each?
> 
> Well, I guess it should be fine to use the PCI device and vendor ID
> for the underlying HBA... considering that devices connected to the
> ports are supposed to be discoverable...
> 
> If they only claimed that the HBA supported PMP, the Linux device
> driver would try to enumerate the devices behind the PMP according
> to the standard.
> 
> See AHCI 1.3.1, section 9.2 Port Multiplier Enumeration.
> Or
> SATA-IO - Port Multiplier 1.0, 7.4.2 Device Enumeration.
> 
> The PMP standard also describes how you read the device and vendor
> ID of the PMP.
> 
> 
> Right now, they AMedia? seem to have their own home-made PMP implementation.

Ah, ok so I think you did see my reply? Checking if we can ignore
the builtin PMP support and uses Linux PMP support instead is
indeed an option.

I think we should still merge the revert / dropping of the quirk
while we figure this out though, because not finding people's disks
anymore is a clear regression.

Regards,

Hans







> Could you try the attached patch on top of v6.8, to see if Linux
> can detect the devices behind the two JMB575 PMPs?
> 
> If that works, we could still support PMP (according to the standard),
> and people with a ASM1064 PCIe card that does not have any port multipliers
> on the PCIe card would not suffer from significantly increased boot times.
> 
> I guess a second step would be to see if ASM1064 also supports
> FIS-based switching.
> 
> https://www.asmedia.com.tw/product/A58yQC9Sp5qg6TrF/58dYQ8bxZ4UR9wG5
> 
> Simply says "Supported port multiplier command based switching",
> it doesn't seem to mention FIS-based switching... so I guess not?
> (If it did, libata already has a AHCI_HFLAG_YES_FBS for other broken HBAs.)
> 
> 
> Kind regards,
> Niklas

