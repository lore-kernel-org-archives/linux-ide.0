Return-Path: <SRS0=B3X7=C2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA757C433E2
	for <linux-ide@archiver.kernel.org>; Thu, 17 Sep 2020 18:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6529620707
	for <linux-ide@archiver.kernel.org>; Thu, 17 Sep 2020 18:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rw4H1am0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgIQSET (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgIQSCv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Sep 2020 14:02:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164F2C061756
        for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2020 11:02:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so2814928wmh.4
        for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2020 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMjGHIdZoN2oxghKfwIVedc2rc75vIEU71EGKBKi4Vw=;
        b=Rw4H1am04yaRpFiTHOynRZlFoGtQnCuPQuwrQzRGIF6J323Ni+X4epQdP8RPddNlW6
         rBkbIxfyjT2Fnqv+qsog+PE6vumYuQcGK9GAQ68o31h76ft64UNz+J6Egx34Uou0gL5Z
         wk6fLnKW65+lJ4i527oHJy4TGXWyNKPwKnRQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMjGHIdZoN2oxghKfwIVedc2rc75vIEU71EGKBKi4Vw=;
        b=typMErBkH4fWCTZU85OZdJmurWeM0A/AEu/31dLPwGX5wzUyaXFdhIswkqlL5lLSbb
         ZGpLxlfx067Glz0/xaRRjszuFI1HaG34rwPJcsAmOKn4BmHczvutz5T+r4uks/r6kQWk
         Za2V9IA6YIXxeo/+HhP5j/qkursSVECozf7ezCURdr2JrwG28IJ5JfNHcfOsPMwcOhMQ
         Uf/JD5uU2XaX0oSVOUrdpIBUhS/PTVsWd+TJDbrAzuRACneXuf2o7nA63dXXypwAs1tW
         p6qRsKH3prv5uZXYab8IiXzKMwmNEmqT6zDnNQ1J6v9jyzYkD1fKEBxX5MVpinlcABNe
         AXLQ==
X-Gm-Message-State: AOAM532mDtanH6aORiepInjGEPA9rM4NyPSo+Fp4XyLYAEDqoVFfozyX
        KOaVVatCrUCwMSznvySSoMwSO3ajWZgTLG5FeR1EWQ==
X-Google-Smtp-Source: ABdhPJwK3mtEBCJ+znIVX4TRVKA++GpeRR4CpX/gV4dLL6lJ47pX6bzp/5So/xiQBELnrZ9ehGsMeKaPsbyIityIEg0=
X-Received: by 2002:a1c:408a:: with SMTP id n132mr10890855wma.45.1600365768299;
 Thu, 17 Sep 2020 11:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200824204002.45500-1-james.quinlan@broadcom.com> <32b000b801202c3d6318da6c5bc52d47ab6947e0.camel@pengutronix.de>
In-Reply-To: <32b000b801202c3d6318da6c5bc52d47ab6947e0.camel@pengutronix.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 17 Sep 2020 14:02:36 -0400
Message-ID: <CA+-6iNwSS0U7zga2WEoWw48bHtOzWzSppKPGV8KEthnNnasH-w@mail.gmail.com>
Subject: Re: [PATCH v1] ata: ahci_brcm: Fix use of BCM7216 reset controller
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jens Axboe <axboe@kernel.dk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Aug 25, 2020 at 4:16 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Mon, 2020-08-24 at 16:40 -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > A reset controller "rescal" is shared between the AHCI driver and the PCIe
> > driver for the BrcmSTB 7216 chip.  Use
> > devm_reset_control_get_optional_shared() to handle this sharing.
> >
> > Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
> > Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  drivers/ata/ahci_brcm.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> > index 6853dbb4131d..d6115bc04b09 100644
> > --- a/drivers/ata/ahci_brcm.c
> > +++ b/drivers/ata/ahci_brcm.c
> > @@ -428,7 +428,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
> >  {
> >       const struct of_device_id *of_id;
> >       struct device *dev = &pdev->dev;
> > -     const char *reset_name = NULL;
> >       struct brcm_ahci_priv *priv;
> >       struct ahci_host_priv *hpriv;
> >       struct resource *res;
> > @@ -452,11 +451,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
> >
> >       /* Reset is optional depending on platform and named differently */
> >       if (priv->version == BRCM_SATA_BCM7216)
> > -             reset_name = "rescal";
> > +             priv->rcdev = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> >       else
> > -             reset_name = "ahci";
> > +             priv->rcdev = devm_reset_control_get_optional(&pdev->dev, "ahci");
>
> I think it would be cleaner to use two separate reset control handles
> here. It is hard to reason about what the code does when the reset
> control is shared on one platform and exclusive on the other.
>
> > -     priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
> >       if (IS_ERR(priv->rcdev))
> >               return PTR_ERR(priv->rcdev);
> >
> > @@ -479,10 +477,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
> >               break;
> >       }
> >
> > -     if (priv->version == BRCM_SATA_BCM7216)
> > -             ret = reset_control_reset(priv->rcdev);
>
> I think we might have a similar issue currently with
> "usb: dwc3: meson-g12a: fix shared reset control use", where two IP
> cores try to share a pulsed reset line.
>
> > -     else
> > -             ret = reset_control_deassert(priv->rcdev);
> > +     ret = reset_control_deassert(priv->rcdev);
>
> Isn't the shared 'rescal' reset a triggered reset pulse? Looking at the
> reset-brcmstb-rescal reset controller driver, without reset line level
> control implemented, this will turn into a no-op for BCM7216. Yes, the
> reset line will be deasserted after this call, but there is no guarantee
> that the reset line was ever pulsed.

Hi Philipp,

I believe you have observed that our reset-brcmstb-rescal.c driver
sets only the "reset" op and implements a pulse when called (it's
actually more of a "start the engine" operation).  This suits us fine
except such a driver can only fire its reset once in its lifetime.  We
would actually like a "new lifetime" when we emerge from resume()
after being suspended.  This would probably require a modification to
core.c to set triggered_count to 0 on resume_early time.  My instincts
say this approach would upset some apple carts.

What we could do instead is use the deassert op instead of the reset
op so that the pulse and be activated on probe and every time we
resume().

Are you okay with that?

Thanks,
Jim
>
> regards
> Philipp
