Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA53C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 20:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0EDF60C4C
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 20:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhJKUq5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:46:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46776 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhJKUq5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 16:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633985096; x=1665521096;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=yGzPNM26iEf055nLw9J5Nh80CZZln93yIJpSUbVsZvo=;
  b=T9FwQ0wsF72zUwcw9aNiLxuSzwWtWWo2+9OWkpRH9BdohObMRluQ6u5d
   RA4SaW2czLF5XJi41zTAoTzaDQBXCOnWNsCbb7UjbPldSr5V1dnOpyoUq
   5/Tc8KK/CTaxbpiYg9Fn9PmX4L9epEeg/gxktUHPMsa99TI3rMQ+QnR+G
   5x+/dxOpEhyJDuBm+7/wTJRldFVEPwuDMoIfy2+PkeSwnqXnt35NftQOC
   GG61jiol6JptET2or4hKtq+JlBPzSfbS9+YywPotoYAys9pzT/9Actxjz
   nfTVkC0ywNf8QBBboeQdlykeN7vAiG7rDSwfE2XXZOz2XsD2gOYHd7GJl
   w==;
X-IronPort-AV: E=Sophos;i="5.85,365,1624291200"; 
   d="scan'208";a="182532760"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 04:44:56 +0800
IronPort-SDR: ee1jnEGjFN9F2X14lFQY0z21nttBCX8OqcjlQb2w4P/q9m8cgZDBkViBmVUVl175JUo6stmPP7
 QjDGBDpSd1BEOsHuO/7R6G01OLgsW7XmyqSb4xC8wtYlNY9Vt6fh7Q2hM++uZwFsfVNzCkB5Ry
 rWl1yStjPrhkxrKWWNl6x+mBNCoaBwPWEUuJfUEHIMtqJUmfMfMSMMG3dzgN8s1sBlK/lt6Ecy
 Ra7O/osuHh+KFopea9z+J5d/XbXOGZM8Vuq+/A7u4xU+qQt3zVD8cuLqSk6Ix1TlNS5H3Gz4FZ
 Y30HZ0V6r46FHqJ9HgcTiJur
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 13:20:44 -0700
IronPort-SDR: 0ZNwBVyXRaci1KOtrMJH7GUCtySm12ssOX0g2T+MDp6Zu3qgvsepwM8chgLyuQyHRPQ2LHMkDB
 ziAiP/fqormWQUW5tBoSnHeie6QO2wvcmalgdn3VsN8XZxyQuGBSZr7cY92Oq/Ipp8sRoQL/3e
 0AGKeVyJsxAjmKPVIoalzlpu7QzimcG1FdSRSSCntRa2qOKXmvMUbHQZ5cF8Ho4WnN8ztQ8kVd
 k9HE+NCzp592ZjXKylESZGNfkXaRcpVoHlL4DJson3Nfjf69cpINL/XEiAl/ESOTP1z7fBlNQX
 wDs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 13:44:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HSrQJ34Xmz1RvlJ
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 13:44:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1633985096; x=1636577097; bh=yGzPNM26iEf055nLw9J5Nh80CZZln93yIJp
        SUbVsZvo=; b=JXWMcxO4Xb8VF43M4GwmHQnKjNvqsICI2gvHOCrcrC3CXoGYceV
        t6+lNsxy2y9lrlYyqh59MOrIvFtR8I7liSn2CxgMJsJgWnrnPttzjVe5NolJt98D
        0fqmI/Dw5kBLDHls6ONcQNNZVXVoGuCG1b4hU5ytCaKCySdrbJh2wzjSOUUaUG2U
        n37zpbar+3IilLIpPWRf0l4RXnmhDA8/ml6s9VjgUt7J4QLnPql6c9Bszc4yZYik
        cQZjFOgzo5WT3r5d5139lWu9DlY45CFrxtAnnFCijxkPw8OvOOQv8fWclsZ1aJQk
        CzBGpam53bWTtMnmKub2IAi6xCuaGK5iFjw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rv2fVmszT_Y7 for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 13:44:56 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HSrQH5Kyzz1RvTg;
        Mon, 11 Oct 2021 13:44:55 -0700 (PDT)
Message-ID: <05f0db0a-e961-0f68-4302-68be034594af@opensource.wdc.com>
Date:   Tue, 12 Oct 2021 05:44:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH] Add AHCI support for ASM1062+JBM575 cards
Content-Language: en-US
To:     =?UTF-8?B?SXN0dsOhbiBQb25ncsOhY3o=?= <pongracz.istvan@gmail.com>,
        linux-ide@vger.kernel.org
References: <20211011203612.25504-1-pongracz.istvan@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211011203612.25504-1-pongracz.istvan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/10/12 5:36, Istv=C3=A1n Pongr=C3=A1cz wrote:
> Signed-off-by: Istv=C3=A1n Pongr=C3=A1cz <pongracz.istvan@gmail.com>

This must be at the end of the patch (commit message comes first).

>=20
> Add support for PCIe SATA expander cards based on ASMedia 1062 + JBM575
> controllers.
> These cards could provide up to 10 or more SATA ports on one PCIe card.

s/could/can

Also, FYI, when you resend new versions of a patch, please add a version =
number
in the patch title with [PATCH v2]. And add a changelog after the "---" b=
elow.
Something like: "Changes from v1: blah". This changelog is automatically =
dropped
when the patch is applied. It is only useful to facilitate reviews.

> ---
>  drivers/ata/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 186cbf90c8ea..97fd96b67731 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -592,6 +592,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
>  	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
> =20
>  	/*
>  	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
>=20


--=20
Damien Le Moal
Western Digital Research
