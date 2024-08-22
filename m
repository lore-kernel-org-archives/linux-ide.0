Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA815E81;
	Thu, 22 Aug 2024 03:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724296951; cv=none; b=awgcyk0qc0LnvPGBMhtz0or738A706hUE0Bv6CFiU1BjS3wjKMaH26iZUf8Eroq8cCUFgbgIAdIytqTS5PC4A+Qq0FMkZzL/vhoC5VeAFoQDMwRVGGN7yygXkyPXcQfjzsTKijzK1B8YsMUPf8IzrYGa6KhgDm4Xv7mqoKwvkJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724296951; c=relaxed/simple;
	bh=0INPQ+GRiE0sl7BLVMVyo+/OfDQdMXakb5mOf0nuc3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SFqaps3bIAwG/5Uhfa+fVx3KNNzB+/76am7MJ2LB65NRhqwYuMbb/A5cuJETSCXVKKyqKKDRfu+S5zmqbKxCHYF4cZZeCoXxUQKQHSFc3Bd1u/WFN+nWPBxBXdX8SlmhVVmcb056xiOWZy+JGILzm87rwqQSX7GeG6qusQaFhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq7mN6T84z4f3jqK;
	Thu, 22 Aug 2024 11:22:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 97CE11A0E9C;
	Thu, 22 Aug 2024 11:22:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHboTtrsZmxnR4CQ--.39420S4;
	Thu, 22 Aug 2024 11:22:22 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	zhengqixing@huawei.com
Subject: [PATCH] ata:Fix memory leak for error path in ata_host_alloc()
Date: Thu, 22 Aug 2024 11:17:42 +0800
Message-Id: <20240822031742.2721254-1-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHboTtrsZmxnR4CQ--.39420S4
X-Coremail-Antispam: 1UD129KBjvdXoWruw18WF4rJF45KFWDGFyDWrg_yoWDWrXEka
	4FvrWxWr10ya1fJw1YkF43uFWvkrn7Wrn3Wa10gFsxGrZFyrs5Gas29343AFnrGr4jvry5
	uw4DXr4fZw1aqjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Jr0_Jr4l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aZX5UUUUU==
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
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ee18c09c39b6..cb3ace759699 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5610,9 +5610,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 		struct ata_port *ap;
 
 		ap = ata_port_alloc(host);
-		if (!ap)
+		if (!ap) {
 			kfree(host);
 			goto err_out;
+		}
 
 		ap->port_no = i;
 		host->ports[i] = ap;
-- 
2.39.2

