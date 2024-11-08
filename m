Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB5192D66
	for <linux-ide@vger.kernel.org>; Fri,  8 Nov 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096996; cv=none; b=Bt5Nt0+uD92kaTTiig6QWsXWMsNXiHIDMyfrCbO44KrvS4dguUwg6FljCT8sUP65dtRfa0bXgAqtGxaOG7+cT3s3ZyJXl8OVuxhpPtVkG7hgQfaScGMhnNeA3VJuFMoh8VNjzNIbR+5Mvk8wd6GyG/dEzhhZm3pL4Ar53Umfiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096996; c=relaxed/simple;
	bh=mVDphxO+zyUtym2hKfPTvKbkaFDjaTbSLPOVsFtJawU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=bfFH3kUjs/JavzE535ZHPXZ/OtyAq/tNpfX7NHVtXkLAA1vOMZSO2wXGBDRVt75Y371y8ofr7L9nJ8sg2IUmuJ4bjZVLwxlBEYRgN1J4m7SZUc1gCBGJvP0DTMKtfRJ+gN9uzuFRe5NjJjha8X9A1WsNoovZqxOxQH12vUbnVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.154.171) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 8 Nov
 2024 23:16:18 +0300
Message-ID: <ca23d30e-7444-4490-a7f2-7020e8cf6fb9@omp.ru>
Date: Fri, 8 Nov 2024 23:16:17 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/6] ata: acard-ahci: use dev_info() instead of,
 printk(KERN_INFO)
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

The ACard AHCI PCI device driver still calls printk(KERN_INFO, ...) in its
probe() method -- convert it to calling dev_info(), also somewhat rewording
the message itself...

This helpfully fixes the following complaint from scripts/checkpatch.pl:

WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/ata/acard-ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 547f56341705..0e16e64d1c5d 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -415,7 +415,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
 		host->flags |= ATA_HOST_PARALLEL_SCAN;
 	else
-		printk(KERN_INFO "ahci: SSS flag set, parallel bus scan disabled\n");
+		dev_info(&pdev->dev, "AHCI SSS flag set, parallel bus scan disabled\n");
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
-- 
2.47.0

