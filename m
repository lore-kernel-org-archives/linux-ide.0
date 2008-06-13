From: "dunneil" <dunneil@live.cn>
Subject: Re: ahci.c
Date: Fri, 13 Jun 2008 17:19:08 +0800
Message-ID: <BAY122-DS49D35770A7DFF4DB4885EBEAC0@phx.gbl>
References: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com> <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl> <48523496.3090208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="gb2312";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay0-omc2-s9.bay0.hotmail.com ([65.54.246.145]:23839 "EHLO
	bay0-omc2-s9.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755260AbYFMJRp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jun 2008 05:17:45 -0400
In-Reply-To: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com> <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl> <48523496.3090208@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

thx your response~

my test step is as following.


My asata controller is based-PCIEx1 1-port SATA controller.The ASATA FPGA 
board is plugged into PC motherboard. My os is AS5.1.the kernel is 2.6.20.7.

1>
Before insmod ahci.ko manualy, the {IO,Mem,BusMaster}=3'b111.

After insmod ahci.ko manualy,the {IO,Mem,BusMaster}=3'b110.

The Bus Master Enable is not be set.

2> I load my available ethernet NIC driver. My NIC and SATA Controller 
hardware architecture is similar,especially pci part.

The BusMasterEnable can be set by the ethernet NIC driver.

how to debug?


thanks a lot

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
