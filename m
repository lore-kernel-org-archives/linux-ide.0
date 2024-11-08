Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F811C1F3F
	for <linux-ide@vger.kernel.org>; Fri,  8 Nov 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097796; cv=none; b=Uv28uw+2KoCNTVMakiCpsWxfQGmRdzhQ1dDJu+RRUqTEVJkwFvvAgvM313mU7e2Af0kmPCRnnhV4t6HyVmNF/JHXeVZEEHQo1NU2hwjps4TwH57zC9yxRqfp0O2V48o909ZbY03XOUTQMDXKLV/gXgdO6w3O8K+9mE/gkZ3oQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097796; c=relaxed/simple;
	bh=HmUgIABVShy5StXbl9NFjuucLUBMflvdxzzuFzE9+Co=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=MIbKHNUYspIm1BzL6EKjUyw0YjlnT1h6EDtbwIl+0PDb8CddlffUrBIgtwU/4b4Wqr2/lygtedcy4RP5jsIYHrcOQuc7v9ffIDOa/J24Wivx3KFIgMcNUHU2JfKDdYdeVo1QAIAIrDWvBOhJfnmOUAtF9+f2RLKD9hv5pgh5Mzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.154.171) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 8 Nov
 2024 23:14:38 +0300
Message-ID: <6cf8979c-c50d-4ef0-b1df-281d932d92b6@omp.ru>
Date: Fri, 8 Nov 2024 23:14:37 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 0/6] libata: get rid of (almost) all printk() calls
To: <linux-ide@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>
Content-Language: en-US
CC: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
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
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.154.171 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2
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

Here are 6 patches against the for-next branch of the LibATA Group's repo.

Hannes Reinecke's large patch series [1] claimed to have moved libata to
the structured logging, i.e. using dev_*() calls; however, some printk()
calls were left as is.  Convert them to dev_*() calls where possible,
otherwise convert to pr_*() calls -- this pleases checkpatch.pl at last.

[1] https://lore.kernel.org/all/20211221072131.46673-1-hare@suse.de/

Sergey Shtylyov (6):
  ata: acard-ahci: use dev_info() instead of printk(KERN_INFO)
  ata: ahci: use dev_info() instead of printk(KERN_INFO)
  ata: libata-core: use pr_warn() instead of printk(KERN_WARNING)
  ata: pata_cs5530: use pr_*() instead of printk(KERN_*)
  ata: pata_legacy: use pr_*() instead of printk(KERN_*)
  ata: pata_optidma: use dev_warn() instead of printk(KERN_WARNING)

 drivers/ata/acard-ahci.c   |  2 +-
 drivers/ata/ahci.c         |  5 ++---
 drivers/ata/libata-core.c  |  8 +++-----
 drivers/ata/pata_cs5530.c  |  6 +++---
 drivers/ata/pata_legacy.c  | 11 ++++-------
 drivers/ata/pata_optidma.c |  2 +-
 6 files changed, 14 insertions(+), 20 deletions(-)

-- 
2.47.0
