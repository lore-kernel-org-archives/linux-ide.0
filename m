Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A913B5A0
	for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860261; cv=none; b=eOGNH55PuFfqFuPp8ibvF+8iluYLOzqpomhvlOjrdY2p2cQ2FAB7uwDnvkT1tNONHBhfX9Jy+kOogM84RJTR5x6LA0rP5Ga3P0c331WN9h0s1vYVRDjfPFg8e2gFR0XI427DiXQnw+o0EdEMs1b3UGk6wIn3CNhuFsy28ht+1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860261; c=relaxed/simple;
	bh=wzNceDon8J/X3zofZcOallzw6jXI+2u16F6PZKC+o+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2i5mBWAx0a2mEXr8qN+4xuy5944X1e+BGVphVFA3MDq3PN8bC15DVlat7dpPnTY5rdlMZ3j/JcYeQpkDncq4fd4l5U5c9kI2xVHSI1GnHWdolzScNLSpk01bTixjmF7SE43AMp92v3VCk5aAXFOUVqbrJ2W7n+N3ldTVUYxrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZn710ZY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZn710ZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741860258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zp7hbJOUv8j+ICa1QmH9m0BekOtVujE7tGDQXjIFMhs=;
	b=GZn710ZY87bZIcB+tvBbkVlulr/D8b3EtQKxuC9KlS19aocjX4olJ+dWvvOOpa5apAptzc
	V+r300MR3qhbcKzRp2M9QWNNU6T35QtrIeA9UbhDErgMQk0koCAKUxgyq1BWVQB2wK1fWf
	SEzo4Fw/+0tOFDWnQPrxI44alPZlmB4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-hJVOV0KoMcSihVLqOl19fA-1; Thu, 13 Mar 2025 06:04:17 -0400
X-MC-Unique: hJVOV0KoMcSihVLqOl19fA-1
X-Mimecast-MFC-AGG-ID: hJVOV0KoMcSihVLqOl19fA_1741860256
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac2840b1ee8so82289466b.1
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2025 03:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741860256; x=1742465056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zp7hbJOUv8j+ICa1QmH9m0BekOtVujE7tGDQXjIFMhs=;
        b=eOl25CnuFPUnA0Mq48A3rNBLnFc+Yyg2fjGVn85q75Upe2saPt3wnejqer+QTnME4y
         WJ5/au8pV+9B0sCyVIZedxm5xW+FEHFjuOYxePssBr5zr+0AwemTUiR3eOW6Qw1jR4bC
         OxMSWspkmUCaiAkB6/hFXA+DYYDnYQoruryIFhWv6RvybosWTzCpTVSaYiGooQKQDtIF
         8o7n83VOd6KaTSRBLv1nVQdfcliYS2LezRXuB6aRRP5meYfuRbNdTeRHC7QAdFD/ZoHU
         45Rz8dSVs1RKjwyEBnAykySwCUQBfOfNKPCoMMcXA3ClGBqx932YhM+df85ByRxoprq3
         NfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWZrwfZGqpeq9zHPKgOCvhiWARs6+Muh/ZpsOury3bVmg9gZ0jqMWkU2iSt0RBxmZ8eBre4IGhJHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+OkeKcLLJXBwGb2BiuhcfuLf9lyk4gk1AUvarasEbpZmXnIv
	ZzjPFQQDsGptd37BA4Hg4Qs9rc0p/PEdfIuhNvEuQs3Ekx+Q5flfBpa2Y5NunRXDjXkcN7U2keB
	T4WWlTxxNIRvp+MN1897u6Ixi1DGYfXUx89Qze3i0aC9VtJrEaXc2PFf/tw==
X-Gm-Gg: ASbGncvpmsCman9xxxKIXVjOOvLTB42c6XnX1ah1HvnCrTbymyEU+A0LpD2g9y2gROF
	tGzRgFvvShWe7GidcZhbrGftuwb2LpVrG8/PlKAFWnStLFNwVlD4sY7KKWNNbtWyuxJWKEr2ccw
	zSg9Co0d6O8jQLlyzSWJrclQRB1/R73H4kdwrr+tYrV/UEFabBvdGUBpzc+bodUtuMU9WrGqc2B
	87KMar3L4oM20r24Q86YM3Kd1UoAk4ygksV621ICjBFMAthmv1xN4y3gSMYee83qwbncJ8ylT0U
	APN38XKlWvVcj+pHwktTlpl77Y7bZmU2wXtABDzo+n1rBBWRkUP3QQOr6S1jCbFXgbwZrse48Rv
	tesc8rrs9mw6R7KHLSAzY+PZkLWwvf80TPE4A3tMAJDWwYK99wGqYCd9QWHQI48uSRg==
X-Received: by 2002:a17:907:1b16:b0:abf:607b:d0d with SMTP id a640c23a62f3a-ac252a884cfmr3339111266b.16.1741860256230;
        Thu, 13 Mar 2025 03:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2PP7hITPCpcD7bejSrfori1Gcf1IzT/fSj09zWOA3DyhQyDL4CraOrxQAIURoaxeaOxIXCg==
X-Received: by 2002:a17:907:1b16:b0:abf:607b:d0d with SMTP id a640c23a62f3a-ac252a884cfmr3339101766b.16.1741860255380;
        Thu, 13 Mar 2025 03:04:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bbbsm62889366b.54.2025.03.13.03.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 03:04:14 -0700 (PDT)
Message-ID: <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
Date: Thu, 13 Mar 2025 11:04:13 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>
Cc: Eric <eric.4.debian@grabatoulnz.fr>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen> <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen> <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen> <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z9BFSM059Wj2cYX5@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Niklas, Eric,

On 11-Mar-25 3:14 PM, Niklas Cassel wrote:
> Hello Hans, Eric,
> 
> On Mon, Mar 10, 2025 at 09:12:13PM +0100, Hans de Goede wrote:
>>
>> I agree with you that this is a BIOS bug of the motherboard in question
>> and/or a bad interaction between the ATI SATA controller and Samsung SSD
>> 870* models. Note that given the age of the motherboard there are likely
>> not going to be any BIOS updates fixing this though.
> 
> Looking at the number of quirks for some of the ATI SB7x0/SB8x0/SB9x0 SATA
> controllers, they really look like something special (not in a good way):
> https://github.com/torvalds/linux/blob/v6.14-rc6/drivers/ata/ahci.c#L236-L244
> 
> -Ignore SError internal
> -No MSI
> -Max 255 sectors
> -Broken 64-bit DMA
> -Retry SRST (software reset)
> 
> And that is even without the weird "disable NCQ but only for Samsung SSD
> 8xx drives" quirk when using these ATI controllers.
> 
> 
> What does bother me is that we don't know if it is this specific mobo/BIOS:
>      Manufacturer: ASUSTeK COMPUTER INC.
>      Product Name: M5A99X EVO R2.0
>      Version: Rev 1.xx
> 
>      M5A99X EVO R2.0 BIOS 2501
>      Version 2501
>      3.06 MB
>      2014/05/14
> 
> 
> that should have a NOLPM quirk, like we do for specific BIOSes:
> https://github.com/torvalds/linux/blob/v6.14-rc6/drivers/ata/ahci.c#L1402-L1439

That seems to be a Lenovo only thing though and with Intel chipsets.

> Or if it this ATI SATA controller that is always broken when it comes
> to LPM, regardless of the drive, or if it is only Samsung drives.

I'm pretty sure we can assume this will happen on all ATI SATA
controllers, the new LPM default is pretty recent and these boards are
getting old, so likely have not that many users who use distros which
ship cutting edge kernels.

I do agree with you that it is a question if this is another bad
interaction with Samsung SATA SSDs, or if it is a general ATI SATA
controller problem, but see below.

> Considering the dmesg comparing cold boot, the Maxtor drive and the
> ASUS ATAPI device seems to be recognized correctly.
> 
> Eric, could you please run:
> $ sudo hdparm -I /dev/sdX | grep "interface power management"
> 
> on both your Samsung and Maxtor drive?
> (A star to the left of feature means that the feature is enabled)
> 
> 
> 
> One guess... perhaps it could be Device Initiated PM that is broken with
> these controllers? (Even though the controller does claim to support it.)
> 
> Eric, could you please try this patch:
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index f813dbdc2346..ca690fde8842 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -244,7 +244,7 @@ static const struct ata_port_info ahci_port_info[] = {
>  	},
>  	[board_ahci_sb700] = {	/* for SB700 and SB800 */
>  		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
> -		.flags		= AHCI_FLAG_COMMON,
> +		.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
>  		.pio_mask	= ATA_PIO4,
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_pmp_retry_srst_ops,
> 
> 
> 
> Normally, I do think that we need more reports, to see if it is just
> this specific BIOS, or all the ATI SB7x0/SB8x0/SB9x0 SATA controllers
> that are broken...
> 
> ...but, considering how many quirks these ATI controllers have already...

Right in the mean time Eric has reported back that the above patch fixes
this. Thank you for testing this Eric,

One reason why ATA_QUIRK_NO_NCQ_ON_ATI was introduced is because
disabling NCQ has severe performance impacts for SSDs, so we did not want
to do this for all ATI controllers; or for all Samsung drives. Given that
until the recent LPM default change we did not use DIPM on ATI chipsets
the above fix IMHO is a good fix, which even keeps the rest of the LPM
power-savings.

> ...and the fact that the one (Dieter) who reported that his Samsung SSD 870
> QVO could enter deeper sleep states just fine was running an Intel AHCI
> controller (with the same FW version as Eric), I would be open to a patch
> that sets ATA_FLAG_NO_LPM for all these ATI controllers.

Right I think it is save to assume that this is not a Samsung drive problem
it is an ATI controller problem. The only question is if this only impacts
ATI <-> Samsung SSD combinations or if it is a general issue with ATI
controllers. But given the combination of DIPM not having been enabled
on these controllers by default anyways, combined with the age of these
motherboards (*) I believe that the above patch is a good compromise to
fix the regression without needing to wait for more data.

Regards,

Hans

*) And there thus being less users making getting more data hard. And
alo meaning not having DIPM will impact only the relatively few remaining
users



