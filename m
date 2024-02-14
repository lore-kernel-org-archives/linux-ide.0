Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536E8527A
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931479; cv=none; b=PzObJnovwxKG5SYqY8NtppT9ryGmWIcsMbXYeP6NiPEfSwGEtsH9BUsF5DgYZIu4AujUvjmwYk+XaiEW9CEFOm390QeW5QBS8yorlZzNX7hCQY6g+bXriihXJqFIvvdMGwv3D/0D5GEpbukIAXe1E42a6ua2YBm0dYJKAsNBih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931479; c=relaxed/simple;
	bh=Ms3OZG2korniXo8SQh7iw4zPYgfjmmJc/3fBA2Mb7EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcNiJfkPkGVt2xofmdMbhCe70E4/vZ+vWQ2c7YWpk2UecFbsokLzsvq4D3kvPjCePidXEXG1ZKUz33tYDqfMRW799BSVRln/vijm9B67sqm5LmOjmE3h3cciZA8nt2pecuZXP2wch6RlrTHCDJY9lMonTnBUcsvVOh8lgLbxTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSSasADr; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSSasADr"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42c7f8588c5so25832981cf.3
        for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 09:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707931477; x=1708536277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4PmUVGUkX8ZNgrCuCFLQheaG9MHkxT80ZcJBPPx7UE=;
        b=aSSasADrJm9oqW/p21lOhFCeGz6lc5VfycZvAdAbjQPupEnh5YTZigghujMZp+/wUA
         s1AxAfC0vOLdDOb8ulU5HhQD8sdcxeXrSDjv80vjWsMTbtvwTcgdx52+oTnN8lor6EnR
         XhjOop53/ztPMPpqs3xl/eXTRhlnpzld2SBdk9N6WkUVjt0KHxldgdqVy7InF8rzhG9l
         y31PDI9LO+/GlkncmwJ3aM3TRcxRbvt+NXpzEvnCwnAVViXf7NKadyBwyKDOtAxOpxBs
         4sG45I/41nCCeqeX1g+aWxjVBRzm4QRkKGYd8Y3zmonIQ97NR0OAdEYmDcduhC+c3tq6
         0+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931477; x=1708536277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4PmUVGUkX8ZNgrCuCFLQheaG9MHkxT80ZcJBPPx7UE=;
        b=mDOnmj/JWXhhMY6U9RpBCnAdOWLpfwIt3KondUukF/M4aSwyHxt8waNelSW75gQ3HQ
         EZN6OLQ2zWEYzwcseFtd9nh/PDh3AwNW8txyiY/yYU+dHTYMZmMPKtVwFtuOaW/N5QHV
         4YVwhl/eJ4lsdEOINQLl1C6fwlqVat5gdXfDZY5PsS4G5dT5d/FZaWYnWBhUtIfUR9mb
         g5ryWsOlQY2YY6IgdH0Ngrk6dQc16idOMZfVLX/ahJFW1dfOO55XUlnteyEoqiCAVPOT
         Dtvt8wJAkAa58Srt6ColBRRpy7r9N8A0oAW2ry+AxrTdZBhVmoWBJR2KAic9jDN+38Ph
         TcMA==
X-Forwarded-Encrypted: i=1; AJvYcCUlr3JM3KFpbLTHs5eLHDsnsnju2OwlWWil5fkPEhysz1XqQyhF9iAJFR329qy7wQYl20fogBMrnUS/de7GZB6ac5AIaXv893ba
X-Gm-Message-State: AOJu0Yzld2cx6J7smbXpEOKp1luqB5dKfP/QbF3ekWn5/hZkcdy4lWLS
	MwbjZq8YPBca/Vkf9eAtp/+vF9z93wwD3YpTc5AZsfVPbpRFYHeJbqcjg+xayjebKQJBJ6KIAFs
	UR2wA4dHINVFNnbF183DrFzDHHLg=
X-Google-Smtp-Source: AGHT+IEUkStHkIEJcE8tp/Splh9x7+jsm8H4MOj+twfzCVVy4WmvCmSsvP2G7Ie1+YPFBirlXpVElOw5YRsb6DbiwZw=
X-Received: by 2002:ac8:5d4b:0:b0:42c:2728:80a7 with SMTP id
 g11-20020ac85d4b000000b0042c272880a7mr3137650qtx.50.1707931476728; Wed, 14
 Feb 2024 09:24:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214165758.986896-1-cassel@kernel.org>
In-Reply-To: <20240214165758.986896-1-cassel@kernel.org>
From: Andrey Melnikov <temnota.am@gmail.com>
Date: Wed, 14 Feb 2024 20:24:25 +0300
Message-ID: <CA+PODjo_5u6hw8K8nNGR0-kRq1W_1bhBZJP9BCgL+VbFyvQY3Q@mail.gmail.com>
Subject: Re: [PATCH v2] ahci: asm1064: correct count of reported ports
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 14 =D1=84=D0=B5=D0=B2=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 19:5=
8, Niklas Cassel <cassel@kernel.org>:
>
> From: "Andrey Jr. Melnikov" <temnota.am@gmail.com>
>
> The ASM1064 SATA host controller always reports wrongly,
> that it has 24 ports. But in reality, it only has four ports.
>
> before:
> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl =
SATA mode
> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sa=
dm sds apst
>
> after:
> ahci 0000:04:00.0: ASM1064 has only four ports
> ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA =
mode
> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sa=
dm sds apst
>
> Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since V1: use switch case.

I think we should stop abusing saved_port_map and convert all quirk's
to use mask_port_map.

>  drivers/ata/ahci.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index da2e74fce2d9..682ff550ccfb 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -671,9 +671,17 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM pol=
icy for mobile chipsets");
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>                                          struct ahci_host_priv *hpriv)
>  {
> -       if (pdev->vendor =3D=3D PCI_VENDOR_ID_ASMEDIA && pdev->device =3D=
=3D 0x1166) {
> -               dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> -               hpriv->saved_port_map =3D 0x3f;
> +       if (pdev->vendor =3D=3D PCI_VENDOR_ID_ASMEDIA) {
> +               switch (pdev->device) {
> +               case 0x1166:
> +                       dev_info(&pdev->dev, "ASM1166 has only six ports\=
n");
> +                       hpriv->saved_port_map =3D 0x3f;
> +                       break;
> +               case 0x1064:
> +                       dev_info(&pdev->dev, "ASM1064 has only four ports=
\n");
> +                       hpriv->saved_port_map =3D 0xf;
> +                       break;
> +               }
>         }
>
>         if (pdev->vendor =3D=3D PCI_VENDOR_ID_JMICRON && pdev->device =3D=
=3D 0x2361) {
> --
> 2.43.0
>
