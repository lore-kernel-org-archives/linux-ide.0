Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52C208B8;
	Thu, 22 Aug 2024 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297738; cv=none; b=Uyo2P3WSsn5O+LwQ8whek0uNKJ0pj9ASsH4jzsJcwOOfZ1UFw2NoOIMGzoImtqmQx+B2HPhytdnyh8TqtojOMpCSiwpGEXe+XTdcBTygWtL4VpMpYKHusl1xH1ZVgLKc77D0p4bNtl6FqBWG1PmOgXE6PvVb0fO5tqjVCJLqZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297738; c=relaxed/simple;
	bh=LpeK4LmFRIzC/X1tCygRYSS8Ml63lXTG+oftOKRoQec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cYNofgVPuRnMvW5xvimEinESRmASrtGUVUOkyNXqenwJ+NYLolPTF7sYjSyKkCBsLpak20TKtAY1Ei0t1qnkHvesCcXkjIxFs/K7noL3T05M68lnPIf6OavzeuAdTJbu5Bs0gPq6+iBxRPv/DAjQrN9uxzeIdedxDjPbinS1wTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq83S4BCwz4f3lg0;
	Thu, 22 Aug 2024 11:35:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B3A541A058E;
	Thu, 22 Aug 2024 11:35:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXfoQBssZmTVZ5CQ--.38201S4;
	Thu, 22 Aug 2024 11:35:31 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH v2] ata: libata: Fix memory leak for error path in ata_host_alloc()
Date: Thu, 22 Aug 2024 11:30:50 +0800
Message-Id: <20240822033050.2909195-1-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXfoQBssZmTVZ5CQ--.38201S4
X-Coremail-Antispam: 1UD129KBjvdXoWruw18WF4rJF45KFWDGFyDWrg_yoWDtFXEka
	4Fkr1xury8Ja1fGw1ftF47uFWvkr1xWrs3Wr4vgFsxKry7tr4DG3s2v34YyFn7Ww4YvryU
	ur4DXr4xZr1aqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Jr0_Jr4l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUotCzDUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Zheng Qixing <zhengqixing@huawei.com>

In ata_host_alloc(), if ata_port_alloc(host) fails to allocate memory
for a port, the allocated 'host' structure is not freed before returning
from the function. This results in a potential memory leak.

This patch adds a kfree(host) before the error handling code is executed
to ensure that the 'host' structure is properly freed in case of an
allocation failure.

Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
---
Changes in v2:
 - error path is wrong in v1

 drivers/ata/libata-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e4023fc288ac..f27a18990c38 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5663,8 +5663,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int n_ports)
 	}
 
 	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
-	if (!dr)
+	if (!dr) {
+		kfree(host);
 		goto err_out;
+	}
 
 	devres_add(dev, dr);
 	dev_set_drvdata(dev, host);
-- 
2.39.2

