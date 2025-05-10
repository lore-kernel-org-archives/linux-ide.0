Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62920FA9C
	for <linux-ide@vger.kernel.org>; Sat, 10 May 2025 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746901771; cv=none; b=Gt9tlWTyRBzO9S1TejO91vKpIy38O/vJPn7GvUcumOOKDTS5xp8dnn5se4aYD8JAu5yeL1fxonX9ZFonQEERSUO/p7hsKbEM4Ldm7IyxjeGeC5AjMovijOazlCbwlMf22eNmdxMMzQroR4H03EiR2mVI4cvbdCtQz2JIjMwQ7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746901771; c=relaxed/simple;
	bh=rBisYG527ndXI8JAfmvhlAIwzhZ0xrgox1F01mDhenI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoVi7XiIh4KJLaYaaK3X4XlhrX2I+VOttSjcC0wR8iGMhcG2yYacf+6dkCo/0UywUDfJjVXjf+bnoFgEqOscB9oKIRq4rmjdLxPWTrngGYAX+BAMW760CKL6OLBrpyh8ILYQrI3yGnpRbmNvNT581F1wFYtzI6ro/oUw0R6ehEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J20CB/rF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J20CB/rF"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30ac24ede15so4220495a91.2
        for <linux-ide@vger.kernel.org>; Sat, 10 May 2025 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746901769; x=1747506569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3DsHTMRQQH0NSHPd7pUXQwUCXcEaFuAhMEKuI9i9UeY=;
        b=J20CB/rFHKUbuJD5UrLEDjOGehcdhaaN7BPw3BK1wWaYNs5TqeOrRfSVTI9ApNM+uA
         +82XQAlgx7unEOmhyJFH0+rqhqz2vKFX4d2VadYa7xFLYFWrk6Ga009DGYDW2CSYOcpS
         ijXN2cEesVeHKlkZ8B+Z9uxPp1IAp0vJb7sXF35BH6OmdRKNm07w4dlQOSrHqcScU1i3
         5OK+ye0W8HdDKdnS/335swXWv1h9y0uV7wzccHVz6eHfE5gagZEkS4Iwg1AS97YkAYNc
         w51qhYuXXTqp1GupOPSZprESR3wMXVGnGRqx6o62G7AYDdmCUfcd5Xm+aEJOwkTRgbE2
         i0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746901769; x=1747506569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DsHTMRQQH0NSHPd7pUXQwUCXcEaFuAhMEKuI9i9UeY=;
        b=RSan1tIL5/apMw+RV1rQFB2pe8i+EU33mnM66nmVTNmaH9Uw3WKpRaR/NQ7fsUX5iM
         +5xvdS72327aElCcTwySITKWLiD6cWRouqLMtqdWJyTaCtiz/bv2QQOpibQhJWGf9Lc7
         AvOqq6yHSb1paG7WlmB48WOEcLaN0Qrf6CLwo0X4OTcYazt/UyEGLLLonLj3Bvih94us
         MBtir36WWTfJpTGgPsyFKNtKCalWgvJq9aFM+NJ7xT9phgjFO/1xCpEDRsR5BCgW8vKy
         XUiwerB8K/92+AMfnv37WZXW+6jYncUKlavZufSo12E8cc1v3Vz9psKpA3RB/Q/4qMXc
         Nx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7W7aeiR9tp3BMuXH4zlQ01PLQNBek6k0Ot5vzw41HqHvYibyu2+HBvxNtHUEzyJQQnHelh3s1RP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza9S8IuAsxVJCb51VUvnf6qfSKaqkhJ8eDljyWGIHIV5bIecBj
	iFbnn5MMgLv/nDWCfNfnzDhpezk9I5WxLOfzMNz/It1fRNjYdfBlA2tJ49bd2wy/r/oOHsUXU26
	5K7W69MNmkCcFM6mrpw+Av70xfbY=
X-Gm-Gg: ASbGnctg5h3tT8HCkvNxgG9YyJRAFbwbFoJoWX6SGWgBn+mm9KuTE93X0gDsfe2dt+j
	okpm+AUAB/Gjed0iEvkjDlsTaK1HfAhC6PEbWD9WxKMPMrybprmLHaExA7YerVuxETe5esTNw9E
	GmMoAEr9UXuIvtfi2YgKLa0KtQ72Mcs4ewVueWYY8E+A8MxEFt4s83rOTRtq1L6rzwwg==
X-Google-Smtp-Source: AGHT+IEjAnf9sfWm60uxzMFVSfMYVWFWFaHhyb5nMhywzeEujMvd4lWIQhJZo6eheVi4M9hTaW7Q/pFBE19A1AY+9w4=
X-Received: by 2002:a17:90b:288b:b0:2ff:7c2d:6ff3 with SMTP id
 98e67ed59e1d1-30c3d664d3cmr12490998a91.35.1746901769316; Sat, 10 May 2025
 11:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org> <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
 <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>
 <aBjbSt5hTaUP_JhG@ryzen> <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
 <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org> <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com>
 <aB8_rITWsMzkTiyE@ryzen>
In-Reply-To: <aB8_rITWsMzkTiyE@ryzen>
From: Ioannis Barkas <jnyb.de@gmail.com>
Date: Sat, 10 May 2025 21:29:17 +0300
X-Gm-Features: AX0GCFu1ujS1B_H6PN4ZeEFn9ORbkRsLR22lEtrSUQ_Ny5HhZntwglQIlJRFGQw
Message-ID: <CADUzMVYNnwf3hkFSvmS7AG9ocxXKfzd0UhZ_DOW8xJtTGru=Lw@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Mikko Juhani Korhonen <mjkorhon@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	Niklas Cassel <Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hello all!

Niklas following my suggestion Mikko updated his BIOS so some settings
may got reverted to default values.

Best regards,
Ioannis

On Sat, 10 May 2025 at 14:59, Niklas Cassel <cassel@kernel.org> wrote:
>
> On Sat, May 10, 2025 at 01:14:52PM +0300, Mikko Juhani Korhonen wrote:
> > ke 7.5.2025 klo 11.56 Damien Le Moal (dlemoal@kernel.org) kirjoitti:
> > > >>>>> On 5/1/25 05:36, Ioannis Barkas wrote:
> > > >>> I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
> > > >>> from 6.9.0 on as they just keep resetting the SATA link , but they
> > > >>> have worked flawlessly with 6.8.x for a year and also now with the
> > > Can you share a dmesg output for the good case with 6.8.x kernel ?
> > > We would like to see differences with the non-working case.
> >
> > Hello Damien,
> > here is the dmesg from good 6.8.12. Thanks!
>
> Hello Mikko,
>
> In the (bad) dmesg that you shared earlier, we saw:
> touko 05 09:18:59 taavi kernel: ata1: SATA max UDMA/133 abar
> m131072@0xfc580000 port 0xfc580100 irq 42 lpm-pol 3
> touko 05 09:18:59 taavi kernel: ata2: SATA max UDMA/133 abar
> m131072@0xfc580000 port 0xfc580180 irq 42 lpm-pol 3
> touko 05 09:18:59 taavi kernel: ata3: SATA max UDMA/133 abar
> m131072@0xfc580000 port 0xfc580200 irq 42 lpm-pol 3
> touko 05 09:18:59 taavi kernel: ata4: SATA max UDMA/133 abar
> m131072@0xfc580000 port 0xfc580280 irq 42 lpm-pol 3
> touko 05 09:18:59 taavi kernel: ata5: SATA max UDMA/133 abar
> m131072@0xfc580000 port 0xfc580300 irq 42 lpm-pol 3
> touko 05 09:18:59 taavi kernel: ata6: SATA max UDMA/133 abar
> m131072@0xfc580000 port 0xfc580380 irq 42 lpm-pol 3
>
> In this new (good) dmesg we see:
> [    1.839502] ata1: SATA max UDMA/133 abar m131072@0xfc580000 port
> 0xfc580100 irq 42 lpm-pol 0
> [    1.840186] ata2: SATA max UDMA/133 abar m131072@0xfc580000 port
> 0xfc580180 irq 42 lpm-pol 0
> [    1.840859] ata3: SATA max UDMA/133 abar m131072@0xfc580000 port
> 0xfc580200 irq 42 lpm-pol 0
> [    1.841516] ata4: SATA max UDMA/133 abar m131072@0xfc580000 port
> 0xfc580280 irq 42 lpm-pol 0
> [    1.842166] ata5: SATA max UDMA/133 abar m131072@0xfc580000 port
> 0xfc580300 irq 42 lpm-pol 0
> [    1.842804] ata6: SATA max UDMA/133 abar m131072@0xfc580000 port
> 0xfc580380 irq 42 lpm-pol 0
>
> lpm-pol 0 means "keep firmware settings".
>
> That we see a difference suggests that the value of the Kconfig
> CONFIG_SATA_MOBILE_LPM_POLICY
> of these two kernel builds are not the same.
> Could you double check this?
>
>
>
> It is theoretically possible that both kernels were built with the same
> Kconfig value. If your BIOS marks a port as external / hotplug capable,
> then libata will force set lpm-pol to 0 (overriding the Kconfig value).
>
> However, if you haven't changed any BIOS settings between booting your
> two different kernels, then this second scenario sounds very unlikely.
>
>
> Kind regards,
> Niklas
