From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_nv in 2.6.23-rc8 only detects one of two controllers
Date: Wed, 24 Oct 2007 06:19:31 -0400
Message-ID: <471F1C33.1080700@gmail.com>
References: <470168FD.8080605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:18613 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbXJXKTj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 06:19:39 -0400
Received: by rv-out-0910.google.com with SMTP id k20so126647rvb
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 03:19:39 -0700 (PDT)
In-Reply-To: <470168FD.8080605@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Chuck Ebbert wrote:
> 2.6.18:
> libata version 2.00 loaded.
> sata_nv 0000:00:07.0: version 2.0
> ACPI: PCI Interrupt Link [LTID] enabled at IRQ 20
> GSI 18 sharing vector 0xE9 and IRQ 18
> ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 20 (level, low) -> IRQ 233
> PCI: Setting latency timer of device 0000:00:07.0 to 64
> ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA400 irq 233
> ata2: SATA max UDMA/133 cmd 0xAC00 ctl 0xA802 bmdma 0xA408 irq 233
> scsi0 : sata_nv
> ...
> ACPI: PCI Interrupt Link [LT3D] enabled at IRQ 47
> GSI 19 sharing vector 0x32 and IRQ 19
> ACPI: PCI Interrupt 0000:80:07.0[A] -> Link [LT3D] -> GSI 47 (level, low) -> IRQ 50
> PCI: Setting latency timer of device 0000:80:07.0 to 64
> ata5: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xD400 irq 50
> ata6: SATA max UDMA/133 cmd 0xDC00 ctl 0xD802 bmdma 0xD408 irq 50
> 
> 
> 2.6.23-rc8:
> libata version 2.21 loaded.
> sata_nv 0000:00:07.0: version 3.5
> ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
> ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 22 (level, low) -> IRQ 22
> sata_nv 0000:00:07.0: Using ADMA mode
> PCI: Setting latency timer of device 0000:00:07.0 to 64
> scsi1 : sata_nv
> ...
> [No messages print for the second controller]

Is this still the case for 2.6.23(.1)?  If so, can you post full boot 
log and the result of "lspci -nnvvvxxx"?

-- 
tejun
