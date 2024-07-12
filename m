Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCE178384;
	Fri, 12 Jul 2024 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800254; cv=fail; b=ggkBGq/4ogyXJZnm7braBSTGMSQmj4lqXMVArdj6iucI8rtZS/ggspqMlA/nc7ru1bqheU57Fr8n8JLma5xn53U3AWGIzv0z4nkFdsFvmGdBAOIQI8cLw62m8EVSFzf7a+33nHGA3BqdG5lyum5Y76b/XScyBK0TlbeewLJyo3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800254; c=relaxed/simple;
	bh=TeMgV7gBaJHtEB1Q2TpmaoqTSxE3B4vt8oKxBhIrnJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KbDHwO/Y8R+xI8ebJNRStBjjo/MchdSleCq9FghwhgfIza3GCiBr4dl6rnPN+t6JGGwARTuQ9pZ6VWMsOEVal8O8lXmeq/XWBAMsXnEaYAwg+s11z3xZDNC95xersyjjI7PA+Jw7jLiE/IVCjLFtGWwlAmUeHxjW8Q8TtGRmUoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qzotOr3C; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qzotOr3C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUE1BVBM0IrcyYbhFoGRS0qEL1X29kvWOCrbr/WBywm70oeMfEL7w6b7RzEpufsk1SEo02ccG3H3wfCTzjGmuT701r0br1JfGuPJ8D9hrDnrBv2PaSqubJg6AXdWbEMDn0Xzjd5vS10cpzO5APpyJvIT6CgE+1x5ruoQz9SSGJUEUulmFkqW2wDAqJiKm8Kj9hkLZ9RtfL/V76BMCJnaFuwn/dDZfEULmA06Hzluhx4mPrJW4j1140lpH3EiZakac7W8d4vzVD1jnV5MIpTUX9DDLAgXHR9UkPU49I28gEVMu4cYphxVrbl8fjwKgdIccC8U+0C8hH3xlubM1WWK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Raii68rV9vt+Ewcx3OxV5GDmxJUukA/SGptLE+MXwBs=;
 b=DHK1vMKcZc7+DtLCogO5niFyTxx9FoyOGb8iv1BM2glW6xg8qlD5zheUeAg3TzmFcjYNC1GbhQtKqyEQq65D9HIf9olWia9c/wr8QhVH6jfGm+GxKkjJ35K8PaW1UuqNfiRMsv0TWzEt530cc3JYdv9o026PnzJM3xpMfVN55Qy6jYmfjNQtxW0XpVUM6xGMtPvgaHyjtSk+UhgrBqj0cwEZrih07RNvh1tcerncqR3tpaO0ERaBj+IcXxW4gEGMf+piDefHd43l3J401qbkCJhAXM321NT1ZZKlFO1JA7X7AGGjSqg2mZpns/l32GA28pyf44enXzSzm/5tmcR1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Raii68rV9vt+Ewcx3OxV5GDmxJUukA/SGptLE+MXwBs=;
 b=qzotOr3CfkO4G3iaHUiAP4ImSYRIy0LpfzhXqdL0PNuJNT6144VGIdI/Zrh+rgRyaZwAeuhi6fAfLiPxRGWv3WX5clXX2vUQVpDI7DqJJkb/l9TfHLtUDEcjYTGDN7VMLiaZoGPwZ4lBqrlLnxODKMhLvZyosOnjwiErXCzdX1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9322.eurprd04.prod.outlook.com (2603:10a6:10:355::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 16:04:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 16:04:10 +0000
Date: Fri, 12 Jul 2024 12:04:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: ata: ahci-fsl-qoriq: add
 fsl,ls1046a-ahci and fsl,ls1012a-ahci
Message-ID: <ZpFT8mdkQTrixIvA@lizhi-Precision-Tower-5810>
References: <20240712142922.3292722-1-Frank.Li@nxp.com>
 <ZpFJhk_HgQhGAQMU@ryzen.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpFJhk_HgQhGAQMU@ryzen.lan>
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e835d7-0c16-400a-b000-08dca28c43f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r1PGrZ7iJILn81M6PYdVSg2LV066Fyg7iIp2UuBUcW9/4p2hN2Gnqp6+vMMG?=
 =?us-ascii?Q?apd4V1k2vMMERnddqJdrp73aj9sNhJIOhwKeqETW6VItc26c6iG0X3ludDco?=
 =?us-ascii?Q?kEm/yVozQu7yBHIVe8ILkEydEXuycxKoGqT43pcYQ+hKc6Ff3yvvYmB9Cali?=
 =?us-ascii?Q?fBZPspmy5KA6PgUxu8CRuieAgMtWniUjLBbH/tN20SvtFIeWmHeqb3G8mALV?=
 =?us-ascii?Q?G/xio4FHY6+ACf0d9M0zFfxqVNxEDqvfBHUUjTaXZDGCAeEXYOCEUmKQait7?=
 =?us-ascii?Q?hExCg2TnbvuSviqXvUSmP31YGbD52CXN0zRUXsA+Ce4vLZmbdBi810RaevdR?=
 =?us-ascii?Q?OZFPjySM8zrKauSldpjmgPMsDCTIsakufhXV3tUewapvZY6Q2OZoMd62AbD2?=
 =?us-ascii?Q?lGqJXUr84dh9AO40E7foBV7dldLZ/rLAnfwE03Jkl4R0QXpoOAAaavLs4qiM?=
 =?us-ascii?Q?FhryGulq0rrxS62UXqfP7QisYt99RfVx+QxGaSqIJB+y7McnFn4oamyz2Hmp?=
 =?us-ascii?Q?NELxbXgVukuqZ/L+rUuafMGOVSQ2i0JiNtvFnBoY5JaLMN645/mnfXgSPnRN?=
 =?us-ascii?Q?rfWJTlOSzB3R8qKTRu7fqtQ0fni8qdatVtjgFjlY/KLc44gTJmkpjJkuvRUs?=
 =?us-ascii?Q?dBTk/Po7pEGqBP6ymdr0klMRkG0D9eACr+KdzRkA/y/ydbZnGtBtFEjockIQ?=
 =?us-ascii?Q?FTEWvGqTOjStiPneqPF/tPEnswB+/krhMhbKUS7c6QtS09r/aHVfnsvhX9X7?=
 =?us-ascii?Q?vj+aU9M+FGEiM/uQ6+gIBwKMU+fxoxkuVIdaN51hVZC7r4AgRN8Xe6z1lDwl?=
 =?us-ascii?Q?MMpQCwH1XE9Jo0Nx5OsvXMfuC0knFVwYjO5jkqPpuWcS3EEXvnWICxw6gAdx?=
 =?us-ascii?Q?PcNotTWjWpqXMna0ZyHla/mm6j1w/b8eu4kTPB33yK/8vlYy/wesltuHkv+P?=
 =?us-ascii?Q?/iZlxcwuTrYrx8NxOXV2ZOn4Su8SF3mbFqhy2rfgPuHmsy0Sj9mbVgf1/Vmv?=
 =?us-ascii?Q?1+WEyT2lRS0T+6QpNzmNTnAtB8Ci0waZYV6kZdTxygB7s/LXrUVSc/NiGsFy?=
 =?us-ascii?Q?gBzOWmZhTn6/XXJOHvXeIgiJF0D+SwLGqCOsqRYTRP3sQkkJqUNHBPCqHuQD?=
 =?us-ascii?Q?J1x+vKS5bPqj7t03yFz8gIbKetAVF/WRZ3j7T0oGwlirFo2vuuFk2zhhCjoM?=
 =?us-ascii?Q?KpO+CGsHFfPQqFJspW10h2BlgdytcvRPT7ch1kRikFYAfFOz6nxC9SpihvSD?=
 =?us-ascii?Q?tCfEeL1lOaDi7T+tOSR1lG9A1gIAMTFGkoB2IkazndGL+z+KyhlKRv+QA1kb?=
 =?us-ascii?Q?P8f2h4se/wjfd+EBCMJInzOjnQL56sL+nyqMbeqVm+SYzJP3qvY9au1LNZRI?=
 =?us-ascii?Q?ytvqTuIpV51kzkjvhe9fv8Q7ZUsRCcBv6ccRn0+kLOpzzNL5Tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eu8hjH46I0QazvdG0jtIrqb6vjSwH5Zl+m2niyOKPwa3r7oQMUhCvUur52ih?=
 =?us-ascii?Q?rgV/3yKYfqwasTVuldrExGkVhp/BgGsrqy/ZKaOeJKsvpeui9EnzEVFwoPRV?=
 =?us-ascii?Q?Zgq7tfcBvqbsgK0/aF8NLyuQgblFYafA1l9w65XE9Z9OXELnhuiMsg0Yp9K2?=
 =?us-ascii?Q?U6lV6CiRkJamCVRjFwN3SPXPDal4oHTxVFCTZ2i8L2z5ICrd9IIhYUQCVhaY?=
 =?us-ascii?Q?10C34qHmTsLhmUAoY2nVll1jcrfa+ldEUgY/QtnUKSBya1aIze4Ki6DoShuE?=
 =?us-ascii?Q?TOvZmzTo35O3pYYcThTKMjZvrzwUsEbui0UnTtS2zTaRmKzDkP7VeR/lRtRk?=
 =?us-ascii?Q?aPO++p+DMpcE+wAO7EbIfD5e0JtNNQ/urhVN4N4H9fud9NrKfVqE8EAsdy2T?=
 =?us-ascii?Q?lOKmZ/XbHYqjXPqiAJjAPXdqyMV8JPOg2bWa7ZR+tWFJPKDSmYVotrpeKAMG?=
 =?us-ascii?Q?K56+fIgTrzqmlU10xkf1ikdeg3xmiOZ1kTaaOjk2+62kJ7Tw3qInraDrA4t/?=
 =?us-ascii?Q?jN8kW7Pgs6ek3N4sB7BWKZg8LDiy9Fb5c1WaTVyPN19oCQX0Oy40D+o3gxNo?=
 =?us-ascii?Q?DIeMQO+Vd5KUjV/tBKlkAcnaND3J/RmiLAJ7yvfQmiboa3MW3P880ibt2SMF?=
 =?us-ascii?Q?bGMqykaT0L0jstvx9b69Ebh+SSfsnbiIyoEJOK41xOey1Pv1IO1+qLW4aJRm?=
 =?us-ascii?Q?YReHuQyqoRvKcvQVmjVdRf1IZsFoiv6aJ+Y2bnE1/v8IeXbNI/T392XQSs5C?=
 =?us-ascii?Q?1DndMP1Y7DhtCeIj0aNcw1QWENVeV0b4jNVBaiKc7jVPnVcjsDq1VVDLREqW?=
 =?us-ascii?Q?se9VhHQ/uS5asGSLSCLSCdiUUfW/CMy8ipG/2KgDimFhFT4Q4gc3VNpBu/CR?=
 =?us-ascii?Q?7JTcfSJ6/sI0zxhrU8LSHTbwFm2S/7biP+FrAM4RTwopnrx2Wa+VC6qgEoIc?=
 =?us-ascii?Q?Wp59dCr8yHB33/H6Mul+8OFX/nK7NS4+tv2MvAisUZ6ckVlosPHK/PT75oe2?=
 =?us-ascii?Q?KbHXxrbXo7BiSbSFYJ4WZa0RHd9P33JTgj02mVjvQjNIRz3DzKNZ7tWEj+jN?=
 =?us-ascii?Q?eZihaiAA0RFNB2m3xQT3gBApi2LJuBClOmi5mMiudlFVfXCfoQ/QM14rhnU0?=
 =?us-ascii?Q?sDjnl6Xo/qz1XrXJMvDZ1X6pYUMzSeCdyAtPylf7LtMtjxp7IjiSjCULlBGj?=
 =?us-ascii?Q?FEKzRFSM8/8VeSJT3i0WAoAfzHwC9wvx7hpmTnJsgZlcxtHifrS9nv8j2MJm?=
 =?us-ascii?Q?g3aEAoNYwWK338bYFYQLLbFlaF2SBI2Hma08zLzAWF+BakDkzibA6h0ttDfR?=
 =?us-ascii?Q?9gQ5PQhNPCnEZOcU6422CcciDerhore+IpqmD4cvba+wQwCODulJcSCXuvOJ?=
 =?us-ascii?Q?iJV0ohl47QJi4FQgDTUEAnUX1TFq5vMOsJofbmWEfj/FCoBSBb1BK11ErIpJ?=
 =?us-ascii?Q?CS3H6BbBDbsv+bh0hgjANgG40oU7w5aOSVruA1VDEdo69NH81+th3M+p5IJq?=
 =?us-ascii?Q?V0lpSPECJOLoe66vFvArXxdn7Tdgf/VbAbM/LOhnuVSeio/n6WvYSBndDl38?=
 =?us-ascii?Q?pGcYgk/eJwf93r5Se3DpHUI6i6kfBV5WPbAigX6U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e835d7-0c16-400a-b000-08dca28c43f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 16:04:10.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlxY8S1GEE5PDYRuI1lbcjhfe3om6j866NigL42z5tX4bmGaSWbCrePEingT5pqiKOSzotTSFwy+1H3dPdm8Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9322

On Fri, Jul 12, 2024 at 05:19:34PM +0200, Niklas Cassel wrote:
> On Fri, Jul 12, 2024 at 10:29:22AM -0400, Frank Li wrote:
> > Add missing documented compatible strings 'fsl,ls1046a-ahci' and
> > 'fsl,ls1012a-ahci'. Allow 'fsl,ls1012a-ahci' to fallback to
> > 'fsl,ls1043a-ahci'.
> > 
> > Fix below CHECK_DTB warnings
> > arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci']
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - rework commit message to show fix CHECK_DTB warning.
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
> > +          - fsl,ls1028a-ahci
> > +          - fsl,ls1088a-ahci
> > +          - fsl,ls2080a-ahci
> > +          - fsl,lx2160a-ahci
> 
> I think that you should add the following Fixes-tag:
> Fixes: e58e12c5c34c ("dt-bindings: ata: ahci-fsl-qoriq: convert to yaml format")

I am not sure if need it because e58e12c5c34c still not release yet.
Needn't backport. You may squash into e58e12c5c34c if you like.

> 
> Considering that the commit that your are fixing is only in libata for-6.11,
> and has thus never been in a released kernel version, perhaps the following
> patch would be better (if it also solves the warnings):
> 
> diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> index 162b3bb5427e..8953b1847305 100644
> --- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
> @@ -12,8 +12,10 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - fsl,ls1012a-ahci
>        - fsl,ls1021a-ahci
>        - fsl,ls1043a-ahci
> +      - fsl,ls1046a-ahci
>        - fsl,ls1028a-ahci
>        - fsl,ls1088a-ahci
>        - fsl,ls2080a-ahci

driver have not support "fsl,ls1012a-ahci", which have to fall back to
"fsl,ls1043a-ahci". and DTS already use 
     compatible = "fsl,ls1012a-ahci", "fsl,ls1046a-ahci".

It can't fix 1012's warning. Only fix 1046's warning.
DT team also don't want to remove fsl,ls1012a-ahci in dts file.

> 
> 
> This assumes that we can get the patch included before 6.11 final is released,
> but considering that the merge window hasn't even opened yet, that should be
> doable.
> 
> 
> Thoughts from DT maintainers?

Supposed through ata tree.

> 
> 
> 
> Kind regards,
> Niklas
