Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077A1AA1FA
	for <linux-ide@vger.kernel.org>; Fri,  8 Nov 2024 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097233; cv=none; b=JNUj3kfLAjdTfkYaZuLnT68dX6EGx/KLADJ8xko/6WtxZXorDHf51NHdm0DCIWn2XWAaiqHDD1IHvwLMGMpCNpkqD9eNSMZs44Ogj9O2a6/V/Baj4GtvAfM+vcHs+rsEuhoQg9L961eaHQIaWYPCGJBW6yABKYPpv2WQNLm4mlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097233; c=relaxed/simple;
	bh=9rLXCgqH2DB3/C6H3+VEQ70BUSpc/UD39RnwDpTLzVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=VS/U8Bln7EOcYSD2TvhyyIsVfzzIYpFFHc95WMh7wvVmJVpEaxn9QBpafJTkupu+aVIVfAaEKvpeby6UvOiEIvIQQ7/x9yJSNEVt/sXrRD47r1Jv9QDUritjG8agFH6gt74Vmba/WHoX+Qrf+VFibfNh09nPCamo8vrHR8eNX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.154.171) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 8 Nov
 2024 23:20:21 +0300
Message-ID: <813b22ec-a16d-4598-8c61-6522ced1116e@omp.ru>
Date: Fri, 8 Nov 2024 23:20:20 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/6] ata: libata-core: use pr_warn() instead of
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

ata_parse_force_param() still calls printk(KERN_WARNING, ...) -- convert
it to calling pr_warn(), also joining the broken up message strings...

This helpfully fixes the following complaints from scripts/checkpatch.pl:

WARNING: Prefer [subsystem eg: netdev]_warn([subsystem]dev, ... then
dev_warn(dev, ... then pr_warn(...  to printk(KERN_WARNING ...

WARNING: quoted string split across lines

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/ata/libata-core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cdb20a700b55..47f652981043 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6443,8 +6443,7 @@ static void __init ata_parse_force_param(void)
 
 	ata_force_tbl = kcalloc(size, sizeof(ata_force_tbl[0]), GFP_KERNEL);
 	if (!ata_force_tbl) {
-		printk(KERN_WARNING "ata: failed to extend force table, "
-		       "libata.force ignored\n");
+		pr_warn("ata: failed to extend force table, libata.force ignored\n");
 		return;
 	}
 
@@ -6455,9 +6454,8 @@ static void __init ata_parse_force_param(void)
 
 		next = cur;
 		if (ata_parse_force_one(&next, &te, &reason)) {
-			printk(KERN_WARNING "ata: failed to parse force "
-			       "parameter \"%s\" (%s)\n",
-			       cur, reason);
+			pr_warn("ata: failed to parse force parameter \"%s\" (%s)\n",
+				cur, reason);
 			continue;
 		}
 
-- 
2.47.0

