Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EF5C46467
	for <linux-ide@archiver.kernel.org>; Mon,  2 Jan 2023 23:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbjABXkg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Jan 2023 18:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbjABXkd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jan 2023 18:40:33 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C10C75E
        for <linux-ide@vger.kernel.org>; Mon,  2 Jan 2023 15:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672702830; x=1704238830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4GTA6e6acIl4V16ANsbLW54boKQXaDIQYI83ea9o5kg=;
  b=G/rTxQBb0AfxIPQIV7qg/EO44IJlb/sIVRNRVOu5jdUSRL8RkSLy4deI
   DJrulh+eMOryyMvDewHtiz9DWIwNlCasgIOY8oYce7nWTd0qfo8HdQB2m
   FO19tBvuRuvcKcxC4xVR+qVwR9D6di2K9oGpSCCAgrm/Wi2WbieqFTcgs
   etA+mvuFbIe0MWVtUvnJynzqgfEU6mHH0Oy5OiDBfjV03hR0IK8fCbe4y
   DHzvHleSUGT4zGuiCuxkOpHzjEVc+UhNA7OifndFxwan3aYC4aPt43lnr
   v5O0S7pzltdVLQKIXbzyrVDx8685Ny7TFByrJBenkHsqkYNRfzePjehIt
   A==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="219780506"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 07:40:30 +0800
IronPort-SDR: JBx8vJPxtsIurSfZQVsPAO0pDUocS2GxnSevgLWxcegeJqu5IlGZoPHJh9TzA8jyeZlMrJwGM2
 NZq8q5FuGN1BpjMVbTIrmMug6vtNkTHZ1BLxtTR6zoQqeL4mSsQ52pH2+EbbKn0WyoHAioxO5J
 ALtlpISy4vsU8v8taLMN1zazNav1PkL1GA9R7WkYBGjdh4RcS+af86SakFzf+gS00rbFNR2RvE
 hmFj1xjuTuLhybJmlKWbJ6EYda1OtaUuLuLGZxdNT6StVMGd05Rg7CDI7wVWY7VxaNq9/2ppke
 oAM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 14:58:29 -0800
IronPort-SDR: WBo48x0K+cbn7zmCUHHOLPg7fufonir5IZE4e/+Fnt3h6yiIQM1HtlTJvst8FGr5abS322CrWf
 5Dp/+GeDKQBOPTOGy9B4h22ert7EtPwcDkCI115uKwvTTcOu+gPJjd4+tFxnidsP/C/7mOuUbA
 Wo3EXoCEa1/HSkpl4hR7aQMdTmgUMGn5/w97FfsNVKiukz1J/Dyb26/Z9r9fvid5tHgiA7ol0V
 7Isaj2PbrWy9iiW/2DH/lx1FYBfneTfGXey5hVInikERtiyEJpKFD3YUbTbZNL5dGtgXytVjGR
 tdU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 15:40:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmC6570yyz1RvTr
        for <linux-ide@vger.kernel.org>; Mon,  2 Jan 2023 15:40:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672702829; x=1675294830; bh=4GTA6e6acIl4V16ANsbLW54boKQXaDIQYI8
        3ea9o5kg=; b=HAJgriobjtYcgelz6m2B3Sn9V/nK7zfKXGdx7T6EcCevkmCvBdk
        xz5qAIlL6ui84l583EpHMO2p3laHvsVOh2UA+doVcMsU9l4bBVlhl4FGLs6jRWD/
        Wq4jRzzRhgoo57t5tPLy0Wh3ycXZAU5yqFPixwwo9m12jqmWLXOTWpu0mmHcAbJT
        mAqh3ct9xdU7P3elDULMR4+5yg4k48R5CVYRwvda/u7+KUOHQk8P2IPAHKm3+h3e
        Tc2iab4mWm21D7z2LXOXYmbfF2qO2RrADchI2zfhMCK7Uadt1QHWZEfZaeGz0qBC
        w087r+czvzhTAOYhLMmQRnPW4iGPDCgGNcw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5qZos__mvMRa for <linux-ide@vger.kernel.org>;
        Mon,  2 Jan 2023 15:40:29 -0800 (PST)
Received: from [10.225.163.3] (unknown [10.225.163.3])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmC650qJ6z1RvTp;
        Mon,  2 Jan 2023 15:40:28 -0800 (PST)
Message-ID: <3ac2abdb-7cf0-e779-1312-2ea8512cbe91@opensource.wdc.com>
Date:   Tue, 3 Jan 2023 08:40:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ata: octeon: Drop empty platform remove function
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-ide@vger.kernel.org, kernel@pengutronix.de
References: <20221212214112.3775327-1-u.kleine-koenig@pengutronix.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221212214112.3775327-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/13/22 06:41, Uwe Kleine-K=C3=B6nig wrote:
> A remove callback just returning 0 is equivalent to no remove callback
> at all. So drop the useless function.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to for-6.3. Thanks !

> ---
>  drivers/ata/ahci_octeon.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
> index b9460b91288f..5021ab3ede49 100644
> --- a/drivers/ata/ahci_octeon.c
> +++ b/drivers/ata/ahci_octeon.c
> @@ -73,11 +73,6 @@ static int ahci_octeon_probe(struct platform_device =
*pdev)
>  	return 0;
>  }
> =20
> -static int ahci_octeon_remove(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
>  static const struct of_device_id octeon_ahci_match[] =3D {
>  	{ .compatible =3D "cavium,octeon-7130-sata-uctl", },
>  	{ /* sentinel */ }
> @@ -86,7 +81,6 @@ MODULE_DEVICE_TABLE(of, octeon_ahci_match);
> =20
>  static struct platform_driver ahci_octeon_driver =3D {
>  	.probe          =3D ahci_octeon_probe,
> -	.remove         =3D ahci_octeon_remove,
>  	.driver         =3D {
>  		.name   =3D "octeon-ahci",
>  		.of_match_table =3D octeon_ahci_match,
>=20
> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476

--=20
Damien Le Moal
Western Digital Research

