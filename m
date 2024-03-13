Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD65339A
	for <linux-ide@vger.kernel.org>; Wed, 13 Mar 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364923; cv=none; b=YxBW4SwTEPaCPL31c3XTSenk8BwYFpcH35RwzuyEwv9JMrNFEcg8aVhKOKVUKz82VLCPHKZ0+iK3SZXSuv6pVtqnGZu7wWk/6E5fT4MQG4Eyrqxc1URMUF9kLKRRKqneSjAN7STjAvSCWHU5/l0n4bQ95GMDoQeglPHRdz52Tnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364923; c=relaxed/simple;
	bh=imchHw75Nl9fqNo40zAiFl6FX8a3opuQAbho3y/uslQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlpszpX+2xjXX8YDPPv5kTOQJ7O1AkJt89Or84WgNCexFvYz47vrFQQE8OFGd4FRQyXmUoHMsxSPKH24wqL75Wizs0UT07Pkz2H+ReVWslCB1eEGPO6OZCWvObn5MoVp641juurY7Uv7+Z8MdNeEquFYgEdFkX1CTBSYcJqE+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSEtUPmQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSEtUPmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710364919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgaORH6QCWM8ygbGm0NOGOp8nS/LaUBXucT0QjxtgFI=;
	b=YSEtUPmQRvo8Rk2FTUpQD0+gnc81vVdtAkx6xhYWkRKg0MrOCBbquDKuOvmJ4W4isLedmV
	VbzJ4h1uUKEDspQfmgozJ1T/x+KRT4MZo30eCcPZ4RYmSp74DZv+vglfAx5jaLplRWrHqw
	Sp6HiPr02jiWDEv+p8DNGx8UgbTUZLg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-RKcoZOjTPv-bGlLLz2e1hg-1; Wed, 13 Mar 2024 17:21:56 -0400
X-MC-Unique: RKcoZOjTPv-bGlLLz2e1hg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4606018ec4so33963166b.0
        for <linux-ide@vger.kernel.org>; Wed, 13 Mar 2024 14:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710364914; x=1710969714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgaORH6QCWM8ygbGm0NOGOp8nS/LaUBXucT0QjxtgFI=;
        b=VVD8Ra/+4vcXJVgu752PCdic2VBHQUZg/oSslP643CFDkUmM7lA43LDGgf24JCv+Y4
         Gv/j/NLZnWwtzuQSFHVpTL/S5VnFxYt/zK6bKFwrMJSW3jbTQTJ452sKGB0mnjZoGDAS
         RlNg4/ZJIAcf7L9HIhqQfoC3tUXwZj23N9CWUaFYDDFUbLWpGymRRit0qGlcKtI1ST1f
         I5+bIakc96EkciLuLbysKllYKEpwz3hCDHDqZGpTuq50rAzvjhlvQGFPaKRoHoidfunZ
         wA1Odl7Swd2lKEw1Dvj2xuRYvlz9RkeFs6agXmMgm1BrrIIigYc1C96rApjn63ohy8L5
         X23A==
X-Gm-Message-State: AOJu0YzTkXNwVaSBrwq6X6+u/YHpAMe7H93rZHlPI5CE3thPdm0+zEUZ
	jJgNDp01q8xz2x8CrBcRsffhKuJ2DfEXkoEzlRNn5sI2gwruLJHo979zcY1POjblcOg6Y7XhYf7
	cCGm2ZTHrobpKwYvsjNu3J22Zd4hMo15nI5H47gDKcjsI3sRphH+qh5jnLg==
X-Received: by 2002:a17:906:ba89:b0:a44:b96:2811 with SMTP id cu9-20020a170906ba8900b00a440b962811mr16519ejd.29.1710364913911;
        Wed, 13 Mar 2024 14:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlM+ptrsOPfwfii5PdEKEGTHZqSFXf1nT0MOdQdSX7ob3HgYTq0ATEDfY7OWNe4/VWy3ag0w==
X-Received: by 2002:a17:906:ba89:b0:a44:b96:2811 with SMTP id cu9-20020a170906ba8900b00a440b962811mr16514ejd.29.1710364913529;
        Wed, 13 Mar 2024 14:21:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d10-20020a170907272a00b00a44ef54b6b6sm27724ejl.58.2024.03.13.14.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 14:21:52 -0700 (PDT)
Message-ID: <066b051d-f092-4ba2-9a26-1c73f3df4252@redhat.com>
Date: Wed, 13 Mar 2024 22:21:51 +0100
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
To: Cryptearth <cryptearth@googlemail.com>,
 Andrey Melnikov <temnota.am@gmail.com>
Cc: linux-ide@vger.kernel.org, conikost@gentoo.org, cassel@kernel.org
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 3/13/24 6:37 PM, Cryptearth wrote:
> Hello Andrey,
> 
> I attached the logs of a regular 6.7.9 boot which works as expected -
> all my drives show up - and also from a freshly built 6.8.0 - which in
> my case not just makes some drives disappear - but all of them.
> Also, just for reference to add the arch forums thread I mentioned:
> https://bbs.archlinux.org/viewtopic.php?id=293493
> 
> So, as requested: The "fix" added actually does cause more issues than
> what it's intended to solve. It should be reverted alltogether - or at
> least gated behind some override switch so users like me doesn't have
> to compile thier own kernels just for a 5-line-change but can just set
> an override parameter.
> 
> As for why the ASM chips report 30+ ports: A wild guess in the blue:
> They were designed with port multipliers in mind and likely report the
> max number of drives they can handle when combined with multipliers.
> From what I get the "fix" is supposed to reduce boot time - well, from
> my logs I see it's not the enumeration of the empty ports which takes
> time but of course the initialization of the detected drives.
> To me the initial report that lead to this changed just should had
> been marked as won't fix or even as invalid - as looking thru the
> history of ahci.c litterally noone seem to have bothered about it
> since the ASM IDs were added.
> 
> Thanks for having a look into it and considering a revert or adding an override.

Thank you for the logs. The working 6.7.9 log is quite interesting:

[    0.596650] ahci 0000:02:00.1: version 3.0
[    0.596775] ahci 0000:02:00.1: SSS flag set, parallel bus scan disabled
[    0.596820] ahci 0000:02:00.1: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    0.596823] ahci 0000:02:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
[    ........] probe output for scsi host0 - host5
[    ........] probe output for ata1 - ata6

The above is for the non asmedia sata host on this system so it is not interesting.
And then now the logs for the asmedia sata host:

[    0.597908] ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
[    0.608537] ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
[    0.608540] ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst 
[    0.610143] scsi host6: ahci
[    ........] probe output for scsi host7 - host28
[    0.611975] scsi host29: ahci
[    0.612013] ata7: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80100 irq 41 lpm-pol 0
[    0.612017] ata8: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80180 irq 41 lpm-pol 0
[    0.612019] ata9: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80200 irq 41 lpm-pol 0
[    0.612022] ata10: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80280 irq 41 lpm-pol 0
[    0.612023] ata11: DUMMY
[    0.612024] ata12: DUMMY
[    0.612025] ata13: DUMMY
[    0.612026] ata14: DUMMY
[    0.612028] ata15: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80500 irq 41 lpm-pol 0
[    0.612031] ata16: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80580 irq 41 lpm-pol 0
[    0.612032] ata17: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80600 irq 41 lpm-pol 0
[    0.612035] ata18: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80680 irq 41 lpm-pol 0
[    0.612037] ata19: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80700 irq 41 lpm-pol 0
[    0.612041] ata20: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80780 irq 41 lpm-pol 0
[    0.612043] ata21: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80800 irq 41 lpm-pol 0
[    0.612045] ata22: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80880 irq 41 lpm-pol 0
[    0.612048] ata23: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80900 irq 41 lpm-pol 0
[    0.612051] ata24: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80980 irq 41 lpm-pol 0
[    0.612053] ata25: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80a00 irq 41 lpm-pol 0
[    0.612056] ata26: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80a80 irq 41 lpm-pol 0
[    0.612059] ata27: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80b00 irq 41 lpm-pol 0
[    0.612061] ata28: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80b80 irq 41 lpm-pol 0
[    0.612064] ata29: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80c00 irq 41 lpm-pol 0
[    0.612067] ata30: SATA max UDMA/133 abar m8192@0xfcd80000 port 0xfcd80c80 irq 41 lpm-pol 0

So on this 4 port controller we actually get 4 + 16 ports.
which isuggests that port multipliers are handled transparently
inside the controller and that ata15-ata18 are likely the ports
on a 1:4 multiplier on ata7, ata19-ata22 are the ports on a 
1:4 multiplier on ata8, etc.

And look and behold, we see a sata drive show up on ata15 and
another one on ata17:

[    3.737114] ata15: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.738149] ata15.00: ATA-9: ST3000DM008-2DM166, CC26, max UDMA/133
[    3.738354] ata15.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 32), AA

[    4.367136] ata17: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.368169] ata17.00: ATA-9: ST3000DM008-2DM166, CC26, max UDMA/133
[    4.368370] ata17.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 32), AA

The patches causing the problem disabled these ports since they were
assumed to be a "dead" ports since there are only 4 physical ports
on the chip. But these asmedia chips are handling SATA PMP transparently
inside the chip, making it look to the OS like there are more physical ports.

For comparison here is what a normal SATA PMP (Port-MultiPlier) setup
dmesg output looks like:

[    1.785860] ata6: SATA max UDMA/133 abar m2048@0xfdef0000 port 0xfdef0280 irq 24
[    2.264187] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.264395] ata6.15: Port Multiplier 1.2, 0x197b:0x5755 r0, 5 ports, feat 0x5/0xf
[    2.265755] ata6.00: hard resetting link
[    2.740213] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
[    2.740245] ata6.01: hard resetting link
[    3.055051] ata6.01: SATA link down (SStatus 0 SControl 330)
[    3.055107] ata6.02: hard resetting link
[    3.532213] ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
[    3.532244] ata6.03: hard resetting link
[    4.008211] ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
[    4.008241] ata6.04: hard resetting link
[    4.484211] ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
[    4.490671] ata6.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[    4.490675] ata6.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    4.497164] ata6.00: configured for UDMA/133
[    4.503589] ata6.02: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[    4.503592] ata6.02: 2930277168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    4.510078] ata6.02: configured for UDMA/133
[    4.510788] ata6.03: ATA-8: ST1500DL003-9VT16L, CC98, max UDMA/133
[    4.510791] ata6.03: 2930277168 sectors, multi 0: LBA48 
[    4.511557] ata6.03: configured for UDMA/133
[    4.512232] ata6.04: ATA-8: ST1500DL003-9VT16L, CC98, max UDMA/133
[    4.512235] ata6.04: 2930277168 sectors, multi 0: LBA48 
[    4.512950] ata6.04: configured for UDMA/133
[    4.513008] ata6: EH complete

As you can see here Linux sees sub-ports ata6.00 - ata6.04 instead of only
the .00 one seen with the asmedia controllers and in this case there
are disks connected to 4 of the 5 ports of the multiplexer.

TL;DR: So we can conclude that the problems on the sata controllers
with ASM1064 / ASM1166 chip combined with port-multiplexers are indeed
caused by the patches limiting their ports to 4 resp. 6 ports. Because
when connected to port-multipliers these controllers handle the PMP
stuff transparently inside the controller and show the multiplexer
attached SATA devices as directly connected devices on ports 8-23,
resp. ports 8 - 31.

Conrad as the author of the patch adding the original port limiting for
the ASM1166, can you submit a patch upstream to drop the port-limiting for
both the ASM1164 and ASM1166 for now, with the following tags added to this
patch:

Fixes: 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
Fixes: 9815e3961754 ("ahci: asm1064: correct count of reported ports")
Cc: stable@vger.kernel.org

?

This way we can get this reverted ASAP and also get the revert on
its way to the stable kernel series, to fix the regressions this
is causing.

Feel free to use parts or all of this email for the commit message
of the revert to explain why these 6/4 physical sata port controllers
actually correctly advertise having more ports.

Regards,

Hans



