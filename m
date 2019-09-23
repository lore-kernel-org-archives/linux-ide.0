Return-Path: <SRS0=3gMc=XS=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E12CC4740C
	for <linux-ide@archiver.kernel.org>; Mon, 23 Sep 2019 09:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8DE21907
	for <linux-ide@archiver.kernel.org>; Mon, 23 Sep 2019 09:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A535mhzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfIWJHq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:07:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29204 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726020AbfIWJHn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Sep 2019 05:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569229661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8T8RjJYcGGqEc0WFaCwZbXoPKLFlizfkrKrigbsteU=;
        b=A535mhzS3PlFDWKRvfzViQAeeoRcUXJ7n9ERbVNRp/m9N7IvJDcZwVLcMwS1RDuE6YIs9P
        NiHZ6raC5AmQcTY8b+MBDpP2sJiTOvsd2JcPo9bSlO4kiH1LvZ8dkCMVKFUyIB67kIarCd
        4qzghlZ6/ROt3jCY1xkgW+2RKhwa+bQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-st70-Cg5Plyd_jkwIqDYMw-1; Mon, 23 Sep 2019 05:07:40 -0400
Received: by mail-ed1-f72.google.com with SMTP id y25so9065837edv.20
        for <linux-ide@vger.kernel.org>; Mon, 23 Sep 2019 02:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z5+JUdEcNbNbYnUHKbmarfCuTHHHOe0SmXNsWUScQrU=;
        b=bie6IJ6vkKiRofKAXtYV4lyNqall7TUW+2Y4z55fhSU4dhGV/ZoOQICVEbQGrk/2N0
         CTP2K9725Iwg9B/IfWnbI39P8etHIpVSwNaW8Gks+BkvU8sq00qiRH94t78jpoZrFuX+
         mf98RrE2hCM2IybAV13g2oBDSTvgxVFLxK2WabPnJmcaT4fvI97egWUL3oShYACqssCl
         DyljVqHFGW33ih+iHSzufKtZkctanmKcPe8hQrgNDnESFeX90iPwvPmTv2uQrf+EDSxI
         Njxcbq1We0FAB3X/OLMMEvmdPf7Y/NGtFy7MJdFAlJCbbuIkll5NAWpetwgMgZjRedZm
         f3eg==
X-Gm-Message-State: APjAAAVsSCUvLVZYXQ8jhNbILn1IhNC8va4qySBP6ZZVRDWTFzyjkMrz
        JliWswN/TuI/sBq64/YitrKOEyx7AZfDOldquoi9tmEdmBxNSjljAzxYbbqQJ43nRXkEzFZYELI
        pS4ClpmbqW9hLckIwnoBA
X-Received: by 2002:a50:fc0c:: with SMTP id i12mr34693067edr.82.1569229659513;
        Mon, 23 Sep 2019 02:07:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCzq+l6MJPGlCUee90zOAQDFcFCUx0OtBxlJM4Nzjg7r/Nu6TdCyo4uiEsmUp7Cb5ztI+lUw==
X-Received: by 2002:a50:fc0c:: with SMTP id i12mr34693051edr.82.1569229659394;
        Mon, 23 Sep 2019 02:07:39 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s16sm2244451edd.39.2019.09.23.02.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:07:38 -0700 (PDT)
Subject: Re: [PATCH] ata: libahci_platform: Use common error handling code in
 ahci_platform_get_resources()
To:     Markus Elfring <Markus.Elfring@web.de>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <6ca97aeb-0892-ed0e-a149-b25848adf324@web.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7463a1d5-e76f-99a6-5a1e-f9477da3c1da@redhat.com>
Date:   Mon, 23 Sep 2019 11:07:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <6ca97aeb-0892-ed0e-a149-b25848adf324@web.de>
Content-Language: en-US
X-MC-Unique: st70-Cg5Plyd_jkwIqDYMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 22-09-2019 15:55, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 15:42:46 +0200
>=20
> Convert the call of the function =E2=80=9Cof_node_put=E2=80=9D to another=
 jump target
> so that it can be better reused at three places in this function.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/ata/libahci_platform.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platfor=
m.c
> index e742780950de..7b2e364f3bd5 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -497,8 +497,7 @@ struct ahci_host_priv *ahci_platform_get_resources(st=
ruct platform_device *pdev,
>=20
>   =09=09=09if (of_property_read_u32(child, "reg", &port)) {
>   =09=09=09=09rc =3D -EINVAL;
> -=09=09=09=09of_node_put(child);
> -=09=09=09=09goto err_out;
> +=09=09=09=09goto err_put_node;
>   =09=09=09}
>=20
>   =09=09=09if (port >=3D hpriv->nports) {
> @@ -515,18 +514,14 @@ struct ahci_host_priv *ahci_platform_get_resources(=
struct platform_device *pdev,
>   =09=09=09if (port_dev) {
>   =09=09=09=09rc =3D ahci_platform_get_regulator(hpriv, port,
>   =09=09=09=09=09=09=09=09&port_dev->dev);
> -=09=09=09=09if (rc =3D=3D -EPROBE_DEFER) {
> -=09=09=09=09=09of_node_put(child);
> -=09=09=09=09=09goto err_out;
> -=09=09=09=09}
> +=09=09=09=09if (rc =3D=3D -EPROBE_DEFER)
> +=09=09=09=09=09goto err_put_node;
>   =09=09=09}
>   #endif
>=20
>   =09=09=09rc =3D ahci_platform_get_phy(hpriv, port, dev, child);
> -=09=09=09if (rc) {
> -=09=09=09=09of_node_put(child);
> -=09=09=09=09goto err_out;
> -=09=09=09}
> +=09=09=09if (rc)
> +=09=09=09=09goto err_put_node;
>=20
>   =09=09=09enabled_ports++;
>   =09=09}
> @@ -558,6 +553,8 @@ struct ahci_host_priv *ahci_platform_get_resources(st=
ruct platform_device *pdev,
>   =09devres_remove_group(dev, NULL);
>   =09return hpriv;
>=20
> +err_put_node:
> +=09of_node_put(child);
>   err_out:
>   =09devres_release_group(dev, NULL);
>   =09return ERR_PTR(rc);
> --
> 2.23.0
>=20

