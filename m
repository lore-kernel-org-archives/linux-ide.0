Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3A6AA7
	for <linux-ide@vger.kernel.org>; Sun, 20 Oct 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729443027; cv=none; b=XUSyak6XruX5TLFluFIOYD9XOo/MjW0gn95eK0VKrZwYxnXcc5ruxzzTM/DDmHbcdPWevKT8CiH1CRcpeKearuzaazSf6fx9v0X1E+wJHMpvCLASYK4WKHJQJ4JQAoiWX1X4FjspgNytijemFlD2KHWzSoY16NCzjpV+5lWfAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729443027; c=relaxed/simple;
	bh=QmKP0EvUxYhq4U/0hqG8nrIoP1JJ88c2FSFbRHhW/5A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BWLuaWwFLC23AlchS7deCrolT/OlmSLOSGMpzNpB48gpfYo9nzlky+8cNvPFpEkUwGWBRNOUitls4XWegc5E4l6VULIXeW1gWAPnebQJkgZzinycw+u+WhT1fjan+7EAyuCgH8LtGd/LXUnvADcxcJF++KJYA6/Uk9455ROp0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.152.29) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 20 Oct
 2024 19:50:18 +0300
Message-ID: <4ea0407c-46f5-4744-8642-1c7da52a7d7e@omp.ru>
Date: Sun, 20 Oct 2024 19:50:17 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] ata: ata_generic: use IS_ENABLED() macro
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: <linux-ide@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>
References: <c1b91a7a-74a9-46bf-914a-b8dfc669849e@omp.ru>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <c1b91a7a-74a9-46bf-914a-b8dfc669849e@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 10/20/2024 16:33:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 188560 [Oct 20 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 40 0.3.40
 cefee68357d12c80cb9cf2bdcf92256b1d238d22
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.152.29 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.152.29 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.152.29
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/20/2024 16:36:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/20/2024 2:01:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Replace the explicit defined(CONFIG_PATA_TOSHIBA[_MODULE]) checks with
the new-fangled IS_ENABLED() check in the ata_generic[] definition...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
Changes in version 2:
- refreshed atop of the newly added patch #1;
- rephrased the patch description.

 drivers/ata/ata_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index d6c210510c36..d5b2fa2ba6ad 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -225,7 +225,7 @@ static struct pci_device_id ata_generic[] = {
 	 * these chips were handled by the generic driver; keep the
 	 * old behavior if the dedicated driver is not enabled...
 	 */
-#if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
+#if !IS_ENABLED(CONFIG_PATA_TOSHIBA)
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_3),  },
-- 
2.47.0

