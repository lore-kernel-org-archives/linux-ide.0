From: "dunneil" <dunneil@live.cn>
Subject: Re: ahci.c
Date: Fri, 13 Jun 2008 21:20:23 +0800
Message-ID: <BAY122-DS144B862CC5C2487230031BEAC0@phx.gbl>
References: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com> <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl> <48523496.3090208@pobox.com> <BAY122-DS49D35770A7DFF4DB4885EBEAC0@phx.gbl> <4852411D.2050702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="gb2312";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay0-omc2-s19.bay0.hotmail.com ([65.54.246.155]:49740 "EHLO
	bay0-omc2-s19.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753376AbYFMNU0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jun 2008 09:20:26 -0400
In-Reply-To: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com> <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl> <48523496.3090208@pobox.com> <BAY122-DS49D35770A7DFF4DB4885EBEAC0@phx.gbl> <4852411D.2050702@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

it seems that the memory allocate is failed.

	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);

why?

--------------------------------------------------
From: "Jeff Garzik" <jgarzik@pobox.com>
Sent: Friday, June 13, 2008 5:42 PM
To: "dunneil" <dunneil@live.cn>
Cc: <linux-ide@vger.kernel.org>
Subject: Re: ahci.c

> dunneil wrote:
>> thx your response~
>> 
>> my test step is as following.
>> 
>> 
>> My asata controller is based-PCIEx1 1-port SATA controller.The ASATA 
>> FPGA board is plugged into PC motherboard. My os is AS5.1.the kernel is 
>> 2.6.20.7.
>> 
>> 1>
>> Before insmod ahci.ko manualy, the {IO,Mem,BusMaster}=3'b111.
>> 
>> After insmod ahci.ko manualy,the {IO,Mem,BusMaster}=3'b110.
>> 
>> The Bus Master Enable is not be set.
>> 
>> 2> I load my available ethernet NIC driver. My NIC and SATA Controller 
>> hardware architecture is similar,especially pci part.
>> 
>> The BusMasterEnable can be set by the ethernet NIC driver.
>> 
>> how to debug?
> 
> At this point you need to buy some books on PCI and such and master the
> basics.
> 
> We are not here to teach you everything in the world about PCI or AHCI,
> nor are we here to debug your FPGA hardware setup.
> 
> If you are going to be working at a low level, you are expected to know
> this stuff already.
> 
> Jeff
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
