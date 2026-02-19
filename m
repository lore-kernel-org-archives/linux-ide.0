Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B33346BC
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487576; cv=none; b=il5ItM+vvCx/33+LolA6fE/WD2NQMftrC2Ww1nvFAyziwDoSvFxIGfb0JWh730lEIZrnTyOBShCrC2yNQaumA2o2JgJmuVtYeUt7ylHCnDo2M17arh+Xzk49UN68CQPzmEo/wKqrrObJaKfRjG0wplHbCllrnqF85e2/5jKJNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487576; c=relaxed/simple;
	bh=lf3CV8aUJXei677G7jpyNANxRaUYa5FRvykqIndO2vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OrrpWPII041RBxQH2IttlrguRR8LfC4xbQHCVyhr41A1y5wyTn0C2yqGOGudUlDqH5g/nKGLS/dF36e9MFcF+bpJni86XD9McXXZ8BDfGQJEbdaINJudHFxkxR2AABjkSt2MnnGbuGzvKuv1Dr8xyVOEmuMTx0jgukjhC3tqUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (213.87.154.131) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 19 Feb
 2026 10:52:36 +0300
Message-ID: <4b93017e-7c92-4996-b2f8-a44eb982cc69@omp.ru>
Date: Thu, 19 Feb 2026 10:52:35 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ata: libata-scsi: simplify
 ata_scsi_schedule_deferred_qc()
To: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>, Niklas
 Cassel <cassel@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
 <20260219062312.1030867-4-dlemoal@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20260219062312.1030867-4-dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 02/19/2026 07:37:38
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 200650 [Feb 19 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.20
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 87 0.3.87
 7430d8ffafccd8879e1d8370e5b501352446c2ba
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.154.131 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.154.131
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/19/2026 07:39:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/19/2026 5:13:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/19/26 9:23 AM, Damien Le Moal wrote:

> Use ata_qc_done() instead of calling ata_qc_free() and scsi_done()
> directly.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-scsi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index c0dd75a0287c..41918e21d0f8 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1685,7 +1685,6 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
>  void ata_scsi_requeue_deferred_qc(struct ata_port *ap)

   You're simplifying ata_scsi_requeue_deferred_qc() but the subject has
ata_scsi_schedule_deferred_qc()...

>  {
>  	struct ata_queued_cmd *qc = ap->deferred_qc;
> -	struct scsi_cmnd *scmd;
>  
>  	lockdep_assert_held(ap->lock);
>  
> @@ -1697,11 +1696,9 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>  	if (!qc)
>  		return;
>  
> -	scmd = qc->scsicmd;
>  	ap->deferred_qc = NULL;
> -	ata_qc_free(qc);
> -	scmd->result = (DID_SOFT_ERROR << 16);
> -	scsi_done(scmd);
> +	qc->scsicmd->result = (DID_SOFT_ERROR << 16);
> +	ata_qc_done(qc);
>  }
>  
>  static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)

MBR, Sergey

