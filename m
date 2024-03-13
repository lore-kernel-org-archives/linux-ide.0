Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAB5490C
	for <linux-ide@vger.kernel.org>; Wed, 13 Mar 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368425; cv=none; b=FmunyJ6Vxtclo8jbBAfV/mv2sWUsvYKBfLu1g5IZfVm+aHVH4s2vq9Mod3sU3JjbIRdkiE9rp8DKCK2DdciIfc45leaTbuGYit423OKf6fMSnz/U8z46pRRw9zr8UNNeTpAnoSzf4e3DuBg2AXRPoUQCFv7g9UzeTaWwHJQIhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368425; c=relaxed/simple;
	bh=hRYN66leCRIeIEQXFAv+jH9zGZDUlSUwTwvb1v2/NIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5CW+rx+IG0Bm3Rid356yE0AJxnvts4uz+/JuTDuj26qFeqbSeakZLGQujSeI18Fz1WvHfWZm9vEwL/CL4jmpTmXvhe2C+rAtrx7hlUuGvZhpF+m81/vgVs1QSYedQHresymlxpQBU5UEcM1SBhHZZSCXLTOh6WnMPKy/LGHYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlKXacVl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlKXacVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710368422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAExe57SyO4dO3uAO8acFGcfmA9XNqyi7G9vYq4n1cE=;
	b=GlKXacVlJ8Fa7CtmtDdR67KKvaCTUaBnFDey1dTv9eznlOsG87YOWQ92RuY03mp6uOg2j9
	MMxWkWSmRLpsZ2pW8ANL2enjXvTXzPcNipAwJNbOXlKSPhz7Uh773Ki92kH6yuaOXm3V6o
	xqwyR4IfJMEc+GD+soNRLayOxP2kclI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-h0TvSzOoP5ysGTuuXEs38Q-1; Wed, 13 Mar 2024 18:20:21 -0400
X-MC-Unique: h0TvSzOoP5ysGTuuXEs38Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a44143c8908so36213566b.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Mar 2024 15:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710368420; x=1710973220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAExe57SyO4dO3uAO8acFGcfmA9XNqyi7G9vYq4n1cE=;
        b=WC6qCFTJHIXS50h9BS15CAvEyukeJFWHU3iUSXhBJexPYkDhsLJLjHBkqqke/6Qpo8
         Wi30vd0o9pukA0hAth6jlHj6O97OXImM7jqKFy/9OWwfF2JMpHAVmSEQ46FKj7uXS8n3
         hYo/IOrovBzeritRZO1HmA7sJ36/U+THuJpf2i0kt2Ny3K8DVm9HnsTe7xN5dvW5vadf
         3UlosgeEOdTMnKLnpK2J+ZCKW3FAXuHQmjaYW+lpH70jdMStZ7subkrUqC7ivgysZm+Z
         eESu/wcj/MDj8MqZC9ZjQIcdl/hwMcl4flhY0mx6HkrtbKwFSCnlmyaGC+m0N2TUEPFN
         wBVw==
X-Gm-Message-State: AOJu0Yx5CHb2oC4/jHlDmLhEKPfzOoeYLncOkIjD4eHBVm+Uyth9+rtv
	ov8c1rvs12tR8Ya23G1AleSJ11T/nRSR1v30zj+YGgHTRL7II6iKOkqnQVctnWJ3O+ufOyVUeut
	aNrtPRcEy9pJzAFnaqSa1wnDx8k/Uz9DtLgljBwb2Micuq5cnDYwc3+RZMQ==
X-Received: by 2002:a17:906:278e:b0:a45:6d38:60aa with SMTP id j14-20020a170906278e00b00a456d3860aamr78519ejc.30.1710368420131;
        Wed, 13 Mar 2024 15:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmFDMbOONORQfZDD10Yz+jGmg5x583cAAmigwVo0szUG5/PcfZMUxTh4GoTMKXcvBkJQXtVw==
X-Received: by 2002:a17:906:278e:b0:a45:6d38:60aa with SMTP id j14-20020a170906278e00b00a456d3860aamr78505ejc.30.1710368419724;
        Wed, 13 Mar 2024 15:20:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kk28-20020a170907767c00b00a4666bfa979sm55439ejc.118.2024.03.13.15.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:20:19 -0700 (PDT)
Message-ID: <e09f1db6-2720-4fbc-ac64-2be498be8e4d@redhat.com>
Date: Wed, 13 Mar 2024 23:20:18 +0100
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
To: Conrad Kostecki <conikost@gentoo.org>,
 Cryptearth <cryptearth@googlemail.com>,
 Andrey Melnikov <temnota.am@gmail.com>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <066b051d-f092-4ba2-9a26-1c73f3df4252@redhat.com>
 <emd39240ba-840a-4d09-a992-7a4b15cd8189@588c6196.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <emd39240ba-840a-4d09-a992-7a4b15cd8189@588c6196.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/13/24 10:52 PM, Conrad Kostecki wrote:
> Hello folks,
> 
> Am 13.03.2024 22:21:51, "Hans de Goede" <hdegoede@redhat.com> schrieb:
> 
>> So on this 4 port controller we actually get 4 + 16 ports.
>> which isuggests that port multipliers are handled transparently
>> inside the controller and that ata15-ata18 are likely the ports
>> on a 1:4 multiplier on ata7, ata19-ata22 are the ports on a
>> 1:4 multiplier on ata8, etc.
>>
> do you have any idea, if we could make somehow an non-default option to disable such ports?
> 
> The initial problem will now persist again. As for example a 16 port x4 pcie card (4x ASM1064, each connted to one pcie lane, so only providing 16 physical real ports, no SATA PMP) will take about 3-4 minutes to slow down boot, as 128 ports are being detected and waiting to timeout to continue further.

I think you can already do this, see:

https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html

and look for libata.force

So lets say the virtual ports for the transparent PMP support are ata8-ata31, then
you could do:

libata.force=8:disable,9:disable,10:disable,...,31:disable

Although I have to admit that that is very verbose and it relies on
the probe order to be constant which is not guaranteed.

So being able to specify some sort of port-mask override to disable
the "virtual" ports would be better.

I guess you could even add a disable_transparent_pmp_ports bool module
parameter to the ahci.c code which defaults to false and then simple
change:

        if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
                switch (pdev->device) {
                case 0x1166:
                        dev_info(&pdev->dev, "ASM1166 has only six ports\n");
                        hpriv->saved_port_map = 0x3f;
                        break;

to:

	if (disable_transparent_pmp_ports && pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
                switch (pdev->device) {
                case 0x1166:
                        dev_info(&pdev->dev, "Limiting ASM1166 to its six physical ports\n");
                        hpriv->saved_port_map = 0x3f;
                        break;

And then you can activate the behavior with ahci.disable_transparent_pmp_ports=1
on the kernel cmdline.

Although some generic mechanism to set an override for the port-mask on a
per controller basis would perhaps be better.

Niklas, do you have any remarks / ideas ?

>> Conrad as the author of the patch adding the original port limiting for
>> the ASM1166, can you submit a patch upstream to drop the port-limiting for
>> both the ASM1164 and ASM1166 for now, with the following tags added to this
>> patch:
>>
>> Fixes: 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
>> Fixes: 9815e3961754 ("ahci: asm1064: correct count of reported ports")
>> Cc: stable@vger.kernel.org
>>
> I've send the patch

Great, thank you!

Regards,

Hans




