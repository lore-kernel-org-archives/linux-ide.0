Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B36AA7
	for <linux-ide@vger.kernel.org>; Sun, 20 Oct 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729442969; cv=none; b=AogNRkCKVG7DgNbGFeysPziTH/nomofx59y00xyr5/k6T1hva/E8DzjSDW1YLJ6NjLcFJmXoW23FgO0yikghlRxs0iVQMrGsW6faZUrApXUFPVWdZOp5LuCpNY/dPn29QWXdcf8fwH2kECVip+cOXhyBl6whLLOvP7rV6twX6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729442969; c=relaxed/simple;
	bh=0Ztj04prAva2Cz6EygRftSQcAPZhBy2KTqGBy9k7ab4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bwucwVGfLvBAPVt3REd8rD4ITk0O9Qv5PW6XVp1mKDF4KVAYfW3u1udbEAx+64JRGng0CbmBJE3nlUCy33ThPGsHzlCRm/gnM1fg2Rn/LWxOZCgEtxoy/RRHUoG3loi93SOfKOco84EtKoNuhCFucr5P9MNaxULFXfDgxx3S58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.152.29) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 20 Oct
 2024 19:49:17 +0300
Message-ID: <7d8a58b7-dbc9-474c-8996-6218aa89d0be@omp.ru>
Date: Sun, 20 Oct 2024 19:49:16 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/2] ata: ata_generic: add comment about Toshiba Piccolo
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

Before the dedicated Toshiba Piccolo driver was written by Alan Cox,
these chips were handled by the generic driver; in case the dedicated
driver isn't enabled, the generic driver keeps claiming these chips --
add a comment clarifying that...

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
Changes in version 2:
- new patch.

 drivers/ata/ata_generic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 2f57ec00ab82..d6c210510c36 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -220,6 +220,11 @@ static struct pci_device_id ata_generic[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
 	  .driver_data = ATA_GEN_FORCE_DMA },
+	/*
+	 * Before the dedicated Toshiba Piccolo driver was written,
+	 * these chips were handled by the generic driver; keep the
+	 * old behavior if the dedicated driver is not enabled...
+	 */
 #if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },
-- 
2.47.0

