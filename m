Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D6DDD1
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2024 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984097; cv=none; b=rNcf8GN/L3mHj7BJercEUdfxt2VklK8Ft1/n+uqjBmh0aaXsd1heTWUm849HGP5uK9ahbJZN3OvLFZwb6ptZvepsS89ySpYYifyDzzlfK12otCvOTqhmbcdT1fIW6HvzllI7nVpljyItmVF/KLuMYX0BcrBeFtZhY0HrPZ3Vz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984097; c=relaxed/simple;
	bh=RCuKcn0lAZQmBwNqN1ew04a0SUpVrTeQr7Dl/Qw+Wgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlENNahtFDwyU9H5fAKe98/jNQLaZIz+YjG0kgRnxOoNqB9pWf/MgFi8GpwZQNCg71kZeLS0W+ZOtNdyjWfstWmTQeT3DSkWxUyiSu2Fi4FnsNzJLmRalk78TRZWlJ9brc79IqyAX9nY4gLIDJjchfz8O72J9hAOYGNi3W3hRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHAVqiGp; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHAVqiGp"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a35c720b8so1809011cf.3
        for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2024 00:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707984094; x=1708588894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvjh53I+fE0xG0bUExbZjOZdpiAC5DZlryszFk1zZ2Y=;
        b=CHAVqiGp4/RDavXuO92aSV0cxTx9JT7vmcX04BD1oA2Mk1Y6jrkea+zeqzDeTgbNj1
         EzowDKX0rUOHokIaEfNh16ELLaItitexg1DmaZjAQt6BuhlSkZzuuyR2vz59r1FStqG+
         yQ11Brp+/BDCLi6GM21SaBCsVtKDsxpjx6/SHiLel6pO93TC+iP8+4p6gLLl+Gyj08xs
         KzzjvMT2piy4oJj/wp2HdkRJ/Gcy+Cas7vswIFkV6GbbSXNPkEd5j5aAVgmXhLDFePHZ
         dzjQv5A+t9QtgU1UHU7fjvkd9XEDl8mrKEeW+PmjFbrXp/6ETqvgkjBbZvL6JsouwAll
         /1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707984094; x=1708588894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zvjh53I+fE0xG0bUExbZjOZdpiAC5DZlryszFk1zZ2Y=;
        b=B1j/bwF/Emtyg29J/yrMlVMs92HKWSt2TtEJVBKniGviu/DIiRc0p8X/nFYO2RV6CY
         C2csUavLR2gou8LM42ohIXnJkF+m6kMqN/GBKwf+K+YyTyuzviHcm6yxNPtWDdJp7r7I
         BTsYlkBwzbVayEUg05r7Ckg0JmNq/HiC3AlpacXenqV59T/b+dWs71dqeTrRVz/AsF9D
         h/bEDqcZDwVY+AhbTTxcDbPiiEiDf9E8D7dmhO8KwZ6UUmcyBa9VcDSUife+76SuCxtQ
         tJcp1F9NyAo1UX3hP8qGC2BHICbFPkYfQO4gWyVDVeC586s5Vcms6oU5iqnhkgbehDN8
         3VMw==
X-Forwarded-Encrypted: i=1; AJvYcCUM1RBnEGXpS62rDxJqL+d7FK2jczpnwO5ay0450z/WnVSvwuv5DC61kqduUVnEOMAsVDDz5HbdwmLbNvDds2MKumW3JETcKRKW
X-Gm-Message-State: AOJu0YwMJZQxWP0/xIlMdmeGhfN1yWI7jiNtoZBXKODjQI723ag4EtNn
	SYbTrZcdXkqCIVmH3R2HVRkPLNvhZGaquZjs+0mWQIkln9nqSDrZ8TAGvzIeFfkzviNoEJlTfjd
	27EazbJB8+uGB+JPaSG15K4H9CDU2PF2g
X-Google-Smtp-Source: AGHT+IGEahy6OFSIDLkmpfowBQZIXbipS3gOTTfW6/S6H3oHItUI14IL9/ibbVC9MBa/0BKQTR1Z+hNzAfk9Jt3JHsQ=
X-Received: by 2002:ac8:5dcd:0:b0:42c:5a27:e35f with SMTP id
 e13-20020ac85dcd000000b0042c5a27e35fmr1321161qtx.50.1707984094579; Thu, 15
 Feb 2024 00:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214182031.1004788-1-cassel@kernel.org>
In-Reply-To: <20240214182031.1004788-1-cassel@kernel.org>
From: Andrey Melnikov <temnota.am@gmail.com>
Date: Thu, 15 Feb 2024 11:01:23 +0300
Message-ID: <CA+PODjqp9q1VeCsDvhn1TZ6bgnghX9t8P2m-7aEjFfSiBuk0iQ@mail.gmail.com>
Subject: Re: [PATCH] ahci: print the number of implemented ports
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 14 =D1=84=D0=B5=D0=B2=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 21:2=
0, Niklas Cassel <cassel@kernel.org>:
>
> We are currently printing the CAP.NP field.
> CAP.NP is a 0's based value indicating the maximum number of ports
> supported by the HBA silicon. Note that the number of ports indicated
> in this field may be more than the number of ports indicated in the
> PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
> Offset 00h: CAP =E2=80=93 HBA Capabilities.)
>
> Print the port_map instead, which is the value read by the PI (ports
> implemented) register (after fixups).
>
> PI (ports implemented) register is a field that has a bit set to '1'
> if that specific port is implemented. This register is allowed to have
> zeroes mixed with ones, i.e. a port in the middle is allowed to be
> unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI =E2=80=93 =
Ports
> Implemented.)
>
> Fix the libata print to only print the number of implemented ports,
> instead of the theoretical number of ports supported by the HBA.

NAK.
Kernel must report what it got from silicone/addon-board. Different
revisions may implement different numbers of ports.
If you want to report real (usable) ports - add it after the mask.

> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.h    | 11 +++++++++++
>  drivers/ata/libahci.c |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index df8f8a1a3a34..92d29a059763 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -455,4 +455,15 @@ static inline int ahci_nr_ports(u32 cap)
>         return (cap & 0x1f) + 1;
>  }
>
> +static inline int ahci_nr_ports_in_map(u32 map)
> +{
> +       unsigned long port_map =3D map;
> +       int i, n =3D 0;
> +
> +       for_each_set_bit(i, &port_map, AHCI_MAX_PORTS)
> +               n++;
> +
> +       return n;
> +}
> +
>  #endif /* _AHCI_H */
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 1a63200ea437..82ebe911a327 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2637,7 +2637,7 @@ void ahci_print_info(struct ata_host *host, const c=
har *scc_s)
>                 vers & 0xff,
>
>                 ((cap >> 8) & 0x1f) + 1,
> -               (cap & 0x1f) + 1,
> +               ahci_nr_ports_in_map(impl),
>                 speed_s,
>                 impl,
>                 scc_s);
> --
> 2.43.0
>
