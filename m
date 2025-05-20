Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BD25A33D
	for <linux-ide@vger.kernel.org>; Tue, 20 May 2025 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747715833; cv=none; b=V2A6fPFJ7PsDE0Sq96uVQEQRrcUEQmnA8JtTDYpRDTsAu3x7OvknVkbUojuxY20xRkzcIBHdPvqNLN7aJUwVjM3Ca6+xdA9i1w4yOxJrwOTHAHFZbfyffqlPYxsNZ0Y+wgNqLgHZqEMDWdKVbaa0kw/iams3N9N3JHFR0VtqUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747715833; c=relaxed/simple;
	bh=yGPunZS/YlovfaXou2nccgWByBF94Lq7JkjeyqtJ20o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEdPX0X5g9IHLUndx5iBdJePwPXfF6xQpGQPXh4O8L3/pwKm3DjhsBmc3f702kr8Or5wGvDex6WymE7+v5MIpb7GpkDb/d0gZhoPU6OYKj9/ymmahQXcfd5Zgf9OhtfMUU71Fcgd/92GH19zK/YA92sQrHJytK5SCL1DdrsVo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRlnl7B4; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRlnl7B4"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7b943bcf0cso2155762276.3
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2025 21:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747715830; x=1748320630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OFTN2UgB/ickwzIPyeCn88gSQu1cBtJ8NEr1Tj/8FH4=;
        b=FRlnl7B40UG/HWptHyzETZnexyHb/Pgm7ZF6kFzhRfm2s3xTEW1yRjC5YpSTUc0kth
         0NLh4/Jm+xKWV4ZwdEJliFzncXRZAL7AQvyYi2tBpzsTDPk4PY/1HZcci6qTjgRQ+eUk
         moPpTwhOWiJGv6roZGoIr1VbxoEMGQgO3ofTwuSl9kdyJUTMq/NgMX8eJzV18Jj0JBVF
         rG1eUgT2Hx46EENg2d3crTOu2G1NWSnqBMXUQITk/5JqQLn1TCGPgY9CMqZuUw716mgr
         QDTOXCyLjIwfJEXamJ/j5OBCA59GOSe7/kCj+Y1iYGuEVVl2bKP86nJHys36BXxKtzNo
         P67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747715830; x=1748320630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFTN2UgB/ickwzIPyeCn88gSQu1cBtJ8NEr1Tj/8FH4=;
        b=wfl+CdjkyLMi8cJ1x10YG5CIw6pQlvd7b9g1LquVfbl79oMz8AC2+pUvoHDKX899L1
         ayAuhleDK14kaCju65nwCHbBB0cj+jhYauaVLu5CKxYvVMA7HzGxY89F8Y4i+vyV5mgH
         fe/BhCFFWjz1i0Nk8oJaWjd3CVbZDiT6R2QvT+iZRSaKrymPpSRgipS1uwKlcDAhKR0x
         wyPE8RSWbinM2ndW2qZTEmlwFEI5+Ha0JhVMtljyO1Hm1APFhnNkCXbyTJXPkoYEwsBG
         s6QEV5pzrSw2OAYla0TOCceKtQcJH7miRZE4Zt1fYOU/jupiE3+RD4FxvdEP8ecd2JSp
         rUYA==
X-Forwarded-Encrypted: i=1; AJvYcCVN1NL02UpXfgfchNYgkExzuJ1ym9QP4l/FxNzC/18sZLFamJI9aLx4R9hYdp01G/N/OrJmV6HeG6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBvPrLym8+/iPZcb6PUeqsRbo0zSxJ1oUeimvdKfuLKWn3Sova
	dVBlIxjM2etGaChbw2apYLTrfp9iDP5CmMP93BjlaD/fJEp7Yk6ABnrhRhQevz70KOjF0HLAs4j
	U+VrfakWT8n795k80J0Q5NaTunxHBOfKa417w
X-Gm-Gg: ASbGncsFpfLdXgPbZ0wB7aetsc0aiTNLjXmpUrVC+9voWBm7BSGHU6rHVGkuRxYl9PO
	xU7IjHrDJpLk6vaxVtAnxQ7xd1m0T5ky+0xyIgU7C8Gug5AAHvfIpri9OvBjOKjPzv21GeaBu3b
	GMqVetBMrrQaAhcbnFzfY455EdFUFxcJkhZw==
X-Google-Smtp-Source: AGHT+IHfTc8FezKFa9CaJAmaeM6UuVxfWL/FJ9YlMnkfOs0wz4tUuHg6lNZgAPufz0Y/r4m54Q2bMN320iU8ScCKVnc=
X-Received: by 2002:a05:6902:704:b0:e6d:f287:bf9 with SMTP id
 3f1490d57ef6-e7b6d42c564mr18722779276.22.1747715830357; Mon, 19 May 2025
 21:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515135622.720623-7-cassel@kernel.org>
In-Reply-To: <20250515135622.720623-7-cassel@kernel.org>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Tue, 20 May 2025 07:36:34 +0300
X-Gm-Features: AX0GCFvBQ0uU4M3x7L_EFdHp_QFwghcKQQq6_UZkgYjsCdR8mK3G3MUFQLFlkjc
Message-ID: <CAAZ0mTfgYMQE2xBgmUE4Asx5X7ssth0L7AYQkLmjnT=+bG35vw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ata_eh_set_lpm() cleanups
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

to 15.5.2025 klo 16.56 Niklas Cassel (cassel@kernel.org) kirjoitti:
>
> Hello all,
>
> I was trying to understand ata_eh_set_lpm(), and decided that
> it needed some cleanups to make the code more understandable.
>
> Please have a look.
>
>
> Changes since v1:
> -Squashed patches 3 and 4 as requested by Damien.
> -Squashed patches 6 and 7 as requested by Damien.
> -Changed WARN_ON to WARN_ON_ONCE.
> -Changed patch 1 to remove parts of a comment that is no longer true.
>
>
> Niklas Cassel (5):
>   ata: libata-eh: Update DIPM comments to reflect reality
>   ata: libata-eh: Add ata_eh_set_lpm() WARN_ON_ONCE
>   ata: libata-eh: Rename hipm and dipm variables
>   ata: libata-eh: Rename no_dipm variable to be more clear
>   ata: libata-eh: Keep DIPM disabled while modifying the allowed LPM
>     states
>
>  drivers/ata/libata-eh.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> --
> 2.49.0
>

Hello Niklas!

just tried this patch set for the non working case of my
sata ports 5,6 -> WDC WD20EFAX-68FB5N0
but as was kind of expected there was not any change.

Best regards,
Mikko
