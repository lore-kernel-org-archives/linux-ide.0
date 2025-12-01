Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023120.outbound.protection.outlook.com [40.107.44.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95BE3002C8
	for <linux-ide@vger.kernel.org>; Mon,  1 Dec 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582408; cv=fail; b=Lhtje1u9PGOruMWNJUpzALgIGCW7sWArG+N2nnRxSePBwoX7/TZNdr1yYxWHbwXe+t6fF8RpyYMYPaPWdEEP4X+mU5r0QmgHAWpBRxqLQfw8tyI4kon35EY2Tz5UZIiIFqoOViL//Digym9q0AFOkAgj+aRXVnr3fZ1iwP9MuuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582408; c=relaxed/simple;
	bh=i2w9iB6NrQAwHzPEAaqDL0bhlTfAFzYacRAZJ9kZlOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OZFNv9J6qRjQhO/yrZBoQ8ND2sOf0NOUYzgRPnKWYkBne8ADvdpgEBjONRtToD+egxlToib+5G7MKIIsvOhA9Y0NmJ5VFYKFO1ChKTwbXMp+XzUa2dw1xoFfM7KSHMQq9jnpYBPq7MGOG55otgTbC4sbA52j2db0pSfpppP3fJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=KF1UNgoJ; arc=fail smtp.client-ip=40.107.44.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="KF1UNgoJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLvafHSi9N1i+lFZ3DnvIdny5DsLI0IJpC45VQjrsqyzEBPf2yKwXqVo+fsDlMvimyUr4C02jJjN4rG2oPq0RE7GJycx6/9kRDDLwKbpfOw8x8/zupQr5/oFnvV1eAazpXUiXXAYUghpEGyu3ftqFzbeLunmRbZNXk+Teb22NxodsiKy0OMV+TzbBV6PFGaeJ91Qu+JwC/RsjqeGRsDWvQSDW3ED2RZo6VP0WEGp6aMeFlB5Y4MgogupSUG0gsqNrm8bBlK8rNENSJJwc+ym7s6w7zsZ0EnfC2eFkqhKMDjgRFBtCc/fMwR8L1QpXmlJMbvD65cwjLyNFp6B1DvjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGyOyjvuTwDrPa5f3hrlHzzj25t9o2eDpia52GRlD3k=;
 b=b1yGQ9lDjCBb019uFBxgJFA1kDkdkLkdbm9Njz0O3u0BSp5dbzUWnBx9OnivGgbEySr0cXF6suNt2OEFzlj8rmQ0e+6kdZr7lMgsSPQ9WlU88dT98YRw6tRHiAT09XAuRpzTEdAdN4ThwHFcOHZgfYCKC7PkMlRX9IWFKwXIY5+tXYBQOpWQ9bN2fneNu39l04QoJERqSc0ne9ijlKLFkS6/ZGdOo9ByqvZS+1cnngucxQdO908z/NvgnsjYIMPf/pAG8HvFV3mm+vjQQMWa+W3JNkahXV7fFw2k88kn+aKkhLvU78BQ92tbcoS4gAHupMnDDXyDX0mlwUrdQ6P1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGyOyjvuTwDrPa5f3hrlHzzj25t9o2eDpia52GRlD3k=;
 b=KF1UNgoJ3qoQzmUsmWBama3IrG12NmNoHq6PmkZSvwmos//OdBO9sLunvoXn8gLs8uDmj03fNax9/hyA5fXlTpCE8z61w/vW9oqYCGGb/05XDt3Lffrows0HrJANkRnc6adeb01iOyfLs8TFbe46iesFvQvFHYaGkuq9Fzi0Hs4Ws/3AMcb1tXtInks5pEoaX7mALjQ6iPXsqbcMcayiDDBYhT4IMH4AGSRiOdaql047jmnmo+zEmUSX72SqSTmUc59/EoE614opAtkkTKoC1l8AvSAb1bqfGwNhyDqzCYKipDPEg2yRGBc+ECS0euVIUZZ9bGFPW+sxyduhmxDTzg==
Received: from SG2PR02CA0072.apcprd02.prod.outlook.com (2603:1096:4:54::36) by
 KUZPR04MB8864.apcprd04.prod.outlook.com (2603:1096:d10:27::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Mon, 1 Dec 2025 09:46:35 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::c8) by SG2PR02CA0072.outlook.office365.com
 (2603:1096:4:54::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 09:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 09:46:34 +0000
Received: from localhost (unknown [172.17.22.16])
	by mail19.qnap.com (Postfix) with ESMTP id ED0DD2AB;
	Mon,  1 Dec 2025 17:46:33 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Kevin Ko <kevinko@qnap.com>,
	SW Chen <swchen@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: [PATCH v3] ata: libata: avoid long timeouts on hot-unplugged SATA DAS
Date: Mon,  1 Dec 2025 17:46:22 +0800
Message-ID: <20251201094622.1475358-1-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|KUZPR04MB8864:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eec69bf4-5d17-4aac-cba7-08de30be83c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?huDA/S0F5m2cx2dUa9lbf4LoAyzRUBGlqyoDd0OJrzQKo64KqhfGmIvPa1y/?=
 =?us-ascii?Q?9i4LcwQIf3TNKD9awLiRYw6APjbZ46jvivv65mwIxmJPGHfk6midSmXQYoH0?=
 =?us-ascii?Q?C5IhO+QW9DGlVHwmYrV07rWWRuRizKH7648AiYfqpDmeGLD/Le+9uLcMtnXt?=
 =?us-ascii?Q?RbYHyveMD+zhURxvUGJyRl5p5qypOoX8FARQbtoUrUj7lKnQDTKNTiJqSN3L?=
 =?us-ascii?Q?/S2Q7U2qD6BzEcMLaBvYR4IoWb2fL5+lPWtILkSgap2P5iaqDm3h7/dm8lj2?=
 =?us-ascii?Q?MMEJbR2/VzYrN6MKMcBq98YHRS4s/7vljSS37AD6GNaEyt/wWZAlBRQz/6XZ?=
 =?us-ascii?Q?jNrlmdXGuWHrwwaWxhk+/dbHm0jLW0OI7n7G/wQCAMrqIlsbv0J8UsfMnRKy?=
 =?us-ascii?Q?Zim4MgdfBSDcFX3UY78ntuPK5bYkD6xQwTBnJrj72z8+z5VRcOS1pIMb9yo0?=
 =?us-ascii?Q?XFCFI6kyx0/eC5i2PWHzy09Wwajkyl3RAHkLfNPHOwc3QW/Oqi1MmKEo8uSy?=
 =?us-ascii?Q?oJvgP7fh+jnALIZ+4W/jQTKr0Ga+6wNsMSTa/lHwAQ83wrlr7WY9S59KD0bj?=
 =?us-ascii?Q?rfP15mjJ0HUXwbFpwGtWf6+JeVq1tvpY7i7WScyTgZ9hhTHtaINdcOchd66m?=
 =?us-ascii?Q?zh2aZ+SS7CiM56dIccTKdH4y8z2h6BvdIH6qOpThwfUHGTljaTP7uIm98XOE?=
 =?us-ascii?Q?iH2soht3QbXyY4ZcCzpRvfuSDPH0NJwCMvquF1Nvr5oBPR/lNxxyUAvYhFVT?=
 =?us-ascii?Q?IvMWta/dddtff0IOfQX6cVP4n/A0wACrhckiu2Gtx2QZErFy9A38bTblE4hR?=
 =?us-ascii?Q?ObavJdDkVVceDTlqYsnw2/R2lme1BYEn1StVr5HCW+rABLoUW4MyOehlrPj1?=
 =?us-ascii?Q?oIgL1V+HvY4446VQ7MIpzQldfJmRAYgPLA9xeUzPMlJsQls2ZGKc5eV1TB9L?=
 =?us-ascii?Q?xVatG+Ds4IjguaRa243+DxIb6hSZ/wIgfGccfLbQOBRrkuAGxh1b4yl6W17X?=
 =?us-ascii?Q?ajq6WC1Gyrce0g6IzO0hiWBcCf30CaE0my2+tXQsulmv5a/Fb8cr3MHM/OuF?=
 =?us-ascii?Q?pRXh1RwBc1oKFuE20B1Sv8+t7FxdHlZiBmuU2W5cdywm1jIUzJ8YQ8My8oK0?=
 =?us-ascii?Q?qMxE5PrEuN49TM9xWS8vCk8PVjuyUiFLfBmG9ilQ+bNHUDs8QpNe7rR/Ga9B?=
 =?us-ascii?Q?08qaT1HcUyAXKA3Fm4BlVCALdizEEBw1rF5vXCttEIJT5z9Gr0zE8XTh+urJ?=
 =?us-ascii?Q?jy3VKEnEYv5DQQLsHQ8vWnfidOy/FMSFP/E9J88AgTrGtQleIrb6l6cZia3R?=
 =?us-ascii?Q?S1qlB8olheAiIudPRS5b7zaHgvaIdBOfFmLiisDLkwxbOQ69BLd6Yn96Bd0C?=
 =?us-ascii?Q?SUA1g+BVsx/vznm+WOk1Hx5M7hthtYBvI3E5mT7GxMsLakHZ+DTxkzuIy04a?=
 =?us-ascii?Q?eejELBPfEjQgS3G0X5BaPptRyrOCqmo/L7wP71ESlyRvvVE2VeXyQciVRMul?=
 =?us-ascii?Q?C7VRSMe6SUwzbX7899BldclfhYIG4juJhSP/DAJUbUe5Ba7rAok5Eqaukmqh?=
 =?us-ascii?Q?4cCTRz2Qe3px7Nfx/m0=3D?=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:46:34.4336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec69bf4-5d17-4aac-cba7-08de30be83c2
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR04MB8864

When a SATA DAS enclosure is connected behind a Thunderbolt PCIe
switch, hot-unplugging the whole enclosure causes pciehp to tear down
the PCI hierarchy before the SCSI layer issues SYNCHRONIZE CACHE and
START STOP UNIT for the disks.

libata still queues these commands and the AHCI driver tries to access
the HBA registers even though the PCI channel is already offline. This
results in a series of timeouts and error recovery attempts, e.g.:

  [  824.778346] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
  [  891.612720] ata8.00: qc timeout after 5000 msecs (cmd 0xec)
  [  902.876501] ata8.00: qc timeout after 10000 msecs (cmd 0xec)
  [  934.107998] ata8.00: qc timeout after 30000 msecs (cmd 0xec)
  [  936.206431] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
      Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
  ...
  [ 1006.298356] ata1.00: qc timeout after 5000 msecs (cmd 0xec)
  [ 1017.561926] ata1.00: qc timeout after 10000 msecs (cmd 0xec)
  [ 1048.791790] ata1.00: qc timeout after 30000 msecs (cmd 0xec)
  [ 1050.890035] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
      Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

With this patch applied, the same hot-unplug looks like:

  [   59.965496] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
  [   60.002502] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
      Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
  ...
  [   60.103050] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
      Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

In this test setup with two disks, the hot-unplug sequence shrinks from
about 226 seconds (~3.8 minutes) between the Link Down event and the
last SYNCHRONIZE CACHE failure to under a second. Without this patch the
total delay grows roughly with the number of disks, because each disk
gets its own SYNCHRONIZE CACHE and qc timeout series.

If the underlying PCI device is already gone, these commands cannot
succeed anyway. Avoid issuing them by introducing
ata_adapter_is_online(), which checks pci_channel_offline() for
PCI-based hosts. It is used from ata_scsi_find_dev() to return NULL,
causing the SCSI layer to fail new commands with DID_BAD_TARGET
immediately, and from ata_qc_issue() to bail out before touching the
HBA registers.

Since such failures would otherwise trigger libata error handling,
ata_adapter_is_online() is also consulted from ata_scsi_port_error_handler().
When the adapter is offline, libata skips ap->ops->error_handler(ap) and
completes error handling using the existing path, rather than running
a full EH sequence against a dead adapter.

With this change, SYNCHRONIZE CACHE and START STOP UNIT commands
issued during hot-unplug fail quickly once the PCI channel is offline,
without qc timeout spam or long libata EH delays.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Henry Tseng <henrytseng@qnap.com>
---
change from v2:
 - Add Suggested-by tag.
 - In ata_qc_issue(), move the ata_adapter_is_online() check earlier and
   set the error mask to AC_ERR_HOST_BUS as suggested.
 - Add ata_adapter_is_online() check to ata_scsi_find_dev() to fail
   commands with DID_BAD_TARGET immediately when unplugged, as suggested.

Note: Thanks to Damien Le Moal for the detailed suggestions regarding the
check locations and error codes.

change from v1:
 - Move the PCI adapter state check into ata_adapter_is_online()
   implemented in libata-core.c.
 - Also consult ata_adapter_is_online() from ata_scsi_port_error_handler()
   to skip unnecessary error handling on dead adapters.

 drivers/ata/libata-core.c | 24 ++++++++++++++++++++++++
 drivers/ata/libata-eh.c   |  3 ++-
 drivers/ata/libata-scsi.c |  3 +++
 drivers/ata/libata.h      |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2a210719c4ce..51090dbbe1e8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2358,6 +2358,24 @@ static bool ata_dev_check_adapter(struct ata_device *dev,
 	return false;
 }
 
+bool ata_adapter_is_online(struct ata_port *ap)
+{
+	struct device *dev;
+
+	if (!ap || !ap->host)
+		return false;
+
+	dev = ap->host->dev;
+	if (!dev)
+		return false;
+
+	if (dev_is_pci(dev) &&
+	    pci_channel_offline(to_pci_dev(dev)))
+		return false;
+
+	return true;
+}
+
 static int ata_dev_config_ncq(struct ata_device *dev,
 			       char *desc, size_t desc_sz)
 {
@@ -5048,6 +5066,12 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 	ap->qc_active |= 1ULL << qc->tag;
 
+	/* Make sure the device is still accessible. */
+	if (!ata_adapter_is_online(ap)) {
+		qc->err_mask |= AC_ERR_HOST_BUS;
+		goto sys_err;
+	}
+
 	/*
 	 * We guarantee to LLDs that they will have at least one
 	 * non-zero sg if the command is a data command.
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2586e77ebf45..f4c9541d1910 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -736,7 +736,8 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	/* invoke EH, skip if unloading or suspended */
-	if (!(ap->pflags & (ATA_PFLAG_UNLOADING | ATA_PFLAG_SUSPENDED)))
+	if (!(ap->pflags & (ATA_PFLAG_UNLOADING | ATA_PFLAG_SUSPENDED)) &&
+	    ata_adapter_is_online(ap))
 		ap->ops->error_handler(ap);
 	else {
 		/* if unloading, commence suicide */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b43a3196e2be..d8a43a680f93 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2974,6 +2974,9 @@ ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
 {
 	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
 
+	if (!ata_adapter_is_online(ap))
+		return NULL;
+
 	if (unlikely(!dev || !ata_dev_enabled(dev)))
 		return NULL;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index e5b977a8d3e1..a14cd588c2d4 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -94,6 +94,7 @@ extern int atapi_check_dma(struct ata_queued_cmd *qc);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern bool ata_phys_link_online(struct ata_link *link);
 extern bool ata_phys_link_offline(struct ata_link *link);
+bool ata_adapter_is_online(struct ata_port *ap);
 extern void ata_dev_init(struct ata_device *dev);
 extern void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp);
 extern int sata_link_init_spd(struct ata_link *link);
-- 
2.43.0

