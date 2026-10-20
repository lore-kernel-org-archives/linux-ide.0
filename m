Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466490;
	b=rV5lUGPExIfrxYudJVZ1w8+R9AygSatnpWSbAVlCtorJDyIK8NzyDz49IzW4JUD80SjJ
	 xYoG1L52cbV73CpaQGYH035b5WgUsVCiY0lz9ujf+xZHo0gt+j29XpHj9tbxo/POQqoxP
	 ZbBSjt58c/vrzIVHx3PK6exawPS0dzcym6f8bPQUn+Q/E+C/U62A97H0/bMUkkfxA/8lD
	 B6Mq1cjEWQz4ba4Y22ro3WUEsrVupi0cSxjMOJQYw5XZ4AC13wAFIFnmv+t6KuHYOWLax
	 UW8U39KFQSGLQuECPvwG69i+RcQ3+aS0FBn/XCzbzEoyTUdc+jh8k7tEdoS/BnIrTBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466490;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3ZczriNEGbYP80Dxb3vE1rbQgQ2Yn+EPpd9+08XBNYI=;
	b=5R2FCEjtYXF3C2CnY+/YrrMcSfHKNPZ8j53t1U6w08z2BwYNzzBLSk7seKzhnfVrPpEG
	 UpBMxKn7cS6Xo1usYGnP7qNIEs5L6UhVcbt1BsCwcrx9xTtlraTGicbkRN9xcK5db0eqi
	 PH6Ub22qKbcNVJ5w93VMvwYymjCisPBX4iyuiLcx0869Zuo611WH5Qifcg08pUrZhQ45I
	 dBR21RYhsIuUWVzh7JXucPekcPFT1/xRZbYcPErn9T41Mkrlm/rn/egDNxx16lqTHfRNR
	 ETzEw3EjJQugEJDbpBaxKbATj9kI1oC2sN6MTmMTlwtFYg2RnrJpoyKXK8DE/FsaDSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=YtOYWhTo;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F137606A319;
	Tue, 20 Oct 2026 03:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F137606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=YtOYWhTo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=YtOYWhToBcLQDDnXV+HFp1yvkgalicr8vcec1O1Cv0zZ2VWj0VsNxC2XYW1Bgtw3ZrJ8gPF/IKyoZ
	 xLz9UJsQmdE+wvjtIal9wgJ0XldJCynb1qCKgMqvB3S2FYKbYoXiKhPozaUlspc8vHmS+5Od+rWRn2
	 lpINaiF0vj4DVvpI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16ad6de33b55-f2fc2;
	Tue, 20 Oct 2026 11:21:26 +0800 (CST)
X-RM-TRANSID:2ee16ad6de33b55-f2fc2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[36.137.216.38])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86ad6de27eca-bdbd6;
	Tue, 20 Oct 2026 11:21:25 +0800 (CST)
X-RM-TRANSID:2ee86ad6de27eca-bdbd6
From: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tongzhiwei <tongzhiwei@cmss.chinamobile.com>
Subject: [PATCH v2] ata: libata: skip sata_down_spd_limit() when no device is present
Date: Tue, 20 Oct 2026 11:20:54 +0800
Message-ID: <20261020032054.430-1-tongzhiwei@cmss.chinamobile.com>
X-Mailer: git-send-email 2.45.0.windows.1
In-Reply-To: <20261010075457.882-1-tongzhiwei@cmss.chinamobile.com>
References: <20261010075457.882-1-tongzhiwei@cmss.chinamobile.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A hot-unplug goes through ata_eh_schedule_probe() -> ata_dev_init() ->
sata_spd = 0.  After commit 69f2c9346313 ("ata: libata: Fix
sata_down_spd_limit() when no link speed is reported"), when the device
is unplugged, every probe lowers sata_spd_limit.  This breaks
commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return
if driver has not recorded sstatus speed").

As a result, when the device is plugged back in, it is limited to a
low speed that is never recovered.

Use the SStatus DET field to detect the no-device case and bail out
of sata_down_spd_limit() when no device is present (DET == 0).

Fixes: 69f2c9346313 ("ata: libata: Fix sata_down_spd_limit() when no link speed is reported")
Assisted-by: LLM
Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
---
Changes since v1:
- v1 ("ata: libata: preserve sata_spd link cache across ata_dev_init") took the
  wrong approach (caching sata_spd across ata_dev_init).  This version instead
  bails out of sata_down_spd_limit() when SStatus indicates no device is present
  (DET == 0), without altering ata_dev_init() or the sata_spd cache.

 drivers/ata/libata-sata.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index ad40f516c6d4..775da21cbbae 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -549,6 +549,9 @@ int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 	 * If not, use cached value in link->sata_spd.
 	 */
 	rc = sata_scr_read(link, SCR_STATUS, &sstatus);
+	/* No device present (DET == 0): nothing to recover by lowering speed. */
+	if (rc == 0 && (sstatus & 0xf) == 0)
+		return -EINVAL;
 	if (rc == 0 && ata_sstatus_online(sstatus))
 		spd = (sstatus >> 4) & 0xf;
 	else
-- 
2.43.0




