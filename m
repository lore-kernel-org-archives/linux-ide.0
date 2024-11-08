Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917D192D66
	for <linux-ide@vger.kernel.org>; Fri,  8 Nov 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097068; cv=none; b=W2Ed49G8od9lH69bliQH46RnUjUWzOOexe3I66oJYvXATES6FPT9++516mD3gqo8IzMGkGvTOjOekiLfUbb6/OXZuLbY0qy4jfAkOzI7CpPg1IDy8+ic9GZo1XUP77qDzbwpfQvC8YKwInGc+WU4cNzWZSd1OvKRM/8DtaqAbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097068; c=relaxed/simple;
	bh=XDc+n/QnjCXyO4JyYO6BSKvNGdZvMsp2rLdXw2Drffs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=rfipeVGlf0gi94VR7LpkuVhyfMi8j0Ssd/mAP5Kjt/17rwvFftJVSWOl6jwIpLTfsbzbzKgVSGI6GC6J43/BcJblcSccPwin58tYDFF5WzLptsmnm6gE5JjbEVMU2c5o54BAMlafGSri8HoB4Z7me/1CIxVAEFxsRyatNFU+G+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.154.171) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 8 Nov
 2024 23:17:35 +0300
Message-ID: <98cac57e-de28-48f2-99a8-a6d1afae1610@omp.ru>
Date: Fri, 8 Nov 2024 23:17:35 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/6] ata: ahci: use dev_info() instead of printk(KERN_INFO)
To: <linux-ide@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>
References: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
Content-Language: en-US
CC: Sergey Shtylyov <sergei.shtylyov@gmail.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/08/2024 19:51:35
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
X-KSE-Antiphishing-Bases: 11/08/2024 19:55:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/8/2024 6:16:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The AHCI PCI device driver still calls printk(KERN_INFO, ...) in
ahci_mcp89_apple_enable() and ahci_init_msi() -- convert them to
calling dev_info(), somewhat rewording the messages themselves...

This helpfully fixes the following complaint from scripts/checkpatch.pl:

WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...

Signed-off-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>

---
 drivers/ata/ahci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2d3d3d67b4d9..32c79b41ddea 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1141,7 +1141,7 @@ static void ahci_mcp89_apple_enable(struct pci_dev *pdev)
 {
 	u32 val;
 
-	printk(KERN_INFO "ahci: enabling MCP89 AHCI mode\n");
+	dev_info(&pdev->dev, "enabling MCP89 AHCI mode\n");
 
 	pci_read_config_dword(pdev, 0xf8, &val);
 	val |= 1 << 0x1b;
@@ -1692,8 +1692,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 			 * Fallback to single MSI mode if the controller
 			 * enforced MRSM mode.
 			 */
-			printk(KERN_INFO
-				"ahci: MRSM is on, fallback to single MSI\n");
+			dev_info(&pdev->dev, "AHCI MRSM is on, fallback to single MSI\n");
 			pci_free_irq_vectors(pdev);
 		}
 	}
-- 
2.47.0

