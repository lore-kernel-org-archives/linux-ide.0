Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371B3C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  8 Feb 2022 08:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348859AbiBHIHi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348877AbiBHIHf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2022 03:07:35 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD47C0401EF
        for <linux-ide@vger.kernel.org>; Tue,  8 Feb 2022 00:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644307655; x=1675843655;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xl8JZwiCBa1DAB909hnmWesBMcLW2Z8/Q6Unw3KRTvw=;
  b=W18Hbnk4LjKR/F8c8RzhjvA2TH4PRVebo3+iPn40uQwRHRQKXyZuePVs
   Bbfi14RPWdaGY8Rr95D+1owRhh0FkuCpTUNJFzG/VNPGWs3Bv2MSIiaoQ
   NK36C7El6IsaLQlHaGC7EwkKb7u3ZhlmMqfLRw64x/n0NkgiL+8D97AlD
   aJhb74WFYeWmrMggmknYK27WqL3GMz07A4zLHh/lbFBrdg27Y9phXDw59
   4WO+EKO9v3gMTP1bc5s52ljlsk/MsOrgfcq3OAL+//Ii5Pf0uRKhVnj39
   oIpe79gN+Ct9u7qJYQ3m4/LWUK42qYm1OsrUwB4C20yraE6cI3+V/OJp6
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,352,1635177600"; 
   d="scan'208";a="193381892"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2022 16:07:34 +0800
IronPort-SDR: wyf1S22Rnc99J5geZC8TI/eS+c4d1RTV8p9ioK2hKIu7QNPF3qU2jeCNmEHNX198463H90Xcey
 uZbt4OY+4Efi/Fk5jHDqUyidIbyBRgVPmzGpXpdojHRDqOtFXHkNfKfpXTgqvrRcjGZGAekDNC
 lvPdyFzxE1YcuyrsY241TJFuhitmyIJ14vYKMMmprSzSCFN1pzyjXCdVHaoZXqC0iI5CjGIfWt
 CaiSpftGciFa/QC4rtEugIWnbY/Ht8kPMhRfltp1UWhtYhYxogAI7hOismZjFm19zx+BWSm5il
 /gQGPN62ALmMjnQeBcoc5MuF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 23:39:22 -0800
IronPort-SDR: DlWTAzN1G0bDCDxqp82QuCXF2/F7HgmhoWkvt6+yPeSW1JMlMwIqjl5GiERItrGRkWiOLb2Oac
 WMyTLEhd2IPvTRmrfNWfPIEqSi2I4yY132hMOS4HIeIMZlIuaXw2x/UwpWhQLaJJirjU5WOJ4H
 OKIbddnFXQotyWq+A7ntUkthVmLyz5CB4CDAfacYB6q70xtdsTxYVF8NLEZ34u19PTmoCn0hRA
 1SyxxEAIotX4VwJZF7ZfnqAKhIC2Te9ojYFRR2dSSCurxBC/Uo8nkEvOdlw8l28SW5SJCqSskX
 vpY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 00:07:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JtFx071sNz1SHwl
        for <linux-ide@vger.kernel.org>; Tue,  8 Feb 2022 00:07:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644307652; x=1646899653; bh=xl8JZwiCBa1DAB909hnmWesBMcLW2Z8/Q6U
        nw3KRTvw=; b=VSs914drxwHDoOXI3uw/xQMXAlUQaEghI5YNQ7eRSeOkxI9RZ8t
        JsLPdhmzaFj/OzMXzLe3riKa/b7/9tbNtM75a7dnSTU6DKWZxPpv5rsLnRPJBB/7
        AGf38LZRVGFbbNIoU45fX/HTUCYp4TXKhyC7OQ26F8+iLC2Qx6QCm4NyWzAtuJcZ
        OgCf8qJh5Jw19J25DhEXzlNo+uTp85R3CLKk5uTWsJwpxa40nCUCj1MEUqq4m3K0
        kByXgZ9P5HgGAK6tawAC4Gs+6FtG6xkhxdQofqVaO5O2YMHDxsJws27Yf4azH5ss
        fNxLL6QF+Sav/YYA0rsJMS05p0PJz+L000w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zgmAdt9vRHtd for <linux-ide@vger.kernel.org>;
        Tue,  8 Feb 2022 00:07:32 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JtFx008WGz1Rwrw;
        Tue,  8 Feb 2022 00:07:31 -0800 (PST)
Message-ID: <f726e9e1-bdad-ac8a-368b-aae423a00676@opensource.wdc.com>
Date:   Tue, 8 Feb 2022 17:07:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] libata: add horkage for M88V29
Content-Language: en-US
To:     zboszor@pr.hu, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Cc:     zboszor@gmail.com
References: <20220204125750.1771303-1-zboszor@pr.hu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220204125750.1771303-1-zboszor@pr.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/4/22 21:57, zboszor@pr.hu wrote:
> From: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.com>
>=20
> This device is a CF card, or possibly an SSD in CF form factor.
> It supports NCQ and high speed DMA.
>=20
> While it also advertises TRIM support, I/O errors are reported
> when the discard mount option fstrim is used. TRIM also fails
> when disabling NCQ and not just as an NCQ command.
>=20
> TRIM must be disabled for this device.
>=20
> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.co=
m>
> ---
>  drivers/ata/libata-core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 67f88027680a..4a7f58fcc411 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_devic=
e_blacklist [] =3D {
> =20
>  	/* devices that don't properly handle TRIM commands */
>  	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
> +	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
> =20
>  	/*
>  	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT

Applied to for-5.17-fixes. Thanks !

--=20
Damien Le Moal
Western Digital Research
