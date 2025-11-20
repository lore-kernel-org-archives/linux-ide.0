Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022141.outbound.protection.outlook.com [40.107.75.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292CBE5E
	for <linux-ide@vger.kernel.org>; Thu, 20 Nov 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763624225; cv=fail; b=eT4tvlC89XryR/s/a0UCZPKEsDelwaa1hVQeGDPNH8yTUndOcp7LFsoMKxLP8pQFdi/NPIpIKNAEfJ8S7R1Ji/V7lGN1qJ2tFJPrC8aWbBhqroSV5XKgPoWHxK++rWfHaRmsW9iwIR7WLxuktG2Kd18xFhEkHdBvVAEIwTbroJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763624225; c=relaxed/simple;
	bh=ry4zzVlDLiP/oSp6WXjHaMD8QYwCKlT/dT9h/SG+1fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DqCAi/NN5pfT6PPBRpUhfHIOpc327QLwkzUM1QnubthaRqZQMkJAamPprOcwqCNMGzjXcyKrTDDeUdBdJ9NQojKkHiiNaF8pH8SHA4j8+73lRIRHQlbg4D6CFQsnaCRRr14hraYu9rrqW5EGf3QJjJ7MFWBDE33v6F5FCzsUeN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=l5R7YTHn; arc=fail smtp.client-ip=40.107.75.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="l5R7YTHn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L00bzBuxsJVT4lYbJXAPDECd/g++F3E/ghzlTpvKo1Kw+rxCvdX3mP6V+qoE6iJ/ANeC74CEgCDuy2EfX4kLze0mvAWxyU5cteZZh/OQnumt7q2uSJHYSKVRKbKhwzT2QbEptjyRGXIEfglPyVYat++keK+K8sfkFhVNYhgyZtwjJNMRtMw/gG7ydqaEpBr7P4VH/8tCB74eVA2MrIiQSlt/ouAzn9d8W/zKLGpLhyl0Vurvsf+C6qOmPcvjMoNCxjwUF+dJ1q9c6nCWqhHH14ov23Bg++OiKteUw1qF2IjNzcTyLVQDGy6Af9dC6ZeYZg8t6dVWXd4Ib5bc8wwpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1RJc5hMkVrZ4cncuV8jG5odyckqNtUDQjIgL9SVKnc=;
 b=CCcN7OjKISBcKG8ZujB44Zfy9ihe/SXUjcoDhj5PxbwHywU+xvTn8A2aczJSMy0cn0Ki0kbqWBdMyOqXoHPY1trahvoP3unVDKZXiIioblbgt6zvzQ3OsEK6TKmlQ1rYpUe5kyT33SjCqOzABSPsyr2NYGqy4K86ZCJg/bkn4PpFuzArgrsYIG9SiY0YNGdjSHeu89dbhYokhPPkyFoZ3EvJOF/DaXwPCydXqC+sBujQc0AOcCOQhkupLpKA7lSYwBqTZlKC68RFOAXox5wUr9eI0wrVsnuccttkWe+ANwVVQh+JiKbi3jyPBK1ctX7hC8sG0wSihhnO824QPcpYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1RJc5hMkVrZ4cncuV8jG5odyckqNtUDQjIgL9SVKnc=;
 b=l5R7YTHnEYfne/YDVBn8d+LSB6ppS3UQce2Xa7qZTrEQueBxJlhgkoaoeyfaJEuVTTMlZlVl9F1+WffJjq1lpGeC1fYss78l2v6RoxjCR16HzjUlLfAPBg2+JqNeT7Gqs9aJ0Z9yFQavRwWBYgWkucRVU85W3xvjH8CjDC3MdL5tXUC05uVhagM1Ef0XjebP5ArwH7g4E+11o8TRB1FZhN8Ix0HJn5Hg9KQ1HK8QhTnl/HA7tZi7I0ptqazUPMZ6IktsujtJqY3GSXFs6Ih3nfLQYf5N1UUkhAE+u2AJXvTzRMihLrxfP0cUjm56N6cdknp/Y+Ufr4eXrOVkRBzh4w==
Received: from SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21) by
 TYUPR04MB6721.apcprd04.prod.outlook.com (2603:1096:400:351::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Thu, 20 Nov 2025 07:36:54 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::38) by SG2P153CA0034.outlook.office365.com
 (2603:1096:4:c7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 07:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Thu, 20 Nov 2025 07:36:53 +0000
Received: from localhost (unknown [172.17.22.16])
	by mail19.qnap.com (Postfix) with ESMTP id B390333E;
	Thu, 20 Nov 2025 15:36:52 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Kevin Ko <kevinko@qnap.com>,
	SW Chen <swchen@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: [PATCH] ata: libata: avoid long timeouts on hot-unplugged SATA DAS
Date: Thu, 20 Nov 2025 15:35:13 +0800
Message-ID: <20251120073513.702344-1-henrytseng@qnap.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TYUPR04MB6721:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 18d8cc09-ba20-4cbb-f9d8-08de28079340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VWCu/znyMcgbF/zMuCs4j/SvUKJpd36xqsCdraUBpYT6AqVyM1DbzEGei60V?=
 =?us-ascii?Q?jmlm87LpnK4QZbjVabxW2OmcWJ86lLd3WwC/u1WVnInClUe05xB0NM8jgd61?=
 =?us-ascii?Q?p8y5wPEkcckjvC6r/1xzV1uVhO4gxc3gP7YVxclwzxo9A52UGecXUlyF0op0?=
 =?us-ascii?Q?nOPchwVYywrU82LDOSTA8TxXq8TTku4fHNPx3F0+k2zQihgT5+bOPPV/kAp2?=
 =?us-ascii?Q?c+xMg2KGHQjDlAO0FH/39Tlk/aKrKHHKlxczmoCv3szIaMFUnfD8FgIVIONJ?=
 =?us-ascii?Q?ls5qRazX48js31WWCuozIsGdkKGp+St483YcN3ka9SlMbV929ivYLpQmKpcD?=
 =?us-ascii?Q?/PZzy8zA/w4UIKSHuCnM3Rc+0H2Lln3Pbens3L3adPBa5DyZyEKZx2J5fmPg?=
 =?us-ascii?Q?xWX5WtIOy8+dAM4xvYIZvvCkae6aqAaMzborQAmMV3OdP1AyYTlEwDObwjL1?=
 =?us-ascii?Q?WMIKD5kOxKkQBmosZQbZzvNu/wdTLAhqqmseOAtz6b5Tvjy4vCZmVkUCipsW?=
 =?us-ascii?Q?lnPtRT3OWJw+OEN8BYqzC+1AtJdws2NsGWlAbIS5P3A7jOQZMQu323JeDHHK?=
 =?us-ascii?Q?EvA2/gkTg3aS5dOXaPeKc+8mBTRj1WojGDq/QlaVDg3vY0td7MDF2CL6lqrL?=
 =?us-ascii?Q?RaFw1b7gQ5tbWmSF0GuBzgXYaKw4aNFJQJT0f2UG4HU6blU6Nb2HHtBs/a4I?=
 =?us-ascii?Q?KOOqx+XSTIFpZASAr+an3vK2oAGVBXKpJXn8IlOyAl9Rn9iYXys+OffXW5MW?=
 =?us-ascii?Q?RP+yfz5uh1ZLF3LSZKjCGofJ1RbtO8UyZpMB67JASpJfu8lU5mehOeTJkBNF?=
 =?us-ascii?Q?KMIuoSM0F5wXnCw+r9gn0Gc6IlyvRf9f0AuPyRGH1sBGsoyMyRVngpWk/N/v?=
 =?us-ascii?Q?xBRDd2/IouRmSRAnOBTuy1vZP8uuPufXZ5oMTf4qoEb8BQBL1jCSME4gF/IK?=
 =?us-ascii?Q?d4yWoRUelfkH8y/W0UByPFWw4Kx53j5fgsjKMj+HDtgTa/lU0DFZ1bDa1/da?=
 =?us-ascii?Q?F6iOvDe2iSFq50OqjdQBFT4tOZsQAfzYssJQ3S/7I6zz2COXnI59C2V41YGl?=
 =?us-ascii?Q?nYG4b1X/nfWgU7gP92WDqv/ML/zd4Z+6SM1uJKIfemqBaQtjoRgLnn4blnyU?=
 =?us-ascii?Q?QCog9aVK7k05UhdfdO0BpJsfKWPJPa8JTf6YfQCSEAEAp+hc88e+4VHOVpAt?=
 =?us-ascii?Q?7mZoaszR6QShtCEBdlWvY16TEv9MnHEVF3w6bbODeUkZ2WyrwOsUWuw8LOyZ?=
 =?us-ascii?Q?15FvKo9KTuuPYSmwomgwXEl6UtwXEzDIpOgKEgXp2RX/7FeH1n/UuH/HVMwD?=
 =?us-ascii?Q?4dGGDLxy/mqMXD55Rvp+WJmc+B7i3qUdnzzRKLOezu3sI9ywRLSW5bU3iaKx?=
 =?us-ascii?Q?KGCpPyPbKVoz9hsQNh8iGheqo/+LqZo47Jv9Hx44/lF6krRS/Erk5ren2KTA?=
 =?us-ascii?Q?rZ01tWMWh9Vum7rt4JKGjCdU+2l6pePma+gz9C4Bbgia9m2/YeQbMwNxBQjh?=
 =?us-ascii?Q?DqMlY3XIAnVqL24NKCdMkLG9FMYCP1Il53K3GTDudtEsDAk8yczo/m6RujHN?=
 =?us-ascii?Q?NPG//2zXH0L9FdVNLH4=3D?=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 07:36:53.2222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d8cc09-ba20-4cbb-f9d8-08de28079340
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6721

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

  [   55.452526] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
  [   55.496563] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
      Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
  [   55.617450] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
      Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

In this test setup with two disks, the hot-unplug sequence shrinks from
about 226 seconds (~3.8 minutes) between the Link Down event and the
last SYNCHRONIZE CACHE failure to under 200 ms. Without this patch the
total delay grows roughly with the number of disks, because each disk
gets its own SYNCHRONIZE CACHE and qc timeout series.

If the underlying PCI device is already gone, these commands cannot
succeed anyway. Avoid issuing them by introducing
ata_port_pci_channel_offline(), which checks pci_channel_offline() for
PCI-based hosts and is used in both ata_scsi_queuecmd() and
ata_qc_issue().

For SCSI-originated commands we now complete the request immediately
with DID_BAD_TARGET instead of queuing it. For internal ATA commands
we fail the qc with AC_ERR_SYSTEM early without touching the HBA
registers.

With this change, SYNCHRONIZE CACHE issued during hot-unplug fails
quickly with DID_BAD_TARGET, without qc timeout spam, and the whole
unplug completes much faster.

Signed-off-by: Henry Tseng <henrytseng@qnap.com>
---
 drivers/ata/libata-core.c |  3 +++
 drivers/ata/libata-scsi.c |  3 ++-
 drivers/ata/libata.h      | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2a210719c4ce..49a59a90e8eb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5060,6 +5060,9 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 		if (ata_sg_setup(qc))
 			goto sys_err;
 
+	if (ata_port_pci_channel_offline(ap))
+		goto sys_err;
+
 	/* if device is sleeping, schedule reset and abort the link */
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
 		link->eh_info.action |= ATA_EH_RESET;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b43a3196e2be..a49fd4bbf321 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4388,7 +4388,8 @@ int ata_scsi_queuecmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	spin_lock_irqsave(ap->lock, irq_flags);
 
 	dev = ata_scsi_find_dev(ap, scsidev);
-	if (likely(dev))
+
+	if (likely(dev) && !ata_port_pci_channel_offline(ap))
 		rc = __ata_scsi_queuecmd(cmd, dev);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index e5b977a8d3e1..ff2eb824e51b 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -12,6 +12,8 @@
 #ifndef __LIBATA_H__
 #define __LIBATA_H__
 
+#include <linux/pci.h>
+
 #define DRV_NAME	"libata"
 #define DRV_VERSION	"3.00"	/* must be exactly four chars */
 
@@ -56,6 +58,20 @@ static inline bool ata_port_eh_scheduled(struct ata_port *ap)
 	return ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS);
 }
 
+static inline bool ata_port_pci_channel_offline(struct ata_port *ap)
+{
+	struct device *dev;
+
+	if (!ap || !ap->host)
+		return false;
+
+	dev = ap->host->dev;
+	if (!dev || !dev_is_pci(dev))
+		return false;
+
+	return pci_channel_offline(to_pci_dev(dev));
+}
+
 #ifdef CONFIG_ATA_FORCE
 extern void ata_force_cbl(struct ata_port *ap);
 #else
-- 
2.43.0

