Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47EC2E6
	for <linux-ide@vger.kernel.org>; Mon,  8 Jan 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (31.173.81.242) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 8 Jan
 2024 11:48:10 +0300
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
To: Phillip Susi <phill@thesusis.net>, <linux-ide@vger.kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-2-phill@thesusis.net>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <14fbc9fa-0876-23c7-b4d3-46a431c2de40@omp.ru>
Date: Mon, 8 Jan 2024 11:48:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240107180258.360886-2-phill@thesusis.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/08/2024 08:32:36
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182479 [Jan 08 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.242 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	31.173.81.242:7.1.2;omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.242
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/08/2024 08:38:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/8/2024 6:15:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/7/24 9:02 PM, Phillip Susi wrote:

> When a disk is in SLEEP mode it can not respond to any
> any commands.  Several commands are simply a NOOP to a disk
> that is in standby mode, but when a disk is in SLEEP mode,
> they frequencly cause the disk to spin up for no reason.

   Frequently.

> To avoid this, complete these commands in libata without
> waking the disk.  These commands are:
> 
> CHECK POWER MODE
> FLUSH CACHE
> SLEEP
> STANDBY IMMEDIATE
> IDENTIFY
> 
> If we know the disk is sleeping, we don't need to wake it up
> to find out if it is in standby, so just pretend it is in
> standby.  While asleep, there's no dirty pages in the cache,
> so there's no need to flush it.  There's no point in waking
> a disk from sleep just to put it back to sleep.  We also have
> a cache of the IDENTIFY information so just return that
> instead of waking the disk.
[...]

   Did you run your patches thru scripts/checkpatch.pl? Looking
at this patch, I think you didn't... :-)

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 09ed67772fae..6c5269de4bf2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5040,6 +5040,26 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
>  
>  	/* if device is sleeping, schedule reset and abort the link */
>  	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
> +		switch (qc->tf.command)
> +		{

		switch (qc->tf.command) {

> +		case ATA_CMD_CHK_POWER:
> +		case ATA_CMD_SLEEP:
> +		case ATA_CMD_FLUSH:
> +		case ATA_CMD_FLUSH_EXT:
> +		case ATA_CMD_STANDBYNOW1:
> +			if (qc->tf.command == ATA_CMD_ID_ATA)

   This can't happen, you forgot:

		case ATA_CMD_ID_ATA:

> +			{

			if (qc->tf.command == ATA_CMD_ID_ATA) {

> +				/* only fake the reply for IDENTIFY if it is from userspace */
> +				if (ata_tag_internal(qc->tag))
> +					break;
> +				sg_copy_from_buffer(qc->sg, 1, qc->dev->id, 2 * ATA_ID_WORDS);
> +			}
> +			/* fake reply to avoid waking drive */
> +			qc->flags |= ATA_QCFLAG_RTF_FILLED;
> +			qc->result_tf.nsect = 0;
> +			ata_qc_complete(qc);
> +			return;
> +		}
>  		link->eh_info.action |= ATA_EH_RESET;
>  		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
>  		ata_link_abort(link);

MBR, Sergey
