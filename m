Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116481119A
	for <linux-ide@vger.kernel.org>; Sun, 11 May 2025 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746983320; cv=none; b=B0V5lg74Y+YFtDEyp1duOQ1cW2gycEEQahCOXYR+kgGfj3BdD+6u8Ay9WFRY8/vGPXJsmfC8MlY2EShKIfDjlwkJ5dg1bpkGdPXsF/FAAVLFr3K47hjVds6YlRxvQNvZWXmLqf9UyAeHuUd85QrMK8S1X1lB97yeQHQIAReQycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746983320; c=relaxed/simple;
	bh=MXP+IDGSHMRsjg8Mm+7f67fZCLG/jGdwW8MUpxfMCuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxfkleBpYckz2GY8VMB/vM4OlsSjL0InXcytf2KO2HuvTHowx7/N35eacjmGwgkdXLaPa8EVarbInnGLuJGdNfZGfFcqwcUsDACRuSGLw8QZmW6XxEBb0OWpc43OkrcwjRqXWwJHpqSg7lqIY9MXz0vtGpAz7yo6C2TQBhRwke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD5cHcQI; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD5cHcQI"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e728cd7150dso3011353276.3
        for <linux-ide@vger.kernel.org>; Sun, 11 May 2025 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746983318; x=1747588118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GYqT+/ko3TAO2ha1bjDVh5PZbi3rDWyqozEtuVXP4CM=;
        b=bD5cHcQIoABLZ34zjgmMUEZ3t0glVpIiiUoxQDEGCOAOJ6b3I943Ay+9pkWz6IwZjs
         V5i/zMR9cfqV3+63rbBUtwiio4Vzs3KjlSG+dmpCIcRRIO9MH9Heqrl/ylZGBrBTJ2a9
         bu0Uj696NLNb6s+42G1UScsXaWjHptCtjdBO1yf7mC2bVniZn4cYbWHi6wXNcFoxLV7N
         pZqp+YzUYmPsfCz5rCmuQqk4Uzt9qKxyWZLUZBKUOlSigaYZSCdcoSmvLXqBySjk46Et
         Ba2aUm3+Z0EoRTksogUEXm+gJfEpLBxEYm9BJNBzOQnynvAUAIR5KBxBkIoG0qAZszQD
         BcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746983318; x=1747588118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYqT+/ko3TAO2ha1bjDVh5PZbi3rDWyqozEtuVXP4CM=;
        b=aRN6J1W/7TD/p1N5nOvukVRxqLvgGilYJ7KhVKM9YeHdQEFB05i0VTQ5Yxi6MpupAH
         9KJtQUulOBileqoUPv2FCOfuT2CipEQ4pdF8pRdtsc8V+PW5HWxC9YWKUbcXz+pNMvWr
         zLRR1eUCvM7uIhIwx47orJYYWV4pS2lAoDlaRpvrw0utosP8yEe7GiBM92jsr05m8sUM
         B1eYdaIKR7zn9BTgj4MjyBbcTX84Op/pAoMQOnaNmp40923emgxEMtN3AqQY3B9KnZDG
         VTK5Z6ASOODBd455GUxeF0286wXckdR4UcZAgcCI7nHmaLx6WYVTZGNkd5hMsH7cf6xp
         fw6w==
X-Forwarded-Encrypted: i=1; AJvYcCXvCzVlsxSJ6LhaZ48ZEwT9MdJ0cwevNs6GIIkZKVH9pi8ioSZOBvyrzkXN6HySSew9Dkcyz5nJan4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0JBqZ2VbIt67xmutYjr4TyfacpM+uiP7jFIPbQNRo2cMbnZm8
	GlcyAwDlNA0XaKmO3ONEo0cnTxxBRV6+JCiN2RVML6V63fVgiC/wD5TLL5RxE/aXJlbi2qUEEMK
	1WQFzmUZ0oFXjnRPFzzh6W+36sps=
X-Gm-Gg: ASbGncuEraqOJ1EGKbHiAiw5Vf17v2OQTnkgd85JheWNHCh14VGarI1gp/AhB60HETJ
	Q8engs2tu7AjeEBnO9bzWth87NS6UWkRz59G1cenHvhVuppBCGylhmae5PHcjzd2aB7nXVOhGn/
	N/1/p4q4exgqOFs1OqkLhsYgEmRCppCzDF5Q==
X-Google-Smtp-Source: AGHT+IFfrEKZdcUs/gv3JiCRt9XUNxld6Z7ZU0xMsODXCXwwWphGjUrEUtGoAOwv6W2e+Vb8h0HXAudoNA2jdPIlVcg=
X-Received: by 2002:a05:6902:2587:b0:e79:100d:5a29 with SMTP id
 3f1490d57ef6-e79100d5ab4mr8322840276.38.1746983317858; Sun, 11 May 2025
 10:08:37 -0700 (PDT)
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
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Sun, 11 May 2025 20:08:02 +0300
X-Gm-Features: AX0GCFuCDlBfpasNclsX5ol1EVXiS__AnkSD-cFbg6T5UN9trO7EaY6vbMDUGHU
Message-ID: <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org, 
	Niklas Cassel <Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"

la 10.5.2025 klo 14.59 Niklas Cassel (cassel@kernel.org) kirjoitti:
>
> On Sat, May 10, 2025 at 01:14:52PM +0300, Mikko Juhani Korhonen wrote:
> > ke 7.5.2025 klo 11.56 Damien Le Moal (dlemoal@kernel.org) kirjoitti:
> > > >>>>> On 5/1/25 05:36, Ioannis Barkas wrote:
> > > >>> I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
> > > >>> from 6.9.0 on as they just keep resetting the SATA link , but they
> > > >>> have worked flawlessly with 6.8.x for a year and also now with the
> > > Can you share a dmesg output for the good case with 6.8.x kernel ?
> > > We would like to see differences with the non-working case.
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

Hello Niklas and all!
I have:
linux-6.14.5/.config:CONFIG_SATA_MOBILE_LPM_POLICY=3 (good)
linux-6.8.12/.config:CONFIG_SATA_MOBILE_LPM_POLICY=3 (bad)
and these are on exactly the same BIOS settings and firmware version.
There is a hotplugging option for each SATA port but it's been turned
off all the time. So no luck with theory that something got reverted
to default in BIOS, sorrry!

Best regards,
Mikko
