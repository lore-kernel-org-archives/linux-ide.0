From: "dunneil" <dunneil@live.cn>
Subject: Re: ahci.c
Date: Fri, 13 Jun 2008 19:53:20 +0800
Message-ID: <BAY122-DS26BB90D328D008C7A9A76BEAC0@phx.gbl>
References: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com> <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl> <48523496.3090208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="gb2312";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay0-omc2-s11.bay0.hotmail.com ([65.54.246.147]:48086 "EHLO
	bay0-omc2-s11.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751207AbYFMLxX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jun 2008 07:53:23 -0400
In-Reply-To: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com> <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl> <48523496.3090208@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

dmesg report:

ahci 0000:03:00.0 version 2.0
ACPI:PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level,low) -> IRQ 16
ACPI:PCI Interrupt for device 0000:03:00.0 disabled
ahci:probe of 0000:03:00.0 failed with error -12

--------------------------------------------------
From: "Jeff Garzik" <jgarzik@pobox.com>
Sent: Friday, June 13, 2008 4:49 PM
To: "dunneil" <dunneil@live.cn>
Cc: <linux-ide@vger.kernel.org>
Subject: Re: ahci.c

> dunneil wrote:
>> if there are two ASATA controller inside motherboard, it will cause 
>> conflict
>> for BUS Master Enable bit? Do i need disable the motherboard integrated 
>> ASATA controoller for my separate ASATA controller FPGA board?
> 
> You can have as many AHCI PCI devices as you wish.
> 
> Each PCI device has its own Bus Master Enable bit in the PCI Command
> register.
> 
> Jeff
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
