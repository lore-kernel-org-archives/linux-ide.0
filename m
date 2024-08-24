Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6E14B06E
	for <linux-ide@vger.kernel.org>; Sat, 24 Aug 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501695; cv=none; b=QxMNA3v8BxBGxelUVMd699EWSNjUKUgfwiVp6hdmYB5RVu92bfozGpprUk+YtnqC9nOUvInBCcDGyI4QSV1y0+7uviIZpThjhoT0QvxEd9mDF/kC4FesuKPKejfRa+2MudyVGIYj25ZJliXAlcLWafwLDZmf/AwLd7rxXxWRwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501695; c=relaxed/simple;
	bh=J1b6kISTGA5XQBti/GUffbBCcoSTZXuvvfkTrr5k1DI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HZF5BE2tycxsjtxUSZzqRWXt6SpXG1X2SkRwkxYU20rlhHM+yW+OZ+EVPRjHX5HLd8Lhrj7bFxeg6e+kFpuUjpKsX4OXKhrPScJ8QL953ayCwTXni0dQjr7EVY4uIF3EcuIcEkdPEqo0lOMKHA9RrH/CFmT3WIAzWAbp5/mFWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WrbTC0MhmzpVl0;
	Sat, 24 Aug 2024 20:14:07 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EDC9140118;
	Sat, 24 Aug 2024 20:14:50 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 24 Aug 2024 20:14:49 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <cuigaosheng1@huawei.com>
CC: <linux-ide@vger.kernel.org>
Subject: [PATCH -next] ata: libata: Remove obsoleted declaration for ata_sff_irq_clear
Date: Sat, 24 Aug 2024 20:14:49 +0800
Message-ID: <20240824121449.2522086-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The ata_sff_irq_clear() have been removed since
commit 37f65b8bc262 ("libata-sff: ata_sff_irq_clear() is BMDMA
specific"), and now it is useless, so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 include/linux/libata.h | 1 -
 1 file changed, 1 deletion(-)

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

