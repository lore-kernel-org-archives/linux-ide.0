Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12B3C1D6A;
	Mon, 10 Aug 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368318; cv=fail; b=RqJ2J1+1jsnZOGSPmEyX48or77ZJA0P7j8pDQZkgVhuT1gAliccDrejVscMNxTHLeW5R0cn9lyWxwHz8h7JJ9BT3LgD8/bGLojbRLntvlvwlTsvOZV9GvmljU8H8BgrHA/K220xlrsZfjDYeAyeZqngT8FGDI0FRzqi7W4CUTZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368318; c=relaxed/simple;
	bh=eFhFlAjxofbxsz5kkidxLudIc3QGipGs0tGD/BOJUG4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OTH82K2OGfjzAbP2WqdzJmEOeEfHLnlOx1UXo/xUlCFYQ6q4P6YR6KbVh+QYo2wM0Lq13sbpmAzBSXcCmiAq4o9HgjsesfA8Rj/CBuHYtKFbHtKdCD4ALHt8KguRzJkTAIV2ymidqvoxRQKQQhXpZb+jYrpwC7LC00IcPX4fEIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ld2HneP6; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ld2HneP6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSAB8fehlJWEEMnUUcxOGdpIrmCDn5fdF8auYKiCo7CNdPTNK2vypHLoVhUYpPBpxPPLGpUe3R9x8TVfm2UBp98Yl1q/aalnusL+crtzrGsacP6etFEm90kYPbiXbXplB1/t+dc9d4BXJQ0tjMuF3N95dQEbIxvlDslyk6698/2IBUebG1XOrrRYO2o138R8PzwqtyXIUbclWbmI0kjTQkAUKLBB6aXnWwH+p4AY3nzwu9J06khAtXOd1AF9H10LLnlfhm/i4KtfZBr546t/w/5dSGI75xRFnENMJABzub1atLyVYG7ZoYqIqfMNHC4dPE99ZMBvtGmsue+xosEmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xKOklX2eu5lvj4mIXF0037FBhfAxw13PveL+wv/sVs=;
 b=oKdjv93VczYVzFkNfO6KDkMBpe1iIIgUR9lZRD3gtDSCjPRMoeSV+e+qeqGePBd3wWM+EYbdLWiWe0t/uFctoCECKlRuvsq/fL4/SA+sDreWJ/okIW+ylvLY0RjJMJIy5Q9bwSlCBkC8Q0nCQt0EfjeQTGy9J2ucMHUyp7E6KzzjFx1DQ3bVpJ78550l3AXRxLMyPeFrktKmJR4KcO8D5tLXZm1ry1wNQ5VkRyjh0bW5OW9ka+JBBpSdQ67AHVCBb936tfIa0Ig/m5XmuQTfC1IA58jgOGNglVNZomEhZyyXgU6FnNN2s9eDELu4IPWejvR14IzHIToTU4OaH48V6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xKOklX2eu5lvj4mIXF0037FBhfAxw13PveL+wv/sVs=;
 b=Ld2HneP6GM8OXYByO8ug6LHb57DjK/VQcRSzXS1Uh7xsKV5oMAPX1o+eDQ/gDtbL+RsDkIAyvXyvEuvxLMhqStSu3yChFLvctCoEQrf+bo34t3EUgSYXokb6U6uN5fTj039fGN17dqAEATlqCaMHgMPQoLfLQSIpIKVF7MAs5GdGiRM0upkjxnBpdJyESoLzsVqjolw/N+gXD+pUmUNL3IGqVb2KtnvvR6S879+oQZ2KqzeejDV8yP4XdRqWnsVrXY4df/cm2HNqCrofPmeP5DrSFuupwKBYVzcTk9RoD6w5guS2WxGwiJY0kJGjtpQQjM774u4tOh5zPwHTwta7sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:25:11 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:25:10 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v9] ata: add <linux/pm_runtime.h> where missing
Date: Mon, 10 Aug 2026 16:25:02 +0300
Message-Id: <20260810132502.460566-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::12) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c286193-e57d-4b74-bd96-08def6e2cd92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Rjy/JDzoo3bQMBrwDfLePmMQwgb51SBipQlG1a9k5Xwz9yjJMWLMsX+fUYmALTDUONZ73jpqJoVyaVyYAp8PSLc7eq185DKgvJdEplxpT6x8S1KhSsj86UJT7ltdFn1VDeIdONlcSRKFgk9Pj29PkB7T4t2h03O9cSgfB2JidqmULOAMyvmdyz1maxcajfseey2wI4EJuV1S8+WAWiSWc1gz48xuLlA6Z4TjC1r2YeRzjiwI6AGjXSyceo7w+oxjFoTRLdinBnKHmk3GrbDlW2WRy7APu88GKMvCPusY9/Bxpeakxj9t6ASe20a7DvDDIkgBUWy7PqxaUTxH1aq1f7MC6shmcZcivWIqaKCY8YKItR7FCkYRw0tkZ/JknDUtIcd79KSFQrUpwJ2Q5erKAlsyLE5815vHusN993UtdF8lbOWX68aW5hzhluyM4eNYjaL+0b69AXP2zw1OIfa6RIuP/PCH4L7v5vdssTwdEk6dkHsG/Flsgd3rWvkdMviCI744vHQTJirmXG1F42f9Y+1+2MPrPy5KfFii3c0reBXaIeh+9VxD/gpoLJR/JeoU7lCEF2KckFxZSA8NIH7aIelHhekz4uKe4vQMu4wyT+e4P/C9SNLdHyGB6lvV6747fPrNGhxnHkZvp4rqmzeXthKmcGIy8F2reIlKtFVANhg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPFz+B/h/M3AnVp5ChF7UCQ3r7PX41XsnhzLDz+aPDYOZptEK8vWwbacXiX2?=
 =?us-ascii?Q?2lTmNf6msg16hCPINczQFyg3UYWl9gWRCaA+ZzTxkcbER52zqRsz7EbAoPeK?=
 =?us-ascii?Q?/FWDgrlc02jBRWeydGQjgnkJo+ZAzFb6LgD48x7aaqs6PWZyvNOZ9v2RIRuJ?=
 =?us-ascii?Q?/9q41zfE+dvVh9tykiBt/RCsdbb1S0bL5ScDrHiRShcQuQmoWOAsYvBZLB9T?=
 =?us-ascii?Q?ZzSHDRIdOm4fcF0Zv3GWCCre2uBkv/g9MFE/8RRO2gk7RAqADvNBDmUTtj1m?=
 =?us-ascii?Q?GZtbhhJ67mhPzCPlUTvRh57aNDMbplsrJYGkB1lbtEK3lSXFqf2CiYlk0AVn?=
 =?us-ascii?Q?eBMk/CoG1OOfy+wg9Ejp/sPXk1UcBHf2RSSc6FpffUaejyaY4Rniy/1fdxiU?=
 =?us-ascii?Q?XSZ4D5EeAtMy/t2+Gbgxn3HqxPD1a4O/4IcvpnNwdjiTswOpKNwUNkJV1ViW?=
 =?us-ascii?Q?NRloxtMNTZHKZsP13Yx0vhKUSo4jFa+CWnroU7hAH7UZ5YSubPTGHtWPHuTq?=
 =?us-ascii?Q?VNfD5aWWjJqQOiD7njEdn3FjfC4kahkMLLyHzDYXGCWFrD/2xlKpFllw/heu?=
 =?us-ascii?Q?BQNzbiF/b+lgIqUYGGntsx1+jO59B9GfLqXaJM0XCU5Luul069iE7jLie3fQ?=
 =?us-ascii?Q?4sI7k0ZwWJWtsS+68/vTag81RPAWQFyFYbfhONAxkdFUcZw7KmH0DnbKyfPK?=
 =?us-ascii?Q?pRQ0ts/uWN5la7slqz0sOEAwwyKqduv9xXkJCkxRQEtpTX5ry6jpPJRE1yB6?=
 =?us-ascii?Q?2muXI0SNjBeCgBTNHNi4XzOEiNGBZUfo/O2zM2M6EmfW9D4rqlE3W9ZlsWdF?=
 =?us-ascii?Q?8iyt26TSTNVB5Qm3LoHwS+E2BvxmHc987K/en5PAXKnDfmOEjK9N+LfHKcWm?=
 =?us-ascii?Q?DUfwCmpb7p6SnKmrxNzvPVoCwhES/UCzWPCe0Lkmv6zj4HUj/b15WGQhmTdn?=
 =?us-ascii?Q?UcKhZN76/AyvkTJJ+5vJ3jYPAvqmXHNq9bjQ87lO35jGTzpHU2JHtZ/oR1Ys?=
 =?us-ascii?Q?w0u5Ynk0LGEDRxTtb0C+uIG+YOZoeoHVHsplS2sUdj+MXiVLKMp/KlH0qsy2?=
 =?us-ascii?Q?GVB+/hkHG+gaD/tGzRwOk1N4agEm+I9hp9LnJ/bKSI29jtsT0KaEb+F3hegr?=
 =?us-ascii?Q?Ki15rYuVNa/6g6oekYVHILbdkvIfEszlQsMHQuohxTh3Fmebnk+C01u/Lke2?=
 =?us-ascii?Q?WOUb2pGXUlquMskN8zqu8o2j5dn64UETqdG7MjCQ4AtdirPMkecI94lxyP3b?=
 =?us-ascii?Q?kjoobuOp0J44i5mIHsfTYtdRuzBfMmMJZ0pJxSnkY5f7RjYavR1cU9rd5kFo?=
 =?us-ascii?Q?8Wq9e9rK5jcPsbqJgGatV2tTeYl261Mdn8emGHRCz65k3LPXJL/VMUr8/Diu?=
 =?us-ascii?Q?gz5hatLIPhPlRd6Zi05qXhlcoxgvh7iUnRIvbHih6hAK5WKkTjGiHrVvXPLf?=
 =?us-ascii?Q?PtTcKdIMs9maDTC9TqNrhlNTS4XFjEpbjPvpecFL9PHfE8I+KYEzNl6Psljl?=
 =?us-ascii?Q?K1j62A6A1koHfnAwkdJneVU7muNtK7F7qXUPtQDRAJkDi5my8aQJBhsvUTU8?=
 =?us-ascii?Q?mFSMz6Zyu9905V7gLtXR2ZxTQQYVtC7znU9pMBYky9UXOolYDaLCIPmHcuGf?=
 =?us-ascii?Q?aeLQKekQmj0jPSIasDyK/ZeVlcO8ctkYfb7bH+oczppEJL8aPU+Yq75M9o1s?=
 =?us-ascii?Q?VfewOVZLD//bkbUOVBSSYT4neOw9LEJxOkpIImtIXKFFXLNbU9Kr3/jf6mw8?=
 =?us-ascii?Q?tYEIONwWuQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c286193-e57d-4b74-bd96-08def6e2cd92
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:25:10.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Lhifl1MrvZ40XaDyHUlTHPYtMrczWxyEugf5YoAvYZuod2UC6JaCm6pz/qIztg2knFrFh/1DIj2WXn5BvIvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543

It appears that libahci.c, ahci.c as well as the ahci_brcm, ahci_ceva
and ahci_qoriq drivers are using runtime PM operations without including
<linux/pm_runtime.h>. This header is somehow being indirectly provided
by <linux/phy/phy.h>, which would like to drop it (none of the functions
it exports need it).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
---
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>

v8->v9:
- none. Extracted out of previous "[PATCH v8 phy-next 00/31] Split
  Generic PHY consumer and provider API":
  https://lore.kernel.org/linux-phy/20260505100523.1922388-1-vladimir.oltean@nxp.com/
  which became unmanageably large and needs to be split per subsystem.
v2->v8:
- none
v1->v2:
- collect tag
---
 drivers/ata/ahci.c       | 1 +
 drivers/ata/ahci_brcm.c  | 1 +
 drivers/ata/ahci_ceva.c  | 1 +
 drivers/ata/ahci_qoriq.c | 1 +
 drivers/ata/libahci.c    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 58f512f8952a..d1cdbf86da78 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/gfp.h>
+#include <linux/pm_runtime.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 29be74fedcf0..48460e515722 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/string.h>
 
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 2961e53288f4..008869d9499b 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include "ahci.h"
 
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 96492159fa7c..fc6b8cd75b32 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/libata.h>
 #include "ahci.h"
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 6d72eb017b49..bea9a39daced 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -30,6 +30,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include "ahci.h"
 #include "libata.h"
 
-- 
2.34.1

