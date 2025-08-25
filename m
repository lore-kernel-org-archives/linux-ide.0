Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1AC1A256B
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2025 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162729; cv=none; b=OEv1JTfkmv/yCpKu+llM88Ft1KG+GROGM9f9tJyfG8rF3SUQqLuDQh14AeFtB+/pNe+2Zn1MVkG8AVsXTr0+Z2aPpxOBggrrUmadW2c6uJpmdYK3ZA0Y+l3bdOQKP97BUlZpWZgdaZH+GLOPUakqlKm9TZXj5sF40V/Glv7sKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162729; c=relaxed/simple;
	bh=vb/sD4wDd2FDpwrv7M5UPp30254YqQCI58p97q+A+Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uybZ/YbOflI9XoKstwjsVwDoPI/EWZDCTnFXKvmTGSQZWmGGgMHN+wDaa9k2LoMDnYiGkf6YcaeBLyGQ/NRi4+OloKtkGKn5prAqWNobNA/QkaiPYxzRhG5ZKo0l6Z2v8etm9/AM45IAPNNESWMy8vAwYNaEon/r6uZVG8WD3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi2VlrSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi2VlrSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DD7C4CEED;
	Mon, 25 Aug 2025 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756162728;
	bh=vb/sD4wDd2FDpwrv7M5UPp30254YqQCI58p97q+A+Ho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pi2VlrSMfYHB7yH/6YOZHtY9JxO/A3/nUGJOGGeSQxx/qdEBqfvDvWtgni0pHZEUN
	 pVHJBJjziu1zTFF5cPviuAjSJvyamkUVDV5V1ICufgN+X4oiFphzkr7nCcIhYLDhdS
	 nOg6PsHpUm0y9eETIoBCE+sI7RU1GG2nbzBIT80e+lZgcyG+AXWUk/FNTBp/QjQoD5
	 6V4TVvoeobQE1/evM46f9p2ybeT4UE3j26+yRnnZFZCV2F3Vl6Ffd85ZQXdbqGs6b/
	 O/TY2BJyxT8ERndPyK+hztYcRlU2mNi9cTdZNNBKcjX3nqA3l4V5nuyFWe3M0DkaDN
	 Fj9eHlSS99yNg==
Message-ID: <5ce0b020-30ba-4d04-a139-55cfdbba871a@kernel.org>
Date: Tue, 26 Aug 2025 07:58:46 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Warning about DRM functions support logged twice and lpm-pol
To: Paul Menzel <pmenzel@molgen.mpg.de>, Niklas Cassel <cassel@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-ide@vger.kernel.org
References: <a9a7e87a-d41b-43fb-9e46-ed10ac6ee961@molgen.mpg.de>
 <6D8A123A-27CD-419C-8ACF-E3B2209B7872@kernel.org>
 <3348a75a-2054-4457-840a-d0af6dd437e1@molgen.mpg.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3348a75a-2054-4457-840a-d0af6dd437e1@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/26/25 05:58, Paul Menzel wrote:
> Dear Niklas,
> 
> 
> Thank you for your instant reply.
> 
> Am 25.08.25 um 22:42 schrieb Niklas Cassel:
>> On 25 August 2025 21:51:58 CEST, Paul Menzel wrote:
> 
>>> On a Dell Precision 3620 with
>>>
>>>     $ lspci -nn -s 00:17.0
>>>     00:17.0 SATA controller [0106]: Intel Corporation Q170/Q150/B150/H170/H110/Z170/CM236 Chipset SATA Controller [AHCI Mode] [8086:a102] (rev 31)
>>>
>>> Linux warns about the ATA device and Samsung SSD 870 EVO 1TB.
>>>
>>>     $ lsblk -o name,model,serial,rev -S
>>>     NAME MODEL                   SERIAL           REV
>>>     sda  Samsung SSD 870 EVO 1TB S6PUNL0T600648F 2B6Q
>>>     $ dmesg --level warn
>>>     [    1.688558] Transient Scheduler Attacks: MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
>>>     [    1.690195] Transient Scheduler Attacks: MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
>>>     [    3.165214] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
>>>     [    3.254639] ata1.00: Model 'Samsung SSD 870 EVO 1TB', rev 'SVT02B6Q', applying quirks: noncqtrim zeroaftertrim noncqonati nolpmonati
>>>     [    3.266623] ata1.00: supports DRM functions and may not be fully accessible
>>>     [    3.304432] ata1.00: supports DRM functions and may not be fully accessible
>>>     [    4.195869] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQBC data block query control method not found
>>>     [  651.061135] systemd-journald[164]: File /var/log/journal/95790226b8d0779f4b4797314ca986d4/user-8578.journal corrupted or uncleanly shut down, renaming and replacing.
>>>     $ dmesg | grep -e 'Linux version' -e 'DMI: Dell' -e lpm
>>>     [    0.000000] Linux version 6.12.40.mx64.484 (root@mehrlametta.molgen.mpg.de) (gcc (GCC) 12.5.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Thu Jul 24 15:14:16 CEST 2025
>>>     [    0.000000] DMI: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 2.23.0 09/14/2022
>>>     [    2.892973] ata1: SATA max UDMA/133 abar m2048@0xef14b000 port 0xef14b100 irq 124 lpm-pol 0
>>>     [    2.901327] ata2: SATA max UDMA/133 abar m2048@0xef14b000 port 0xef14b180 irq 124 lpm-pol 0
>>>     [    2.909685] ata3: SATA max UDMA/133 abar m2048@0xef14b000 port 0xef14b200 irq 124 lpm-pol 0
>>>     [    2.918042] ata4: SATA max UDMA/133 abar m2048@0xef14b000 port 0xef14b280 irq 124 lpm-pol 0
>>>     [    3.254639] ata1.00: Model 'Samsung SSD 870 EVO 1TB', rev 'SVT02B6Q', applying quirks: noncqtrim zeroaftertrim noncqonati nolpmonati
>>>
>>> I wonder why the DRM warning is logged twice, and why the LPM policy is 0. (It’s a desktop system, but still.)
>>>
>>> Is there anything I can do about this?
>>
>> Hello Paul,
>>
>> What is your Kconfig CONFIG_SATA_MOBILE_LPM_POLICY
>> set to?
>>
>> If it is 0, try building with CONFIG_SATA_MOBILE_LPM_POLICY set to 3,
>> which is nowadays the default, see:
>> https://github.com/torvalds/linux/blob/v6.17-rc3/drivers/ata/Kconfig#L121
> 
> Indeed, it’s set to 0, probably for historical reasons. The change to 3 
> was in v6.11-rc1 (5433f0e7427a (ata: Kconfig: Update 
> SATA_MOBILE_LPM_POLICY default to med_power_with_dipm)). We use the same 
> Linux kernel across the board on desktops and servers with a lot of 
> software RAIDs on disks in enclosures. I am going to discuss it with the 
> colleagues.
> 
> How can I check, what the firmware has set?

There is no easy way with the kernel/sysfs right now. You essentially need to
look at all the LPM related capabilities and see how they are initialized.

>> Didn't check about the double prints yet, a bit late here right now.
> 
> No problem. Same here. ;-)

The print showing up twice is due to the fact that disk revalidation by the scsi
layer is always done 2 times when scanning a disk.

The print itself means that the device has "Trusted Computing feature set
options" and so may not be fully accessible if that is in used and some LBA
range of the drive is locked.
If you are not using this feature, you can safely ignore the message.

> 
> 
> Kind regards and good night,
> 
> Paul
> 


-- 
Damien Le Moal
Western Digital Research
