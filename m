Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0309C4332F
	for <linux-ide@archiver.kernel.org>; Mon,  5 Dec 2022 02:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiLECDw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 4 Dec 2022 21:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiLECDX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 4 Dec 2022 21:03:23 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE1BF01C
        for <linux-ide@vger.kernel.org>; Sun,  4 Dec 2022 18:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670205780; x=1701741780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lyBY3tcYfsJlh8CZWArqlqogJuU4ryw9aI17xIpx3sQ=;
  b=USzkBSogyckd4kTlU6lKAGvMYGadIL2fS28FIEM2ocl4A3XPS3AMK+Vn
   JQKykDKKBq5eFRyQy27ZwMHYPllJHaA+hMCDkkqGvSpI5Ph7dIuOeQqdR
   qZmq3g52Ri/gDePcSAFIxdl6PnJMKc8PV93nTY2N+4EmTVWZdaakmOLL0
   VIwpZfGNE6DVtLRaAKF4pJz4dHd9/HKg4acDCoZFkmLu0vMvF3qr1kvQb
   0m768LbdLz5Hb0lk9zidoIy5n9/zYW6aoKLTV3Ogi2R0i+Po5qYYMhFRl
   NHWcNR5bpYFwu14msFWrP8Up6SyvwYehy0bqYXlnk/ETW+n+L3EFLXv5f
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,218,1665417600"; 
   d="scan'208";a="217878380"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2022 10:02:59 +0800
IronPort-SDR: FHVYa7b63AfUitcdDW5StHmhhPfzfTu/lDpDCvWw9Kk1qHdurK35ksbqV5BkrhCJrrgl6noTuw
 oXq9+Gd6uI9qK7b+2MISE0uDsb7po39erVeXa0MZpj4haf8EVTMHcu9thTtu2a6MIVX+Lr1Z24
 ZobI4ECwmii5hgxW/5N/eu915JBo8YCz+DB/EracbnkfpcPQ64GXUVr8JLncYJvtE9ZhY5IbDb
 6TA1qA7Q/s+IbE+fptqoTiZGGCg0dSdRtttIMrr6xDbmMKdKMr++iP0khuyt4MCbEuchoGx92e
 D9o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2022 17:15:48 -0800
IronPort-SDR: Oh5Q5ylhsiYbD8NdQtYW3P6nbvsvlDk31Bp5TWS0gXMoPBGS5RT8LS3hvbkWmbD83vm1HKIudZ
 IwYIf/eValWFXyoTxLzNR58DwKRWJxB4nWwJj19M7Bh+fhFEGPeZemM44xmD9yN+0AJDzr0Z5n
 x5tkH3D0+QmAMPerYqnaVLfz4ZxtAR5xhkYTSCB6UISGAq+E4t9fBfELxDSuCnVOtSOTtJQTYY
 kwHBs5lttPWCdC6m/AUKHts+XPgMrVDO6NQNTq/x1tHRM29prUGLf94QUr789+RgKxsJUOM+1E
 abU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2022 18:02:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NQRdv2mBHz1RvTp
        for <linux-ide@vger.kernel.org>; Sun,  4 Dec 2022 18:02:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670205778; x=1672797779; bh=lyBY3tcYfsJlh8CZWArqlqogJuU4ryw9aI1
        7xIpx3sQ=; b=r8+lyg3YwcwSXH/Wbkh368ikstreGCk4Bzls9SgWqK9Mk7ZUWEg
        0U/k6BoNrGajM3wci9q/YkLOIEflZo6ZUNscuFJ0Vu+//7e4mSw1hZw3VYBwRnqy
        JD0vetDOt3I3ct0I1TGPyxVibcjsKH9lvZhxxc1RgAe10YQaupgDlbi+7KkCeHPt
        dOUpU7Y6l8QDu4uRfc7Zd9SV7e6VuRPKhRI90/jVyKGp1zHULYogIKyuRADMxtYi
        2ieg/mdT8XJW5j4yheAg2K3gydvyL/eehbv2jriloZx7O4Oiuq0ofhJkNYm67wwH
        7tEXaMD+Ip+S4cwRdEChIsMwZwJYOcgCGRQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GQalGkF43Wyr for <linux-ide@vger.kernel.org>;
        Sun,  4 Dec 2022 18:02:58 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NQRdt1t0Xz1RvLy;
        Sun,  4 Dec 2022 18:02:58 -0800 (PST)
Message-ID: <c675ac12-c54e-887b-7485-e7210e5ecf28@opensource.wdc.com>
Date:   Mon, 5 Dec 2022 11:02:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: Bug report for ahci-mvebu driver
To:     marius@psihoexpert.ro,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-ide@vger.kernel.org
References: <20221204102235.n4z2fjmxk5hbjiwd@pali>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <ed1841a08205d417e2e9866479878b29@psihoexpert.ro>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ed1841a08205d417e2e9866479878b29@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/12/05 6:14, marius@psihoexpert.ro wrote:
> December 4, 2022 12:23 PM, "Pali Roh=C3=A1r" <pali@kernel.org> wrote:
>=20
>>> What next? Should I contact David Milburn <dmilburn@redhat.com> (the
>>> commit author) and ask for a better fix?
>>=20
>> That is a good idea.
>=20
> I think I'll wait for an opinion from Damien. Since the same libata-cor=
e.c
> works perfectly fine with sata-mv driver, but not ahci-mvebu, the probl=
em
> might still be in the ahci-mvebu. The comment said: "sata_down_spd_limi=
t
> should return if driver has not recorded sstatus speed". This probably =
means
> that ahci-mvebu does not record the expected "sstatus speed". I don't k=
now
> what that is, but Damien probably does.

Attending OSS Japan conference Monday & Tuesday, so I will be able to loo=
k at
this second half of this week. Given this latest information, there are a=
 couple
of things we can try I think.

>=20
>>> @ Pali Rohar: I could't find the errata you mentioned. If you have it=
,
>>> please take a look at the commit above and see if it is affected in a=
ny.
>>> Thanks.
>>=20
>> I do not have more details than what I already wrote in previous email=
.
>>=20
>> Errata documents are in most cases available on Marvell Customer Porta=
l.=20
>> You need to register for accessing them. https://www.marvell.com/porta=
l
>>=20
>> Documents which were available publicly without registration are here:=
=20
>> https://www.kernel.org/doc/html/latest/arm/marvell.html (errata for a3=
8x
>> was not publicly available)
>=20
> There is a slim chance that I could understand them. I'm just an amateu=
r. I
> did some bare-metal programming on MCUs, but the kernel is way too
> complicated for me.
>=20

--=20
Damien Le Moal
Western Digital Research

