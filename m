From: Jeff Garzik <jeff@garzik.org>
Subject: Re: IOMMU and DMA mode of pata_jmicron
Date: Tue, 28 Dec 2010 20:00:12 -0500
Message-ID: <4D1A881C.3080109@garzik.org>
References: <4D1A7628.3050704@steffen-moser.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57103 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab0L2BAR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Dec 2010 20:00:17 -0500
In-Reply-To: <4D1A7628.3050704@steffen-moser.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steffen Moser <lists@steffen-moser.de>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Joerg Roedel <joerg.roedel@amd.com>

(CC'd linux-ide, Joerg)

On 12/28/2010 06:43 PM, Steffen Moser wrote:
> I've encountered a problem with my AMD 890FX based system
> and linux-2.6.35.10 (x86_64 platform).
>
> After activating the option "IOMMU" in the mainboard's BIOS
> setup, the onboard P-ATA controller "JMicron Technology Corp.
> JMB361 AHCI/IDE (rev 02)" puts itself back in the PIO mode.
> When loading the module, the kernel reports:
>
>    pata_jmicron 0000:06:00.1: BMDMA: failed to set dma mask, \
>                               falling back to PIO
[...]
> As soon as I deactivate IOMMU in BIOS setup, the P-ATA channel
> runs in the DMA mode again. The S-ATA controllers don't seem
> to be affected.
>
> My question is: Is this a known behavior? Are there any
> things I have to consider when activating IOMMU (which seems
> to be AMD-Vi) on an 890FX based system? Is it a problem of
> the chipset and/or the controller or is it related to a
> problem in the libata area?
>
> Some information about the affected system:
>
>  - Mainboard:    ASUS M4A89TD Pro/USB3
>  - BIOS version: 1101 (most recent version)
>  - Chipset:      AMD 890FX
>  - Processor:    AMD Phenom 1090T
>  - Memory:       4 x 4 GB (Kingston KVR1333D3E9S/4G)
>  - Distribution: openSUSE 11.3
>  - Kernel:       2.6.35.10 (from "kernel.org"), x86_64
>

This condition occurs when the PCI API cannot set the PCI device's DMA 
mask to the 32-bit value
	#define ATA_DMA_MASK            0xffffffffULL

That is an unusual failure for such a modern system, which certainly can 
handle 32-bit masks like that, one would think.

	Jeff



