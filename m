Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E717DE24;
	Tue, 25 Jun 2024 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349091; cv=fail; b=hDtGoa8hHiNdaBpBgisKFMUQxfBR1RgAuIzke8Ho2IPrrlTu+7qS3NoZK0rzvCpVkLP6nF0IBDn5erdsuwYZ4Qvm3MDb8Zu447e4guYJSCWZmDMF0f2lZwoI4NogHagAmccAEMnO0AcbRVh/Fe5m4RU3pxspNUUrIu/n+LzBvKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349091; c=relaxed/simple;
	bh=3ywklQzvOVTJb5aIVXWk7tn4d3g/O2twhMI5lUho3QM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XZj7HthWEeMc8Jnaqfbqoz7jbwcfKsZxbZJ7nFJZ/WP0hPq2ru0ikplXtbdvuJEnGAVhU64r6lBT08VnPJDmTbdaaFhZsRfKShaCn+RhFu565TrQyLDREUV+DOOUs7EfIYh5YLFFy2HOL/fvyt07GtEhonx2xBx7gItKLlzVLCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gRTyV2XA; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gRTyV2XA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iimINLUWnxX76Bj6ofcLDDwnF0GK0H51QsUD9K0cdY0sn8iZDi8jjh8LjD0v4XXdwxt8DaHs5yJfpWkjFtmfXdSKfdkEt5Bi3A5rOrLKax2To1v92UwDlM2B3X90mstPphF5CpkXWeHni0ea14Jy24mz8Ue2Y9kE7GhmTDdrAOhh0I9B0buoeGYKziY8sHdUxPtnv+DFu6JOeIyyYXN5P4wRcUH+gDS9EW9ifuxoPOe5VSKphdDIY9BHavxbVQY2pBXCZ8DXr6i9Tiy+o1MK3tYCdBRW24DKFWNiQNc98mxdifbHWk5hq1aj1Qc/HDofP5Xl4FKF9M8Q3bZ2qtdOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t63Y51v7beGEz0x4M1h70HW/QJAPElZF9OSk6QZLDhM=;
 b=HtLM0L3CgMJ5qgUzZOD4oWrwRY6VORFjebhjLiCPadoaMYpDbvUTcTqAYzPIDRRqD5GV+PfoQygl0ENoL2lIwT8x/pZ+Nwa7Z2X8uEKVdtkIRr5oppoU02TSlWOCT/EfnryUxTRIk+mK77N/Jj7iHU9p29Co3dNl+1EzeQeQu3tUzNFkFvnYWxtNHGZTYZL3MU982LaHzUK5kfIEURLeFKfze3Za55pbKuDFBpJAXm0S7VzZ4ZsoOOeP9r+R4sPZADs6p5UoRHu7i2LI+puHrm+UQTB5jTMEzux816Pa04jE+iSN3GV5TExp0jVh8wuIiovbSXYC1rCRN/mzRv/1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t63Y51v7beGEz0x4M1h70HW/QJAPElZF9OSk6QZLDhM=;
 b=gRTyV2XAwU3yhyJOOJkALAvsi4l5OIVZTr5NtpWjkpYW4s+kVeslUyAohcPYiN118tQ3TaA4OEHMJhsnXw2ksFK9f7UzB2qJQdN5Ujp24kT+1QYZds+sGoZX8qvQRnoWzCnMrcrKgq/+ojYOmonu6iWQZFEG076bgVn6kO7ZKiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10623.eurprd04.prod.outlook.com (2603:10a6:10:580::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 20:58:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 20:58:06 +0000
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
Subject: [PATCH 1/1] dt-bindings: ata: ahci-fsl-qoriq: add fsl,ls1046a-ahci and fsl,ls1012a-ahci
Date: Tue, 25 Jun 2024 16:57:52 -0400
Message-Id: <20240625205752.4007067-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10623:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b62237e-53f7-4973-8f96-08dc9559832f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bb5rpe1Tnl+XfiC3o+3xZCPFs5RtRTkVyMI9fr6YyOEHTuIWYXEOELPrhEhX?=
 =?us-ascii?Q?GxsNxk9o9ElSVWrKTVRV/wOW473T9muXvnmeSx99LVOPca6evjFpJnbp+Fk5?=
 =?us-ascii?Q?I9+eQnPjxy5lDY/2Qn8oh7AUtVxuWubbnZXZubcztBm6xzbJ87opV33ORVHJ?=
 =?us-ascii?Q?t7Zt2u/Kro8LD5QlJCaTfNt+xMpE43NcitU5fOkLyC3UXrqHLbiZ9EAh32Ix?=
 =?us-ascii?Q?XxKf2aIYltjl9Txvk17vifT+ad/cEm5QbFDO4sdpW3xluBocJv9QbkpTXPFv?=
 =?us-ascii?Q?LvIw61JZ4wjq3IJLO3WbUFqMX79/j9AsAova7n5dyeONqTdm8uKD59ZyVRnH?=
 =?us-ascii?Q?iGQfPEpnLuPkbuAkse0j+Vxr4wNh93UnQx8/Hk1tC6aJAAwmPTzZvkCInREk?=
 =?us-ascii?Q?yhxGrhS3J6Ox2pkrbl7DPf7dcGMrc1WJkdG8F7xkFSdfF6F4HdWIiS3FZ+K0?=
 =?us-ascii?Q?p4LA0jie972EJQ7Og4rdAEIj3wp5gfAy0O2oCVCyHTtbQOW/+EqSj0S+uLg7?=
 =?us-ascii?Q?yBhX0vDteIezoZy2l+Fpl5hjpynOzvsMkLO9iLCUMVMaW1Ju2KhecQleQEfc?=
 =?us-ascii?Q?1MMjVBdulFTAGaFPWnAJ3bwFvpTOZVkJaI5a94h7G5t0F+NNWNRfZrA3376s?=
 =?us-ascii?Q?o1mcCPZ/Hxr5E4qNwIspK0A1K3IgSHJYJ+u/zBdeAgtuZFI9pgD9NuzyTMoc?=
 =?us-ascii?Q?55Nx7R4ZHSdBeyuwsBfeM45Qt7k6v0EYjOAXbTtPcvMXUr3BD3jS4il+JCZY?=
 =?us-ascii?Q?VqzH8PX5uTgjEXG6N3bcB+MN/EBWURrsSGGVF9R9Mu0VKSpkpQ7gpZYmlynk?=
 =?us-ascii?Q?jjzflJY7k+FTG3B9jerabYbeM8q+KwTy32xAeIk6f9Nzi9bTFLOq5sqltN6n?=
 =?us-ascii?Q?/B4v6UBSpdb0vys5rXpVLf48biXzpM+pxIF8xchsqt93wZy6vOp3AFwAjZrO?=
 =?us-ascii?Q?A5gOh02toU2f3lki0JHSZnwmO9KLexE3SXWVI/KaeMiG0zb7PjLAjodQWtGP?=
 =?us-ascii?Q?xLmKdrTnDlM5cHlecG5TROhRCrklKHcL+ayzfsLP95CurzypEd1iwrbwvlzA?=
 =?us-ascii?Q?jFiHvw0L52PosgR8VHrtjMdBv0cXv2ww+UJWOqZ0mnVMx4iOVC4MzYLIn/rw?=
 =?us-ascii?Q?+NUiDVjrEB22DjNFKOqCIO+pam1mnKCTcnULSQpG/1ebrdfOVN0tGsvnzniR?=
 =?us-ascii?Q?pCMOlCnUKpFUsaROPygdZx7Pgr1/M0XG7os4CCNctq8x7szD52zIA0+QoRnx?=
 =?us-ascii?Q?0lmHtguoRAccaeBBIvXS8h8q0+68BhY01Ooww7qAWpymH5dg/LN/nf4x/J9w?=
 =?us-ascii?Q?MLLm3tpHBiy5FyUTFv8IUVjVqqy9u8L8E1J+GBAN0STC/dwtiW1gtN8wpSbI?=
 =?us-ascii?Q?1bqpKvhTaNoZy5NUeTFgRMcuTBYmlZxdyPzdqw4TwRoMDXwLmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pPQHeictuyRGLXxIwDgcs/iNLy1KqbxgUzTLvnwzRvI5kFuWB5c3TKvGcUis?=
 =?us-ascii?Q?a9G8CTKiTRGBPnAB4em71MBgnddbYHy7bSIzqOqH728qM+e5PqGHfJ8Iu71O?=
 =?us-ascii?Q?hKHzU0aHt9edXfWWcd8mfFp61zqs6Vrx2w6qHjrolhwbD8u0ZgOTANqRkIXc?=
 =?us-ascii?Q?vcmjmIS2PwowSuhW9/7CSJIxpf1P9OYNpdPleqpIkAkEk3B97Om5VmHeHsEI?=
 =?us-ascii?Q?yZykXOFWY+QXtfM5RwZXJgICcsf+AXAeN5uJ+MlUsCA65xeaC5ne2wUzuVUH?=
 =?us-ascii?Q?Ej6Y/kOwjg0GkKJbaSL5Gv4eejBvn1fY47x+f24YGSRi9RxCFEHQu+lf5CZh?=
 =?us-ascii?Q?1NStDlJjUMtK9QpqyiqnGU3prAGKajtwI3qur4rx0eKen4eBKPxTegQhmpPM?=
 =?us-ascii?Q?OAZmq05S36JuapnVwqZSbAV1wm2QHf5rJXgmS18ZQirImQ1Wo0djRui0msPx?=
 =?us-ascii?Q?kXkCkcy9obUO+b+9CCt/pqAp2ixwhy8QH9fFnfnu6wf6i3qf2Eabfe+LBlwC?=
 =?us-ascii?Q?htxyB/RZfhsBsbwGItQjRkffRe3fjTBeqJpXKtz09wXCaHmH4psAZ7+cIrWZ?=
 =?us-ascii?Q?uYHvJIxQ/+Oqu0XU5NArjV3IT73URCbv3gjxDjzxTgr9zqNkn4tDaUtQvckL?=
 =?us-ascii?Q?3/WTlNepNrewJ5XCG6ShsV+5WHT5Oirrd7QIDV4yVrPU161bxr2j2SISYaBF?=
 =?us-ascii?Q?iQeZHvA09bq+ijRLpMnsFOnqMvcTwxedDkShqgyMAd/s/eILJoHFju4Fexzi?=
 =?us-ascii?Q?kvHMobgmjFamrM/66illVNz82x8oUTDrU003acNIJCOBPgJoptMmrViG2cTO?=
 =?us-ascii?Q?dJYlQ88aXGEtHhIGD3L+AJ7UCb00evAOa32ihInRPjdrALrqZ7Zz9jcvRO+a?=
 =?us-ascii?Q?68orI0yPOMBreGlWKSfaD5zjKJc64JFCxx8Cj0eTMnow0bCt/ftWZeiBZ6L4?=
 =?us-ascii?Q?R/bh30jjtuK7ZM68itz7wxAlWMabnY9RhxNBLOIs5VUCbiDoOD3fGfuSXGx7?=
 =?us-ascii?Q?fyZqJDseksTKnNYg2ugSzMztE6GkeT5Sjrv99QUkncmHx9ud3kyyqg7YEeRd?=
 =?us-ascii?Q?6gVNtHXLnJ9hepTinnfUukpJ7ocvFIQ4okHJU7gV+0kJNa4nwkE6QFVwRppF?=
 =?us-ascii?Q?FpvtlqT9AdQxBB0QbyLCK+l9Pd7q8rrpEcguJ7Ze5YauRSsCjETrfzz9IYGd?=
 =?us-ascii?Q?W+26up8tqC3VgEtpX1wpqNowEBpUC5yYbKOX1kEwtDOjgP5KC1d4XQgg1Ifl?=
 =?us-ascii?Q?LrZp5ouqnWxuRBL8Ad0rKzljrW8FdzXpFIocHLG7R5VEj4PWJ0cFRORKlHDm?=
 =?us-ascii?Q?qqrsWJEm/GJoqR44zytyWASUDk0EGjdKQhPTpy/CmfqfTkMcL6Nt98pZ1INd?=
 =?us-ascii?Q?NFuT9zHR4dNSAeCXuVSxNH82o8zcTBz+zzrFU0SiGAhOTPKHl6ycRjuqAsIx?=
 =?us-ascii?Q?Toq/d+Cegl98coSA23/+nAyMxSpnPYHyxhqq8Y6Voh4PobifjSL3/GXpeKL2?=
 =?us-ascii?Q?n6LiGrTw28PgtU5DVecApIQcFFpjLfnLeLtxOlZhNt7PpI9jvvh3I99qSiKe?=
 =?us-ascii?Q?eusrSHvVg+P7tTig0B4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b62237e-53f7-4973-8f96-08dc9559832f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 20:58:06.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m0xwZ20/lTnOPU9YA0Xh+snZ3wX2kzxtDXP2s+7OvdUwUYXAJxYJSGbERdWHWyOyg1d6dfRaNfal18R/KpqaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10623

Add compatible string 'fsl,ls1046a-ahci' and 'fsl,ls1012a-ahci' compatible
string. Allow 'fsl,ls1012a-ahci' fallback to 'fsl,ls1043a-ahci'.

ls1046a ahci ecc disable bit is difference with other chips.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
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

