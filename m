Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791D101E3
	for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2024 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708668489; cv=none; b=JBOyxblQrFlpV1OEASwLQXf/gXwZWoveNDlt5k0/6a4HLD+kTUiAVNXU+NDxCrJAk3lgHHOvxw4YKom25k3g9Rn8SZnWXAPeDsLqu0TOYXr3OLgRxgGvnpBETzCAmfupi1UtOEtNLxjEQUb3EYUHvIZBe80FNfFgwfqZWFMnYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708668489; c=relaxed/simple;
	bh=eQK7qVEXnFyJxYuajKtR5Gilf9EU1VOgbNlr2ET6vec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=grsdJdla54PN6TN0YamVdI7q46NcPu8nnyhEPtpm+Xx1Z68SV3KTULe8GvfwZZ6qr/M1ZokiK2Fa5k2O4MsU6cUlkC8CHniKTpZ5KNRwD/7WU50z65DSsvPuXuvoazKSgb134J2lUxhc2jrotKD+BE8y++ZsVKJf0IvHFiREixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D/kUIiiE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D/kUIiiE"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N1rSWx005281;
	Thu, 22 Feb 2024 22:08:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=KpPsTwIE
	BbVb1Nlmt63TsnfDJxUk8yRFnMG9NzVfb8A=; b=D/kUIiiE+8DPEtPIJpIk/XIY
	TPt7nzPhEW1KhriG2+c6ygNlAQtjWYn7sUHPE02i3wZy3G7ttc3owiFUtzcbmpM1
	p9EWG/yMmzQpT87sBnOmayxg2bSGVZjQ7BE7AXNfwAYyPZktwjqNCkBTqsL0SffD
	lF0sHMT/oTe+nsly31XYNl6zBFb86oGNimpYkI+D8DvaiM+ZkLkSidSDp/fL4U0a
	q/VDl2lTm7zMtAbO8FUdBGfAFSAWNBJ05LgHNGmnXAB59ZuQAmvINpjI4FdTn/aL
	w6EfU/W6ACTmhA4q6AJfE5Z7B9Rzkm54nLj+LnQ7NG0R8QhdoK5F7ZqmxKcQAA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wej3j8mmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 22:08:05 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 22 Feb 2024 22:08:04 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 22 Feb
 2024 22:08:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 22 Feb 2024 22:08:03 -0800
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.187])
	by maili.marvell.com (Postfix) with ESMTP id 0B5383F714F;
	Thu, 22 Feb 2024 22:08:01 -0800 (PST)
From: Saurav Kashyap <skashyap@marvell.com>
To: <linux-ide@vger.kernel.org>
CC: <skashyap@marvell.com>, <soochon@google.com>,
        Manoj Phadtare
	<mphadtare@marvell.com>
Subject: [PATCH] libata-sata: Check SDB_FIS for completion of DMA transfer before completing the commands.
Date: Fri, 23 Feb 2024 11:37:52 +0530
Message-ID: <20240223060752.4926-1-skashyap@marvell.com>
X-Mailer: git-send-email 2.23.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nH61b4ZguGkAqiD31WguC3A-4kaoOtQK
X-Proofpoint-ORIG-GUID: nH61b4ZguGkAqiD31WguC3A-4kaoOtQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02

Sequence leading to an issue as per PCIe trace
- PxSact is read with slots 7 and 24 being cleared.
- Host starts processing these commands while data is not in system
  memory yet.
- Last pkt of 512B was sent to host.
- SDB.FIS is copied, telling host command slot 24 is done.

Cc: Soochon Radee <soochon@google.com>
Tested-by: Manoj Phadtare <mphadtare@marvell.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/ata/libata-sata.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index b6656c287175..b2310f3a2a02 100644
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

