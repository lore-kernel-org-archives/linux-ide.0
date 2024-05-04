Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C341C6C
	for <linux-ide@vger.kernel.org>; Sat,  4 May 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714854474; cv=none; b=ooTuyGMYQa7CyBHmaHgZj6DgeImQ8j7ILU9tOLSJV2EEWNB5KN6ePppq69ibwWL3gfILMI+LBF0uUMlKTu65Pn4aj/0JPlRJqZY5ryIMPgsVD2xKuKuodftN1OpK4X5pGw+gBuYoQUQlWkIuSmxb54REEYFGUM+jcS1jGDZ0pYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714854474; c=relaxed/simple;
	bh=tX3KTxFyuRQKhiTsSKTCWMhh/vqtUMAM71naPIKg3eg=;
	h=From:Subject:To:CC:Message-ID:Date:MIME-Version:Content-Type; b=f8C36sRXNUzosS/XCbX8mobS+vmigp0horgWov493pdBFg58i8GZPyk6H7/I2QzJ0/0YwBVckvoOlMQ1zr/vVI26EKNLYV/RIp5BKhEk6xVYES1e/FD8C9jC9Ej69bN/bjqOp26fOuKV51NRyrh5J7QwIgNuPJ6H3cgIOcag3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.78.178) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 4 May
 2024 23:27:26 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: pata_legacy: make legacy_exit() work again
To: <linux-ide@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>
CC: <lvc-project@linuxtesting.org>
Organization: Open Mobile Platform
Message-ID: <c6ad7d07-4dc8-7087-4018-6ebdf93d6580@omp.ru>
Date: Sat, 4 May 2024 23:27:25 +0300
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 05/04/2024 20:04:41
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 185057 [May 04 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 19 0.3.19
 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.178 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.178
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/04/2024 20:10:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 5/4/2024 6:17:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Commit defc9cd826e4 ("pata_legacy: resychronize with upstream changes and
resubmit") missed to update legacy_exit(), so that it now fails to do any
cleanup -- the loop body there can never be entered.  Fix that and finally
remove now useless nr_legacy_host variable...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: defc9cd826e4 ("pata_legacy: resychronize with upstream changes and resubmit")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the master branch of the LibATA Group's linux.git repo.
It's only been build-tested...

 drivers/ata/pata_legacy.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux/drivers/ata/pata_legacy.c
===================================================================
--- linux.orig/drivers/ata/pata_legacy.c
+++ linux/drivers/ata/pata_legacy.c
@@ -173,8 +173,6 @@ static int legacy_port[NR_HOST] = { 0x1f
 static struct legacy_probe probe_list[NR_HOST];
 static struct legacy_data legacy_data[NR_HOST];
 static struct ata_host *legacy_host[NR_HOST];
-static int nr_legacy_host;
-
 
 /**
  *	legacy_probe_add	-	Add interface to probe list
@@ -1276,9 +1274,11 @@ static __exit void legacy_exit(void)
 {
 	int i;
 
-	for (i = 0; i < nr_legacy_host; i++) {
+	for (i = 0; i < NR_HOST; i++) {
 		struct legacy_data *ld = &legacy_data[i];
-		ata_host_detach(legacy_host[i]);
+
+		if (legacy_host[i])
+			ata_host_detach(legacy_host[i]);
 		platform_device_unregister(ld->platform_dev);
 	}
 }
