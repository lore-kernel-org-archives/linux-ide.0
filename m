Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37504A28
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653969; cv=none; b=crI9uSRjUpWBSSmd6nenkMMrCN0LFjQTnIc8x304vCGukmrRX+VZjZKUbYSOoLU0MSe+a48w8nvHFvYUHG2MJg/+uNGdLBgWJzcbsGvooub+T1BjJ4fAF48EYmv0Agl1nDX8qedM4r81+6rbTcrhIbPwk9MlXcFA9RYCqDtY86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653969; c=relaxed/simple;
	bh=pPYPBtMmSmsrk3qYpmscfHEhOEorD2WWvgxSWbNqiKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QCtWL6rpZP7v2FSpjoDe2z27tqW/9vAlWm/AqpZnH1oq7YTQQn3M2l4XcCjGa979fuFk1iTGviRtpaCDwaTbIWy2sdZH43fY9s+83ThVQvFs5pXfXdWbnAaTEi/jT0+DwmrcXuiTlBJcbQ/JyyRgbgjgkYQ4ZUteFzqwWvcx4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wsgnq4V81zyRCp;
	Mon, 26 Aug 2024 14:32:15 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 8ADF71401F0;
	Mon, 26 Aug 2024 14:32:43 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 26 Aug 2024 14:32:43 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <cuigaosheng1@huawei.com>
CC: <linux-ide@vger.kernel.org>
Subject: [PATCH -next,v2] ata: libata: Remove obsoleted function declarations
Date: Mon, 26 Aug 2024 14:32:42 +0800
Message-ID: <20240826063242.4132493-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The function ata_schedule_scsi_eh() was removed with
commit f8bbfc247efb("[PATCH] SCSI: make scsi_implement_eh() generic
API for SCSI transports").

And the function ata_sff_irq_clear() was removed with
commit 37f65b8bc262("libata-sff: ata_sff_irq_clear() is BMDMA specific").

Remove the now useless declarations of these functions in
drivers/ata/libata.h and include/linux/libata.h.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
v2: Submit a single patch to remove both declarations, thanks!
 drivers/ata/libata.h   | 1 -
 include/linux/libata.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 6abf265f626e..22e667394368 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -124,7 +124,6 @@ extern void ata_scsi_set_sense_information(struct ata_device *dev,
 					   const struct ata_taskfile *tf);
 extern void ata_scsi_media_change_notify(struct ata_device *dev);
 extern void ata_scsi_hotplug(struct work_struct *work);
-extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
 extern void ata_scsi_dev_rescan(struct work_struct *work);
 extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, u64 lun);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0279c0a6302f..6552e90753ae 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -2006,7 +2006,6 @@ extern unsigned int ata_sff_data_xfer(struct ata_queued_cmd *qc,
 extern unsigned int ata_sff_data_xfer32(struct ata_queued_cmd *qc,
 			unsigned char *buf, unsigned int buflen, int rw);
 extern void ata_sff_irq_on(struct ata_port *ap);
-extern void ata_sff_irq_clear(struct ata_port *ap);
 extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 			    u8 status, int in_wq);
 extern void ata_sff_queue_work(struct work_struct *work);
-- 
2.25.1

