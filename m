Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC16FC88CB2
	for <linux-ide@archiver.kernel.org>; Tue, 13 Jun 2023 09:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbjFMJCY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 13 Jun 2023 05:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbjFMJCW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jun 2023 05:02:22 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A6E54
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2023 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686646939; x=1718182939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mq9bMQWO83ubxJJooxrjZfoqkzsBW9ZbPr2owsJZpHE=;
  b=YeAeeA6ync+BMnuoTcl/CHsw6Lkr6Dddm+z3xN3tvdyyUsu/Cpm6TE9j
   IzV3zdQIrs7y0XYZGBMmX9pzqgrfMQLu+wXvCOLCPkks6ZixtnJuJLE9i
   DfP08Ca0j0hVnNVhWlEuNAIzdtyXwEieV1x8Chpbjbrisgibh1ILbsaAU
   lLHYwQ6VvVDxz4hfiSOTuLKNah0vy7eSViIRRj2HHnZT6JEdnOdouI4u4
   tYwXvgO2+JAQ6r6Nzt+5GtomvPZDW4KHl0ghqd0aU6MmDNo/3rwpnkzGz
   hOaMPgP4IM45XyRFXEZkLNkopLnPC0d45kWo3IHfRX/plNMQKXlTzBN8J
   w==;
X-IronPort-AV: E=Sophos;i="6.00,239,1681142400"; 
   d="scan'208";a="340199813"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2023 17:02:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvUkvozJYBRelxUFMZt1lOTRtGl71mX12grS632U+GmWcwewIsOLtGLeSKkpD7e5hxOH9I7hYRtAEQGqs2vI30F5I1hBpbU8TL3KcmYEaxY1Vleg1WhLgWeQp8AlDRprA2JIjL975teLIAIzWwzzWromNQQcYY96W/8RcBUI6NBHjqELDKWW32QV7zP0lwmN6S4TfESRbfvmHGaNAP1+svQS04nuwlNQ5VB5WdFAosXT5r2wwe2KTiu2yt7fUkCGUGe4QJuCTtRrl/HkdaJsbytriJx0Z+Q6huqE4hIh3Uvu9L+6UiH+WW+ihZzVzFACOvbt6qNZKXeyKkSJhfyz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiGmNsz7OQQbuvdf8DOuCzSpkPRJ6oUsR5ALxHMrKDk=;
 b=TMjGz7CVRcRFQJfva2XwLf6zWlKfjmROoVM+FY18UJBYt9ftMbJv4lX4mwQPnTj8ZhonTfNrSR2Z8CMRO2pnQv30Zsn7KvI3bput34AktmQQsZ4zywQ1vMgawjaD/U/zXQ9L/WVyDI4deAoR8RUHQ29VkpT5R4z8CH58sSrty0zlaGghr6QCK62nNoF7sdVmgsSUN9Wv2i7Vz+WVmBatUeM9vmM9LU77QbHIDK4RG5pr7pyRoPYaCipTyxZwGSaj1ln1n1+IonitaA3TD39Y3lps4j/hdEyW5Bxa3ynah4j5iw8HnAoaHBIXo2DYkROVNSBInF+RyhVVSS05HugkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiGmNsz7OQQbuvdf8DOuCzSpkPRJ6oUsR5ALxHMrKDk=;
 b=pyPrGP/e0leaKw/QqhXiRSLJv9EZvrXpFgOsu0QBzoQigTGrw0+aXWz5FW9RSP8WEEJ6XCI7wsraR0WoOYNVgXQnoJrpbBJsXdsj3Fea5eJp0rg8H7DTujJeo761luQ8JAxNKcN7BcCOfLaK+uWtG4XcyEhMsIy19sARwebyhfQ=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MW6PR04MB8882.namprd04.prod.outlook.com (2603:10b6:303:244::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 09:02:16 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:02:16 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: Cleanup ahci_reset_controller()
Thread-Topic: [PATCH] ata: ahci: Cleanup ahci_reset_controller()
Thread-Index: AQHZndXAfAkFJXkkZ0uVrCKjGmyRjQ==
Date:   Tue, 13 Jun 2023 09:02:16 +0000
Message-ID: <ZIgwUsjnEGbXBQmE@x1-carbon>
References: <20230613063436.370406-1-dlemoal@kernel.org>
In-Reply-To: <20230613063436.370406-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MW6PR04MB8882:EE_
x-ms-office365-filtering-correlation-id: 05f5649f-9d9a-4f27-f004-08db6bece2d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSMeC+NXMLb/oNupsS51LJ/tQPHDFOTEEz0jDrS4DJesg4HOu1C7r9+y6N0IPjhSs6tuQpyzz5jGdQR2VCCng6oJypYyIVs+w3g6BE7moTqOxYJ0TSYEbbq0GhhKSKa1HSC+ltL1VZ/LKvhR6YMQYT3xtQe0tCK8rVEM1aOXMlqGZe6KSIKQnBL37hRigWK/5GPGMozDmZckshH8aIMEN5huGaZBcODLZUVLrsnFXGDy9k213j/44tas+7vyoSM/+JXedN6eSLqIn4ssilhi8HH4yD0xD/bIR5+pcnEy/t0Eo/LJj8qvM9GWnHjD0bYvP2FrWr0XO/tfPeq8FmxrGPEbP83KU4UY4LbcxlQ1FQG+FOaGPVkhLE8WR9VN539pb+VkDxt3PDqwFmXeaV7zImd3CWIyzgwK9nZ2Rq0H3UfrcoCLA7ROg6qAmNsRihbq1hDzFdjvqxAv+OBjqml0j9ey+809AoMKBOgo7yOMsHXk5auWqW0eSZTGPxhqVjKxIrrkUDEv3PJew7F13FcytuvkRm3ZmKTXKdRBTDGVWTWkSN5jhV6Os+r+G3hyEUm6j8j/G5vGdRxU71iSUYEgwLua+u2lBX4KbSDhxKJrHBbt28bTVWAyRmRsST+fWTmK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(478600001)(2906002)(38070700005)(186003)(26005)(6506007)(83380400001)(6512007)(9686003)(122000001)(86362001)(82960400001)(33716001)(38100700002)(6486002)(8936002)(71200400001)(5660300002)(8676002)(41300700001)(4326008)(6916009)(64756008)(76116006)(66476007)(66946007)(316002)(66556008)(66446008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o+nZkCn40MGswvqAn5OJle5krPmnpe29GggNED4XuLtVDuKeam/GAvGW5rft?=
 =?us-ascii?Q?yRGAefzNe6mNmOVuBpGZsHmpLKvELkIA7LkPa5hAKv478JbHbzMsFoGI4sqV?=
 =?us-ascii?Q?yTmB4iw72tPJBO0nawvV6cEBWjuA7EKJz3Ms5T5ahCzaP/shMNbx8xKwxiJr?=
 =?us-ascii?Q?8e6RM7WBUp5jKvV+QNdtSpfgZixbfsn2AQpFuBwAqTtNQ0VpXKg3McGJ4WSh?=
 =?us-ascii?Q?9XQwAo32yPqVjq4RlEL3ijcl1/4JwB+ivsKRHucHYI/5TU9HnlInR+xVaF4j?=
 =?us-ascii?Q?X5Mz+XCwWErSCjY8htlZr2knQ6OUNHo96QbTxTEwSxy1J6vmupcgKKKVLeBJ?=
 =?us-ascii?Q?TwwzmR1uYViDjH3bmr8X6NijLt2rlcpbZLntULb4rE5lUP7UPR7OyPeaw7EL?=
 =?us-ascii?Q?C7MsPsABMnlswnmbGQ9XBexSJj5ZHfL2ljkFFJoImkbeoXxF7/apIFax4Lq4?=
 =?us-ascii?Q?IS9P+VA1H1hTuqMd1TkPOHCQfFd7ZeMAzD+uhzR+vAXJgRCFx+6qqS7qzO5h?=
 =?us-ascii?Q?pOOdbG7GGltuvx4LE4TLLTFCfyCBN/21QjuPA46Jd5kwdbphw9nCvS+1ZgDt?=
 =?us-ascii?Q?hlMJiayY9rP+0kbJ72sIsN1lDIgOoe7px+xJvoHqQ1VNuaRMDrac/d/VpWqp?=
 =?us-ascii?Q?m5JkxdhEsYesbCi4C1FHZ/VImr6WRaRuhppZ9zvr5SRX0izPf7XfwB3+bhh4?=
 =?us-ascii?Q?pELDNaIL4VLEQWnDJmHiQM0UbnfLIX9YZGcpEPcNePLgZcrlz8tKvHbdpf2j?=
 =?us-ascii?Q?Np3xbjzJTEkl/k6ybrGrHuX8p0NLYYJYE2yQTJ/Ds9PIPu6EACTCSfGXDIRt?=
 =?us-ascii?Q?PQUoNtI2SELvsgR3LOfrnMSfHeLnlPUH9lSBrWpU8LV+0pfZNW5CvkhDThEW?=
 =?us-ascii?Q?wtcM07YI9Y1cvqJfkYNmFziW+vdo3XHu5FPn3+/8bCX/mRA63u8xuGDvohtr?=
 =?us-ascii?Q?p6oqV6ZGQTQofkHswCJ69X7Hgw9ThvcytuEJmO1EbMppSDwtpulUYZN3dMZ4?=
 =?us-ascii?Q?AXduhu4Wm4pf4vAVaRYSg0DtlIzX8TvmCI/J2BB3Tj+pYRfyAOckyzZFI/HZ?=
 =?us-ascii?Q?z1/bquDFbmr3LkqDNfDis+8iub+MyKiUVTsEFXvcONbdvJtIhN3jumAwiAkY?=
 =?us-ascii?Q?aaxXE1eQb0kBNw9d8o5xpueQriIk4z+yZHVCU8s5eHOoCw5nepgRhUKddQ0P?=
 =?us-ascii?Q?esl3aLPnHun4Sa7TpJwD49vktSLxz6CHK8ComNmldHnM/wgZIWH242tkxWJN?=
 =?us-ascii?Q?sSV+qclaTBD5jwxuWmS5o8gRtT1TRkQuev8E+47+nfLxGUEmBXbeyRNfqRAj?=
 =?us-ascii?Q?g4QuweCZZwr4ZCtfQz7enYlyJj7IoK7WZ6b1I4nbG4ElfEPNCN0Mt9zLWZaM?=
 =?us-ascii?Q?aUWPdt5pd4Dgv93bWCes0HVTqsKusT2eXJdKBXVcldF4PtMDs3Pl0PjrziyE?=
 =?us-ascii?Q?62T4ZhkhDGjDGSvrbhVi6PAMoqfhw7iCj6d0YeXqawkRTMlRtCo7B7ejp1ih?=
 =?us-ascii?Q?UQaFUjsXksyVwPOsaWfXqGUmzDDwJBA5CEmArPE3mitPhH1uV573SrSFS8gl?=
 =?us-ascii?Q?bCQVZ1prHN8H5agXiRfQRu5UmgGt5um+o67Dvws6xO33HB+RUHrU1r66lJq7?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DDC7C95217F1C44A319573DC6B6B81F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WVSVzI75Y1ICZkZS87ZvOAl7AmPeNG8puaQJDtTaFO2VVnhB4MN4EptHK8Be5OppfSm6D3nytn3dEawVLak3KljezJvuqZBKQe1QbNT+a3PIV+mYry58Q4GQ7nsSkFRlBvP0A7CpB6Qwg/bWMseuXocOFImPI1L+ltt7gZ7vxOHshcPGHtGFmxqlbpIXBLAq1oIkOaaAg/mxHtvAYNNGCc2pqCbGAq9QBbqoSHFbbg1XsvIcEpQBspj8m8WQ13ldva9D5xZfdZ+ocUsZAB8j0aP2sgbzmJIVBk0shZv4VJC72q5R4gdmTHWJsv4tmOukF4vbP541zgQ443c0a4wkInAntr3qZqgqYoPQRj45eRWr8Y1ReN38ueatW75po4n4oco2LKb8YAqr4jecq3ikyVtLfM7xxjJk/Uxl0+RnAgw/GU/2ga3snqgxUchL/yZUQDJTYbNfY5uoS5nLPksmv+3pXbTEuaHdGbyeOMERw5UNzmqfZ34LH8cR0Fl++zfU7u5YVdgwtDQOnZ8SJ1Z+Cnez+kWebnuRyUNqtjBDCmu/VQfYXZ1uBwXjlwIahLxhKXfmOeHsZFhFWA6X53vtYqGIF0ggwBKr8kgS9Hlx7vVA9fHsVMtk3MEZeu+U8kIIkWraLdmR4qI5QzuCsKM8dAM8mj18SHDiC267AznQNkh50eHdEa5xFjPUoWXS1OHNDHKfEgrQtT1nnmD0PGNyoQz4UwGs6ix1CJjvnFM6shGh1kkO+QDp3I8wyV1jFb74myaQpYrHq5IrjdL0/Ni41FZulT2w9CX2bhC2sbx2MGcej3ibiYB1rjW8/WpFE2I2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f5649f-9d9a-4f27-f004-08db6bece2d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 09:02:16.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8zE6z1PMrMXreOctVedV84SEoD4AG0/hhnBMz4zgmWBkMCJySEpVeg7MvvU2ISgllMzTvfzpjIs0E8cgHCSMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8882
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jun 13, 2023 at 03:34:36PM +0900, Damien Le Moal wrote:
> Fix multi-line comment style in ahci_reset_controller() and change the
> code to return early if ahci_skip_host_reset is true, reducing
> indentation by one level for the bulk of the function code.
>=20
> No functional changes.
>=20
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libahci.c | 61 +++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 9c2cb6cbea76..bd38ff72e543 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -975,44 +975,43 @@ int ahci_reset_controller(struct ata_host *host)
>  	void __iomem *mmio =3D hpriv->mmio;
>  	u32 tmp;
> =20
> -	/* we must be in AHCI mode, before using anything
> -	 * AHCI-specific, such as HOST_RESET.
> +	/*
> +	 * We must be in AHCI mode, before using anything AHCI-specific, such
> +	 * as HOST_RESET.
>  	 */
>  	ahci_enable_ahci(mmio);
> =20
> -	/* global controller reset */
> -	if (!ahci_skip_host_reset) {
> -		tmp =3D readl(mmio + HOST_CTL);
> -		if ((tmp & HOST_RESET) =3D=3D 0) {
> -			writel(tmp | HOST_RESET, mmio + HOST_CTL);
> -			readl(mmio + HOST_CTL); /* flush */
> -		}
> +	/* Global controller reset */
> +	if (ahci_skip_host_reset) {
> +		dev_info(host->dev, "Skipping global host reset\n");
> +		return 0;
> +	}
> =20
> -		/*
> -		 * to perform host reset, OS should set HOST_RESET
> -		 * and poll until this bit is read to be "0".
> -		 * reset must complete within 1 second, or
> -		 * the hardware should be considered fried.
> -		 */
> -		tmp =3D ata_wait_register(NULL, mmio + HOST_CTL, HOST_RESET,
> -					HOST_RESET, 10, 1000);
> +	tmp =3D readl(mmio + HOST_CTL);
> +	if ((tmp & HOST_RESET) =3D=3D 0) {

Nit: perhaps use if (!(tmp & HOST_RESET)) instead, such that we use the
same pattern as:
if (!(hpriv->flags & AHCI_HFLAG_NO_WRITE_TO_RO))
below.

> +		writel(tmp | HOST_RESET, mmio + HOST_CTL);
> +		readl(mmio + HOST_CTL); /* flush */
> +	}
> =20
> -		if (tmp & HOST_RESET) {
> -			dev_err(host->dev, "controller reset failed (0x%x)\n",
> -				tmp);
> -			return -EIO;
> -		}
> +	/*
> +	 * To perform host reset, OS should set HOST_RESET and poll until this
> +	 * bit is read to be "0". Reset must complete within 1 second, or the
> +	 * hardware should be considered fried.
> +	 */
> +	tmp =3D ata_wait_register(NULL, mmio + HOST_CTL, HOST_RESET,
> +				HOST_RESET, 10, 1000);
> +	if (tmp & HOST_RESET) {
> +		dev_err(host->dev, "Controller reset failed (0x%x)\n",
> +			tmp);
> +		return -EIO;
> +	}
> =20
> -		/* turn on AHCI mode */
> -		ahci_enable_ahci(mmio);
> +	/* Turn on AHCI mode */
> +	ahci_enable_ahci(mmio);
> =20
> -		/* Some registers might be cleared on reset.  Restore
> -		 * initial values.
> -		 */
> -		if (!(hpriv->flags & AHCI_HFLAG_NO_WRITE_TO_RO))
> -			ahci_restore_initial_config(host);
> -	} else
> -		dev_info(host->dev, "skipping global host reset\n");
> +	/* Some registers might be cleared on reset. Restore initial values. */
> +	if (!(hpriv->flags & AHCI_HFLAG_NO_WRITE_TO_RO))
> +		ahci_restore_initial_config(host);
> =20
>  	return 0;
>  }
> --=20
> 2.40.1
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
