Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB23BB21
	for <linux-ide@vger.kernel.org>; Sat, 24 Aug 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501518; cv=none; b=JEYZBB7naXSMOhYApXj1TRdjMNE/lBis5McnMoIok5IHlLBWsY3c2IXQ1hgwu7AjjH24Xc1ge7BFSQwG5Edn9Pqdn0FTzpCQY8vuaWNoMLFE0h5iK7WZv8M0GR23Vtzxpf86zRnwcHAvvfhdwSLbYMHmaONOIlgsLe1m+pQAUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501518; c=relaxed/simple;
	bh=/qKOVqO4EQo+y5YA1KoFyntLOeN44xfwh1kl+a8ucSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hU0EUWvRw0OEmNaXfUkPY+ma7+7KznTVxE9jD7q/r/yXlsgpMraVzuYTd/VjWdiVsF8TGd5uuUZ6l1d3hVJKfK8mDCYJkQeUcksFEuja5w9B3/FqltPTxcw0k/UnLT3xsAl2VEIs6mqwORmiPhRJC1ACe7W1FHtgd0JUCHmbZao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WrbQ30R7yzyQyb;
	Sat, 24 Aug 2024 20:11:23 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CD631800A5;
	Sat, 24 Aug 2024 20:11:49 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 24 Aug 2024 20:11:48 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <cuigaosheng1@huawei.com>
CC: <linux-ide@vger.kernel.org>
Subject: [PATCH -next] ata: libata-scsi: Remove obsoleted declaration for ata_schedule_scsi_eh
Date: Sat, 24 Aug 2024 20:11:47 +0800
Message-ID: <20240824121147.2521772-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The ata_schedule_scsi_eh() have been removed since
commit f8bbfc247efb ("[PATCH] SCSI: make scsi_implement_eh() generic
API for SCSI transports"), and now it is useless, so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/ata/libata.h | 1 -
 1 file changed, 1 deletion(-)

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
-- 
2.25.1

