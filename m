Received: from mail-m24107.xmail.ntesmail.com (mail-m24107.xmail.ntesmail.com [45.195.24.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6A3FE4A;
	Mon, 16 Sep 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473068; cv=none; b=rfTRXr+kW/FKzVNVX81tynDdNr7rfvkDTZhOzgIKw5m5Ns98x6aTPFO+mSewmbA6GPqdi5q+fki+GBMbAKGVnvywX8YKnMlnbGi5WayfnFinXvhf2jnpXCT4r8Mi/pNk8MH4tfEh7F+HJ9rkwSrV1qVIW/DwNnMTJvZg5z84oVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473068; c=relaxed/simple;
	bh=3WC3+vQthHcjSb94pmTkFylbQh9rHbtR/Uji9nicOCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/j7D0QZj2N2BG8A42X8eEcDu5TVJMhsJjneeuL1OUr2mbgrf+3ZP8/HSJRm2pIJjCHriYx1Mqg4DA6VDv4E1vt9xFVNmghagEcUs2N0k4aJAWH4dn8wTcZQhLJmGw+xU/EW11hizcFSp+SVBEIB0VZI6DVnPpVxzeE3CrS9NO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zspace.cn; spf=pass smtp.mailfrom=zspace.cn; arc=none smtp.client-ip=45.195.24.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zspace.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zspace.cn
Received: from localhost.localdomain (unknown [123.113.110.156])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 4922D1C01F0;
	Mon, 16 Sep 2024 15:42:35 +0800 (CST)
From: Guoliang Zhang <zhangguoliang@zspace.cn>
To: dlemoal@kernel.org
Cc: cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guoliang Zhang <zhangguoliang@zspace.cn>
Subject: [PATCH] ata: libata-eh: Fix the low data link negotiation
Date: Mon, 16 Sep 2024 15:42:31 +0800
Message-ID: <20240916074232.2584182-1-zhangguoliang@zspace.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHU4aVk1PH0gfQktJHU1DHlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVSkpIVUpKS1VKTk1ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
X-HM-Tid: 0a91f9c88be309d6kunm4922d1c01f0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6Pww4QzI1ThYuGCE9KSI*
	NzQKFDNVSlVKTElNT0xJTk5NS09DVTMWGhIXVQETGhUcHA4UFxIaFRw7AQgLGhgeVRgVRVlXWRIL
	WUFZSklIVUpKSFVKSktVSk5NWVdZCAFZQUhDT0o3Bg++

large capacity hard drives, such as the 16TB Seagate hard drive in hotplug,
have data link negotiations that only reach 3.0 Gbps.
The reason for the issue is that after powering on, the hardware reset time
of the hard drive is relatively long.
In the driver, after the hardreset signal is sent, the waiting time for the
first two tries is too short,
causing the hardware reset to fall into a vicious cycle.

log is as follows:
[ 959.461875] ata7: found unknown device (class 0)
[ 963.686830] ata7: softreset failed (1st FIS failed)
[ 969.442516] ata7: found unknown device (class 0)
[ 973.686229] ata7: softreset failed (1st FIS failed)
[ 979.426704] ata7: found unknown device (class 0)
[1008.687432] ata7: softreset failed (1st FIS failed)
[1008.687447] ata7: limiting SATA link speed to 3.0 Gbps
[1009.566733] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[1009.567405] ata7.00: ATA-11: ST16000NT001-3LV101, EN01, max UDMA/133
[10009.613694] ata7.00: 31251759104 sectors,
multi 16: LBA48 NCQ (depth32), AA
[10009.614223] ata7.00: Features: NCQ-sndrcv
[10009.639149] ata7.00: configured for UDMA/133
[10009.639366] scsi 6:0:0:0: Direct-Access  ATA ST16000NT001-3LVEN01
 PQ: 0 ANSI: 5
[10009.639779] sd 6:0:0:0: Attached scsi generic sg2 type 0
[10009.639989] sd 6:0:0:0: [sdc] 31251759104 512-byte logical blocks:
(16.0 TB/14.6 TiB)
[10009.639999] sd 6:0:0:0: [sdc] 4096-byte physical blocks
[10009.640028] sd 6:0:0:0: [sdc] Write Protect is off
[10009.640038] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[10009.640082] sd 6:0:0:0: [sdc] Write cache: enabled, read cache:enabled,
doesn't support DPO or FUA
[10009.717866]  sdc: sdc1 sdc2 sdc3 sdc4
[10009.739038] sd 6:0:0:0: [sdc] Attached SCSI disk
========
Logs after modify:
[  661.023298] ata7: found unknown device (class 0)
[  675.253714] ata7: softreset failed (1st FIS failed)
[  680.996545] ata7: found unknown device (class 0)
[  695.251101] ata7: softreset failed (1st FIS failed)
[  696.131404] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  696.132140] ata7.00: ATA-11: ST16000NT001-3LV101, EN01, max UDMA/133
[  696.172742] ata7.00: 31251759104 sectors, multi 16: LBA48 NCQ (depth
32), AA
[  696.173327] ata7.00: Features: NCQ-sndrcv
[  696.198155] ata7.00: configured for UDMA/133

Signed-off-by: Guoliang Zhang <zhangguoliang@zspace.cn>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 214b935c2ced..9e0f17e93e73 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -80,7 +80,7 @@ enum {
  */
 static const unsigned int ata_eh_reset_timeouts[] = {
 	10000,	/* most drives spin up by 10sec */
-	10000,	/* > 99% working drives spin up before 20sec */
+	20000,	/* > 99% working drives spin up before 30sec */
 	35000,	/* give > 30 secs of idleness for outlier devices */
 	 5000,	/* and sweet one last chance */
 	UINT_MAX, /* > 1 min has elapsed, give up */
-- 
2.43.0

