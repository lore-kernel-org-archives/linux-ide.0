Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713CD192B6F
	for <linux-ide@vger.kernel.org>; Fri,  8 Nov 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097416; cv=none; b=f01b6X6Xl4Cz2pPLPViIhskUuKQLu3lW/ek37uRX6vajzOr0mlErGBgjBL8ag632DvSZ3bIDdZcSyqnGIVsp4xHaa2LKPayQOCGKzK5WEFzrhZwSn/vzZBYuYRJvesTOz/JV+mqZMlrwr7wj0bQDF/cWI4J5y/b85vHqKapaQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097416; c=relaxed/simple;
	bh=U1iTEf4aMh9CnsRUFSkphdPrpz182Aw96jdNUq2s9M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=mE0qOTtK1wpLTwFmVikiR3mYR5ITWmXmlkvuaVK5HbqobQzaaSOoYBvUDiXsYaNB7efqab+E+rdOg/Ypo+2yNvhPocWFp7BITVrBOFvUTbG/lM9GfIluKTT747de8ntrVaSHWfosIc2zEnyRKbnJompTIWFoJ10gRt3hmn0Fuh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.154.171) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 8 Nov
 2024 23:23:23 +0300
Message-ID: <5d048235-2bac-4a27-b0ce-32e2aec298cb@omp.ru>
Date: Fri, 8 Nov 2024 23:23:23 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/6] ata: pata_legacy: use pr_*() instead of printk(KERN_*)
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
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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

The PATA legacy device driver still calls printk(KERN_ERR, ...) in
legacy_probe_add() and printk(KERN_INFO, ...) in probe_chip_type()
and probe_opti_vlb() -- convert them to calling pr_err() and pr_info()
respectively, also joining the broken up message strings...

This helpfully fixes the following complaints from scripts/checkpatch.pl:

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...

WARNING: quoted string split across lines

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_legacy.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index e7ac142c2423..9c6918e48448 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -209,7 +209,7 @@ static int legacy_probe_add(unsigned long port, unsigned int irq,
 		lp++;
 	}
 	if (free == NULL) {
-		printk(KERN_ERR "pata_legacy: Too many interfaces.\n");
+		pr_err("pata_legacy: Too many interfaces.\n");
 		return -1;
 	}
 	/* Fill in the entry for later probing */
@@ -927,8 +927,7 @@ static __init int probe_chip_type(struct legacy_probe *probe)
 
 		if ((inb(0x1F2) & 0x80) == 0) {
 			/* PDC20230c or 20630 ? */
-			printk(KERN_INFO  "PDC20230-C/20630 VLB ATA controller"
-							" detected.\n");
+			pr_info("PDC20230-C/20630 VLB ATA controller detected.\n");
 			udelay(100);
 			inb(0x1F5);
 			local_irq_restore(flags);
@@ -938,8 +937,7 @@ static __init int probe_chip_type(struct legacy_probe *probe)
 			inb(0x1F2);
 			inb(0x1F2);
 			if (inb(0x1F2) == 0x00)
-				printk(KERN_INFO "PDC20230-B VLB ATA "
-						     "controller detected.\n");
+				pr_info("PDC20230-B VLB ATA controller detected.\n");
 			local_irq_restore(flags);
 			return BIOS;
 		}
@@ -1096,8 +1094,7 @@ static __init void probe_opti_vlb(void)
 	u8 ctrl = (opti_syscfg(0x30) & 0xC0) >> 6;
 
 	opti82c46x = 3;	/* Assume master and slave first */
-	printk(KERN_INFO DRV_NAME ": Opti 82C46%s chipset support.\n",
-								optis[ctrl]);
+	pr_info(DRV_NAME ": Opti 82C46%s chipset support.\n", optis[ctrl]);
 	if (ctrl == 3)
 		chans = (opti_syscfg(0x3F) & 0x20) ? 2 : 1;
 	ctrl = opti_syscfg(0xAC);
-- 
2.47.0

