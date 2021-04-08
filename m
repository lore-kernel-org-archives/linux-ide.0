Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BDCC433B4
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1086113C
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 13:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhDHNFy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHNFx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2021 09:05:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B9C061760;
        Thu,  8 Apr 2021 06:05:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v6so1666595ejo.6;
        Thu, 08 Apr 2021 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZmtC6Rmr7madlGC7eFgIOwR9CPFzJsFk7LRy9mqEPo=;
        b=AfBnmCh6WrhyMdLuhcMN+Ue+1u09BK+hyny0dqjsmyZ0wQze0EMP+mex3hznJBGwnD
         Q8NXF7NvFDXS05atzZstPnwi5OA9UumubIS5LFgDCB90y2I9Xr23xleN2B+8hiRAmFXl
         p2nO6TGb+8MQrd9M3jBFhpIwxTiXZTXqlY2q0RyO3JOm6tI0NIx806JsGzR3f5UDwkDT
         kOPgT6cOA2OInBrlzFhaWIrQ9LuC2APc+MuzeyTPzWv1eRhzd5RiWmdBzjWWDfY9y24+
         VnaD+Kgr5gWmK5Nlf8vi+8/c+6H6CSOP+9qG7TQ4OtljYw2wUW3u4rD9s8GHMX8TL4l0
         S4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZmtC6Rmr7madlGC7eFgIOwR9CPFzJsFk7LRy9mqEPo=;
        b=JS0T3lg9IE4M49ry+y6HLW0sknHDhnbprCx/8dzySfEwxec15TMhiZh9Oam4PodQQg
         3E3ow3XsLL9dkhVQtCbnOVMaPV0axSTqAgpYYggcQ7ek8e/6X43K+hgYl9SxDdPFLZRV
         myQwDbSS+Wcj+IzVuLTmoFxIURNeCz0CgEyyNCNjC2OcYEYr6URCmyQRyZv2rxmutQl8
         SrRw5XKl2vfi7yqAZEkO1iWs0vHVxQaqabIdELJbdigsEZytOGPFFDxNWHchQLfaCbsE
         QJCFdNWmsJI3DcvZdqMhB5QoGKzbGsjNFSy9tbqa6kkLV9DWCdq5f3mfBV0THQJC+Rky
         839w==
X-Gm-Message-State: AOAM533YI2rVTlzbAHcPD+IPB0KQ4/KF8aIroiKP4gloBjkvZzYJ33rw
        NeHNapU48UrplSJ0/rp74GvHRmictO8=
X-Google-Smtp-Source: ABdhPJw9dCJJ6hkJC05NvNrFvPddtvcMj/iiwniR/S7Ju9XwBtcQ5KWxBIM3e+dCMogyojBUzDcW+w==
X-Received: by 2002:a17:906:2307:: with SMTP id l7mr10450940eja.27.1617887140042;
        Thu, 08 Apr 2021 06:05:40 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id w6sm14019831eje.107.2021.04.08.06.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:05:37 -0700 (PDT)
Date:   Thu, 8 Apr 2021 15:06:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, axboe@kernel.dk,
        jonathanh@nvidia.com, robh+dt@kernel.org, pchandru@nvidia.com,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ata: ahci_tegra: Add AHCI support for Tegra186
Message-ID: <YG7/xPVoA4gPrMBf@orome.fritz.box>
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
 <1617758731-12380-4-git-send-email-skomatineni@nvidia.com>
 <594c622e-4505-3448-1c7b-eae8f36cbad8@gmail.com>
 <49eba27e-18fa-b682-1385-2930dfff28ac@nvidia.com>
 <01fd01ab-f4e7-57ee-2ad7-2aabaeb92a0e@nvidia.com>
 <2ef2a124-9e4b-bc02-3830-8ef077638ced@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dUTOrUhVWpEd1PiU"
Content-Disposition: inline
In-Reply-To: <2ef2a124-9e4b-bc02-3830-8ef077638ced@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--dUTOrUhVWpEd1PiU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 02:25:19AM +0300, Dmitry Osipenko wrote:
> 08.04.2021 02:00, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >=20
> > On 4/7/21 3:57 PM, Sowjanya Komatineni wrote:
> >>
> >> On 4/7/21 2:36 PM, Dmitry Osipenko wrote:
> >>> 07.04.2021 04:25, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>> +=C2=A0=C2=A0=C2=A0 if (!tegra->pdev->dev.pm_domain) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D tegra_powergate_=
sequence_power_up(TEGRA_POWERGATE_SATA,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tegra->sata_clk,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tegra->sata_rst);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
goto disable_regulators;
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>> Hi,
> >>>
> >>> Why you haven't added condition for tegra_powergate_power_off()? I th=
ink
> >>> it should break GENPD and legacy PD API isn't not supported by T186
> >>> at all.
> >>>
> >>> I'm also not sure whether the power up/down sequence is correct using
> >>> GENPD.
> >>>
> >>> Moreover the driver doesn't support runtime PM, so GENPD should be
> >>> always off?
> >>
> >> This driver already using legacy PD API's so thought its supported and
> >> added power domain device check during powergate_sequence_power_up and
> >> yes same should apply for powergate_power_off as well. But if legacy
> >> PD is not supported by T186 then not sure why original driver even
> >> using these API's.
> >>
> >>
> > Sorry just took a look and driver supports T210 and prior tegra as well.
> > T210 and prior supports legacy PD and this check is applicable for
> > those. So we should add power domain device check for power off as well.
>=20
> You could fix it with a follow up patch. Please try to test that
> power-off works properly, at least try to unload the driver module and
> re-load it.

Agreed, this should have the same check as above for
tegra_powergate_power_off(). It currently works fine because on Tegra186
tegra_powergate_power_off() (and all the other legacy APIs for that
matter) will abort early since no power gates are implemented. The AHCI
driver doesn't check for errors, so this will just fail silently. It's
better to be symmetric, though, and add the check in both paths.

> > But for T186, we should have GENPD working once we add runtime PM
> > support to driver.
> >=20
> > Preetham/Thierry, Can you confirm where SATA is un powergated prior to
> > kernel?
> >=20
> >=20
> >> But as RPM is not implemented yet for this driver, GENPD will be OFF
> >> but SATA is not in power-gate by the time kernel starts and
> >> functionally works.
> >>
> >> But with RPM implementation, I guess we can do proper power gate on/of=
f.
> >>
>=20
> I now recalled that GENPD turns ON all domains by default and then turns
> them OFF only when driver entered into the RPM-suspended state. This
> means that AHCI GENPD should be always-ON for T186, which should be okay
> if this doesn't break power sequences.

Yeah, the generic PM domain will just stay enabled after probe and until
remove. This does not impact the power sequences because they have to be
completely implemented in the power domains code anyway. With the legacy
API we used to need more rigorous sequences in the individual drivers,
but with generic PM domains none of that should be necessary, though it
also doesn't hurt, so some of the unnecessary clock enablement code is
kept for simplicity.

To be honest, I'm not sure if it's worth adding runtime PM support for
this driver. If this top-level layer has a way of getting notification
when no device was detected, then it might make some sense to turn off
the power domain and the regulators again, but I'm not sure if that's
the case. tegra_ahci_host_stop() seems like it might be usable for that
so yeah, that might work. We currently do turn off the powergate in that
case, so extending that power optimization to Tegra186 using runtime PM
makes sense.

Thierry

--dUTOrUhVWpEd1PiU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBu/8IACgkQ3SOs138+
s6FRzw/+Ilb7WlyutjGr1ASDrEiyNdCvPf3vGY36hyI1cOMw8eexfUupqxrVVA/w
AMIG58I9Wa2kku7uCr2Kji8JpWMLsggUTuE0RDaDAZmEzpEoKUSo7hVxvu9SQAk+
FR0RXQfBICotlh/0LfA9osXVfStqS6U2W72F5ipqiUSv1xnAy3fMmvUpay5rt6Gq
Izk5b3SHXglsC0kJr0jeE6+AqJmcofI7EJgoAR0EgCJqxvTjyDKXYlpkqaFefERX
1RTdH2+dyvEWN79m9ug4C+qOw/w8VKFVfuaRuX/YoKONl+iVN8uxgcc95Bjlz62x
wTiP+S5pS2fVks0aOsw0dpsYAPbUvLuG9MPmcu4yaXl7nbx1zL41Jk8P0cwPXpfQ
xvERn+FXU4jqOG72Rw7h8Dhb1Ul4P5rBahMQDDozHNuPLRIZePY9E8caL5WBxDif
6nVAiiVway7m+SacUxOtEYi2WBkrPSn/dxKtPUdkQzgSi5KkEJZczVSHNWtYMXRJ
3VxxVz3NYgaIcQfw1kN1HNnZ1gI7kzfV0K/LviUAEotI4Eh7Vz/3d0kbqKvcn+nn
Tt6gPgHd43UXKTKPfbJ4zwLK9v4lF+kS7o26zVn75WHND9YFLRKrPwx4bdPCZwGi
/Xtcy4h0t3iOAaaq2EpxYlZ4yPiHVmVtZBMMNSX/FOKmrJee9hA=
=OKXJ
-----END PGP SIGNATURE-----

--dUTOrUhVWpEd1PiU--
