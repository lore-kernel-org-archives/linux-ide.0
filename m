From: "dunneil" <dunneil@live.cn>
Subject: Re: ahci.c
Date: Fri, 13 Jun 2008 15:50:23 +0800
Message-ID: <BAY122-DS6E6B9AF90A23D8C03375BBEAC0@phx.gbl>
References: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="gb2312";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay0-omc2-s31.bay0.hotmail.com ([65.54.246.167]:46895 "EHLO
	bay0-omc2-s31.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752512AbYFMHtA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jun 2008 03:49:00 -0400
In-Reply-To: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

if there are two ASATA controller inside motherboard, it will cause conflict 
for BUS Master Enable bit?

--------------------------------------------------
From: "Jeff Garzik" <jgarzik@pobox.com>
Sent: Thursday, June 12, 2008 10:50 AM
To: "dunneil" <dunneil@live.cn>
Cc: <linux-ide@vger.kernel.org>
Subject: Re: ahci.c

> dunneil wrote:
>> hi,
>>
>>   My hardware is AHCI SATA controller with FPGA-based PCIE board.My
>> kernel is 2.6.20.7. after insmod ahci.ko, i run lspci -xxxxvvvv
>> command.but,it seems that it doesn't set the BUS master enable bit of
>> PCIE header command register.plz check my header content.
>>
>>   But,i run Pcitree software at windows.The BUS master enable is
>> observed to be set,and that i can read out a part of sata register value.
>>
>>   how to debug this issue?
>
> ahci.c calls pci_set_master() to enable the BusMaster bit.
>
> Jeff
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
