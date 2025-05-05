Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729625C6EA
	for <linux-ide@vger.kernel.org>; Mon,  5 May 2025 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465023; cv=none; b=jcnBt3izKYrF7Wkv28Mp7IH5LuQIYX3Az1J8a3eReQICxVfl3PhRKbdqxkDUKwHq+OatiVnDUTa0s90030n9LQEamYfTaLNEaNbl0xSBKqrPGA6Vij9IilG/eEm2oiWwhaR0U89WAtNZiTjB6Oik5wxMTp9835BdXuGR9LCcLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465023; c=relaxed/simple;
	bh=04jR3TVTGHWUAtdDWkNRnN0tDoXvdkLJmMHZPgdNacw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jrk+0m3pqBojGwkciXMSYbhCtNj7ce+rcDI0en3fVe+LF1Tw4pmLin4nMKsebGeQsXdJ109/ZXLofJy92OcTpz4DAcWdmRKqbJYKkPuc744NdWqEmHcmRY1xmxZHJ61HjfP8UbaI5bFlSd/z6xJ8Y+JWYCLxTg2Jr4Kvb5wmTrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm184Wd0; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm184Wd0"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso2631194276.0
        for <linux-ide@vger.kernel.org>; Mon, 05 May 2025 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746465021; x=1747069821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=04jR3TVTGHWUAtdDWkNRnN0tDoXvdkLJmMHZPgdNacw=;
        b=Tm184Wd0WEezRCYRHjSRJ9A9pcqAGCHYAI7B/N/VPzRaHiHxfRyLsmvQZvhPhpwqW5
         dN48OtXHy7BXqZ/MmwkIAvpb5I0VAT0rX8QwI3CCDz4Wai0+Ndsa4XGuNAAFPkwWhjoR
         qan1Bac03OGA6w+FHYGAFdp/Xbyi2a+ahyRSICKtZl5uwF95eAjSGpU/pVGP7Ns5lWLx
         iCDPlnWh1ZGQOniWDI0rU8xK6nlS77VmsG1CClU2Okh8zWvmzDh/4hoPhsKIqtE9Tkyf
         ER+FaQSAvIl96EorbLcnjjjqK4Ar+K7sIs1bKmZymWoVbIBPOkPE09j7mRwV3vRIT88L
         n7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746465021; x=1747069821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04jR3TVTGHWUAtdDWkNRnN0tDoXvdkLJmMHZPgdNacw=;
        b=l3eDAjIDl+B/Cy8zpmLr7FhR04s/iOJ0Zlvflis7jhQ7ZelTfFYwM3XuU+rWQ/pLuU
         uwnT1Jdsq2YCoOZBcpcWAC3mniFV7ifTguFaoWp0KIV++6qqnURFwme8WphnWtT6mblG
         c2MDZN2Jwo/HJR2xBRXJt1oxYPWofyYZ75Vrs3S+NOC7wUDmWVI2/K+oXv6L2O47/yhv
         vXRbfzt0EFGOrAsXIyZQA8ZY63Cg9JVO79a/U8pvepaXIzevdKf82xvvuhoF3eAoasNR
         WUqBQihV7DATc03eDPR5Xm7+kPg4Qgn+koJnxMS34TJJafALzJibveyWGf3RjmjMQ1sf
         vFUw==
X-Forwarded-Encrypted: i=1; AJvYcCVspV9TAMqUKYZ+IA+YKcwyXEVPIU1b9ZMLDN6Rs2t4rcnw9ue8lqIS0Zx3CukHLy+8kuuHyAbc91s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUpI0RfdGzrwLiE9/LdPlZ/fb9BNhiTs/CgiDyLhWdmOP7b26
	zRhhDvQ/L7Rmc0M+VIA6o9YQqLeysjH/pBaC2K8ZJHYUJprl7PSnLHL9WWsII9jD3O3NUwvn7fu
	b7IWVMZbMOhlo4+vl0JdPREwbgs4=
X-Gm-Gg: ASbGncvcTYfQxtdHTLsgKdruSztVntlPgyx0lmFOaQClP2i1RMjRzLhuWODdSRPkYRD
	JYSnH+UTUEv2baqCNpjgsZiVs8giDR1kOVyJjoTP47QLqeNRAEHn0uRrBK06Yd/sCwyZDHrm3M6
	pJGIp2i2N52Vnc3E+iDDUSmr0=
X-Google-Smtp-Source: AGHT+IHTmNVRCv+08s6tzuBT4k1e1IDE1wrKmVhKRQ3k+dt8EmS4qKvTzG4+e4jMVVL9VlWoTTttMimt0Eab2SzUBXQ=
X-Received: by 2002:a05:6902:1549:b0:e73:1813:b304 with SMTP id
 3f1490d57ef6-e757d2de5fcmr9090737276.12.1746465020744; Mon, 05 May 2025
 10:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org> <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
 <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com> <aBjbSt5hTaUP_JhG@ryzen>
In-Reply-To: <aBjbSt5hTaUP_JhG@ryzen>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Mon, 5 May 2025 20:09:44 +0300
X-Gm-Features: ATxdqUG9V9ad3ezdW0kiN7liiTgjsDbkOJUEQvPOGiYt6usdU0iansVspbkfWys
Message-ID: <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org, 
	Niklas Cassel <Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"

ma 5.5.2025 klo 18.37 Niklas Cassel (cassel@kernel.org) kirjoitti:

> On Mon, May 05, 2025 at 10:58:22AM +0300, Mikko Juhani Korhonen wrote:
> > > > On 5/1/25 05:36, Ioannis Barkas wrote:
> > > >> It would be better to have more details on this since only the 2TB
> > > >> model is targeted.
> > I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
> > from 6.9.0 on as they just keep resetting the SATA link , but they
> > have worked flawlessly with 6.8.x for a year and also now with the
> > quirk applied.
> > I have also tested a different WDC model with med_power_with_dipm on
> > the same SATA port and there are no problems.
> > But after you guys got suspicious I found there is in fact a SATA port
> > on my motherboard where the WD20EFAX-68FB5N0 works with LPM on
> This motherboard looks to be AMD chipset, so I assume AMD AHCI controller.
>
> Could you send the output of:
> $ lspci -nn | grep -E "SATA|AHCI"

mjkorhon@taavi:~$ sudo lspci -nn | grep -E "SATA|AHCI"
01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 500
Series Chipset SATA Controller [1022:43eb]
