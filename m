Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC441C1F36
	for <linux-ide@vger.kernel.org>; Fri,  8 Nov 2024 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097577; cv=none; b=D4pjrJhhpSbhvRXjMoI3seVTqPHiw+3nWXOAQTjxuAHO/itLqux0512UPBT2CUK6laUz0FQp6Zdib8xt+GJwYXw/08U/yVeLAsshh1ec404FNkG77vsSJXszHDDDdaYrWFn8m4tcya1BmfWgKtH8h50dl2BEV8ZjQunVv3H6HDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097577; c=relaxed/simple;
	bh=7euJUJUlk/doFkTeZIJrt9klOozZXTqjnqNgUYaqDkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=gQHL4Zz4zi0sD4WFuDFcQ1LzzIq0pv4aHjvf5rwrtp9igV4dcFK2JIvjjvkdOCUDamLAVR8BJZ2f2Icjrrri4dCD0LWbVaIpCQP89IklKvmcQGGZNoD21SewXM1t+OHEMzBe7/QLfkHJfBGwv2Fpw5Xf0wzpvUJwrXSe+TKrGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.154.171) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 8 Nov
 2024 23:26:13 +0300
Message-ID: <0a19e2e7-b33c-4fb2-9183-33855337097d@omp.ru>
Date: Fri, 8 Nov 2024 23:26:12 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6/6] ata: pata_optidma: use dev_warn() instead of
 printk(KERN_WARNING)
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
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 189049 [Nov 08 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.7
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 41 0.3.41
 623e98d5198769c015c72f45fabbb9f77bdb702b
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.154.171
X-KSE-AntiSpam-Info: Rate: 0
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

The OPTi PCI device driver still calls printk(KERN_WARNING, ...) in
optiplus_with_udma() -- convert it to calling pr_warn()...

This helpfully fixes the following complaints from scripts/checkpatch.pl:

WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
dev_warn(dev, ... then pr_info(...  to printk(KERN_WARNING ...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/ata/pata_optidma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index dfc36b4ec9c6..23e2326ce31e 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -390,7 +390,7 @@ static int optiplus_with_udma(struct pci_dev *pdev)
 	if (r & 0x80)	/* IDEDIR disabled */
 		ret = 1;
 done:
-	printk(KERN_WARNING "UDMA not supported in this configuration.\n");
+	dev_warn(&pdev->dev, "UDMA not supported in this configuration.\n");
 done_nomsg:		/* Wrong chip revision */
 	pci_dev_put(dev1);
 	return ret;
-- 
2.47.0

