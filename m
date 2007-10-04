From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 04 Oct 2007 14:57:29 +0900
Message-ID: <470480C9.9030309@gmail.com>
References: <18180.26625.216781.626572@kitty1.shrimp.net>	<470468EE.909@gmail.com>	<18180.30643.554165.292012@kitty1.shrimp.net>	<4704790C.7060901@gmail.com> <18180.31651.305092.579581@kitty1.shrimp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:9771 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759578AbXJDF5i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 01:57:38 -0400
Received: by wx-out-0506.google.com with SMTP id h31so63793wxd
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2007 22:57:37 -0700 (PDT)
In-Reply-To: <18180.31651.305092.579581@kitty1.shrimp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: idurdanovic@comcast.net
Cc: linux-ide@vger.kernel.org

Igor Durdanovic wrote:
> Tejun Heo writes:
>> Igor Durdanovic wrote:
>>> Tejun Heo writes:
>>>> PMP patchset is not in mainline yet.  You need to apply patches from the
>>>> following page.
>>>>
>>>>   http://home-tj.org/wiki/index.php/Libata-tj-stable
>>> Yes! it works now (though there were tons of hard and soft resets
>>> during booting, if you need log I can email it).
>> Yeah, please post the log.  Also, please cc linux-ide@vger.kernel.org.
> 
> No problem, here is the log of sata_sil24 while booting the kernel
> 2.6.22.1 on Dell latitude D820 with SIIG SC-SAE512-S1 SATA II
> ExpressCard 54 connected to DS-2350S 5-BAY enclosure.
> 
> Regards, Igor
> 
> sata_sil24 0000:0d:00.0: version 1.0
> ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 19 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:0d:00.0 to 64
> scsi2 : sata_sil24
> scsi3 : sata_sil24
> ata3: SATA max UDMA/100 cmd 0xf8d08000 ctl 0x00000000 bmdma 0x00000000 irq 16
> ata4: SATA max UDMA/100 cmd 0xf8d0a000 ctl 0x00000000 bmdma 0x00000000 irq 16
> ata3: SATA link down (SStatus 0 SControl 0)
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
> ata4.00: hard resetting link
> ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata4.01: hard resetting link
> ata4.01: softreset failed (SRST command error)
> ata4.01: reset failed (errno=-5), retrying in 10 secs

Eeeek, the above sequence repeats for each downstream port.  Weird.  How
reproducible is the problem?  Every time?

-- 
tejun
