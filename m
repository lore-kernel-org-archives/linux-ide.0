Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2CDC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 23:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbiA0Xkb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 18:40:31 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29328 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbiA0Xka (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 18:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643326830; x=1674862830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NadNmmlzB77tjWV3btgPpuY8pP8FjW2UhgusoP+QS6Q=;
  b=j1zcB8bx1Xt4rbLdPe0Unz2pTp3P5CFQ52wPiO6hZYBNAu8WZNJC4u6z
   1wbvF2AI2faDC9C8My3mLX5tCZKsid7TdES/XgVse/HvFcKkC0YUMeQl3
   IkeEUG4jo19UvJt+kLLbs3lutNYeUNIR9yOWfgnr2BO2yEaqPkbq4fUEL
   6wGM5/rf+o5T3JxtEsr5M5x6SZMND/HTwP0qaHDRI0Pep7rNmnW2tb770
   KCB74BfCEWI31ueB15ki0HOYehAeQ5FMkfG9TO2QofXVLioR37ULNFa6m
   rFlqBAGJwJaOq06LBjVkenNWVvmnhZmSvmApUlYvchUuTLMgFq4EQyeQ7
   A==;
X-IronPort-AV: E=Sophos;i="5.88,321,1635177600"; 
   d="scan'208";a="190527649"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 07:40:26 +0800
IronPort-SDR: o7u3HANTARB8ZQFoQ+5grW0v5IjNNT57eXqUGSdQv/If8m4O7VuDSN12AppHBIRebBB7joQh1B
 jkZHkx82IAd0D2a4d4dwWXLBcpBFlvH6bk5Ke6/y5I6PSuiX06djyhRh/inKcKCZuwvg704dXr
 M/vs2ykezS+rXQmd/MrvwhIrvhzZFC6zUr1fKauYPimnohWu10bhJeq3y4/MZA/id3h/82JtKH
 KqmXwjZWf0krZdROdOkThl4Bpl8vnbz8d18fEZqnYYRKX5zn+OAmHAuVgrf72KULvfqfwCC+Lv
 UO01gtbA8dY47XqS4CH7B3H5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 15:12:28 -0800
IronPort-SDR: GG4ay/leS8yqcn0/MXMO3ia/5RNi9Muq3H+twHLXgxFRobNrJb2sX7/FnKtGX4VuQp2Mabemjn
 AeKi6xoVpbF0bl6rk5VXmG5GnxZ+wJqH7eUhUPrDtG6Fp8uky/8a6TJ4132LesXkb6pSgLgrK1
 c0xXtajMwxOmQurJfRIReRHxftz225l5l0i3qfgWAVggP8pj62tZ65OzkwmNY5To996okrCNHH
 eScgegV8XQ7Vpixne95LJewrslp5pzj43QKIMhok/xTrc2jM4OpQjPQ+sYdXtVtt+lkW/ys9EB
 oto=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 15:40:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JlHBw2353z1SVnx
        for <linux-ide@vger.kernel.org>; Thu, 27 Jan 2022 15:40:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643326823; x=1645918824; bh=NadNmmlzB77tjWV3btgPpuY8pP8FjW2Uhgu
        soP+QS6Q=; b=mmxXZQaAAE8JX0xcWzjYN/RQjp7ffAG07LDEOx+Y7/fDXlMPk38
        RAk5ew9fWQy8kvk4gIE87CINNyf8TThx22aVxlHcXJKk9G1mmgo0JxKsCKCzIMP9
        +6EIAGK9Jm3HdpSiwPMmSQZn4YGRug+CcyO+Xca9MWOM0yoTwQoptZh5gr75HWhz
        PbFZ6OWgiyhKA8Bdqtcjt6emolxMuO5uZd6FTvtGm8uNwrto1eexOy8JdXPl8LuJ
        CCMzDRjjAb+X8PxXNr2FbKr3PhdaeFq0drndTXTl8wTpHnb35fqrZGkcieynigKd
        eHKTp4xrXd7RxV42fsan+RVpLIniUzZdBLw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UzIzHRH2Kgx0 for <linux-ide@vger.kernel.org>;
        Thu, 27 Jan 2022 15:40:23 -0800 (PST)
Received: from [10.225.163.58] (unknown [10.225.163.58])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JlHBt4Tpfz1RvlN;
        Thu, 27 Jan 2022 15:40:22 -0800 (PST)
Message-ID: <1ef3e995-3f61-ef53-0d5e-03bb41a52624@opensource.wdc.com>
Date:   Fri, 28 Jan 2022 08:40:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: ahci: Skip 200 ms debounce delay for Marvell
 88SE9235
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220127233527.445659-1-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220127233527.445659-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/28/22 08:35, Paul Menzel wrote:
> The 200 ms delay before debouncing the PHY in `sata_link_resume()` is
> not needed for the Marvell 88SE9235.
>=20
>     $ lspci -nn -s 0021:0e:00.0
>     0021:0e:00.0 SATA controller [0106]: Marvell Technology Group Ltd. =
88SE9235 PCIe 2.0 x2 4-port SATA 6 Gb/s Controller [1b4b:9235] (rev 11)
>=20
> So, remove it. Tested on IBM S822LC with current Linux 5.17-rc1:
>=20
> Without this patch (with 200 ms delay):
>=20
>     [    3.358158] ata1: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3fe881000100 irq 39
>     [    3.358175] ata2: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3fe881000180 irq 39
>     [    3.358191] ata3: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3fe881000200 irq 39
>     [    3.358207] ata4: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3fe881000280 irq 39
>     [=E2=80=A6]
>     [    3.677542] ata3: SATA link down (SStatus 0 SControl 300)
>     [    3.677719] ata4: SATA link down (SStatus 0 SControl 300)
>     [    3.839242] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
>     [    3.839828] ata2.00: ATA-10: ST1000NX0313         00LY266 00LY26=
5IBM, BE33, max UDMA/133
>     [    3.840029] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (dep=
th 32), AA
>     [    3.841796] ata2.00: configured for UDMA/133
>     [    3.843231] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
>     [    3.844083] ata1.00: ATA-10: ST1000NX0313         00LY266 00LY26=
5IBM, BE33, max UDMA/133
>     [    3.844313] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (dep=
th 32), AA
>     [    3.846043] ata1.00: configured for UDMA/133
>=20
> With patch (no delay):
>=20
>     [    3.624259] ata1: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3f e881000100 irq 39
>     [    3.624436] ata2: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3f e881000180 irq 39
>     [    3.624452] ata3: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3f e881000200 irq 39
>     [    3.624468] ata4: SATA max UDMA/133 abar m2048@0x3fe881000000 po=
rt 0x3f e881000280 irq 39
>     [=E2=80=A6]
>     [    3.731966] ata3: SATA link down (SStatus 0 SControl 300)
>     [    3.732069] ata4: SATA link down (SStatus 0 SControl 300)
>     [    3.897448] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
>     [    3.897678] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
>     [    3.898140] ata1.00: ATA-10: ST1000NX0313         00LY266 00LY26=
5IBM, BE33, max UDMA/133
>     [    3.898175] ata2.00: ATA-10: ST1000NX0313         00LY266 00LY26=
5IBM, BE33, max UDMA/133
>     [    3.898287] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (dep=
th 32), AA
>     [    3.898349] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (dep=
th 32), AA
>     [    3.900070] ata1.00: configured for UDMA/133
>     [    3.900166] ata2.00: configured for UDMA/133
>=20
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/ata/ahci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ab5811ef5a53..edca4e8fd44e 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -582,6 +582,8 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
>  	  .driver_data =3D board_ahci_yes_fbs },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
>  	  .driver_data =3D board_ahci_yes_fbs },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
> +	  .driver_data =3D board_ahci_no_debounce_delay },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L=
 */
>  	  .driver_data =3D board_ahci_yes_fbs },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L=
 */

Looks good. But for the commit message, instead of the dmesg copy-paste,
could you simply write the gains in terms of shortened scan time ? That
would make it easier to understand the benefits of the patch. Also,
there is no need for the lspci output.

--=20
Damien Le Moal
Western Digital Research
