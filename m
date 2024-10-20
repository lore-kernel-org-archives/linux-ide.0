Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D509F6AA7
	for <linux-ide@vger.kernel.org>; Sun, 20 Oct 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729442889; cv=none; b=Q5NHznDezylZMDMwhjLZB7PjmX1FcwEUeFoYQ0UpOdnm+7POzvI6qC0q/nIZOWRKdyZKLYRHYA9vxEMK2LbUgj3PjLKqAfjt9ad6DGfUSxC1o8HOXkgZAx1Rk1cabWgGdOterWnTYDj2sEmv3SgKshQf0QtngAO48me7JUqEz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729442889; c=relaxed/simple;
	bh=ZUtQoX75wGB8cTNPCMQ+/JLg3DWFHsk+doJYAh8Igl8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=ImElCJFbaG4Xbw8bfHAYpcAumzSxS7DUosBX+kqHFz+Vp8V1osHwh/03BnBX0rPvjgZPFT4nlXKJD742/d3ZLpnBDCwclsJgCU7znpWnE8Y8Bgcme+0/QonZnrYXr01bPTNB+WKmiWxYPrmGBbGvuAbuIfJ6HTgP1UzaxxGBDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.152.29) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 20 Oct
 2024 19:47:47 +0300
Message-ID: <c1b91a7a-74a9-46bf-914a-b8dfc669849e@omp.ru>
Date: Sun, 20 Oct 2024 19:47:46 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 0/2] ata: ata_generic: clarify about Toshiba Piccolo
 support
To: <linux-ide@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Niklas
 Cassel <cassel@kernel.org>
Content-Language: en-US
Organization: Open Mobile Platform
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

Here are 2 patches against the for-next branch of the LibATA Group's repo.

First I saw that the support for the Toshiba Piccolo chips in the generic
ATA driver was guarded by the old-fashioned checks and replaced them by
IS_ENABLED(); then Damien asked to add a clarifying comment before that
check -- and we have 2 patches now! :-)

Sergey Shtylyov (2):
  ata: ata_generic: add comment about Toshiba Piccolo
  ata: ata_generic: use IS_ENABLED() macro

 drivers/ata/ata_generic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.47.0
