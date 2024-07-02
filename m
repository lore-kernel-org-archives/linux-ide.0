Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DC71BA06B;
	Tue,  2 Jul 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953163; cv=fail; b=GkiCG9n3o47l9+5KmBte7pj3/FBQ/FzmQqp7nwkZ+uspDfCzmDUWiHT0c5BvlYfNpYCjRv9GHGC40z9f1N7xmVu4K91BLFFfdoIhaFgPSenxZ0JeiRpxdUOU7yOGPLfiixiHw7zw/v3mTRkEpNptgSRpEZOUc7Gs2Gwcuu+46sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953163; c=relaxed/simple;
	bh=1QZBuAM5zRzI0ZUFljNyRc4GQ6CU4usiwrEgJ74H+kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ohys8N13bZoDEhON29TylMRK1PzH5L2ss9zqViVgsFDR1AuYX4mlEaZlsT6cazpY9oeknYPkoheHHxSt8LD70BvXE0IZ3mW+f1el9ks2XGqd9AIoSEd1v6vXf5G1gmZfEh+pcM/LuEht//5KZVS211dW8fAHDoDQqCxSh6KxC6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=V8AcB05I; arc=fail smtp.client-ip=40.107.103.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V8AcB05I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fli2NAumRoae9pFBcQibsTmQnTiGk1Cz8LGToBBT5xVrDiRiaHgZJLP30kI062Mw1XyWMpX00AzNXVxJb5jzXXJY67pA3QsiFhOPXqH1UzBfw94h4W5gPt0PTAEm4WInsX5bSKSQ5O4BrGTNv2KB/47MEsvtgL9A781KrjMN9M1S8bHWhViWyiK4H2VX9orMad+usHoeNxcFefqZQd0rMQBfyumzOmBKqHxatexKqRna2THMUoQSzX8S22lpAJY43kxD3vEb9L1hxTXPiQvstq46PiJcujbsIeVTU69G488R/PaNSNHHPZnp+RyJn2WB4CGaFRNPCYg/yGse9PBmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJeqZVQJDUdIartxzGf62Bcq4Y9n8tJ+SDcEzgump9M=;
 b=acr0gDwnfTmpmBAnx0AuXhqaXULrRIVBlb04bqEFsV37uojBpuzIVUNX/bR8sY0WGnJlkChKY3hW8ZBFbXsShvFE98ufM0eQtjcUGPkcPVOuHIl+FyDkz0qqBt1lOyqdGWPtz/bk9pinv2J6frIBhbyFjhsE/dIa6qHlOnXug551i7wSg6m/retdsxAZSTO/9PewaIBOwPicyZd5DNM3abWoiyUx6IrMrHlxlHEvt3WQc5ECu+wTArdMTUlPnjUHsFyk/k8GIt2O6xOeB3cySrSxNVQVQFLq2gr4PRKXFxO/K6G1pzFBSOzMv7OZuXyuxuNguGoHXxTHbRrsYD5o5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJeqZVQJDUdIartxzGf62Bcq4Y9n8tJ+SDcEzgump9M=;
 b=V8AcB05IraYdK3HA4UTMdo3WScnUjexm++ISzAK8mdEZDEKvt5c9rQZvN+5ElqkwaKavm8qfR+qapMofsVJ+xbF67KRjGzLZMMfN7et7psGlNlKTajxXc8zkQ5rC+AI9340h17JRlaa0eCcGjUwKKOj44uv29wrS2dHQ1XG4oa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7522.eurprd04.prod.outlook.com (2603:10a6:20b:282::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 20:45:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 20:45:58 +0000
Date: Tue, 2 Jul 2024 16:45:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
Message-ID: <ZoRm/Lwqb4KGCeUx@lizhi-Precision-Tower-5810>
References: <20240625205752.4007067-1-Frank.Li@nxp.com>
 <327d6dd1-3f31-4b49-96f0-afd754eae086@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327d6dd1-3f31-4b49-96f0-afd754eae086@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: e37e26fd-d8e1-4f22-2650-08dc9ad7f9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jVIhNUTGObNmdSanDJENX0kF0AXMybG9vm2Gf5fpKOqmZsW0NPXQZaWwit8F?=
 =?us-ascii?Q?8+0Wbr8jQW8r5ijBl5z5LIJjaMauUWvwDjELI40FjcLFhvvKuOEsM76Vp4tu?=
 =?us-ascii?Q?mFaYYwrOS+34eUMu/V/doU04UGsox1dzsJ0IBc9fj3OFYNxulTdr88eMKjV2?=
 =?us-ascii?Q?DuQ5VI9yLFQjdIYlFUZr62Y7YPHqLxiU/rtitQtHipFhDChJseIsOECvp0NV?=
 =?us-ascii?Q?ENqoQc+QdkmFVjBZ7F7L4mhS3MnjA+kW53ZiMmRQbOwllw6nsuTYQcISPELD?=
 =?us-ascii?Q?PjmcbzJiUF2TCf18TOhfj1llzTd9zrEzDWJU1d2BtTTtxiswZvOPwZvUNZN8?=
 =?us-ascii?Q?tpD2XEUEr/CRCyvxNSFX68hytL/1NUYq2freI3QBuujFglxhwRmYTd+xYBYd?=
 =?us-ascii?Q?StilX0nCXxccrgpG4FJaMXn6ssrkQAIdKRA5NkpZXIJoAU7ou9f/KwtQ4KJL?=
 =?us-ascii?Q?GubtS0/wx9OreolXLXoPheiSIRR8A+luIqy1BpyEkFujdtiBQL+KG4anSJ+x?=
 =?us-ascii?Q?CbFQHGnR/jr4tD9U690eWGlhVlnr2a6yF1Lg1IWq+pzlZh6csJsF4Ho2G0xL?=
 =?us-ascii?Q?nWngpeorDNIGxXSATal6rlJ0HSPnBlS4nkMHj0LPnHNmxg91z7FczV6n+gbO?=
 =?us-ascii?Q?B3dSWqivVsAKSnHVTT3zzzpbe5udhBCspUg+IA+0Cm3FVIxMESkvlDL/xriX?=
 =?us-ascii?Q?pGX7mBLIBfSIBRZVcvQ0MLfIw/cJ6QkRiPW2YaJkIqagmbRwf11rSV1IgJrb?=
 =?us-ascii?Q?WKesRj2JTndYWReEmAJ+lRDiJA4e9wC6IDcCHfKQKc30pzB91f652dxR3akx?=
 =?us-ascii?Q?3A0Qe8REYDRsBSb3YeJK+LummJw+O3qLDafuG1qvJXsypYeSu9mk6EC0EQw+?=
 =?us-ascii?Q?ysVYrAZCZ7nPJSJT5TGWvOCfJ4TgT0ZQ07Qd7uHWFEM4H0UBMetmOajCTQUH?=
 =?us-ascii?Q?HoGhGQedUTpt1rvlSSMCv+65DhItIWZyDFKHlNokXmhQeRiXIWBRn/wjPh8P?=
 =?us-ascii?Q?R71taV1n6r1rgcImIY5fAQVKhGOSBDj6gUyNYijaLSb9xJrf8KTercM034+i?=
 =?us-ascii?Q?r4QM2qJ9+vzCWH+hdxdwsQFYxSInrfO5H6ltD+AiCGsi8jKoN3UEphz/UBTK?=
 =?us-ascii?Q?HJ8wqsDOL8wPd1Nva2YYefQ0f6Ha+p7XsgY27qsIrDEJ4Ssa380/tSd5Crs4?=
 =?us-ascii?Q?v8EPUJQmhisFqF4QhJjr5iuH4RGKTvXeZadthzGYQVVcmLZB0ENfX8LunYpS?=
 =?us-ascii?Q?DrQHRj1b7V27RNF+qmDq84i4m8PH/wrBFS4Jb3+stDGrBdDD8ccg58m2nL68?=
 =?us-ascii?Q?3331HGHG+/6/SI/RjHZUutkc0qAGq9u5jCEn04kge7wDmwyyqPisM7xXJYRK?=
 =?us-ascii?Q?dflw0zyGAfcswecYQYu/Q5rkZGKz29ulR/fnGeUZZ6LmGhmRYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t8BwUegcE5Fd+QimbmNPMqN4+M4OoN4OpetJZzMapuDr2gIKKi8OF0xKU3lW?=
 =?us-ascii?Q?+vyEG7ft/NBzs7KDcGxzlAyWRNiDrdmzinmFuKxlvhKSmnWcqyk/TBYhYvFj?=
 =?us-ascii?Q?uMbS4bcOiyfW88lwTluI7/scTuhp+Cvl9mGrSq9SDRBeuL5w8yWwkBUp/lia?=
 =?us-ascii?Q?g9Ovs1/IhBpCgdTN3Dgvg7bKMP4snU6buCOIT5K6R516JEaW8Gv4oqJVND5g?=
 =?us-ascii?Q?lcnYEi3MpUzWtbaihIYL2aBV9kFI8btE6xrOz6gb4auEEgz//1pkrpbUBrcX?=
 =?us-ascii?Q?IxZHFB6cJAezz8jbrNb6HZssEzh6dsE116XFahE+xF8csHm0im8jaECgKcBZ?=
 =?us-ascii?Q?gnNxN7uh7fuT0Vby9Mglb/sRNCrYvLrfze/HDq3K60PBsAqkfnCLH6NuQ+iE?=
 =?us-ascii?Q?V/iHC80kS66HsX8fgin+P7k6v/wO3w+uNqsF4i1AreffOTSuS+XioSWZ6fTp?=
 =?us-ascii?Q?0PY+guY1+HMrs7UnRibY4T3AZK2QOdpWDvP9f8FjTyvan5WwzXwQN/rY5CuM?=
 =?us-ascii?Q?nlJhkTz9b4ey07iZd356x8pfw2Z9p7FIp8RPcEzNxyQ2CUJi2DgXyc2oFLr5?=
 =?us-ascii?Q?YSviFMQ1/u8YHkQJjh/ElN6/ndjpGoFTIYDp/c7Fu5FHygwsYb7+9dtHI1hK?=
 =?us-ascii?Q?pQB89me7VcJzBxDQ0AGbiBySNrE0Ljcjnmr3GYynB6wpNFtjZJdKcHaAf3WG?=
 =?us-ascii?Q?ArnK3s8Gpri0k1O5NXA2m+JfRzYNXCltj1DYh/r+x4K5gwdNhNtQ6bWYP/tj?=
 =?us-ascii?Q?tctUaf8OYxyLgkZHxCuSw5bFqd3ub0Sit/Ey7mvgwCEEd6qAvHpzlR9vBScB?=
 =?us-ascii?Q?W4mFfwMApQYPzlq+lvopwi3aCGn/2f5uZJ9wJr0STzjPBXpcfC4ADXhkh6UU?=
 =?us-ascii?Q?DKyyw3B2d3w6MeqKv4+fepehdKlNjGid4eHZUoZoe2teXCK2EcmBvc+joXjN?=
 =?us-ascii?Q?b0/55BmzaSRc78soBX9CJyZnxVUGKzlPN6q9awXG4tiEpbO0RiGOMzVOrORy?=
 =?us-ascii?Q?gZpswF8HrFFRjQ20TVmMg71NBD61hFN0I6y2SmUXsxeJxRcaBZ8XfT1p8uAQ?=
 =?us-ascii?Q?YDOdeiicl9LPtyVGI34noLIXgHqcfYdi506AbChqq4WrDZYcfXinF+wb7hPZ?=
 =?us-ascii?Q?+ajYkneykDx6RU5mrQRfIXaLOS8IGOAwXYddPx8QaUfsOvA11fsKqJtmuGGb?=
 =?us-ascii?Q?QsmV59YCeIiCvB2W90IvqHMfm//vhEhWhyqRMrf/Re7nNsmGPcMjhavQXHQM?=
 =?us-ascii?Q?UBgdCW98zzSiRB8lbzU78GvH1dlOfgbfbbFGdLIpz8e8cu1DBExtyew4rb1s?=
 =?us-ascii?Q?EsJh7g77ZiWVaTxETkt3eudgcc3JpHrQ9sIchTAeFzvUMxSPDuFxXDOaKM3d?=
 =?us-ascii?Q?mZcIKs7kAWTuNp/4+p8Qowdy9PCoaAbOb7Nmn53/Ehnuvqh+XzYiv0zov8qJ?=
 =?us-ascii?Q?t5wfBnQZ/yTaC/XQCf24dLbOmfAHfDJ10/EYi3dcMV6a+BFcEJIKvAFh7wAG?=
 =?us-ascii?Q?tkSB7hqXbhB1iwqDzJ1fxge9YmTuoUwLQRjdLDmDcd64e1MlVg6RJDtPijB5?=
 =?us-ascii?Q?2Y7uRF/AGEcvQ25WB2Op/MzzgkuHCk3e0Rx8gUhj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37e26fd-d8e1-4f22-2650-08dc9ad7f9cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 20:45:58.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMGKtGSoxb4UZsAIfB0RQUjAkbDoRsixZGWsum3rXoQBaDoh3LHyIjVr7dKdYW1f38sedqrUzFq8rk38VDCa3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7522

On Wed, Jun 26, 2024 at 10:17:55AM +0200, Krzysztof Kozlowski wrote:
> On 25/06/2024 22:57, Frank Li wrote:
> > Add compatible string 'fsl,ls1046a-ahci' and 'fsl,ls1012a-ahci' compatible
> > string. Allow 'fsl,ls1012a-ahci' fallback to 'fsl,ls1043a-ahci'.
> > 
> > ls1046a ahci ecc disable bit is difference with other chips.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/ata/fsl,ahci.yaml     | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > index 162b3bb5427ed..a244bc603549d 100644
> > --- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > @@ -11,13 +11,18 @@ maintainers:
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - fsl,ls1021a-ahci
> > -      - fsl,ls1043a-ahci
> > -      - fsl,ls1028a-ahci
> > -      - fsl,ls1088a-ahci
> > -      - fsl,ls2080a-ahci
> > -      - fsl,lx2160a-ahci
> > +    oneOf:
> > +      - items:
> > +          - const: fsl,ls1012a-ahci
> > +          - const: fsl,ls1043a-ahci
> > +      - enum:
> > +          - fsl,ls1021a-ahci
> > +          - fsl,ls1043a-ahci
> > +          - fsl,ls1046a-ahci
> 
> Where is the driver change for this?
> 
> Your commit does not explain why you are doing it and without driver
> change adding new support it is not obvious. This probably applies to
> all your patches.

I think I missed ls1012a and ls1021a.  Commit message is wrong. This is
for legancy platorm. 

Basic try to eliminate the CHECK_DTBS warning. ls1012a use

"fsl,ls1012a-ahci", "fsl,ls1043a-ahci". There are two methods, 
1. change binding doc to allow "fsl,ls1012a-ahci", "fsl,ls1043a-ahci"
2. remove "fsl,ls1012a-ahci".

which way do you perfer?

Frank

> 
> Best regards,
> Krzysztof
> 
