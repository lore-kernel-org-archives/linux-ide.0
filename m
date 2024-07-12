Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C87407B;
	Fri, 12 Jul 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794586; cv=fail; b=IucZOo5i2wr2QRiV//Fb3JUSI5thmZESyN6k3cOkpa6HHB6H2HahxhS5mzIGges4Ki5POtNKlx0hO+mrIBNDd0Fjer1O0liCl27VkHehqO4mBNcjetfCBsmnrjY9SgGy6RXwcpqdV9hUjIKa2W5WmVfrel5x2PFh2CyBQo8/S0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794586; c=relaxed/simple;
	bh=Su2KfeLtplpNHaVO/iFXHaZi545X+ELM5wiEdx6gLmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eZDMUrzq9ii+yjDRpnCIFsAtnRnkmNPBE77JYn0J8WuwWZ0Xe6831WZbTOVIvNuacF5lGcwfjWHqo5zSQdhvSHWihyUlsCaZa4yVDNI5JmKKhA6TgzbHhnD32+nv5/koug9LZEzghT7csDTPHx/IV72A4AIutl5X1U3E1CvvBRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XTWohQ+J; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XTWohQ+J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7ta7phpQZeFCYmE1own7GETq6HyfxKfLGjh7ltc84JPHT1nrP/S3yJIiGnL4QlUsZfeXDfHTJitXPogwbYBguC76KYszvT4pZrJDfBqBTUeLpyIayvKC76wZJGfjeFpo02szM2K8oKHnR1AoqRR8+C6TZZXqFzzW7LczI/wtEjt31IAdM/GPrLuNvbk+5dhZ33DFpc1Fe2fTMubrCei/cLX94dtAxOEDFuUiZnDrC1C2jwC8Mk/RE+nbOGNyX25Pj9r46izKd3qbFgan4vWfiqJDvETNTMeDycM8DYKdlm//Ep77YzgtyQ1iXnyk/HOjIogUt3EgVeOHog11Rjd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/7HyIgPxS8pP10ecDBggiYqFOa+mvU0vJEiIjVKYww=;
 b=EJLnUhY9pPjHL6nU5AIZkGl4xlKUQaETrLlO0sKmiXR/ePKQc3XD9YEAtI7WnxWnsSdl4NIk0RcO6mmoZwapbyH5bjBDi9H7ftQMsZ+99xb3Q6fTh5bvExxbwx0OWFfqCLYx0+M84bCF5XS2qyEuRf0/RjPUScDjmYEDtRm407u2VBrUEa9R2FvXrFg2o0tWkz9JcWVmTkvjQvgGME4rbWLyocpwfqXwOKiMvkemU8YBvXWtIrjtGok0DbKtuXhuh8KHqcFcE991wclj2mA4hXb+Rj2kwR9/+1ZtaroS8u5KXms6SbBpuuhNheHTmO6CRqkwpvzW7fyPNA+FTV54qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/7HyIgPxS8pP10ecDBggiYqFOa+mvU0vJEiIjVKYww=;
 b=XTWohQ+Jdt7SmF5a6Kbhm2Rl0syD9/+T49vtS2wYKrzTjdTq4sZbj+38IpagB+D9ydnOLeZ/dwrnAaos+GF2PFLXAkzEj1NfzFV1edl3m+V7lKN18A64RqbprKx9cLIk3Xs6jzUFyz35T18llnHxh17h8mJowheD97yTSdVtAkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9486.eurprd04.prod.outlook.com (2603:10a6:102:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 14:29:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 14:29:40 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: ata: ahci-fsl-qoriq: add fsl,ls1046a-ahci and fsl,ls1012a-ahci
Date: Fri, 12 Jul 2024 10:29:22 -0400
Message-Id: <20240712142922.3292722-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: e67930b0-f42e-4604-76d6-08dca27f10a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EUGjAFmwMghst/GW8l0WdirVuRc7qVR+nv2uNPFz78o+XvZewPkN5EuPLuLH?=
 =?us-ascii?Q?XoCdCoayaWJmpQcrTXhlpuNbcW3G9oxqSc+95lRDdyHnYIhaLJvYFkEtZ+DV?=
 =?us-ascii?Q?Ef45Fvk6Mzi3CZJL1naFb6UbRs3dNdlHcquXeZ4eavSXphY5Av5oFZ9zzEhn?=
 =?us-ascii?Q?vKuAJuVGPQVH0beqOarG6uwx71CFTBUv7fMBi63UZo8ywKeMHwmdtyzb1B4j?=
 =?us-ascii?Q?PXxbv7a4D0vhe17P0B+cZJ0WARMqsB7GQeEpyKEgxda+mg+5bUZzq6CEnA91?=
 =?us-ascii?Q?GAiZ2/QRunlaVcicu0+TKOsIMfJUbhtiGejJsM294gs3iZmivdQP7j4v0ExI?=
 =?us-ascii?Q?ax+ommivDkiRgN8Zq+cYtLxs/T6lveZUZhjMO4Ezb7tEzW7Ak188DxMl3QNT?=
 =?us-ascii?Q?V+/ZzQDQhoxwoxyq9i+n4u/6/2zLXC49E7yiUd866KnEYPC64uPaolyQLVah?=
 =?us-ascii?Q?okuuzGcCi52H3dKQE4NT4xcW8cgLu798fODYfWNq1tmRUalmhMIbuTcOtqFq?=
 =?us-ascii?Q?O0ZPiroBSTsgDA1DcmiMkg6qdmH3fygGiF38JchwYy1HbHU5oiq217B5OK4k?=
 =?us-ascii?Q?SnJMVUxwME3Ge3NTsE3bA8GadRkflE/G+R4XVK1r5oVg3zSVJqLtOxjvX2L+?=
 =?us-ascii?Q?XAam1I4xsmKzY+vhIrBy8Hty9//eRoJ24hXGCsdsSv7adYgMJOfLEY8Z9cbT?=
 =?us-ascii?Q?IKbImcQtD6rCugduif+67138CDLtPJKzb9XjOMnjRcGILk6slftfa6y049UP?=
 =?us-ascii?Q?33GM3tuL3ursjRPI3W+Ao9asc07SnaCUChq3kx+brT98MSsATqnS6DRKuRa2?=
 =?us-ascii?Q?EOLML9OWRMZJIQYaqH+g9AFZNjUROex7fPk+/pBGlK7apFNNabuzjB0GF4xN?=
 =?us-ascii?Q?mEorA6ye18ianfsesd19uuriQP6yKjrfSK1qmalVZBxixWitKKgP1yphh4hR?=
 =?us-ascii?Q?6suYilM3qAnBTLTdOifqCnw85LJMB5GfIlCVcz6avokilBWb5H+CmEKFjXNC?=
 =?us-ascii?Q?QF1A1Nws1WrOAgwN3Xq1vtFPXF5Tv1hOZwxDLeXIxtLcSxa/oHjKnc6VTC4q?=
 =?us-ascii?Q?owZCKX+Fjl7jt8h6zGQIkpUWPBt3fb/agMNqtq0Te0X5xvznCu4GBWNoSvAi?=
 =?us-ascii?Q?vCAjjQyjpyUY2ao8f84c4hjtMdAfEsl9l+RJZTiF5TkBZkdwImlzGKqw26tV?=
 =?us-ascii?Q?3/83RXPhUwTg6pSXKpEHVntcXqnhkNgZ7bfaKD8ePe1AvmYyDQe0HiCMbKJ7?=
 =?us-ascii?Q?MqR7WNMfY3kD0ZSqM50sk6HexJ2vtEbHDEa5XQ8rKseiaU/Z04W+/baPzZ2q?=
 =?us-ascii?Q?PzIPRZYYe09z+v6vqlW8H0Lj+jIvYhjsqYyMVY78TezbTzj0s9ddRF1FqqWi?=
 =?us-ascii?Q?u4Kk8zAJXYL78WYQd8Xnx39F73IooxcqKHIYJW/JHLXzjlusEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pc1RoCVsYcEIyteVCpLTTPSBto4PtUA4sM5/czkOiFqPYJNHIQlWOf/svRzZ?=
 =?us-ascii?Q?Wu3/QGcmCJ5rGb3LZxunQISXjpJsfnf/mw/Iz/S+DLVW9sJS1WRVkSURLGhl?=
 =?us-ascii?Q?KlfIlL0AL+fvLa5TglhYIdygtw3kjpHNL/+R8Dl+qcdv4r6/cDwNBJt4vrYS?=
 =?us-ascii?Q?0CVH3Pg5zxOkozlxfW2jX5kFHK1ATPXf/rlxQ4i/B6VPPd38Nmv3Ykc1wnYi?=
 =?us-ascii?Q?A+nYOvdrXR4ohb0A24F+NXrQwGgOetMm3tNp+u+Jis01Ivcxh9TGfUJFX6VN?=
 =?us-ascii?Q?yCvzHwUh3I4jWExPKOeak4XHU/m/uKQaSYc3vzgVB7CU9NIxJYpFuS2SuSSR?=
 =?us-ascii?Q?YreSIO7qIUsMiaZ+UHK5m4g7yHj+X1kSwOVLGLbqv2oFI8qgiEdTacwu0kxH?=
 =?us-ascii?Q?5l/pY0htaNvvRLmjrOsVutPKYcipWbo/4pN4TMkN8JqdML/RgkmSHZAtgw+6?=
 =?us-ascii?Q?JFGWRRJjLwOYGSLRBmtszF66xIBoolRTDq9x8C0T0YatycMQ9+2ECp74JgUO?=
 =?us-ascii?Q?LQwxSaiLnMaKt5edSk/f4EBmdsEzVpqEb4Wh13fKZDBJvQriv0EA4WOG158c?=
 =?us-ascii?Q?nF/QtUX+e7B9XHWDer4WAWhgXPJQid5B+15vytmOpoE022f+r3bIgKUB2EKw?=
 =?us-ascii?Q?ATFvNq72PxYeh0/ZBPa8kkbfvWiEK7s+G5F6GnBSunJ+o7o6gBi0JOu+Hacb?=
 =?us-ascii?Q?7u340CKr5pW640VO8W+zPTKPchp+o5ES6SIlbucwqMXVsmFd+lkE7lEJrk2p?=
 =?us-ascii?Q?0Dvqb/NH3x1YukyLbcxrIWzJQBZeITFb++f3T90zC/5p0ZY0hLNVdxwgkt3/?=
 =?us-ascii?Q?89VfufVoc2f6DGLeh06mDuGm+XZ46LY6Z4nUf+I816H5rq4ztuhPILlMjaX3?=
 =?us-ascii?Q?Z67MZ1OEvL/w5XhKa2NQjoOWm+UBNzait1SUbZ4HB3u6t11/xL5d91miuHyu?=
 =?us-ascii?Q?IPuFj9e2UP8Gpbz9VvP1ot2vs2OgYsEOgj6V88eZcaamFD8F57uVH3wJYXQA?=
 =?us-ascii?Q?eCLLIoAWEpiwAXz+8o8j2VJKDm9kbk9ipUHVbWpxl8egAFtfcBbWziiIxNI0?=
 =?us-ascii?Q?17T2AoaH78U3FOeAhRszi367h3vkXynQQ+Zv/63XaGYorX6cUYy8yc2TiV5a?=
 =?us-ascii?Q?bKh/vBwlZeOqIcpLMzka1V2opLq7sWkn8hjNv+tPveQ94hA5LhQ3Cc8591TB?=
 =?us-ascii?Q?8C+N7Qb1IVfmLdgWNuhClcnOV+EqUiMmewdN4Iahu6h5SGa8JWYYqFSxDJ33?=
 =?us-ascii?Q?1aoXyUX9TQ9NxS0kzdmbANapIwCJsYakYx4d4AmT6KHn9Pxcp21EaXB0wLav?=
 =?us-ascii?Q?XGnEOhEJIDAgetf+YPc0oIDPmQYiZrlf8RzPkA+ofhkDIB4lInB2wj2BhG8A?=
 =?us-ascii?Q?EcMOacXEzt8d8+MZNN5Kw3fj6sdAB44pspszgHfMngOZS2T5ZIPisHWpy8Ui?=
 =?us-ascii?Q?t1vqyJUga0WgIjuUs25RJLDNtQ0wEjeUQ+ZMyKvDWsJlAOTaMyc8YfcHRttU?=
 =?us-ascii?Q?+9WCrh9GJFq/jTaOoio1fnEA934x8OFWbAknCdeombvYI1PITdrvCCbqi2SP?=
 =?us-ascii?Q?vh5xoGPKf7VJyjUmbQY7xKtdaV6/WNKA2gERUjqV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67930b0-f42e-4604-76d6-08dca27f10a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:29:40.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiErfy0PUjQf7jC4whbseP4voSG6RTF3SNTxa5cgQMq1nxDmwSHr2GSxtBT3R9bwoMSEWx/tykZua9/Jg+N6ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9486

Add missing documented compatible strings 'fsl,ls1046a-ahci' and
'fsl,ls1012a-ahci'. Allow 'fsl,ls1012a-ahci' to fallback to
'fsl,ls1043a-ahci'.

Fix below CHECK_DTB warnings
arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: /soc/sata@3200000: failed to match any schema with compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- rework commit message to show fix CHECK_DTB warning.
---
 .../devicetree/bindings/ata/fsl,ahci.yaml     | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
index 162b3bb5427ed..a244bc603549d 100644
--- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
@@ -11,13 +11,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,ls1021a-ahci
-      - fsl,ls1043a-ahci
-      - fsl,ls1028a-ahci
-      - fsl,ls1088a-ahci
-      - fsl,ls2080a-ahci
-      - fsl,lx2160a-ahci
+    oneOf:
+      - items:
+          - const: fsl,ls1012a-ahci
+          - const: fsl,ls1043a-ahci
+      - enum:
+          - fsl,ls1021a-ahci
+          - fsl,ls1043a-ahci
+          - fsl,ls1046a-ahci
+          - fsl,ls1028a-ahci
+          - fsl,ls1088a-ahci
+          - fsl,ls2080a-ahci
+          - fsl,lx2160a-ahci
 
   reg:
     minItems: 1
-- 
2.34.1

