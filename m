Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE3AC433EF
	for <linux-ide@archiver.kernel.org>; Tue,  1 Feb 2022 08:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbiBAI1y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Feb 2022 03:27:54 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35292 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbiBAI1x (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Feb 2022 03:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643704073; x=1675240073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D4M53Zuz/HgDGQqLCLLEoLL3kiq5QIWQEo0Ih1LbUWk=;
  b=GZ+gc9B3azKpWNwks/z64OJtFhTuvQ4TBDYo9+XcI1bPLJ6g3dOpesgE
   FohHOfGQl688aEZgIZQoQVE/2dg80izTH9ov50mMS/bnsuFsZLqH92nV4
   DGnZKy0cwEd3v6wZ8xumwsGCUUbICRZNqbqj2kbMCgLg3jBpjsOJ6A3Wz
   1a1zAYD1WLPZ9Ulcqi8GSwsYNZxxLD0ZFmLYEheFgT8AqN5VL5vqEINpY
   SmAmFWNHVh42AWVPGVNneKNpAM5OaT6imuq+qMxiH9oVISbeNL/9aKjeK
   oT/w4NthnbB3QwbhqteHbSBKmhQGmkoPBSQ7D+B2yJ8TE0p2TQ7upK7IG
   g==;
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="190815640"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2022 16:27:52 +0800
IronPort-SDR: hGrsnEo25D7IunKrnT3zPNOMMTdi+t9a7q1Sr/IotL93yT8JUAXoywSz51MuBOS3Wo8uxUlB2y
 BU+lnTQ5brRX6ne/v7C23unGJ9q+pUtYlEo3CUxe4z6wozfNP1LoizTdnewbkSC6p3Lvt6lK9t
 vp/+rC+rw4S1LLf2qlyFK8Jw5bk5M5LLEu6h2UmHvzNJJpBDHIuvklkdIwpElWBl1AZMHmqp1O
 d+jDcWw4AgXd8UAMo71/+HxrNcklrimPA+TEzAZ58WhEF8bwq/ZR30wEt9GtNphNiWzJ1JMZVN
 F55/Krg90cB/weIQiJZiwK23
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:59:51 -0800
IronPort-SDR: jbvE60lBVdaxrspTiAon9PwfDt0N4o34DljPvYUUvmm57p15+ZGZiOeoD5oALbD5rPrYRkUzOo
 qVA/z4l2183YaR3NEaThDiZluD43VU/l46naw6aEhtXwq/eVR4DUnNJCSASAWjGoYglkb3ebCx
 MgY2CN4/iHCkRYbp4toB/dlldC5raJfKdKSc3ojQBrTwTFMrDxi7M8dbMOUrquqLCjCPYSKSCf
 ZoRG1q/3GH6RP70WMpA1uiUbNkIrOgIKuIOEUyUMFCzMsxFZycrf+fqxj8NdYsBWRCF1kyPffW
 BKQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 00:27:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jnyjh3ckyz1SHwl
        for <linux-ide@vger.kernel.org>; Tue,  1 Feb 2022 00:27:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643704072; x=1646296073; bh=D4M53Zuz/HgDGQqLCLLEoLL3kiq5QIWQEo0
        Ih1LbUWk=; b=io0QARvZTKXc2Vmm/e+1Ki8rjhaZTy/6cW+ipL08IVKGGIfs8VW
        t2SHQMpZsJ80oXsCl9kt+Uw9eiMX6aZeJlB0pqKI8YMEzITF+BDPuzvrh/NXA+cF
        FbyWIxdM49OGsFjtWAGfjiCrZklvOu8acnXa/s00OqkUI+fT0fFaCTRtseSjIfT5
        coCkeew0FRjw1EwyTlappBj3qG7g/ELgHJ7dtadbiWZvNFjPCSyMlcqZJHi5ahg6
        lRcnwvtHYJfNc2lb92lO7A0aq1aolMcpoGcFWI+FmeC4U3JRX7T0rQvRWYrX0Crz
        9JRv5NwFS4R7kkm4tDYV/pfjYsY7e7u8m1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bmhphKDxk3cC for <linux-ide@vger.kernel.org>;
        Tue,  1 Feb 2022 00:27:52 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jnyjg4Dwjz1RvlN;
        Tue,  1 Feb 2022 00:27:51 -0800 (PST)
Message-ID: <d9ba1eeb-9ac8-179e-e167-f091b9795d6d@opensource.wdc.com>
Date:   Tue, 1 Feb 2022 17:27:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v3] ata: ahci: Skip 200 ms debounce delay for Marvell
 88SE9235
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201071229.6418-1-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220201071229.6418-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/02/01 16:12, Paul Menzel wrote:
> The 200 ms delay before debouncing the PHY in `sata_link_resume()` is
> not needed for the Marvell 88SE9235.
>=20
>     $ lspci -nn -s 0021:0e:00.0
>     0021:0e:00.0 SATA controller [0106]: Marvell Technology Group Ltd. =
88SE9235 PCIe 2.0 x2 4-port SATA 6 Gb/s Controller [1b4b:9235] (rev 11)
>=20
> So, remove it. Tested on IBM S822LC with current Linux 5.17-rc1:
>=20
> Currently, without this patch (with 200 ms delay), device probe for ata=
1
> takes 485 ms:
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
> With this patch (no delay) device probe for ata1 takes 273 ms:
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
> v2: address comments for commit message (but forgot v2 tag)
> v3: resend with v3 tag in subject line/commit message summary
>=20
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

Looks good. Will apply to for-5.18.

--=20
Damien Le Moal
Western Digital Research
