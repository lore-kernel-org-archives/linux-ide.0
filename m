Return-Path: <SRS0=8YDW=YK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC946FA372A
	for <linux-ide@archiver.kernel.org>; Thu, 17 Oct 2019 12:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B39F2089C
	for <linux-ide@archiver.kernel.org>; Thu, 17 Oct 2019 12:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bm6/1QRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfJQMHx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:07:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47031 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731634AbfJQMHw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Oct 2019 08:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571314071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1oegUJVPFLn61YHVnzPGrrTp3OBn8TBZrzcUlwJqAc=;
        b=Bm6/1QRoFhALDCC8p34d01wQa12UGQRJ2u00ulcEAQ1Wf/M1CaWS9VJLnfXk2rokgDXfqR
        3MrzCVHM5ZujJFjiWerPmY0c+CGEp/zt57XKObIJuDr6+pZtr6QnejDI2eJSL+T0qbyf8r
        vWYFEVr/LI/WNAYwJ7WTUnJuBQie5lI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-6sMvtCHcOyS-NIRcV9zQHQ-1; Thu, 17 Oct 2019 08:07:50 -0400
Received: by mail-wm1-f70.google.com with SMTP id r21so954383wme.5
        for <linux-ide@vger.kernel.org>; Thu, 17 Oct 2019 05:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=adj8hIWDAVnqUbx2V0M1ph+t4YIHAy6uSYG0vaD6M18=;
        b=TY32iAcmbYnhSWl9j+zBHiwkYGWNASvw5xsZSTYXVKQrvxdQogKhUQKrmWsaDrNOmw
         KPlEcK6JfXX4aIGFsEJSKwxV+8h7BpCN+vXFTuyTz+KWgaIDckL6wuWDrGpv5iBq8dXC
         d1FfoGwzGEl75QoJpe4bXy1cuSTYkhEXckgzMtvCrU4M5h5T5Mn1DctzMbeZRObkxLcV
         iQoluZdOhrL4uxnIFDvb+ULaKZfLVjRk9kSsJ5wDHwwrtLjCn9GFhCliXrdNiGNgAuR5
         9MoqlVpNQiCPiqCEdrpNQykXDvKnd+EPf5RiMbVnxrSlFhiZeHBpXg/CrRjIbu4b6JRa
         QrZg==
X-Gm-Message-State: APjAAAVQR2tA+dUS2sdB727Zp54kscVps7SENAsGiZ0qUUlnAwDdbM/K
        0PcTBOQgIKfK1W4o18oK7z1xbYlH2GSCK/GbD9eQoEgEt8z2JZ669cbxg+2HWkMR7V1XDs9H5al
        mZw6YQzRWTP6RQ3+w+aTD
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr2618307wma.27.1571314068239;
        Thu, 17 Oct 2019 05:07:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmXLcRi0MKU6vHDlb1B+cqH4yMb2ZY4MeeVrjhHC1xlZfM/SCk9octNlVMWebgMewRZ9DSPQ==
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr2618283wma.27.1571314067991;
        Thu, 17 Oct 2019 05:07:47 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id t8sm1997148wrx.76.2019.10.17.05.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 05:07:47 -0700 (PDT)
Subject: Re: [PATCH] ata: libahci_platform: Fix regulator_get_optional()
 misuse
To:     Mark Brown <broonie@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org
References: <20191016105105.7791-1-broonie@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2ad4693f-d99e-4ca3-67f4-28cc38ec85cf@redhat.com>
Date:   Thu, 17 Oct 2019 14:07:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016105105.7791-1-broonie@kernel.org>
Content-Language: en-US
X-MC-Unique: 6sMvtCHcOyS-NIRcV9zQHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 16-10-2019 12:51, Mark Brown wrote:
> This driver is using regulator_get_optional() to handle all the supplies
> that it handles, and only ever enables and disables all supplies en masse
> without ever doing any other configuration of the device to handle missin=
g
> power. These are clear signs that the API is being misused - it should on=
ly
> be used for supplies that may be physically absent from the system and in
> these cases the hardware usually needs different configuration if the
> supply is missing. Instead use normal regualtor_get(), if the supply is
> not described in DT then the framework will substitute a dummy regulator =
in
> so no special handling is needed by the consumer driver.
>=20
> In the case of the PHY regulator the handling in the driver is a hack to
> deal with integrated PHYs; the supplies are only optional in the sense
> that that there's some confusion in the code about where they're bound to=
.
>  From a code point of view they function exactly as normal supplies so ca=
n
> be treated as such. It'd probably be better to model this by instantiatin=
g
> a PHY object for integrated PHYs.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/ata/libahci_platform.c | 38 +++++++++++++---------------------
>   1 file changed, 14 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platfor=
m.c
> index e742780950de..8befce036af8 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -153,17 +153,13 @@ int ahci_platform_enable_regulators(struct ahci_hos=
t_priv *hpriv)
>   {
>   =09int rc, i;
>  =20
> -=09if (hpriv->ahci_regulator) {
> -=09=09rc =3D regulator_enable(hpriv->ahci_regulator);
> -=09=09if (rc)
> -=09=09=09return rc;
> -=09}
> +=09rc =3D regulator_enable(hpriv->ahci_regulator);
> +=09if (rc)
> +=09=09return rc;
>  =20
> -=09if (hpriv->phy_regulator) {
> -=09=09rc =3D regulator_enable(hpriv->phy_regulator);
> -=09=09if (rc)
> -=09=09=09goto disable_ahci_pwrs;
> -=09}
> +=09rc =3D regulator_enable(hpriv->phy_regulator);
> +=09if (rc)
> +=09=09goto disable_ahci_pwrs;
>  =20
>   =09for (i =3D 0; i < hpriv->nports; i++) {
>   =09=09if (!hpriv->target_pwrs[i])
> @@ -181,11 +177,9 @@ int ahci_platform_enable_regulators(struct ahci_host=
_priv *hpriv)
>   =09=09if (hpriv->target_pwrs[i])
>   =09=09=09regulator_disable(hpriv->target_pwrs[i]);
>  =20
> -=09if (hpriv->phy_regulator)
> -=09=09regulator_disable(hpriv->phy_regulator);
> +=09regulator_disable(hpriv->phy_regulator);
>   disable_ahci_pwrs:
> -=09if (hpriv->ahci_regulator)
> -=09=09regulator_disable(hpriv->ahci_regulator);
> +=09regulator_disable(hpriv->ahci_regulator);
>   =09return rc;
>   }
>   EXPORT_SYMBOL_GPL(ahci_platform_enable_regulators);
> @@ -207,10 +201,8 @@ void ahci_platform_disable_regulators(struct ahci_ho=
st_priv *hpriv)
>   =09=09regulator_disable(hpriv->target_pwrs[i]);
>   =09}
>  =20
> -=09if (hpriv->ahci_regulator)
> -=09=09regulator_disable(hpriv->ahci_regulator);
> -=09if (hpriv->phy_regulator)
> -=09=09regulator_disable(hpriv->phy_regulator);
> +=09regulator_disable(hpriv->ahci_regulator);
> +=09regulator_disable(hpriv->phy_regulator);
>   }
>   EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
>   /**
> @@ -359,7 +351,7 @@ static int ahci_platform_get_regulator(struct ahci_ho=
st_priv *hpriv, u32 port,
>   =09struct regulator *target_pwr;
>   =09int rc =3D 0;
>  =20
> -=09target_pwr =3D regulator_get_optional(dev, "target");
> +=09target_pwr =3D regulator_get(dev, "target");
>  =20
>   =09if (!IS_ERR(target_pwr))
>   =09=09hpriv->target_pwrs[port] =3D target_pwr;
> @@ -436,16 +428,14 @@ struct ahci_host_priv *ahci_platform_get_resources(=
struct platform_device *pdev,
>   =09=09hpriv->clks[i] =3D clk;
>   =09}
>  =20
> -=09hpriv->ahci_regulator =3D devm_regulator_get_optional(dev, "ahci");
> +=09hpriv->ahci_regulator =3D devm_regulator_get(dev, "ahci");
>   =09if (IS_ERR(hpriv->ahci_regulator)) {
>   =09=09rc =3D PTR_ERR(hpriv->ahci_regulator);
> -=09=09if (rc =3D=3D -EPROBE_DEFER)
> +=09=09if (rc !=3D 0)
>   =09=09=09goto err_out;
> -=09=09rc =3D 0;
> -=09=09hpriv->ahci_regulator =3D NULL;
>   =09}
>  =20
> -=09hpriv->phy_regulator =3D devm_regulator_get_optional(dev, "phy");
> +=09hpriv->phy_regulator =3D devm_regulator_get(dev, "phy");
>   =09if (IS_ERR(hpriv->phy_regulator)) {
>   =09=09rc =3D PTR_ERR(hpriv->phy_regulator);
>   =09=09if (rc =3D=3D -EPROBE_DEFER)
>=20

