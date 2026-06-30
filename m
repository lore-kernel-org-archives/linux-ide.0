Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1509287263
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786202; cv=pass; b=ekE0mesTLMV0CPdDiVOX5lJuq6eJu5XICBVR9G1WfYNEiSf6bJBUWVaymE3RzSRd9akob3TaAZZOyuioAqepO5WNR6aPg6ho4Ntmw9oDcoju1/SY+SwApjv9dEYNcavEdxibCQoqVKT4FB9dUOIZRAgIESWw8D2qf8HAqC1wsn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786202; c=relaxed/simple;
	bh=b5JjAuKGhirnUZ/oyddIaoLcJBQe7FrCtPBjpicD328=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mygo9NQVwILquVXcX7wpSB48dlQmHE8ZTD49RSl+0nGDg4nI30Oyuj+9tYdAyxrCoN+zrKtxonE3ycn6eyspWXTMN1ahlWsQRiRh+qqgces9rYwNQO9520zIK536Ob6sMLwF+kCneXxOjDzsx2jpaSuBBp+4Cys8AE3dxZcQgNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ4h0ZZS; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ4h0ZZS"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so1653526e87.1
        for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2026 19:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782786199; cv=none;
        d=google.com; s=arc-20260327;
        b=k38LfY39y/V4XpJbC29qiXVjzQDGQaJ8atKs6GxAka+GRtJeTw5AYbOexUAdhSBL/Z
         /+WOT4MD3wtIQMVILRNdPymqgl8IwDtbJU2q7eyssPPelndixpN/N0HdG4TOtPCoyq2Y
         wOZ1Dt6q0XUBoMKz20SelGcw8NWZKjAsZ/jhEhbFXbckS8fVc841j3mYeszreDLwldFj
         JSyxKgTf04ER9zBFJDuNxEsTRbdz4M4EHAlBvbgJvfGXfRvyzKF2SP8IN9QUVVSwqKdF
         m003/+tLzKRQzu5yytivxc51zFEQ8X8yxJ05VgflQlhp24Ahu+fgXmspiAjLmbeL8ic/
         8y+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PwQIaMcpLgNgtPYnD1pIfMPZ1ES8RtTtPpYvVHZp5eU=;
        fh=sqCMmzVDuLQHU8hnIfLCdW5jmoNMOa0M22nEWpBX4lw=;
        b=sIvjRftd7DgJl8AirZxaKZ4WOBhoD8kjOZiLCkt+jw53XGtrKkEUAF2MTko8RtI4N+
         g5krXCdDAK8CIpiwhNuLBb/8/aexbOPqDd94Xjdx50JDlpJxVUmgNUW29Z/nJiGOAU2k
         MaH9QaWs2Bh5poVbW4C9N0p/ZQz9uN/Aa56QVlkb6Zwc+NxGJI0aLuiR5ENqO/Vn1x3w
         Xk+r3BoEX1rXWybEZQBAY8m+H7MP5FOco/RlqK4pB7LDl43YMiFy2Mp+KPxJGKwyPYuT
         e9t1f6Z8z2SMhC2s3Jn5rujbBeazSrE+Ph5AlbNwym96U56y53kwkUwI9f0Fp0cN0Hhr
         sZDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782786199; x=1783390999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwQIaMcpLgNgtPYnD1pIfMPZ1ES8RtTtPpYvVHZp5eU=;
        b=BJ4h0ZZSovqMQYJIPqDeOtQjOnmJO0/phP56DyJSBDf569KENTAumzvWOw2ayWYXtR
         hxNna5kR/dGiyCXlTxYzerRmrbMBdJIOYgZuDcWN5WRG/Bqiv/Kspl8ocvKGCoL+gal7
         3sMgF5WyXYYc1pY+mUV2wsIG3bejZzrSzqGzd/EaxGBbS+Jh3DQNMQv1MCEghkJBbEQ3
         /BWxbDSanZU12S/VhXMgwbT4faRInWt431M6EHfay+bnWTgk/uWY7NcbKD6scZv182gG
         dBT4GQjwDOYzsitTlsEkFffXca54/8PDfIi9gXO4xhGdK7bUiSIFCFO5W8WKYpx1wT8m
         7HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782786199; x=1783390999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PwQIaMcpLgNgtPYnD1pIfMPZ1ES8RtTtPpYvVHZp5eU=;
        b=TKKMBy9IEoxCTxHrDLoncalCXgbUhorxj6dh3JJRJkRE/ZxeoTndpbiLZ9/YZrHB8T
         kVV4/yE21cXNPU3jDkLuyV02bb4ejWEnJRz7nShSWNHKNpnN/sAFsa/EKzTi4YyLozY5
         uv8Yc1XGg2fjPYT+kU2CnWaN2jErt+DkWO/LIG1J+yhmPCuEkZivfqGZ+wcOgheKdznH
         kznoK7CDzt22rXQenUxgSPrs8Dyzc9XYR/cbmnuawXdrAtkI2sX3x8Sf0NGaqDbnxlUh
         olIs88LK6Gy5jjEk4C7wrh8YSQmiNdbjynM2WG2w5cWdBh+rIRZngFN32D33pbUWkk0D
         58ow==
X-Gm-Message-State: AOJu0YwLioQAjiqOErpabNNmdFlm+gXHVyk/dPRNOBSwiOgoz+mxXCSM
	5zJyRgH8AFSCYLy5Y4xYsL7nlbu1kGCcqe0BEmJjaD0wXHzJCxGyGA2ITxW5XeuItfj7veq29xl
	LQ7h6zK0S95sAdLXnRtAXegeu0c+HW2szCqgk
X-Gm-Gg: AfdE7cmzvxvrTNd3RlWaHQ97CJe0x0JYK5R3wi75j2+aqBWYs/ou1rPFtzY+MLnOl0L
	KbIa0mznoCgx/Qg1DSGD7haHA1FYiDxT9UQnCM8ALidpXYXuurYso3CatpopjJHDV0sYzo4g1/3
	xVw3xfd2bi+8sCDTNZk2YO5wzAvfXOSNG8vXDCLA5bfpVqTp2ILpJWc5mizvG5tmZMiy+iAmJZv
	5rO2tgsMaobs2ZR1GH8sd/noNAqaPYVfD9f9cu6KoLcLlLbkxmlEpbMnRPfk8CKUH+5sVCohNyr
	hPe02uZ3yUqaGmuWPY7sL5vmj5//kg+FNi3yHjEawT1RLN19cYsk1wWqgn2TN+fHDNnlwLwNDOt
	715aj1jhFkdWXxijrVY+DL+fbr6A=
X-Received: by 2002:a05:6512:1548:b0:5ae:b86b:71ed with SMTP id
 2adb3069b0e04-5aebdb610e8mr275795e87.13.1782786198830; Mon, 29 Jun 2026
 19:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630001731.1174739-1-rosenp@gmail.com> <5b03d0b4-1961-498f-a720-f764b14fc1e9@kernel.org>
In-Reply-To: <5b03d0b4-1961-498f-a720-f764b14fc1e9@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 29 Jun 2026 19:23:06 -0700
X-Gm-Features: AVVi8CdTZMdj26coDppvmcu-SSaBjBNmrDJdzvGvnwBZhpyu9uBrRJMvstG4J54
Message-ID: <CAKxU2N8buRUxmatjjwf8q=JShOa6+r5004+Sy5kesQBfMZk3Ag@mail.gmail.com>
Subject: Re: [PATCH] ata: sata_dwc_460ex: use devm for old DMA resource
 lifetime management
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 7:06=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 6/30/26 09:17, Rosen Penev wrote:
> > Convert sata_dwc_dma_exit_old() to a devm action callback and register
> > it via devm_add_action_or_reset() after dw_dma_probe() succeeds.  This
> > lets the devm framework handle DMA controller teardown automatically on
> > probe failure and driver removal.
> >
> > As a result the probe function can use plain return-on-error for all
> > failure paths =E2=80=94 the dma_initialized flag, the goto labels, and =
the
> > explicit sata_dwc_dma_exit_old() call in sata_dwc_remove() are all
> > eliminated.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/ata/sata_dwc_460ex.c | 35 ++++++++++++++++-------------------
> >  1 file changed, 16 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.=
c
> > index 35aa7f9acdf7..a1e319deb0b4 100644
> > --- a/drivers/ata/sata_dwc_460ex.c
> > +++ b/drivers/ata/sata_dwc_460ex.c
> > @@ -221,10 +221,18 @@ static int sata_dwc_dma_get_channel_old(struct sa=
ta_dwc_device_port *hsdevp)
> >       return 0;
> >  }
> >
> > +static void sata_dwc_dma_exit_old(void *data)
> > +{
> > +     struct sata_dwc_device *hsdev =3D data;
> > +
> > +     dw_dma_remove(hsdev->dma);
> > +}
> > +
> >  static int sata_dwc_dma_init_old(struct platform_device *pdev,
> >                                struct sata_dwc_device *hsdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> > +     int err;
> >
> >       hsdev->dma =3D devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL)=
;
> >       if (!hsdev->dma)
> > @@ -244,15 +252,11 @@ static int sata_dwc_dma_init_old(struct platform_=
device *pdev,
> >               return PTR_ERR(hsdev->dma->regs);
> >
> >       /* Initialize AHB DMAC */
> > -     return dw_dma_probe(hsdev->dma);
> > -}
> > -
> > -static void sata_dwc_dma_exit_old(struct sata_dwc_device *hsdev)
> > -{
> > -     if (!hsdev->dma)
> > -             return;
> > +     err =3D dw_dma_probe(hsdev->dma);
> > +     if (err)
> > +             return err;
> >
> > -     dw_dma_remove(hsdev->dma);
> > +     return devm_add_action_or_reset(dev, sata_dwc_dma_exit_old, hsdev=
);
> >  }
> >
> >  #endif
> > @@ -1187,7 +1191,7 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
> >
> >       err =3D phy_init(hsdev->phy);
> >       if (err)
> > -             goto error_out;
> > +             return err;
> >
> >       /*
> >        * Now, register with libATA core, this will also initiate the
> > @@ -1195,12 +1199,10 @@ static int sata_dwc_probe(struct platform_devic=
e *ofdev)
> >        * error_handler() to execute a dummy Softreset EH session
> >        */
> >       err =3D ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_s=
ht);
> > -     if (err)
> > -             dev_err(dev, "failed to activate host");
> > +     if (!err)
> > +             return err;
>
> What about the generic error check pattern:
>
>         err =3D ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_s=
ht);
>         if (err) {
>                 dev_err(dev, "failed to activate host");
>                 phy_exit(hsdev->phy);
>                 return err;
>         }
>
>         return 0;
>
> Which I find personally much nicer to read.
OK. Will do for v2.

I did it this way to reduce indentation.
>
> >
> > -     return 0;
> > -
> > -error_out:
> > +     dev_err(dev, "failed to activate host");
> >       phy_exit(hsdev->phy);
> >       return err;
> >  }
> > @@ -1215,11 +1217,6 @@ static void sata_dwc_remove(struct platform_devi=
ce *ofdev)
> >
> >       phy_exit(hsdev->phy);
> >
> > -#ifdef CONFIG_SATA_DWC_OLD_DMA
> > -     /* Free SATA DMA resources */
> > -     sata_dwc_dma_exit_old(hsdev);
> > -#endif
> > -
> >       dev_dbg(dev, "done\n");
> >  }
> >
>
>
> --
> Damien Le Moal
> Western Digital Research
