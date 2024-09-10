Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB616F27E
	for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958378; cv=none; b=hkHDMEzCY6z6+vdqf/Ux6RX8DPm4mg6Jvd9iiW5ROTeQwDlYRLKqv+k4MneLJUuL7P06dpmVYhb7mz3owmKs6dLmSEQObTOC78I6DCwGW++TlhMszvI7oZR5iyTynBORCF6yTQij6xLuZtLkqm1XQd3q3Y/2BeVdo7EuY+1wPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958378; c=relaxed/simple;
	bh=HqO1zqvFeKFSSmZm8TQqQ5VmM8tJu3i0d4NpY+shHDE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bWOTvDzTzWxEwQOWPCA2EX0jdILFx97T6f3V8ev+BCQ6FexHFbgqPOVb5vpveKanAoe9LQEFWwqQJSVAvgUJ9b55r5XROIrpj4k1IHF1OYaX+YU5Z5KUurWZ9GzEOA5w1uMgTphua62lI1FvdRM3iMsS5udfnIM3Z/cVXHLcecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.106] (31.173.82.116) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 10 Sep
 2024 11:52:49 +0300
Subject: Re: [PATCH] ata: ata_generic: use IS_ENABLED() macro
To: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>, Niklas
 Cassel <cassel@kernel.org>
CC: <lvc-project@linuxtesting.org>
References: <d9c0acab-909e-da06-decf-be5de59d23bf@omp.ru>
 <87f85704-656d-4c08-b729-87c9b2e6d686@kernel.org>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <4414c20f-7e0e-de47-8311-4a8948f2504d@omp.ru>
Date: Tue, 10 Sep 2024 11:52:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87f85704-656d-4c08-b729-87c9b2e6d686@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/10/2024 08:34:01
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 187648 [Sep 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.82.116
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/10/2024 08:39:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/10/2024 6:41:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/10/24 7:50 AM, Damien Le Moal wrote:
[...]

>> Replace now gone out of fashion defined(CONFIG_PATA_TOSHIBA[_MODULE])
>> with the new-fangled IS_ENABLED() macro in the ata_generic[] definition.
> 
> Please mention that CONFIG_PATA_TOSHIBA_MODULE actually does not exist at all
> and so can be removed.

   Huh? =)
   CONFIG_PATA_TOSHIBA is a tristate option, so CONFIG_PATA_TOSHIBA_MODULE
does exist; else there would be no point in using IS_ENABLED() at all...

>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...[

>> Index: linux/drivers/ata/ata_generic.c
>> ===================================================================
>> --- linux.orig/drivers/ata/ata_generic.c
>> +++ linux/drivers/ata/ata_generic.c
>> @@ -220,7 +220,7 @@ static struct pci_device_id ata_generic[
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
>>  	  .driver_data = ATA_GEN_FORCE_DMA },
>> -#if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
>> +#if !IS_ENABLED(CONFIG_PATA_TOSHIBA)
> 
> I do not understand the negation here... It seems very wrong. If the driver is
> indeed enabled, we need to add its PCI ID, no ? and the reverse when not defined...

   The separate driver was added by Alan Cox in 2009, before that
Toshiba Piccolo controllers were handled by this generic driver...

[...]

MBR, Sergey
