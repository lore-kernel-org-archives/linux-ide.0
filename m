Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010034.outbound.protection.outlook.com [52.101.69.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B4433A8;
	Fri, 12 Jul 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817992; cv=fail; b=u6HBqxrLcrrURDFMygLgmKShH290g5c0B7tiLqY9Azd3eK+qPrgmymnEDPRmojEeWAvKofpt5R0/8nsiTV9NjpyO9Edvwi2LDfRyxfepg8eAxZR9dakwFUDoi1dgP/9MP/vMuulTnKk3TFDQSv03nr5TeU8OmYbA/b95OkKf0wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817992; c=relaxed/simple;
	bh=4u3hqglToQ2te2NiaKeTlJbuj5fhJ5ccs4Bs0fZ2RAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ks8Akl4JBDcudZarh93kZNDgpB2t8MOCVWy0LqV6OACBzcKxI/691lipQJC6b8OYdz7cDmtKb9mZ0NNVhV2hhsNwocm4pU5UkNsuElura9eNQUx2ua8ofqlvXcPiirwOQb7KHoU/i7Im1H4bmxewbkpV8AxOKRBj71u+eZfvOtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DE5+UXJv; arc=fail smtp.client-ip=52.101.69.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DE5+UXJv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7jYTc6nrPPpfCiSfGuG+0RIvqbGaIGFaIsVYqBkm1w7YmYFwabxQUQx5KSQCj37W6OHCHZr2UHk4pyx9k/K0Jt5FwWBLqH+2+XhRccewAoVlux1wXDCCi8iYOxnAQTY14h90isiaeksDigUngtdk6BEWXPK1ITm9DkGijVfB/6WSQ8ypm9BJAjcJpfW5YnetL0JdGIhliT7F8ZtHQEc/FFkBwAJXin5McK8uxZk2CJcqB9O1iq3v7lha/2EolnHV/jV6rkgHKTedYEZ7wvA2vIUpRmxZR4gDcAUgjq0t9TdBFRBVZrQAnMQI3BejjLKQrtvDMJrKDOBZXzPWLjEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1dhlgdOhHC+iNkMo/DdsaqNxHmpVXsej6g0p1K+Gw0=;
 b=OwdthXd4fYa89vI4fPLbksufMZg8YxeHDdUocK8y0iKJNjnJbOlxg/kc/UJnRbFOrlsVQmb2ij0nUjPLFaXc+jUIMbdi9Tpgy/F5s6YLJ7BwpuZVO8A3DJS3QPFiVn1bYHPcs11lgx7UAtvgWg3pEFPe43qecNuFHsTfS6kebEsmCWZfvAPlB9TUL7jWgP9532LKfm6kP6VWwhKAoRTFJpB/r+wCqJ2A/k3RD/5likiDOyPORXbOwPIS6KPJzIWrWhwc0HoPCLf06Xid6xGCDhLYux8DyqEd/+59CjNOAF4C5DhOdeci7a/biefKAe6xaOk1TunQ2ORvOrVgz/NN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1dhlgdOhHC+iNkMo/DdsaqNxHmpVXsej6g0p1K+Gw0=;
 b=DE5+UXJv2TwjD72PfR5qNzT+ID8n1VQkEXC3UPmnXlHU3bTQt1nUXjA08g460NmZ0u5hRXnTm2eWTX7bqtw+krXzIOLqm1Y3P7AswOC/3d8jovVGbqYsr8swbVhCeUVvuXwOV/xRJJ3FAwjDjInwOCJwyWFMHgkt11WmKo6KDRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10921.eurprd04.prod.outlook.com (2603:10a6:150:227::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 12 Jul
 2024 20:59:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 20:59:46 +0000
Date: Fri, 12 Jul 2024 16:59:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
Message-ID: <ZpGZOtjjlcpPBp5d@lizhi-Precision-Tower-5810>
References: <20240712185740.3819170-1-Frank.Li@nxp.com>
 <ZpGXl7W4h-sCjeGz@ryzen.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpGXl7W4h-sCjeGz@ryzen.lan>
X-ClientProxiedBy: SJ0PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:332::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10921:EE_
X-MS-Office365-Filtering-Correlation-Id: 48eb1280-c5ff-48b7-3300-08dca2b58f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xCwYNHgaRr8oOhmc6I07vzNd7V4WCoiRPA/DpX5XKM1ZBZdvQzFoFvBVKwKz?=
 =?us-ascii?Q?qSLczZK39Zm9RMWC4T+wsvoXnlcty9a3BX7dNFLUt7N8NgL1A+UoRx2oOmuj?=
 =?us-ascii?Q?45LMJqFzjr5yIpZ5mXIquMYeMkS7cPcDzGtbJev3OiDhI9DOyiBmmo+iuvsa?=
 =?us-ascii?Q?sn/MJV74suGgNeHfeJf39QiGfglUFm7i/DX9lTnj/t/qqzTKsevJpXqp6Bvk?=
 =?us-ascii?Q?EDeuVwVKxENQUlIFiRWrxTl5H1ZQIVO+GBYWXczDNW0/0geTP4vjLaOxEgfc?=
 =?us-ascii?Q?hdKzUUHv22GXxYNw6iFTJsfHSxkuyKxj3q/kYz35sdyRuv+x8dYi/+qruJrJ?=
 =?us-ascii?Q?6nTw94QDmOblw9SchILQztBsXNUSYg7GMfR2c9EtYQe0AAScxH1nySIZPCKe?=
 =?us-ascii?Q?q3+k3+o4PI7lRYNsQKJCy3fBCLfpV1KneWksIlrK7ujjZRZvN3A/pwR6NK0s?=
 =?us-ascii?Q?j3ATJfJjJFVqe/byaxSxGESp+x7Ncpf9LdsfSdp6K9JtE9BS3uVveLJEjqEX?=
 =?us-ascii?Q?5yJOa24X++2o9DVTHiGxJuDbNXBD9nmwczgKbsyDb+WULQVjGlYklkw+FLS7?=
 =?us-ascii?Q?ZMu2OE6zxlHA/9pARGznHO/u7wwP1t/QErh3HXJBo5RWXPJ3axYfl4gXmGbT?=
 =?us-ascii?Q?E7WxTZb5mKOxcZMlBfob9eXTcedY21HVvHfhliB+E8D3QtqIJiFR2udF5/VK?=
 =?us-ascii?Q?CrMrPbI3dlfoI+HIqK/I7tKBtLHVWdFrqLNG51R3aBV30yqy3Zq2RdKtLIba?=
 =?us-ascii?Q?iH6DdR5+3CrcgiOfhaf5GzBe/kD8il3bD7gYF+wlCZyk3TlJvljC8wJob3b3?=
 =?us-ascii?Q?fLgKL8CGIE7vY3d2St8DSvUZ4A014CrWU/ZBpozGp5WQm5QfbWzCoJvw59cR?=
 =?us-ascii?Q?r5jcE4ytuIQoNwS/wifh3aH7jogH3Jm962uHVKBKYcPyk/gg2kB66fGRovQx?=
 =?us-ascii?Q?KbaQr4G0M+OK8UunRRwcqfeT0QOCWm4wQRLLvPaKQ0YrEfT42ZxLCu+jSdZH?=
 =?us-ascii?Q?JgQ1a7a/yhUebDK8urexSPyt35MS3yiTs9fxNIpQ+Xg0YcPq96oJquP8P28t?=
 =?us-ascii?Q?MNJelhnwJ/F3lknewZNRHdMupnuf5hm/l/e/yYqPFzuTk71M7fNhQXj4Y+Jq?=
 =?us-ascii?Q?cn+R225rBTAxYmpxiG+pIsJr6i7smmqda4Je8QptzZhbjgEsYObQsjAGn0wy?=
 =?us-ascii?Q?QCGV+z+Kiw0kM02SXpffioSlhwN1dc9LinTaZq1nsJT45qdJ+SGL3A4pbvhG?=
 =?us-ascii?Q?PnjhKta3vYQa6TlU3jbErmUiebm0ug1JMBHrX/8iqf7Ah9rIoTC75T5w0Pcv?=
 =?us-ascii?Q?fLnU9kQCJdwq2G0QptJwjZDpOORPDaDRvBWGsGPxeI2dolTirDM1D3awsYQ8?=
 =?us-ascii?Q?im0OBJVWyq+d/pCYT7kh1DiqRecugOhy9PsbXqEsIS6GQo/y0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ygj6yfoHxc6Ys/vn024ohwT9v3KU5qBX1eTyKlaTTRaIM5/3E6VoFwvX4Gc9?=
 =?us-ascii?Q?iI3p2JUNrknveWzJ3muhEO9Ak8mfPg1QcPOUmifxDI28tZsEtYhPz1gl4iGH?=
 =?us-ascii?Q?Bq6IubI1A2z+yJa04gUjrXWmS1PAewiWenC7mfuMcmoCbvqMH4qAEzrPADZW?=
 =?us-ascii?Q?XFBETnk03TwPh3SmQd6j27PuK0CM+L90TD/bw8k21ZUm/q7/mo6rz7n5N5Li?=
 =?us-ascii?Q?dCIlLY3qna2k0dJymwIFIPNWCkreFTuBN9e3I9kH1V942D+cGIJqMNNE4p0N?=
 =?us-ascii?Q?xFSowQedn3YvdMn3omr2cVuUmIow/4nOo7eAfWo0l0ws4GNQICqAktGhYE+T?=
 =?us-ascii?Q?6KUgdi9OimfmaOrR540y6MqKUo509koKQX8JrIk/BLogIWFrOgS/Tgs05zQp?=
 =?us-ascii?Q?Bz4gW3cKkahu0bjo5OHvl1ANtzVzTIN6jYjixOVzxUJeiicle8mop+EQlSIr?=
 =?us-ascii?Q?TOjLJBHTinFdcN/RKvWVYYVhtBa+KtRicCOeSeP4IB73tj+2bjujtkbZSdcA?=
 =?us-ascii?Q?Ks70CoOCmv7M0ZWganHNBYF0U2HYgrCJpAr0qa8S0gtZpCasrFTbeMUvDD/o?=
 =?us-ascii?Q?Wzra5Dd+8NNlxTnQdTvGaxxhKoy4tJ8nGoWw8Y7ptZo/JKq8x+cQqpRhelyQ?=
 =?us-ascii?Q?MzeoLdGzXBQC15JOqdm8lNJ8VMkVA7NWl1SGkXdF7jj/FcWqKXDymrFDq5ac?=
 =?us-ascii?Q?xIH42LwAju7e60IxtghcEbWRBKXmTEJXf4mmukS1Xa0J5weVVECyF2dPFAvw?=
 =?us-ascii?Q?EHkQ1VdaIt6piqcSA/MlfB3mSGpSQO5BeiEFcWznNIKH7gd74kkoCqERZW6d?=
 =?us-ascii?Q?RcaqdO1rLJ2P8HBio55Lzl81oAtQLhqFmXv+4SFG08A4EcJwRFaMspV/w8kO?=
 =?us-ascii?Q?IGmYg/6lFAnQ9MCBVdqsS8TKL1aw6UHnBCa8dChNxDOhNhswun6P8TRI3WmJ?=
 =?us-ascii?Q?gCNQNZi3JQGmQklEJ34zEP4i59ica79d+4qdHT2Dv6vjd5Wfoxi3EbfpuCSd?=
 =?us-ascii?Q?U+SfGHrz2qNOAzm6cnjkQnyfj2LQIfNjKCsQWEQccEE5sGAuzBufLKyE+1JF?=
 =?us-ascii?Q?tOJVaLWMGdpsVgw2Gt27ZLVXzzKIsJYZiEfcOZmPLqcOaaJHkirW1qd1qL1z?=
 =?us-ascii?Q?ibK27Vyj8magQw6QMdX1PKMbN6xnSzgMiLeJp1sd2UGL2r/UlV/pD6WXPMoS?=
 =?us-ascii?Q?uFzk8Dr/hCcEJKINFrgSTE9RcJZxldOrtpYnT3kWDcdOF5gXzEfJNXhYYER7?=
 =?us-ascii?Q?Pk/fArPTxAcKtosiSMgVN/0Gk9hhBlkVSaUZaHVQKYhK0I9QriVSMMhHa5Nu?=
 =?us-ascii?Q?pnRVgkLk6I35LPWs9dRiStKWxt9kv0tKb14N7ucTVB6DFWgijMl6IhvPocJt?=
 =?us-ascii?Q?xBVzHjAsydUkPfQy5Jiou3OyuQ4nsg+3o4G/TMvMdnAUgLEKOjs4JefXPFpS?=
 =?us-ascii?Q?9aVNc/C+eG1K5LWSQA+sYtFdf52EMPRYq8de9RDHkibVJxsJq087rCIZl31l?=
 =?us-ascii?Q?ndn/VxOWyqw8xkoU9MJXfTnlIgsZIKk4tk+U2Cn9daHatXbIC+Lt2Cx/g8lE?=
 =?us-ascii?Q?XBGjIUThDe6HJRsRNMAnGBL/u/zHy8LvExKevrY9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eb1280-c5ff-48b7-3300-08dca2b58f7f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 20:59:46.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgHCQVYxz2s1yH5O+jx729RdncNp6/492Gb7xeKY6kwyC0vQZm0B4eLBQdNrHYdVOPcuknmwkdFzRoJtqFVKTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10921

On Fri, Jul 12, 2024 at 10:52:39PM +0200, Niklas Cassel wrote:
> On Fri, Jul 12, 2024 at 02:57:40PM -0400, Frank Li wrote:
> > Add missing documented compatible strings 'fsl,ls1046a-ahci' and
> > 'fsl,ls1012a-ahci'. Allow 'fsl,ls1012a-ahci' to fallback to
> > 'fsl,ls1043a-ahci'.
> > 
> > Fix below CHECK_DTB warnings
> > arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible:0: 'fsl,ls1012a-ahci' is not one of ['fsl,ls1021a-ahci', 'fsl,ls1043a-ahci', 'fsl,ls1028a-ahci', 'fsl,ls1088a-ahci', 'fsl,ls2080a-ahci', 'fsl,lx2160a-ahci']
> > arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci'] is too long
> 
> These lines should have been wrapped to 75 lines IMO.
> I will fixup when applying.

Thanks, according to my knowledge, computer generate warning, error, log...
doesn't require wrap. 

It may impact my other patch. just want to make clear about this.

Frank
> 
> > 
> > Fixes: e58e12c5c34c ("dt-bindings: ata: ahci-fsl-qoriq: convert to yaml format")
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v2 to v3
> > - Add rob's review tag
> > - Sort compatible string list
> > - Add fix tag
> > - Add two warnings in commit message.
> > - Add - description: sata controller for ls1012a
> > 
> > Change from v1 to v2
> > - rework commit message to show fix CHECK_DTB warning.
> > ---
> >  .../devicetree/bindings/ata/fsl,ahci.yaml     | 20 ++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > index 162b3bb5427ed..b58ea5a183082 100644
> > --- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> > @@ -11,13 +11,19 @@ maintainers:
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
> > +      - description: sata controller for ls1012a
> 
> SATA should have been capitalized.
> I will fixup when applying.
> 
> 
> Kind regards,
> Niklas
