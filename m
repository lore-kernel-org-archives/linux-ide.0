Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915CD17D34D
	for <linux-ide@vger.kernel.org>; Mon,  9 Sep 2024 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915100; cv=none; b=qOeH2hHztCBPtZJ6xjTxOF7jeO7qGnwyPtUZXccwEAzhde/QE8HX5+UmawuN/PQRwB7QdKBouiHIJiRHNUD2nN0AENxSqq7f1IaToz44VHWYNLO4UnvE7NcfUXhXsQSfuWKUl60BG1Kf/9kVPieHuVz8dEblz1WN7HQtMYSHcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915100; c=relaxed/simple;
	bh=3r1C7BcIfj4tg0QOgwViGh7AT73+wHN1Ro/lGksF0yQ=;
	h=From:Subject:To:CC:Message-ID:Date:MIME-Version:Content-Type; b=cEtcT2Vm925t8pQtzfh5NUqGM4CaWMocELY+ypCpBZ51XWjUJkNQ6wfssDzYclAM1T0ANHgf61oRoVdTFQ5hgWu7ujOSX9pNbACQLvwNtLV27BGRdZnF+beM7gSYumMOzgDykXqO0hRkNgKBsapyixwG64IdIazYTOd8R1inneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.106] (31.173.81.96) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 9 Sep
 2024 23:51:26 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: ata_generic: use IS_ENABLED() macro
To: <linux-ide@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>
CC: <lvc-project@linuxtesting.org>
Organization: Open Mobile Platform
Message-ID: <d9c0acab-909e-da06-decf-be5de59d23bf@omp.ru>
Date: Mon, 9 Sep 2024 23:51:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/09/2024 20:21:48
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187640 [Sep 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.96 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.96 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.96
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/09/2024 20:24:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/9/2024 4:30:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Replace now gone out of fashion defined(CONFIG_PATA_TOSHIBA[_MODULE])
with the new-fangled IS_ENABLED() macro in the ata_generic[] definition.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the for-next branch of the LibATA Group's repo.

 drivers/ata/ata_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/ata/ata_generic.c
===================================================================
--- linux.orig/drivers/ata/ata_generic.c
+++ linux/drivers/ata/ata_generic.c
@@ -220,7 +220,7 @@ static struct pci_device_id ata_generic[
 	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
 	  .driver_data = ATA_GEN_FORCE_DMA },
-#if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
+#if !IS_ENABLED(CONFIG_PATA_TOSHIBA)
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_3),  },
