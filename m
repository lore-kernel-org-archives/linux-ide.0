Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDC63AC
	for <linux-ide@vger.kernel.org>; Fri, 15 Mar 2024 05:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481477; cv=none; b=rBggy48d888tEY3u6Me3WhtXJnDqz93bo8zwA1l+IfT7QQw9eMNDObgerFcxB3EgD5cjykbEqjSsTP1V9KVlsTmzq/Enf2wU1p0u3HEZLh9pBd4+I2piDRZ2s2O+uWNjRtXy1mlCCvjDR4Dopur9Os8PsmiPxjTdu/4FCCKAjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481477; c=relaxed/simple;
	bh=xSvuzFkjmF9aooRjcPPSfvCRrSJj3NAMBQdxCcSx/Bo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ny+KpzaJhFTwJuZ7KeUCdEbfbDJ0iI8Kh6M7W+2v6U/We2CSwBqktU0/1wJYPv1ugl732Ebi8jWgS8rWyOE9ENRcV76aEMM0EqeDQWtL42JGJXWhSEO7XHU+DpFt0MRejxrOe4/oGpB/HuXsPyg9YyH+8zrTqdi6wURXJbaQBbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J7jMnAUp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J7jMnAUp"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EMJPOv032499;
	Thu, 14 Mar 2024 22:44:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=4r4Rr122
	sMq4QiXotLXTHeEIbu1sjDlA0ngQ2BbV/T8=; b=J7jMnAUpZhZ7HLx77hQ3sNcG
	L018LYGEOn+ovNnWBlz1DwA+GZJVcH4LDC3Tt+/HcFZD/yfUlrOw2GMKian/gDgW
	J/d/WeTAXhHu8mUO6wlm529oDZLtD1KrfLTIbVGON7v7E7LBvhQrRJjCv/YJipp9
	0FsJaOz8NiHGbcGSbgUdbpkGJn1rzg0qKrVQUtnP+EMG2kMog1MNqBHdkRRyJRPv
	Slk2M2AvzkPUSQj7NFmS/TmVr+oXfXx6IGOZicj6Qult0O/loNAIKzWsCV+mJVAf
	g205PTKP/8bbMxAZoL82J8kgpwMO8vajp/ATa1qptA2lp1aBsEAJEKdy07wWTw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wv9xa12qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 22:44:31 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 14 Mar 2024 22:44:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 14 Mar 2024 22:44:29 -0700
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.187])
	by maili.marvell.com (Postfix) with ESMTP id A08653F706A;
	Thu, 14 Mar 2024 22:44:27 -0700 (PDT)
From: Saurav Kashyap <skashyap@marvell.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>
CC: <linux-ide@vger.kernel.org>, <skashyap@marvell.com>, <soochon@google.com>,
        Manoj Phadtare <mphadtare@marvell.com>
Subject: [PATCH v2] libata-sata: Check SDB_FIS for completion of DMA transfer before completing the commands.
Date: Fri, 15 Mar 2024 11:14:14 +0530
Message-ID: <20240315054414.27954-1-skashyap@marvell.com>
X-Mailer: git-send-email 2.23.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aRdNItsob19rtypz4njkOKx-y_L4rg5M
X-Proofpoint-GUID: aRdNItsob19rtypz4njkOKx-y_L4rg5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02

This issue is seen on Marvell Controller with device ids 0x9215 and 0x9235.
Its reproduced within a minute with block size of 64K, 100 threads,
100 jobs and  512 iodepth on AMD platform. With decreased work load it
takes 8-9 hrs.

Sequence leading to an issue as per PCIe trace
- PxSact is read with slots 7 and 24 being cleared.
- Host starts processing these commands while data is not in system
  memory yet.
- Last pkt of 512B was sent to host.
- SDB.FIS is copied, telling host command slot 24 is done.

Reading SDB.FIS confirms the transfer is complete.

Cc: Soochon Radee <soochon@google.com>
Tested-by: Manoj Phadtare <mphadtare@marvell.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
v1->v2:
Added workload and platform related details in the description.

 drivers/ata/libata-sata.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 0fb1934875f2..7cdeb0a38c5b 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -14,9 +14,11 @@
 #include <scsi/scsi_eh.h>
 #include <linux/libata.h>
 #include <asm/unaligned.h>
+#include <linux/pci.h>
 
 #include "libata.h"
 #include "libata-transport.h"
+#include "ahci.h"
 
 /* debounce timing parameters in msecs { interval, duration, timeout } */
 const unsigned int sata_deb_timing_normal[]		= {   5,  100, 2000 };
@@ -649,6 +651,7 @@ EXPORT_SYMBOL_GPL(sata_link_hardreset);
 int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
 {
 	u64 done_mask, ap_qc_active = ap->qc_active;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int nr_done = 0;
 
 	/*
@@ -677,7 +680,30 @@ int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
 		unsigned int tag = __ffs64(done_mask);
 
 		qc = ata_qc_from_tag(ap, tag);
-		if (qc) {
+		if (pdev->vendor == PCI_VENDOR_ID_MARVELL_EXT &&
+		    (pdev->device == 0x9215 || pdev->device == 0x9235)) {
+			struct ahci_port_priv *pp = ap->private_data;
+			u8 *rx_fis = pp->rx_fis;
+
+			if (pp->fbs_enabled)
+				rx_fis += ap->link.pmp * AHCI_RX_FIS_SZ;
+
+			if (!qc)
+				continue;
+
+			if (ata_is_ncq(qc->tf.protocol)) {
+				u32 *fis = (u32 *)(rx_fis + RX_FIS_SDB);
+				u32 fis_active = fis[1];
+
+				if ((fis_active & (1 << tag))) {
+					ata_qc_complete(qc);
+					nr_done++;
+				}
+			} else {
+				ata_qc_complete(qc);
+				nr_done++;
+			}
+		} else if (qc) {
 			ata_qc_complete(qc);
 			nr_done++;
 		}
-- 
2.23.1

