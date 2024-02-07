Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639212E47
	for <linux-ide@vger.kernel.org>; Wed,  7 Feb 2024 04:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279633; cv=none; b=ReKt+Bhe464/cb6iOk6dvHzOQt3DqxzNSi1tUDE9IxtiDftvYsCSpHwUw/Pr9mr8gEIQKTiJQGbxR6elT2HIpYyRzAPiP/FCNrCnJwU3hycc+uMxoi83hDgfXMbmwUTXA7Ce1LXDmafRs/8cCEXumx/v1FBZ1uxUBgLM7bKd0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279633; c=relaxed/simple;
	bh=xQ5CLY2p3a0J6IOHokG5rtOQ1eenVS+lwvZd5cOCv38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LA4HV/eC7gs6pI7YB8VFImt6bpM54tKvXM6jBv0DbyY4UZe1fHQdq36VVe17WxSDL82nVofrPTNqOlJaVS4NYZ1/4cOSrgOh/QbjfB0YBN8Os6TsrJ4TYuj8QtA0layubBi3O2Jfjo4+sQzeGKVjR1Kduy36bcqE4gquHW2V7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Bsq3Lyai; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Bsq3Lyai"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so165587276.2
        for <linux-ide@vger.kernel.org>; Tue, 06 Feb 2024 20:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707279631; x=1707884431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvk55CTVs126B+wpdqRQApcn0Udw72kWMmC4ePOZhrE=;
        b=Bsq3LyaizDL+/+d4J581fvj7YaPUFIWIVVMyfMNMvWa2WpvzT/j3M/37p5bPNrNn2l
         97+DATPbVIk5b28sp/qqs34eXefGhSfmK4K/xJXpu+GrVYKO+449a8+omVZ2MYHWH+Zx
         uc/sZ1387zSTfnO7LygQw5FXMkkYcqgBGODMHufLqFyF9A0baOeGuPpXeiJd82CE0LYv
         O932So4ZB/ihq7qpZ4rCiOLe4NVjKuHOt4gEuD4FnFRa/2G0MHy67cFvM2qhhJMF1uje
         WbZgWBw2TYhQzuiYPe2Leefw4gdi/qkeCb9IsshqZUas2r1StczbIujEqw5ZB88U5QLl
         SiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707279631; x=1707884431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvk55CTVs126B+wpdqRQApcn0Udw72kWMmC4ePOZhrE=;
        b=dcO5XGlPHDY78sr1yGMAf9hvXS+qet4OWigaYlEn3sUgT7NYRiuluNiGDOhvBvIiHN
         XxHKBynclm7J5XuvI+29HeBsHfyHjpG4iMIVzqJkgKDB8DgS2o0+t4u0A1gxOXNFMpLw
         UHLFy4S7c8qhgpLujgOdusgdObM+Hgu7oU07Z4KjzO0nC9gw78sVFATpm/tV0VVU9uXO
         5qpRrdk4HvDrtKWkxPKKiDsW1jyw7CXZzT5fkxSBR8jmFZOytUJ0S0cCUNk+o3Ng3T2F
         +UbSUIFAbJLpv5lki+TDVrG47y7Ee5Yw8VDKdqZaWkT7tnkrA74aYjy3ysP3nQze9sCc
         45oA==
X-Forwarded-Encrypted: i=1; AJvYcCVe7n0N2RxaKs7EGWkqntX03goHxvwmGjZP4i2pNdxqrMMUT7HdX9Lj9j/jLEpJafhGI1+VMMOkyNAgq+ODuy2R0T33h2CCBI3I
X-Gm-Message-State: AOJu0YwoEKiJSTrh+jFkb0lNN2aND5dNeGEPJGrsQuTBKxOkllk1fwxL
	p5fleCf3FEvP2RhtVs0XJd5gZj0tEgUtqFhXNwVLK5ot1MD3UcHbOWSpe5XZEotZ0LmVsWprOrr
	X060TpROg6AqDfScj7kYlPUv3akky6Xvk03fzcw==
X-Google-Smtp-Source: AGHT+IEDyMtxexfr8JWFuOY6dTfyEdnskjX0J4zCZNjplio3sZVAt/nxZSSbPCSWDTf0sQbhzPZS9alEffCwTpOfEB0=
X-Received: by 2002:a05:6902:1209:b0:dc7:cb:60d0 with SMTP id
 s9-20020a056902120900b00dc700cb60d0mr4512613ybu.22.1707279630758; Tue, 06 Feb
 2024 20:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206211352.1664816-1-cassel@kernel.org> <20240206211352.1664816-4-cassel@kernel.org>
In-Reply-To: <20240206211352.1664816-4-cassel@kernel.org>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 12:19:55 +0800
Message-ID: <CAPpJ_ed2_NeCbYtrwDeTHxeVVVs2ODmW_rPBrY0ytYaMz3_9kw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ata: ahci: drop hpriv param from ahci_update_initial_lpm_policy()
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Werner Fischer <devlists@wefi.net>, 
	Daniel Drake <drake@endlessos.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Dieter Mummenschanz <dmummenschanz@web.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Niklas Cassel <cassel@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> There is no need for ahci_update_initial_lpm_policy() to take hpriv as a
> parameter, it can easily be derived from the ata_port.
>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 4d3ec6d15ad1..346a0f9ef246 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1655,9 +1655,9 @@ static void ahci_mark_external_port(struct ata_port=
 *ap)
>                 ap->pflags |=3D ATA_PFLAG_EXTERNAL;
>  }
>
> -static void ahci_update_initial_lpm_policy(struct ata_port *ap,
> -                                          struct ahci_host_priv *hpriv)
> +static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>  {
> +       struct ahci_host_priv *hpriv =3D ap->host->private_data;
>         int policy =3D CONFIG_SATA_MOBILE_LPM_POLICY;
>
>
> @@ -1949,7 +1949,7 @@ static int ahci_init_one(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>
>                 ahci_mark_external_port(ap);
>
> -               ahci_update_initial_lpm_policy(ap, hpriv);
> +               ahci_update_initial_lpm_policy(ap);
>
>                 /* disabled/not-implemented port */
>                 if (!(hpriv->port_map & (1 << i)))
> --
> 2.43.0
>

Acked-by: Jian-Hong Pan <jhp@endlessos.org>
