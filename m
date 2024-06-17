Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628319AD5A;
	Mon, 17 Jun 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647382; cv=fail; b=qFB/C6vMyX6NtzY5U3YbeUU8SZIASD15eNSA01SSJyvoloH9PmIAa6o6RYhuFBIsXaMaOhVQ367xUr1nrk/5Og4H2j7G9Eg1KgSY8imjQvfGf9tSbYqP5Yvz+tfj1UZyDiygr+DyC0hsL2D+a42uq17aufvz5j/XaPVOaVMAleU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647382; c=relaxed/simple;
	bh=1sTDjxtBNCYgA010Dk3F/8eEkxfKsEvZRLCSRcz/n/o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uBhE4BrDFs29HjfSiyXbkxqA/yjaE7fyldOA3ZErgSYo8IH5MkyBhuAO8uwiYtD7aDHs2S/CXFkOlcVnGdF3/M9deQ5sDZ/lQ/Qxexf7EiQGUHMcXruzEvYrNp9c1IQRBuebA09KYYwkqrd+2t5iGI8l9osAoC6mHvFyM6Buh5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Oc8S0ZQP; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oc8S0ZQP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fykxPq/U/nl8Fl2QzbHBjJwrBtYarNvll3ey+Ze9emc2MBIptu4mcPVFAM3akuVDKDVUxamWby7NwJFSW/15T3c7ti48TPkW5/5XOOBoIqdZyJLO3+HHPVOhKdmmvKOFGgd8niI57R7dF6t2tVlmNwArdVxe0gwFWi4Gwg7jGSczSjkXrLMMtNprnlSjcTVz+DXqHuuicHJF3JQLRW4gbWSYem5uZJgzoTSqys4FGbdR0/1IeSmOg+KgXJCl/z/WDmHqIJOQuHLCU5wKolQ2bONfad6YXzH1WaWKs91bvFfHbXiipgEBkNzoVh/Pw7EJXrxvvt70TcGtxHUiD5IfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZhflHKkhPx1x+CqBA76QfJJ4EN9TwtIEAuyXSjIkBI=;
 b=oevF8XH/gfifZpwkn4i8aOL8BsY3arngEiQjRkBPzHOJOUW8lNdsxv58+mHiw/gJqaNB0glP8AzkPRePp3YmotB7wPB15HASm4FUP2IF2HEwcGycj3niciIjMzIzPxs2Ok0wILHdlY4xhEG2hI8iCjxa9YeNWUxifO03gudVfCArEyFdngj7UrdNFAU7alExjgFz5sinLVkkHxYvGA/s92av6qyM/t1y9DJnMgg+iPXIKUkyJ4gjmVA0RWWZcCuKR+K4JjhJTuebKHieIvGViKZUfJCeB338HVvzhFl6cppsafPhyJMSTPpWMcllnO+5F3aRR6YeBQfYQyq5ODfs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZhflHKkhPx1x+CqBA76QfJJ4EN9TwtIEAuyXSjIkBI=;
 b=Oc8S0ZQPB9G5lG1al04zf260UMHMLbTrf/9GIPrPT9Snmerd23i3UYrvJHNl6aWSLTG4QJQvGRGd7p/RegmPIWQG4nq0KlDWNlqBFNMKN+vvEvUqMkWJZfpKGWMGsagzspyPNKfIw0QXieHZUKgAAK63g6mvjRPaJbf/GMIov/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9972.eurprd04.prod.outlook.com (2603:10a6:20b:682::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 18:02:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 18:02:57 +0000
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
Subject: [PATCH 1/1] dt-bindings: ata: ahci-fsl-qoriq: convert to yaml format
Date: Mon, 17 Jun 2024 14:02:40 -0400
Message-Id: <20240617180241.901377-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db0494a-91d3-4a64-9a62-08dc8ef7b7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WTBgkwG2ZFTpeQMMZCAu4gi8SUN/VZywLl0B9gbRAfy6482+RTCFLuzwes8i?=
 =?us-ascii?Q?QLUNztxfctuEikUNBT52rXPJ5xJMMyMiIH+5Xz+IJjwfBbj7l4jF8WYp8OxE?=
 =?us-ascii?Q?u1YCiINHbfCjQNGrp1cqAwWqxGUUyQfQ0u0ivw8WKocdYfQMCPnFhVmX2Lxz?=
 =?us-ascii?Q?yeJVdlQoP8csUWO6RXWjSas9mETJXDLk8230hehmIlwHzyswDbLBvsktOXJL?=
 =?us-ascii?Q?Hzwy/O4Cvy+JO0VHKh8qWJMCdmcyhpWJHFTwB3u/gRhHOxINhPFshFA6P7Hk?=
 =?us-ascii?Q?xTeBQ4Wm4oLaqA85hp5hPTrjStVyPYpv/ugrgm0FlSTC7Mf9yvOnPEDqR6yo?=
 =?us-ascii?Q?o4FA1Z4afBSB/3kwArRtlMkOP3qSvYV2DDLht/8zbfmixTX0qsi7XssDjivz?=
 =?us-ascii?Q?CH+YYJXxKJu4R6eY5JLMfzZwRpsBlyBgvoVD1kEPnRLpGXOOSclVHQeF0Q3q?=
 =?us-ascii?Q?F91BCqK5nB3ZJTXmdhHtiCBGIR3xEN1r6pw9KEIKyR9WxgvYcgUGn3m/pz8P?=
 =?us-ascii?Q?UmfxzN2ceOf+bRG2gAhMPIp6nsMHcJae2fIBoIp8wnmLmwVD6QjsPAcBKYj+?=
 =?us-ascii?Q?7qkt1QO6nnbqM63GIB4D1K6ULtTuj7Za0rxjXMsbQ9jbkJYYeiYnhRM9RS8x?=
 =?us-ascii?Q?H5SAehOdFrBb15B4/mDk8fu4jbPT81iMzQzBlqyKnlI/0BJzeM7aEy4nJlle?=
 =?us-ascii?Q?8umdTMmNZN8r/DYwNv3EYYVLQe29QNlu5WbxnB9jhI5GFZW+BXEtWoOXeWfx?=
 =?us-ascii?Q?mwZzrLRmGIMmkfeU7P0yCIZ/Fu41zhtBB9AEmGLPww/I6+1NhY86rilTsu4O?=
 =?us-ascii?Q?ku1Esi+fNeaJwGNucEOPxiP5PNCXKENfsWUWdTW5rykewwvu1HnoJ9QHD0Qw?=
 =?us-ascii?Q?ddAZIdlFjBLG2/t4ZiWEj/BIC32FKDYHip1FnZb5N2I6hvDZNje7HXE4YWu9?=
 =?us-ascii?Q?v0kk9eOnzl31t02mpOuMv06scXtI3MJCn/CIJx21pyOfRsmkKjIJxX0q+s1j?=
 =?us-ascii?Q?OopFsPanQZIpvJIKfFRYxs7ErVqZlWPkCsrK2J5PGGVFovC6156TMLo4z/z0?=
 =?us-ascii?Q?SUnEkKFFo8WO+ujS6pmNbTyxtna+U6Ii1RyE4slvUFmXTSslqiH1E6x30GTB?=
 =?us-ascii?Q?qFAiDmOhM/dKOotlPet8athR0XE9sr704BnWwLo/K+RVJD9wams/3GqWZrrX?=
 =?us-ascii?Q?YAQdg89Vyyy1wmUaVv4Pw3zqwAJRmTcEuiWDiIf5XDNT9GR0PYG1kSQc7UwJ?=
 =?us-ascii?Q?PgMUjd3snmCy3ohZ7kwvy78NDOv2Vb/+T/wgL2zjIoOMrAg1QagkblbHb6+A?=
 =?us-ascii?Q?qJhG69iF3oog8UHgS70cB3fx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2QTO5YP0pzsMWDp3c7v8T5XbFRB/9Diw9sbEizwlsPZw7Px5QK9t3WIKMyry?=
 =?us-ascii?Q?/ZhXwKY6/fl/P4bG6yK2JkHawRxaLI9p6+sa3AZu6ub9YCanlyIRn+tpiBBd?=
 =?us-ascii?Q?fb42A+19s3LxzuA/O6qRrIFHqsAGRpDToeUOV9n4p05RaMcoiJovQJnz3KIi?=
 =?us-ascii?Q?+N4BWaxXBX3UtBfE4uCCPf5vsWJ9FuDm0yu+nAD5B6mr8uBH2Qf+DtE1lWQU?=
 =?us-ascii?Q?56Zx3tubnNKgXjXvWyEnBPxtCKdvCwtJexX2VT1etY+9k7Ku6CYXiboYD1cU?=
 =?us-ascii?Q?Je+KzTEn6Xg39JiDS2sTJh4fUs5FgibGR1Hcw0mIQBg1EVKReBb/PHzjiRoq?=
 =?us-ascii?Q?DeH+H8o3WCXi49mjQjtX05f5wG3YzPKAPP8ybovTs8qDAgR0By4gJ37ahksy?=
 =?us-ascii?Q?VvWvtlF11KZ1URavIzn3qF2eOL255qEbJuSoZI/4EMEABsdzspJQWSNmNaP9?=
 =?us-ascii?Q?3vL++lqAk+mrVie16OFrbPAiC4Ij9YC8rRhoiRrRdpjsjdA6oKLeKbT+UBx5?=
 =?us-ascii?Q?zeBqaL4a9A5GQlXX6LKwgpLctcL2RJZKkyCrFNzKJGibfzkJRUErderHZHWw?=
 =?us-ascii?Q?+vojTfdkPXntS+5r/GQz6Zmpt/yF8X2AVxqWN3jn59kIHXi1lKTh4Xa0C7Xe?=
 =?us-ascii?Q?2lQomokIAF0xEpO+LP9S1Yi1gIxr5fAzHUdfQ8G4C4xhiZuxjuQmeaS8e7ep?=
 =?us-ascii?Q?ZKDKvEWYUzdtSi+q/NIvSrfEK1agcQzRGuoX3osJzk6/vS+2cg7SXAJRJ0+o?=
 =?us-ascii?Q?Q8BLGAmtSQPXqsuVmAvJfXD0B5Ju7s0dOYY8H/0Gb9aZbklcaYHh2Ky5oyfQ?=
 =?us-ascii?Q?V6JVJy+eUDEC9cG4yEJzgf7r582rMMquhZhmc/0PHcB5ElGIxIVU0o/rOIBa?=
 =?us-ascii?Q?9nAXBJTbrNpD1KrgTlbzWmGWhd9WyfYu5l7GRFg7aNtK2ujygUEV/+MyUmmK?=
 =?us-ascii?Q?UAnKNRv3moY+JnSKhRf7QujkL0ooWZovtj0e1zYLVz1f0RHEX/kEL2nMLjA/?=
 =?us-ascii?Q?ku3V//KxnDpowmCol8ydx2cU5nZz3RyvfOy2wdXTUxIdyLWRKx3rZvrE4jmY?=
 =?us-ascii?Q?cdOi7Lweb1L6AQZmWs6Umnxm3PH2dTCgGUXcnQt59FzpNOqNQGCKlcNSJEqK?=
 =?us-ascii?Q?TCv6rUBMY7bitX2TJKVIP79PDorcZdaved+itYJm766/791OhlBBrC7haZX9?=
 =?us-ascii?Q?fQPY9CgwxTmO0eDiN5k8hyGZpONIcMTXpYTPVJLMMyZyJUwFu1mwh2JDQkP6?=
 =?us-ascii?Q?fRrdhTMhT1Ekq0MTtWeXKrGjsbpByrUB30HPKpxFpAv66rbdaCMwSU3kYAND?=
 =?us-ascii?Q?PKOOEqPBEjonuu2jW6nTVl81SXFpuWrPJmwAaQhLQKU48xqZalu2nNTKFN9p?=
 =?us-ascii?Q?1FaPqGWrH13fpJF9G58VCS+ibIjLe2Bdih36oLERNJh4jljimp+Br+vc2c5w?=
 =?us-ascii?Q?xMmR/kS2lQw5T+DiwwketkLUJGQUg2PnWwvXuRFrex9hSRaboLbVUN45qiyG?=
 =?us-ascii?Q?DrjPaNZwHQ3AipEf1cIhGoT11t+uPObzrlX98cJSWT7E+eUgKHqU9Ur5cSR/?=
 =?us-ascii?Q?Awy39qKaMdXq1jxNHCZ1dBUKVmKWA/xJIkUs5nmh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db0494a-91d3-4a64-9a62-08dc8ef7b7d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 18:02:57.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kb2t2SVAC4rb4yiwkasrhJSBdceG9ftMJoIUa38IzIZ/CkaiTJQShQkhOAjrLMMTVrZRQBSKGktIhgM8FMmpIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9972

Convert ahci-fsl-qoirq DT binding to yaml format.

Additional changes:
- Add reg-names list, ahci and sata-ecc
- Add fsl,ls1028a-ahci and fsl,lx2060a-ahci

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/ata/ahci-fsl-qoriq.txt           | 21 -------
 .../devicetree/bindings/ata/fsl,ahci.yaml     | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
 create mode 100644 Documentation/devicetree/bindings/ata/fsl,ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
deleted file mode 100644
index 7c3ca0e13de05..0000000000000
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Binding for Freescale QorIQ AHCI SATA Controller
-
-Required properties:
-  - reg: Physical base address and size of the controller's register area.
-  - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
-    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a etc.
-  - clocks: Input clock specifier. Refer to common clock bindings.
-  - interrupts: Interrupt specifier. Refer to interrupt binding.
-
-Optional properties:
-  - dma-coherent: Enable AHCI coherent DMA operation.
-  - reg-names: register area names when there are more than 1 register area.
-
-Examples:
-	sata@3200000 {
-		compatible = "fsl,ls1021a-ahci";
-		reg = <0x0 0x3200000 0x0 0x10000>;
-		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&platform_clk 1>;
-		dma-coherent;
-	};
diff --git a/Documentation/devicetree/bindings/ata/fsl,ahci.yaml b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
new file mode 100644
index 0000000000000..162b3bb5427ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/fsl,ahci.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/fsl,ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale QorIQ AHCI SATA Controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,ls1021a-ahci
+      - fsl,ls1043a-ahci
+      - fsl,ls1028a-ahci
+      - fsl,ls1088a-ahci
+      - fsl,ls2080a-ahci
+      - fsl,lx2160a-ahci
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: ahci
+      - const: sata-ecc
+    minItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sata@3200000 {
+        compatible = "fsl,ls1021a-ahci";
+        reg = <0x3200000 0x10000>;
+        interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&platform_clk 1>;
+        dma-coherent;
+    };
-- 
2.34.1

