From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: IO_PAGE_FAULT from SATA card during boot
Date: Sat, 29 Jan 2011 10:41:35 -0600
Message-ID: <4D44433F.1040607@gmail.com>
References: <20110129112456.GA13204@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33918 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab1A2Qlj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jan 2011 11:41:39 -0500
Received: by iyj18 with SMTP id 18so3533425iyj.19
        for <linux-ide@vger.kernel.org>; Sat, 29 Jan 2011 08:41:38 -0800 (PST)
In-Reply-To: <20110129112456.GA13204@arachsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Webb <chris.webb@elastichosts.com>
Cc: linux-ide@vger.kernel.org

On 01/29/2011 05:24 AM, Chris Webb wrote:
> I have several Supermicro H8DGT-HF motherboards (BIOS version 1.1) with Star
> Tech PEXSAT32 PCI Express SATA cards attached, and am seeing an
> IO_PAGE_FAULT during boot corresponding to this card:
>
>    IO_PAGE_FAULT device=03:00.1 domain=0x0000 address=0x00000000000403c0 flags=0x0050]

What's that device 03:00.1? The AHCI controller itself seems to be 
03:00.0. Can you post the lspci -v output? Though it could be that maybe 
the IOMMU can't tell functions on the same device apart, not sure.

Given that the onboard AHCI controller is working but this one is not, 
it could be that the controller is doing some unexpected read request 
somewhere..

>
> The card later times out when the kernel tries to access the drives:
>
>    ata6.00: qc timeout (cmd 0xec)
>    ata12.00: qc timeout (cmd 0xa1)
>    ata12.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>    ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>    ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>    ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>    ata12.00: qc timeout (cmd 0xa1)
>    ata12.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>    ata12: limiting SATA link speed to 1.5 Gbps
>    ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>    ata6.00: qc timeout (cmd 0xec)
>    ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>    ata6: limiting SATA link speed to 1.5 Gbps
>    ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
>    ata12.00: qc timeout (cmd 0xa1)
>    ata12.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>    ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>    ata6.00: qc timeout (cmd 0xec)
>    ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>    ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
>
> I first saw this with a 2.6.32.25 kernel, but get identical behaviour with
> the latest 2.6.37. The kernel config I'm using with 2.6.37 is here:
>
>    http://cdw.me.uk/tmp/sata-fault.config
>
> with a full dmesg and dmidecode output here:
>
>    http://cdw.me.uk/tmp/sata-fault.dmesg
>    http://cdw.me.uk/tmp/sata-fault.dmi
>
> Because I initially believed this might be a problem with the ACPI table on the
> IOMMU driver, as similar issues have come up with other boards (and very
> similar symptoms) recently, I've added amd_iommu_dump to the kernel command
> line, so there's dump info in that dmesg. However, Joerg Roedel, the IOMMU
> driver maintainer, tells me that the IOMMU ACPI table is fine in this case and
> the problem is a different one:
>
> Joerg Roedel<Joerg.Roedel@amd.com>  writes:
>
>> The flags indicate that the device tried to read an address which is
>> only mapped writable for the device.
>> It is at least no BIOS issue, both devices (3:00.0 and 3:00.1) are
>> listed in the ACPI table as indicated by these messages:
>>
>>          AMD-Vi:   DEV_SELECT                     devid: 03:00.0 flags: 00
>>          AMD-Vi:   DEV_SELECT                     devid: 03:00.1 flags: 00
>>
>> This looks like a bug in the driver for your SATA add-on card. It
>> probably requests a DMA buffer with the wrong direction parameter.
>
> I think both the onboard cards (which work) and the PCI Express card (which
> doesn't) use the ahci driver in this case. Any advice would be very gratefully
> received!
>
> Best wishes,
>
> Chris.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

