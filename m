Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F3146593
	for <linux-ide@vger.kernel.org>; Wed, 20 Nov 2024 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732124456; cv=none; b=A8pMUxLYmDBmenPzqIrHn6bcCRcc0MbWbCajJbYvs5m1JdJ0YPZfV0e4zTVoxlg3P5C8LqvSMb0r26bOLsi25jHZtpgfCmhPIZJKPIaiXtoMnFptbEydj+pfim2BYKJZNcXW4hwz4auMxEaG6MYXXgytj0VTnCYhDwrhi6ZRpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732124456; c=relaxed/simple;
	bh=tzJ3DAsjRBH0i+ae5c0Ceh4tI56Ka37ylpgxNJdLmt8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=YRR2JPpVbeKeo8luzOBatlBLJlW5DuZSOkNuWtpolkw4CbW/p6MWro/gVtmr2XjB1lHfaCuzubCTAVNHe/TmwaJH2/70NEK+zRg1kknaxpX4/uJNh0y6RHyW5Eo3g9yzSmy4n4uSSCaMZbc+FZblRDhsH/9jk9rDlJeUHxbY7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.156.212) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 20 Nov
 2024 20:40:37 +0300
Message-ID: <b19c6aa7-3095-4a40-a329-3c86c00de537@omp.ru>
Date: Wed, 20 Nov 2024 20:40:36 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ata changes for 6.13-rc1
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Niklas Cassel <cassel@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, <linux-ide@vger.kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>
References: <20241118155013.2706907-1-cassel@kernel.org>
 <1170a234-2bb2-48c7-867c-ef1b091044b2@gmail.com>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <1170a234-2bb2-48c7-867c-ef1b091044b2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/20/2024 16:43:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 189318 [Nov 20 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.7
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 42 0.3.42
 bec10d90a7a48fa5da8c590feab6ebd7732fec6b
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.156.212 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.156.212
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/20/2024 16:47:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/20/2024 3:19:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 11/20/24 7:41 PM, Sergey Shtylyov wrote:
[...]

>> Linus,
>>
>> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
>>
>>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.13-rc1
>>
>> for you to fetch changes up to e8a2389ea808c3902d9938b20e40e2df36c3702b:
>>
>>   dt-bindings: ata: ahci-platform: add missing iommus property (2024-11-12 12:15:59 +0100)
> 
> [...]
> 
>> ----------------------------------------------------------------
>> Andy Shevchenko (1):
>>       ata: libata-scsi: Refactor scsi_6_lba_len() with use of get_unaligned_be24()
>>
>> Damien Le Moal (7):
>>       ata: libata: Remove unused macro definitions
>>       ata: libata-scsi: Refactor ata_scsi_simulate()
>>       ata: libata-scsi: Refactor ata_scsiop_read_cap()
>>       ata: libata-scsi: Refactor ata_scsiop_maint_in()
>>       ata: libata-scsi: Document all VPD page inquiry actors
>>       ata: libata-scsi: Remove struct ata_scsi_args
>>       ata: libata-scsi: Return residual for emulated SCSI commands
>>
>> Frank Wunderlich (1):
>>       dt-bindings: ata: ahci-platform: add missing iommus property
>>
>> Uwe Kleine-König (1):
>>       ata: Switch back to struct platform_driver::remove()
>>
>> Yan Zhen (1):
>>       ata: Fix typos in the comment
> 
> [...]
> 
>    What about my 8 patches, could you please clarify why they didn't get
> into this PR?

  Sorry, replied from the wrong account...

MBR, Sergey

