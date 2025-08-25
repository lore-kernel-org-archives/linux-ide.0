Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA11E89C
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2025 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155549; cv=none; b=F3YFhDo/ztXB8eAeUIIY0pUYCIuZcwkIgGAX4Gb6/x7+H+bdv4OOn26T3n9t7aUAkl9iEZPs7oCnPpRDZtjSXn5lqnqjI1l5P1RSOFCwBChBLXmS6yVVZ9YZ/4yNvMTDzhVMDRHCVZMZ/thkxRrq5ySJNnQTWr/alxPyZ0jOH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155549; c=relaxed/simple;
	bh=FMieUAu8zxLMpotwFfFceOdkv1d70YAXCpaB3AEu7uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXN1vk9J/Zr1ktujJix6VhR4rqIfpxbHpEJIJoB2PZ5sCjG90twJD68PjDmYTRVD4rLuk6Rh/uAx0or5g/nGRSytafip8ZQr5HEszhmiEN73j+0dh3Ul/YN9ZtoNoGXuF0uZiQwQxdq95V09m8RMjVqpy2LtUeU9YOmayP0VeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af7f1.dynamic.kabel-deutschland.de [95.90.247.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5FCD86028826D;
	Mon, 25 Aug 2025 22:58:54 +0200 (CEST)
Message-ID: <3348a75a-2054-4457-840a-d0af6dd437e1@molgen.mpg.de>
Date: Mon, 25 Aug 2025 22:58:53 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Warning about DRM functions support logged twice and lpm-pol
To: Niklas Cassel <cassel@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-ide@vger.kernel.org
References: <a9a7e87a-d41b-43fb-9e46-ed10ac6ee961@molgen.mpg.de>
 <6D8A123A-27CD-419C-8ACF-E3B2209B7872@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <6D8A123A-27CD-419C-8ACF-E3B2209B7872@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Niklas,


Thank you for your instant reply.

Am 25.08.25 um 22:42 schrieb Niklas Cassel:
> On 25 August 2025 21:51:58 CEST, Paul Menzel wrote:

>> On a Dell Precision 3620 with
>>
>>     $ lspci -nn -s 00:17.0
>>     00:17.0 SATA controller [0106]: Intel Corporation Q170/Q150/B150/H170/H110/Z170/CM236 Chipset SATA Controller [AHCI Mode] [8086:a102] (rev 31)
>>
>> Linux warns about the ATA device and Samsung SSD 870 EVO 1TB.
>>
>>     $ lsblk -o name,model,serial,rev -S
>>     NAME MODEL                   SERIAL           REV
>>     sda  Samsung SSD 870 EVO 1TB S6PUNL0T600648F 2B6Q
>>     $ dmesg --level warn
>>     [    1.688558] Transient Scheduler Attacks: MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
>>     [    1.690195] Transient Scheduler Attacks: MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
>>     [    3.165214] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
>>     [    3.254639] ata1.00: Model 'Samsung SSD 870 EVO 1TB', rev 'SVT02B6Q', applying quirks: noncqtrim zeroaftertrim noncqonati nolpmonati
>>     [    3.266623] ata1.00: supports DRM functions and may not be fully accessible
>>     [    3.304432] ata1.00: supports DRM functions and may not be fully accessible
>>     [    4.195869] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQBC data block query control method not found
>>     [  651.061135] systemd-journald[164]: File /var/log/journal/95790226b8d0779f4b4797314ca986d4/user-8578.journal corrupted or uncleanly shut down, renaming and replacing.
>>     $ dmesg | grep -e 'Linux version' -e 'DMI: Dell' -e lpm
>>     [    0.000000] Linux version 6.12.40.mx64.484 (root@mehrlametta.molgen.mpg.de) (gcc (GCC) 12.5.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Thu Jul 24 15:14:16 CEST 2025
>>     [    0.000000] DMI: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 2.23.0 09/14/2022
>>     [    2.892973] ata1: SATA max UDMA/133 abar m2048@0xef14b000 port 0xef14b100 irq 124 lpm-pol 0
>>     [    2.901327] ata2: SATA max UDMA/133 abar m2048@0xef14b000 port 0xef14b180 irq 124 lpm-pol 0
>>     [    2.909685] ata3: SATA max UDMA/133 abar m2048@0xef14b000 port 0xef14b200 irq 124 lpm-pol 0
>>     [    2.918042] ata4: SATA max UDMA/133 abar m2048@0xef14b000 port 0xef14b280 irq 124 lpm-pol 0
>>     [    3.254639] ata1.00: Model 'Samsung SSD 870 EVO 1TB', rev 'SVT02B6Q', applying quirks: noncqtrim zeroaftertrim noncqonati nolpmonati
>>
>> I wonder why the DRM warning is logged twice, and why the LPM policy is 0. (It’s a desktop system, but still.)
>>
>> Is there anything I can do about this?
> 
> Hello Paul,
> 
> What is your Kconfig CONFIG_SATA_MOBILE_LPM_POLICY
> set to?
> 
> If it is 0, try building with CONFIG_SATA_MOBILE_LPM_POLICY set to 3,
> which is nowadays the default, see:
> https://github.com/torvalds/linux/blob/v6.17-rc3/drivers/ata/Kconfig#L121

Indeed, it’s set to 0, probably for historical reasons. The change to 3 
was in v6.11-rc1 (5433f0e7427a (ata: Kconfig: Update 
SATA_MOBILE_LPM_POLICY default to med_power_with_dipm)). We use the same 
Linux kernel across the board on desktops and servers with a lot of 
software RAIDs on disks in enclosures. I am going to discuss it with the 
colleagues.

How can I check, what the firmware has set?

> Didn't check about the double prints yet, a bit late here right now.

No problem. Same here. ;-)


Kind regards and good night,

Paul
