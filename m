Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022138.outbound.protection.outlook.com [40.107.75.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9822D7D59
	for <linux-ide@vger.kernel.org>; Fri, 21 Nov 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720080; cv=fail; b=XUkvyeJu1uq+LCGSFwZLz0yZtAKKR64SeP7tivnRBkYNOTPyM5Oz33WQZY7VxHf/Kh0tVRiECFj9nYcL5Tq6VIKz1rQgozBPcJkyC96UApbbtKTb31xamt3NJADDWK1DFhqKqewaNIhFRBT8+MPePlsOnmHWqkTjpswsbWDlqhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720080; c=relaxed/simple;
	bh=XrpDkXiQFocsulUT016MnDuJpL8Mzgglpbsnf4P7scY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BN6Z/c8TfuXbwTJ11wWxjuBTrUuvz09Ak9ure1yNgz6410ta7X6RZvdP8NMMS5dTlCIrqG9fuQgv82ALWHTVnRbCtsQ0iTzK6OnvRYzVZv2SNGQ3dsBXQJRYTLpPMOD3woGq5PNmCZtWtBx+/yQYlmjn1EUDbvna/Q0GG+E+0KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=S/6WrUKt; arc=fail smtp.client-ip=40.107.75.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="S/6WrUKt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWQJtYXmKwARWM6C4F8HUOsmjCKiROw8p4IcjhqgzQTKWMs9phkBRy5GjaO+X6yoI6sYd7flO8tZ905fepeDb/j0FkMBaUs3RHgD9MpZkNjJGAdxWn+f8c6QgqA1RUl6AprAeP2dkdKUPh9Mdqau5N+7dCdOaTTbanQYFMdTFf1qqS/GUreJyuhKp+AH+fuBrgRjG3cZykLn8UmuaW4PocTYNBPvhffotfrk4hGPUO/KDkH6w10gHw5D10SOn+5qgbG19Ln9hVNlyc1HW0PGY4ZRYYVq0Z/wdaMDR/aeyV5q2SRLICjyA3Ujua94rxUX73XtYZRJOm3Ef8iv/twPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqDf3qVQBzbk91dkHmA6wCQ9OyCntxmNBRzkIlR0608=;
 b=x6GnNN/xz0zhz3c3rqfQQjT0Hss/d0nKGg5YG8AbL2e+w4j5BiCPEnbPHVS3jVrShefSH12eWIPZgg/cM5q4KeJ1nKIPrWlWY7txtdydynRPj+aWe0knHFO8dICvWFeKuJtRDFkRA5OiXCdmpvRzVj50p7eAG7QIV4vqQ4lWWVD9qLowWW+Ch2CYLA3/aXpClVv2PxcGzeFkZS9qT/zmapcDZRTIRHx8XSruNU4RhMeXzz4SwuvbM+neCLg4eOd7RHehxvW8/VXc+steE2vnJiqs2DiotQK/UEMSo7i4ZW7BS6l2bC6IdlKcE/ogR2at+8ZqYzEnuPc981JI+1K91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqDf3qVQBzbk91dkHmA6wCQ9OyCntxmNBRzkIlR0608=;
 b=S/6WrUKtsGZyL0FHSojy4zRGcUHRrjUXCfri7QZTwGeK9AgeXKGrmGenAg5O/rQPDcLLa3jXCMNgG+qtqiw1wJ8Qp6czPcsiGfjUJ81vHvSNEBPXLcUqfh+H7hOL+bnJ0CBdpEA2qROfrPAwlZmFk3yJjwYrdnVEas3R3cIBFskVO4IPNiBOkytUwMWzCpuFCA2n0iPuNk8m2a9Xauq4KCbS2nWo8Pa6extWZTdM5rTpoTktaIFAx1VNUXZqiJ++8RU95Ib4MzYKXB2N9jZbZqSO2qhPprlnByjTzCD9HXgx1bRc6bCX+NPcCGx5DiUgl1yJ/SZrk4TDmER2OAh6LA==
Received: from PSBPR02CA0013.apcprd02.prod.outlook.com (2603:1096:301::23) by
 TYZPR04MB7667.apcprd04.prod.outlook.com (2603:1096:405:3e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Fri, 21 Nov 2025 10:14:28 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:301:0:cafe::a8) by PSBPR02CA0013.outlook.office365.com
 (2603:1096:301::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 10:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 TY2PEPF0000AB86.mail.protection.outlook.com (10.167.253.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Fri, 21 Nov 2025 10:14:27 +0000
Received: from localhost (unknown [172.17.22.16])
	by mail19.qnap.com (Postfix) with ESMTP id 835F8127;
	Fri, 21 Nov 2025 18:14:27 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Kevin Ko <kevinko@qnap.com>,
	SW Chen <swchen@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: [PATCH v2] ata: libata: avoid long timeouts on hot-unplugged SATA DAS
Date: Fri, 21 Nov 2025 18:14:07 +0800
Message-ID: <20251121101407.978550-1-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <27a5386e-1cc9-438b-bf05-41f7dcbb3f77@kernel.org>
References: <27a5386e-1cc9-438b-bf05-41f7dcbb3f77@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|TYZPR04MB7667:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 55630d2b-8a69-47e4-7587-08de28e6c115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kfSIgQF7qxeREpzncyMfo7+P8LS/6luyGJPN/hYygirPVVNMaYw2m4b2hT87?=
 =?us-ascii?Q?36CM1Xt9dow/cmYsiZr1TRRrr7ZjhZOSw2zH1hBNeQ9Ml5FbCzP21WXw/HKr?=
 =?us-ascii?Q?DNIsH23TGMMz+L+h7rbqexjbP03JJHRE12/zEBZVtg2mGVQ6+NjBhNPU0MsE?=
 =?us-ascii?Q?PmTwcdDqXvtpXuUKfyBxD3YhgAx3v4rb8j/GoG8fU+CB7Xwg2hNrD3CATqBF?=
 =?us-ascii?Q?YQlcAtp0gfKgqEUiNoww1m0VtPLZQwopedZ7vAbSmhV+srrY2pbdljgLQfLV?=
 =?us-ascii?Q?J7WYXRxN/hc7OpcoPvpfJrxpW36oyvLFSXY1Gc2XiYOYtBrtxsplFZoSrKkA?=
 =?us-ascii?Q?wDzfLkaTqnF6f3u7ZqS3iveIPZmq0UNbPRQIuevcmPg7LghcPC4dPRuwDAJu?=
 =?us-ascii?Q?vgkACdczhor7HK0hgG37vdr1bL8MR3zszET2urxoN3pfhjqCOxbzFhybbRbS?=
 =?us-ascii?Q?hBTj742xM8CNAuaQP9b+kc4Y34/IOm18PrmkZBK91G30yOQU/8Xb5qkZ/NC+?=
 =?us-ascii?Q?3mg6RQOghCUcZ3Y+EFsytfUfYqMnj3634xYH5JlNRT/emEl5KevhuyY4QOSB?=
 =?us-ascii?Q?YX3swuKoGYHMzNw1skTKZk57UWTQjw+WG2K8H/UUKa3dsvLfCSloEZzduMG+?=
 =?us-ascii?Q?IDC3UjM+oBIR9X1QwK4GuFJeprboKTj80K9ZL3Vpgl4QF2vULvkSyvwfBof/?=
 =?us-ascii?Q?9bNORgN7PBE62PiA/NNBiydkdv21/nvPN2+QbVze6oL6QP0h7VrcL6mq6t6i?=
 =?us-ascii?Q?kPSFl7U6fyMnGcgcrV4X0NRC4OBq9MaiaHBHsl3JjIvonATFN1Yoj28jZ1Wn?=
 =?us-ascii?Q?sYuAiNNc87sBaxPqlO1OhIWs2NKej7VC7hsQ0tP/uT0CT4RbQDNVa8xaSrkv?=
 =?us-ascii?Q?+7/KTxiJCEUI9ZSo3WAi8kWJgd3FwmmJ6ctRo2h6Zor5vn5IhAN4/YvzfSZq?=
 =?us-ascii?Q?OO0+3pQWppi0mnpt2S3marfxK0BttTCwMDo9gyJ1VFfGf5WJtbvYgazQ8vXZ?=
 =?us-ascii?Q?xznHOF5yEWVTatHFY0LbS4mHBo678dShHecHNhWkGBd37yf/szX3eeClNkGE?=
 =?us-ascii?Q?TbsUSxvlqafiP9cb6Qr5AAWSJ7TP3AXL2AGg4+ZyuKDpnd4kkiKTek15wFp0?=
 =?us-ascii?Q?foJQu0qjEu0rOm2ycJW4S6QwzmqDfoWq4GgitOQGqZSRlA/y7jNCGPYNburL?=
 =?us-ascii?Q?/v+jeIvPh+jTtnutJfHYsynbRFPlHyjKU5/LaRhYJhaBsEt5dGknSkA8npcN?=
 =?us-ascii?Q?zVYwp5srjRhV6dIlbPlAvOBO43VDTsA3OoqcMfKRXQyZOHUxmXDrlYv/LAcU?=
 =?us-ascii?Q?zb/wWKh08rf+eEInBLWSasYoQxqfHKFy/kjqTmLpfzZVW2P5gqMCK1mnLTzr?=
 =?us-ascii?Q?VDgn0SSeRn+BiSgGvKYqk+umE72iyrkuqo5I8kNCUcWMuJYoykUDab7RpK8Q?=
 =?us-ascii?Q?GnkVlUpZh5UNilJ8joKfCj7p8OylLg/04IYhf5ML9PogLYNdIOv3VdU/FPkk?=
 =?us-ascii?Q?mv7Jfc9uHqcYdb8x0KvngAbMjk4w7BBGkgWnyDX7qx9ayV9i/ZkTTKNLR5XY?=
 =?us-ascii?Q?LymCt8rQapVU1sigcBk=3D?=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 10:14:27.9057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55630d2b-8a69-47e4-7587-08de28e6c115
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7667

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

  [   53.905168] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
  [   54.069159] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
      Result: hostbyte=DID_OK driverbyte=DRIVER_OK
  ...
  [   54.330226] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
      Result: hostbyte=DID_OK driverbyte=DRIVER_OK

In this test setup with two disks, the hot-unplug sequence shrinks from
about 226 seconds (~3.8 minutes) between the Link Down event and the
last SYNCHRONIZE CACHE failure to under a second. Without this patch the
total delay grows roughly with the number of disks, because each disk
gets its own SYNCHRONIZE CACHE and qc timeout series.

If the underlying PCI device is already gone, these commands cannot
succeed anyway. Avoid issuing them by introducing
ata_adapter_is_online(), which checks pci_channel_offline() for
PCI-based hosts and is used from ata_qc_issue() to bail out before
touching the HBA registers.

Since such failures would otherwise trigger libata error handling, we
also consult ata_adapter_is_online() from ata_scsi_port_error_handler().
When the adapter is offline, libata skips ap->ops->error_handler(ap)
and directly finishes error handling using the existing unload path,
instead of running a full EH sequence against a dead adapter.

With this change, SYNCHRONIZE CACHE and START STOP UNIT commands
issued during hot-unplug fail quickly once the PCI channel is offline,
without qc timeout spam or long libata EH delays.

Signed-off-by: Henry Tseng <henrytseng@qnap.com>
---
v2:
 - Move the PCI adapter state check into ata_adapter_is_online()
   implemented in libata-core.c, following your suggestion, 
   and call it from ata_qc_issue().
 - Also consult ata_adapter_is_online() from ata_scsi_port_error_handler() so that libata can
   skip ap->ops->error_handler(ap) once the adapter is offline, using the existing unload/suicide path
   rather than invoking a long EH sequence on a removed AHCI adapter.
 - This patch focuses on reducing libata EH delays and qc timeout spam when a Thunderbolt-attached
   DAS enclosure is unplugged after the file systems have been unmounted.
   It does not attempt to address general surprise-removal safety.
 - As a side effect, the SCSI result for these SYNCHRONIZE CACHE and START STOP UNIT commands
   changes from hostbyte=DID_BAD_TARGET to hostbyte=DID_OK with sense key "Aborted Command".
   From the SCSI/block layer perspective, the commands still fail, and the devices are being removed.
   If preserving DID_BAD_TARGET is preferred, the error mapping can be updated accordingly.

 drivers/ata/libata-core.c | 21 +++++++++++++++++++++
 drivers/ata/libata-eh.c   |  3 ++-
 drivers/ata/libata.h      |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2a210719c4ce..0116dac3b4ec 100644
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
@@ -5060,6 +5078,9 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 		if (ata_sg_setup(qc))
 			goto sys_err;
 
+	if (!ata_adapter_is_online(ap))
+		goto sys_err;
+
 	/* if device is sleeping, schedule reset and abort the link */
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
 		link->eh_info.action |= ATA_EH_RESET;
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

