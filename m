Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E662224D1;
	Fri, 12 Jul 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810682; cv=fail; b=uy+ovAyvqpkoLJm/HcC6hdhzKwMDWnPgyvUk6JLg9lwr+DAjM3l21wm0ifXzlmf0VzGU2XuMGf3w95fVsuOgsxBUvqBYSQPr4grNbmkk86sg1eqiLBZZ3L/GOsQvl5HvpFzcptuqUYoQ7MwmATYVE8RN9iH5rCRZR2SHIASxi0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810682; c=relaxed/simple;
	bh=HuHafaRoM0M8pCdiDLe4b7w3FgtSy2lD/VmhSmN34YE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OedJd3JaXki6OwuDirorw1LwGJ3F0OXLUoQxDtuHx7oPfbVUCPc6uZ9v+IO/LNKYim6kqaVmKR8eaz10jlILlNoD4o4nByT+jkXJGw3SmFZBLhe8SwuLbleRs48bGyaEn6EpVMpmLFhDt76BXhMGg/yCp1mrgI7LfHsQowwDzhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oO7x3g1x; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oO7x3g1x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMvu5IjY8AmvLEzY1LRl7kCs8li/rboQnreq3p9fVtRr8WPtZXEKginUEDXpyBpEMJpi5d+0EwgNbPC0YU4tJ6b1UCE4yVKgg9KBXahKy+oZB41rUSBoYu1YBhvTQB5G1Ek8qdNf9VFXf6M2VflBTpqNkidSZ1kNpZbbbVO5be7LpCELdXwmXSl4Qp+NjogG/3+99DeJVoaZp7a4+XiYFvs4/yb7QPldYF3f5f1rBb4MOermSkWD8VdbOJXhBT/6khBMoT8LazUpDQ6rQFWEWo8TFUZhUBO/zFbJldCo14tAWmtyK3Zu9FBXAyXhzexftfxKbxWdAkBfvnJqgs73Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mFFeKbv/NHDpn3HFqRvUoC39WQiolBlh70dIYa5zdg=;
 b=vTJu46BiTEUq8VcZu1iHx2vBZ7kZld/56/qeR/eoiqMqiibLGp/4JVF16qndyoZ7GtQiz5vj9ViuWpDco66UOvmai2vIBwrfke4Sxe5ziAQPGdoSkbvT/UgjFHeyAu2Nk4CI809SwmVVG5eEWZXE/gTaYwSz9oT4zpI6iZwrS4jHlNuvb5+0FdgqC1kcudCnIKtJursldm3sYpeMow5fgVozPw+3qjGZPnIDCqWlVL2KK4aHOsNUjkGCC6Wu3XGdHUVlyuchQBoI+z0qqX1nSmuL3RdsTbE5hoF7UVc4CE0Kbip4zOiatCJ0NVMcHEO+2mdZ4SxJ3z2Myg0F6VSQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mFFeKbv/NHDpn3HFqRvUoC39WQiolBlh70dIYa5zdg=;
 b=oO7x3g1xYF6yk/s8h0GFHfrTKU39TCXZ9kyWYnTXfUxTfSx/FRuha/v8p4P0zVoDvPPW6cdRCrYIwET4u3VCkr2S5JccSB76MFVNKO2TUhHzKHP68NlbXY8DdaT2nWGIgvxhIOEM+YlqdNg841EOwEXgE8KFLXUIeWmt7xGeToA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7589.eurprd04.prod.outlook.com (2603:10a6:20b:291::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 18:57:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 18:57:57 +0000
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
Subject: [PATCH v3 1/1] dt-bindings: ata: ahci-fsl-qoriq: add fsl,ls1046a-ahci and fsl,ls1012a-ahci
Date: Fri, 12 Jul 2024 14:57:40 -0400
Message-Id: <20240712185740.3819170-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:a03:80::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e84b01-51b7-409a-4bb5-08dca2a48af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gjmnxk9ELiRu2o6A5cqqjEgGA8Fy9frIkxnxThaMxDbj4xj9uLzHcmKnGUP+?=
 =?us-ascii?Q?51Cia4xm0Symf83qkbO1lmDJCiYLJoc6mkhWj7TZYwreZHQJq20XnY+IRJqv?=
 =?us-ascii?Q?lTvPgtQJu58MZmgHbS6mJJG2TSSvrVbvz5UXZ6jGOn27d7WTlpyhmHRJDrjb?=
 =?us-ascii?Q?M6t2u4ZyzoEqHYQXvKrVNAZczEziAh77I2lP2Wj/ji383iJd3PP7w9R2nxtv?=
 =?us-ascii?Q?k8068k48vYkZDS3jiD8IFKTcZRL5LZIzeQAse/s5m2iRuKM2JpyKgzVDL3xV?=
 =?us-ascii?Q?duoFd+WainNn9DebonbKREFr2UFxN/LgYvYcm8HCo/xiCeLWB7v1mhYtn/1a?=
 =?us-ascii?Q?wokE3ImO/ZQuPog01MsvalFpLqVyCfT5Cr5CPSWCojTptYVJSM54l2AI9Sf0?=
 =?us-ascii?Q?urZoNAjpZs89VRzPkl84V4nyiWKFHYATK1fQA9PM0RLcZh7pGx5lNvVRGSsY?=
 =?us-ascii?Q?xIh5XA6rJZziEm9uPB+xmrr/nI7HIRDdju8DjeHTeHsUMoJTdfG9X8H5/ESA?=
 =?us-ascii?Q?LoHs3rkBJ/0fuO9rDCT65qC5IvkBcUTRf9E4SafhOn1VbTYhQgID/h1f3FqH?=
 =?us-ascii?Q?w1C3i28he2zOW2BFMJc0/fN+itzgOoPFSzx+Y+WWN+k9DOf9Z4lZHBsWsQ5n?=
 =?us-ascii?Q?ImcKSwZj+WFthTYAWijTk4oy5cdEpXKhW/YKQGNwOCXxz7O/Z8G2dyaKH7Qr?=
 =?us-ascii?Q?A/ZREgteL8j9T+iyvqXAguy3D7limapiFHQ6xK9Z2MWKQcTs0xWR+UR17r5Z?=
 =?us-ascii?Q?CKzoSNMsXMXfYCoHbfggMV8jMD6NsFzYD+yboNLnBHGVZd426aCs6v5CByrW?=
 =?us-ascii?Q?7088Bz16ZzsG3aJ9VKTprjWyIToX2yhozDxUn+zrVVoVLJLmY3qVr/Kh7gBt?=
 =?us-ascii?Q?RPehlypJycog5IJGV3pqweMm0lmOFGe5cvKrKr/R40vtiML5GrEZA/SrWqfl?=
 =?us-ascii?Q?7F5mfca8W79dFXw6G/AcCuaazPUpX204OX0xU90ZgEbTcYzaZCQevV87Trmn?=
 =?us-ascii?Q?W11HrFfastRMm3D9ls/TE/jTqKjppzOvfUZnELvWLDwW+Yfddl7AjUgoDTsX?=
 =?us-ascii?Q?99Su7N0V5yYLj9DARMz6zjhCjZJBcHX/5nbjqKXIMTwO2h0hB7ylHobtP3uZ?=
 =?us-ascii?Q?QVKas9WBsLprXy4PLcFvYGo1oXU36dqdGsDEV3or4dDTEttmCSyI3cK0kf3d?=
 =?us-ascii?Q?7OoTITTFc9Ic0koNQxOVJanLK5M+mb2RjRrdFH0jtebdcQU9ILhVSu5yDSzV?=
 =?us-ascii?Q?LqgIdRKUZRNfCmeIhyUSHbBtE/ljCRbo/dcaG2ciYW/WehiXe43f22QQ62Sy?=
 =?us-ascii?Q?zNOVDj+vQzPRjPwa93OufMr+R9Etzpbxi2yRdplleqqCKGAvPmOSdNNusPXv?=
 =?us-ascii?Q?fOBMZXbVBAauAoxjbjHG/+cjK5Pjwn/No6VBVakA67xio5NVww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6UVC76vbXY1FrauYqMoKGzu9p0QzG2qmJSC+moedL/ywr6QwHbDJjysFhDJe?=
 =?us-ascii?Q?BqThLcuj7SxeWJzBm0GWODEmc6CbiaB1nhYxe1wYjegSgS19nqMbqE79Dbj6?=
 =?us-ascii?Q?sF0U6ZgpiaVrMZ9zKMvQjQMkprUWQFAJEIBvevnbvHZpzcq0yXtkYvOMelCa?=
 =?us-ascii?Q?ehu0KEw8Qh3691DP7nLOZEXjjviKuDgzGqWvbVeZ8QIhv6laSx/ujNdi2YM1?=
 =?us-ascii?Q?IPZXGhfCNiEH7PeQg3Lfj3b8FvVIMiSvmaq7s6Y7LwJK/cxhBdDKWJb0kp7C?=
 =?us-ascii?Q?usjCtBG+VinbbdyHja7dZAtFc8E+EeQw4e6BYwCoE/A9qm879/4/kvK/AThH?=
 =?us-ascii?Q?hbTITgahcoW+HS/Pk+jMwvMLn2RZeQo841wwwCx8ajHlc0QZ3/j8QgDFfBxr?=
 =?us-ascii?Q?aSNzbJe/d7oZZ+QZauCeAYYxsTkONyBEEWb67/Oop0XoO+u5Soa06XMPtjBZ?=
 =?us-ascii?Q?0hymojSay9Gj8pzCi19D4k4eqfM4UwkcphMcTFuDIIxj0ffCVif19I4pdNq5?=
 =?us-ascii?Q?BNJRiLFSBO+8VTs8779ByV40y63oioPL477qeyPY/5PNAtAPfFf39ahv8hAX?=
 =?us-ascii?Q?KtaNKgxTI2qK68/LAhZDTs75YXTFdCDwJw3u0t9a4fWYIte/z053iEqHsbmO?=
 =?us-ascii?Q?NiLh5JoLRjuRlrN9n5X6SanBEtTdw1JQqG/JCNnXzj7mozWqfeJc5ZZ9tO9X?=
 =?us-ascii?Q?KmrIBmDFCPxe7WVSeOW9/6nt1+keeOwEbSvjdkIs6CxDWozd0Dpgnxk5nVLr?=
 =?us-ascii?Q?hCW0coVcBjmidbNNKBL3gKI4iP4+uoyVQlzlXFkXyECW6kH6jvbwBJQHptK7?=
 =?us-ascii?Q?p72840ybGWsP7EB/FtK2ibCx/+3xHZZakewY7/tqejPQmhWbUVUei3Bd1eNy?=
 =?us-ascii?Q?sM5CnU2G2fpwCg2hI+n2Fo1zeLNr4o9rMTAQUc530tQI+qNQCawUtgaviZQT?=
 =?us-ascii?Q?RxU+DFoT4Q4yB4APFHvGi6HGivXVyxzw9WQUShWfh5fYCgZhGrWRZfwZqWhM?=
 =?us-ascii?Q?U7+KXPkDu2AUhmhkxGSi6OgMPoTN9EvjV2yJ4wli1x5qykTviZOB/L87TEPk?=
 =?us-ascii?Q?yrYYYeWOp+W8Q/2ChNHHUz0S45NsOF7Z+/GA+0HiZG2J6yXIELJams7DzYDt?=
 =?us-ascii?Q?CbjbObHclIYvVRsV0ITHfR6gm5Dm/Qm8zgC5QFZT9w1PCQnLAKCpo1nSn05E?=
 =?us-ascii?Q?JrEytQ5DKBQdxm2O5c5YGTbwQvrVrg4uOp4C8I0daBlIWjPIptymv2876yq1?=
 =?us-ascii?Q?TarqRoloh9g4yyRHF2TX6LlORuvYnG7vkteRJO8Noi0sxKVggTbrlVRrGW5j?=
 =?us-ascii?Q?wJz7Xpg0p6DvU0GMMAt698atIcV7o+6oUv1XBugPSUfPmDhtTn0S5QlXh8Pc?=
 =?us-ascii?Q?2B3WqM1ZzS4FNAak4+UR+/PuRambhIGGSU8QFVjBqWig8TxLRJebbPncjMof?=
 =?us-ascii?Q?JmnGrUOZAuz7NKWKcOqJCFbNeFBMaC4owcPmH+uK7S4JuDHFg+IzeoWolBAC?=
 =?us-ascii?Q?rr8owpb+5LLZhf6HGx4SWr9NFksroKCbV2JTjJUPMTlBvXrE4rywoaYY8aao?=
 =?us-ascii?Q?56qni6Oy9hqSPGqd+PbKpbqnV50rszkERZtazAqT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e84b01-51b7-409a-4bb5-08dca2a48af6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 18:57:57.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2o+o/wrROBZNSJaA30kQwP63S8ASRZCfyCgrpSFE59ps9MjvNr7HRiAm3nqES8MhBRUQ2q+aig4TEBrcdIkr9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7589

Add missing documented compatible strings 'fsl,ls1046a-ahci' and
'fsl,ls1012a-ahci'. Allow 'fsl,ls1012a-ahci' to fallback to
'fsl,ls1043a-ahci'.

Fix below CHECK_DTB warnings
arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible:0: 'fsl,ls1012a-ahci' is not one of ['fsl,ls1021a-ahci', 'fsl,ls1043a-ahci', 'fsl,ls1028a-ahci', 'fsl,ls1088a-ahci', 'fsl,ls2080a-ahci', 'fsl,lx2160a-ahci']
arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: sata@3200000: compatible: ['fsl,ls1012a-ahci', 'fsl,ls1043a-ahci'] is too long

Fixes: e58e12c5c34c ("dt-bindings: ata: ahci-fsl-qoriq: convert to yaml format")
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- Add rob's review tag
- Sort compatible string list
- Add fix tag
- Add two warnings in commit message.
- Add - description: sata controller for ls1012a

Change from v1 to v2
- rework commit message to show fix CHECK_DTB warning.
---
 .../devicetree/bindings/ata/fsl,ahci.yaml     | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
index 162b3bb5427ed..b58ea5a183082 100644
--- a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
@@ -11,13 +11,19 @@ maintainers:
 
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
+      - description: sata controller for ls1012a
+        items:
+          - const: fsl,ls1012a-ahci
+          - const: fsl,ls1043a-ahci
+      - enum:
+          - fsl,ls1021a-ahci
+          - fsl,ls1028a-ahci
+          - fsl,ls1043a-ahci
+          - fsl,ls1046a-ahci
+          - fsl,ls1088a-ahci
+          - fsl,ls2080a-ahci
+          - fsl,lx2160a-ahci
 
   reg:
     minItems: 1
-- 
2.34.1

