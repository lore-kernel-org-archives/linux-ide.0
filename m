Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED50D286435
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2025 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151548; cv=none; b=tpcmkFI7CvXSupa0Y+9KuwEuqTu+UhmIoij41wXXcYA+R2zphwL7uQE+Xjy36TX2doysZbBR6QiZEqlGBmxg3UnbDsSN7nhYmnQLFgwfbvkMk1YWW6bfPxUI+D++Lg7KYG8iLiJjk84AUFGPRJM6eV0nBSOOcKPXyo3cC4ZlWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151548; c=relaxed/simple;
	bh=KiwQ4PSdBWaFQAPMQ4xnKtth6TTqkcKvVgNhLhTcs00=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XiKZnzYUbjTxUSUJD9PU+JDLa4v8WlocvFdl8ZnWyO768gXsapxGvJQEBAWzJXek5xorzSisC44onOoLy4OU1HFcAMAwCFIJIbXupaXcIGZ1UyNEj2aKlv6cO5/J2Irx0dT9Pe3mAE7HgBJNFKj/9cpM9vtAm4j1sX3ks38f2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af7f1.dynamic.kabel-deutschland.de [95.90.247.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8A1126028826D;
	Mon, 25 Aug 2025 21:51:59 +0200 (CEST)
Message-ID: <a9a7e87a-d41b-43fb-9e46-ed10ac6ee961@molgen.mpg.de>
Date: Mon, 25 Aug 2025 21:51:58 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Warning about DRM functions support logged twice and lpm-pol
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


On a Dell Precision 3620 with

     $ lspci -nn -s 00:17.0
     00:17.0 SATA controller [0106]: Intel Corporation 
Q170/Q150/B150/H170/H110/Z170/CM236 Chipset SATA Controller [AHCI Mode] 
[8086:a102] (rev 31)

Linux warns about the ATA device and Samsung SSD 870 EVO 1TB.

     $ lsblk -o name,model,serial,rev -S
     NAME MODEL                   SERIAL           REV
     sda  Samsung SSD 870 EVO 1TB S6PUNL0T600648F 2B6Q
     $ dmesg --level warn
     [    1.688558] Transient Scheduler Attacks: MDS CPU bug present and 
SMT on, data leak possible. See 
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for 
more details.
     [    1.690195] Transient Scheduler Attacks: MMIO Stale Data CPU bug 
present and SMT on, data leak possible. See 
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html 
for more details.
     [    3.165214] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
     [    3.254639] ata1.00: Model 'Samsung SSD 870 EVO 1TB', rev 
'SVT02B6Q', applying quirks: noncqtrim zeroaftertrim noncqonati nolpmonati
     [    3.266623] ata1.00: supports DRM functions and may not be fully 
accessible
     [    3.304432] ata1.00: supports DRM functions and may not be fully 
accessible
     [    4.195869] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQBC 
data block query control method not found
     [  651.061135] systemd-journald[164]: File 
/var/log/journal/95790226b8d0779f4b4797314ca986d4/user-8578.journal 
corrupted or uncleanly shut down, renaming and replacing.
     $ dmesg | grep -e 'Linux version' -e 'DMI: Dell' -e lpm
     [    0.000000] Linux version 6.12.40.mx64.484 
(root@mehrlametta.molgen.mpg.de) (gcc (GCC) 12.5.0, GNU ld (GNU 
Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Thu Jul 24 15:14:16 CEST 2025
     [    0.000000] DMI: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 
2.23.0 09/14/2022
     [    2.892973] ata1: SATA max UDMA/133 abar m2048@0xef14b000 port 
0xef14b100 irq 124 lpm-pol 0
     [    2.901327] ata2: SATA max UDMA/133 abar m2048@0xef14b000 port 
0xef14b180 irq 124 lpm-pol 0
     [    2.909685] ata3: SATA max UDMA/133 abar m2048@0xef14b000 port 
0xef14b200 irq 124 lpm-pol 0
     [    2.918042] ata4: SATA max UDMA/133 abar m2048@0xef14b000 port 
0xef14b280 irq 124 lpm-pol 0
     [    3.254639] ata1.00: Model 'Samsung SSD 870 EVO 1TB', rev 
'SVT02B6Q', applying quirks: noncqtrim zeroaftertrim noncqonati nolpmonati

I wonder why the DRM warning is logged twice, and why the LPM policy is 
0. (It’s a desktop system, but still.)

Is there anything I can do about this?


Kind regards,

Paul
