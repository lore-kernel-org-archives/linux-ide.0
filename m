Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F722AE45;
	Thu, 20 Nov 2025 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763610629; cv=none; b=is3sr8H6sg51wcak8Y+aEwT4Wo4q/CqOiDFzPctE/b7N7OIQcAg5gr1eT5Jruq2JH4jzeAAlTiWFyyzcgs8KhU3dp/GgnXivhS9U5LQzpqZXUzdCEMj6ugNyjxnbZfv/bx9N5I2Os/D+KObBY92/D0wFjTGn27x6GJu9KUCAlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763610629; c=relaxed/simple;
	bh=TwgZCvDLewn4mMYfhgCpXByZzntJ6xfXGLZh/O0sFpM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=etqwLfvRhT1aIiSzt+Egs7/IuKadz4eVDB0Nzj50Jx9vQxvwPHPwhOjfqi86YfUv74ujp1nKIPLWgCSsSsQOZmopLy2kYT5vJLnAQsXft0w9HhNW1BjGZ5FU/5RW0llevOuC/FUjyPzi8haR6NEOwz1Gh7ac7fQos4nfhLqwIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=V5umHewD; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="V5umHewD"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=G6trIIOwhmdCQATyjbkKF8RRLf4u0WWEMTy/ycUCmgs=;
	b=V5umHewDzdq3B3YBxqNjhP6iI32zPUn7P1KVbKVRNfjaNSQrfLn/t/yumppUFLltwSwBJCxBY
	Qya+xgwQQGwD/5JYGycpFVL+wbhGi2V6GWf1NDqltOHnTyZgZ8dMe2cxBT4Pxe92tagA7aDYXqC
	PUTkph5cHijllrFxQr2Js3Q=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dBkpv2LzCzKm4r;
	Thu, 20 Nov 2025 11:48:39 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id 28A5A140277;
	Thu, 20 Nov 2025 11:50:24 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 11:50:23 +0800
From: Yihang Li <liyihang9@h-partners.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <martin.petersen@oracle.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liyihang9@h-partners.com>, <liuyonglong@huawei.com>
Subject: [PATCH] ata: libata-scsi: Add missing scsi_device_put() in ata_scsi_dev_rescan()
Date: Thu, 20 Nov 2025 11:50:23 +0800
Message-ID: <20251120035023.1256818-1-liyihang9@h-partners.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh200005.china.huawei.com (7.202.181.112)

Call scsi_device_put() in ata_scsi_dev_rescan() if the device or its
queue are not running.

Fixes: 0c76106cb975 ("scsi: sd: Fix TCG OPAL unlock on system resume")
Cc: stable@vger.kernel.org
Signed-off-by: Yihang Li <liyihang9@h-partners.com>
---
 drivers/ata/libata-scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b43a3196e2be..3fb84f690644 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4894,8 +4894,10 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			spin_unlock_irqrestore(ap->lock, flags);
 			if (do_resume) {
 				ret = scsi_resume_device(sdev);
-				if (ret == -EWOULDBLOCK)
+				if (ret == -EWOULDBLOCK) {
+					scsi_device_put(sdev);
 					goto unlock_scan;
+				}
 				dev->flags &= ~ATA_DFLAG_RESUMING;
 			}
 			ret = scsi_rescan_device(sdev);
-- 
2.33.0

