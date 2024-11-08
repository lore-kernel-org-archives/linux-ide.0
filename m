Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304041AA1C1
	for <linux-ide@vger.kernel.org>; Fri,  8 Nov 2024 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097322; cv=none; b=vGFQKhuljO95Ik6w0vqUQJJAgb3ROIrDxu2F8KbFqB9sooXbgtCHjZlY6TT7w131LsTLolT69Un7PAJf595CvAT9wiYcCldELlDvHf7QOCICWE9ZQWae9n8B13azQRioEkRdEhHYUSbqNdq31P64A0//pyNOv7aUdtE1q1efGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097322; c=relaxed/simple;
	bh=xoHlpOe8HK0MNcglKaWIk8u2CBZ6MuitKmpWDPi1fYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=RNE9sggTz5T57n0GKVqq/3OgDQGS+tkiZtmYYbh0fwBRpDaGkc6UWSUIEqrU/7mUWCXFDp++LfRZH6FOx4FeAYEXTt7Dz3Adh3pikkRCDh8busah1OE1YCFBMQQKFFmPi0r/bXs88CTON7xUYpYOJInChDZHfhYdIzENYQGjtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.154.171) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 8 Nov
 2024 23:21:51 +0300
Message-ID: <0d4048ed-8256-4c5f-9b6d-7e68786fa7cd@omp.ru>
Date: Fri, 8 Nov 2024 23:21:51 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/6] ata: pata_cs5530: use pr_*() instead of printk(KERN_*)
To: <linux-ide@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>
References: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
Content-Language: en-US
CC: Sergey Shtylyov <s.shtylyov@omp.ru>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/08/2024 19:59:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 189049 [Nov 08 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.7
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 41 0.3.41
 623e98d5198769c015c72f45fabbb9f77bdb702b
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.154.171 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.154.171 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.154.171
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/08/2024 20:04:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/8/2024 6:16:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The CS5530 PCI device driver still calls printk(KERN_INFO, ...) in
cs5530_is_palmax() and printk(KERN_ERR, ...) in cs5530_init_chip() --
convert them to calling pr_info() and pr_err() respectively...

This helpfully fixes the following complaints from scripts/checkpatch.pl:

WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/ata/pata_cs5530.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 1e67b0f8db43..4ff98c4722e9 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -177,7 +177,7 @@ static const struct dmi_system_id palmax_dmi_table[] = {
 static int cs5530_is_palmax(void)
 {
 	if (dmi_check_system(palmax_dmi_table)) {
-		printk(KERN_INFO "Palmax PD1100: Disabling DMA on docking port.\n");
+		pr_info("Palmax PD1100: Disabling DMA on docking port.\n");
 		return 1;
 	}
 	return 0;
@@ -206,11 +206,11 @@ static int cs5530_init_chip(void)
 		}
 	}
 	if (!master_0) {
-		printk(KERN_ERR DRV_NAME ": unable to locate PCI MASTER function\n");
+		pr_err(DRV_NAME ": unable to locate PCI MASTER function\n");
 		goto fail_put;
 	}
 	if (!cs5530_0) {
-		printk(KERN_ERR DRV_NAME ": unable to locate CS5530 LEGACY function\n");
+		pr_err(DRV_NAME ": unable to locate CS5530 LEGACY function\n");
 		goto fail_put;
 	}
 
-- 
2.47.0

