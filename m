Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E7529405;
	Thu, 30 Jul 2026 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381402; cv=none; b=DCi9WUAD5Xp3d5TuepcXDF57K4EKMucTlHZFUYV5NPEVuW4vzKnx3FvIkmvTAfvrZxvkACmsPeT+63oYG7oMFSZtQoArjTP3k3NDAZgllPPyZBTqNVGXHvx48grbc8fq503hGnAFHMwT1sK/cVlXwNeyPmm4QuI8wMNvV2MOswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381402; c=relaxed/simple;
	bh=mKBg7YS9/8eTeYXI83oud074x7n8s5vqmdm65L2wNZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T6xU94oOqkWkFSg1u91xx16YxjYssOFLTRZZMVdWrf5Tdz+TBlO2dddcwKLRo2FZ2q++r7svBqOnVpZ3AbyHmrHR5NksYVZLpymTgFZHv28QrlTjDLRvsh8J7JADxelT52AMIGu1MQ1B42lRHOobzI9FCU63NM64iIp3b5i59SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1196ced68bc511f1aa26b74ffac11d73-20260730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9bcfa7c2-84be-44d5-a03f-bb8da5cbead6,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:112e416b4e7611d1d571b7bbd12faae7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1196ced68bc511f1aa26b74ffac11d73-20260730
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1785222389; Thu, 30 Jul 2026 11:16:34 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	linux@zary.sk,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH v2] ata: pata_parport: Fix use-after-free in new_device_store
Date: Thu, 30 Jul 2026 11:16:29 +0800
Message-Id: <77dad1184ebd0e1e7ea541d4207568f8bc5ec01f.1785381141.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function new_device_store() calls driver_find() without any
protection against concurrent driver unregistration. This can lead
to a use-after-free (UAF) when a driver is unloaded (via rmmod)
in parallel with a new device addition via sysfs.

The race window exists because driver_find() returns a pointer to
the driver's private data, but does not increase its reference
count. The caller is responsible for ensuring the driver remains
valid, but new_device_store() did not hold any lock or reference
during the lookup and subsequent use.

Concurrently, pata_parport_unregister_driver() releases the
pi_mutex before calling driver_unregister(), allowing new_device_store
to proceed with a stale pointer after the driver has been freed.

Fix this by expanding the critical section protected by pi_mutex
in both functions:

- In new_device_store(): acquire pi_mutex before calling driver_find(),
  and keep it held until all uses of the found driver pointer are
  completed.
- In pata_parport_unregister_driver(): hold pi_mutex throughout the
  entire unregistration process, including the driver_unregister()
  call, so that no concurrent lookup can see a partially removed
  driver.

Thread A (new_device_store)       | Thread B (pata_parport_unregister_driver)
  driver_find("ate")              |
                                  |   mutex_lock(&pi_mutex)
                                  |   idr_remove(&protocols, id)
                                  |   mutex_unlock(&pi_mutex)
                                  |   driver_unregister(&pr->driver)
                                  |   (frees driver_private)
  /* continues using stale driv */|
  -> UAF!                         |

Logs:
BUG: KASAN: slab-use-after-free in driver_find+0xd0/0xd4
Read of size 8 at addr ffffff9f970dc690 by task sh/4737
Call trace:
 show_stack+0x14/0x1c (C)
 dump_stack_lvl+0x70/0x84
 print_report+0xf4/0x5a4
 kasan_report+0xa0/0xe4
 __asan_report_load8_noabort+0x18/0x20
 driver_find+0xd0/0xd4
 new_device_store+0x140/0x30c [pata_parport]
 bus_attr_store+0x5c/0x94
 sysfs_kf_write+0x1c4/0x25c
 ...

Allocated by task 4734:
 kasan_save_stack+0x28/0x4c
 kasan_save_track+0x1c/0x34
 kasan_save_alloc_info+0x3c/0x4c
 __kasan_kmalloc+0x98/0xac
 __kmalloc_cache_noprof+0x158/0x3cc
 bus_add_driver+0x70/0x4d8
 driver_register+0xf0/0x3b0
 pata_parport_register_driver+0xb8/0x1c4 [pata_parport]
 0xffffffc07f5ce014
 do_one_initcall+0xb8/0x36c
 do_init_module+0x230/0x6d4
 ...

Freed by task 4737:
 kasan_save_stack+0x28/0x4c
 kasan_save_track+0x1c/0x34
 kasan_save_free_info+0x48/0x8c
 __kasan_slab_free+0x5c/0x84
 kfree+0x174/0x3e0
 driver_release+0x1c/0x7c
 kobject_put+0x178/0x47c
 driver_find+0x78/0xd4
 new_device_store+0x140/0x30c [pata_parport]
 bus_attr_store+0x5c/0x94
 sysfs_kf_write+0x1c4/0x25c
 ...

Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/lkml/20260728024015.2014674-1-shuangpeng.kernel@gmail.com/
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
changes in v2:
1.Modify to use the correct fix ID.
2.Use mutex_lock instead of guard.
---
 drivers/ata/pata_parport/pata_parport.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 40baeac594a9..cf81a6128f55 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -618,8 +618,9 @@ void pata_parport_unregister_driver(struct pi_protocol *pr)
 			break;
 	}
 	idr_remove(&protocols, id);
-	mutex_unlock(&pi_mutex);
 	driver_unregister(&pr->driver);
+	mutex_unlock(&pi_mutex);
+
 }
 EXPORT_SYMBOL_GPL(pata_parport_unregister_driver);
 
@@ -646,18 +647,18 @@ static ssize_t new_device_store(const struct bus_type *bus, const char *buf, siz
 		port_wanted = -1;
 	}
 
+	mutex_lock(&pi_mutex);
 	drv = driver_find(protocol, &pata_parport_bus_type);
 	if (!drv) {
 		if (strcmp(protocol, "auto")) {
 			pr_err("protocol %s not found\n", protocol);
+			mutex_unlock(&pi_mutex);
 			return -EINVAL;
 		}
 		pr_wanted = NULL;
 	} else {
 		pr_wanted = container_of(drv, struct pi_protocol, driver);
 	}
-
-	mutex_lock(&pi_mutex);
 	/* walk all parports */
 	idr_for_each_entry(&parport_list, parport, port_num) {
 		if (port_num == port_wanted || port_wanted == -1) {
-- 
2.25.1

