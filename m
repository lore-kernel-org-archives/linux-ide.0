From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ahci.c
Date: Fri, 13 Jun 2008 05:42:53 -0400
Message-ID: <4852411D.2050702@pobox.com>
References: <BAY122-DS4E91A6CF6FAF2D10B80E9BEB20@phx.gbl> <48508EF1.8000304@pobox.com> <BAY122-DS5943144F5B68D62071DDEBEAC0@phx.gbl> <48523496.3090208@pobox.com> <BAY122-DS49D35770A7DFF4DB4885EBEAC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40409 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754981AbYFMJm4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2008 05:42:56 -0400
In-Reply-To: <BAY122-DS49D35770A7DFF4DB4885EBEAC0@phx.gbl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dunneil <dunneil@live.cn>
Cc: linux-ide@vger.kernel.org

dunneil wrote:
> thx your response~
> 
> my test step is as following.
> 
> 
> My asata controller is based-PCIEx1 1-port SATA controller.The ASATA 
> FPGA board is plugged into PC motherboard. My os is AS5.1.the kernel is 
> 2.6.20.7.
> 
> 1>
> Before insmod ahci.ko manualy, the {IO,Mem,BusMaster}=3'b111.
> 
> After insmod ahci.ko manualy,the {IO,Mem,BusMaster}=3'b110.
> 
> The Bus Master Enable is not be set.
> 
> 2> I load my available ethernet NIC driver. My NIC and SATA Controller 
> hardware architecture is similar,especially pci part.
> 
> The BusMasterEnable can be set by the ethernet NIC driver.
> 
> how to debug?

At this point you need to buy some books on PCI and such and master the
basics.

We are not here to teach you everything in the world about PCI or AHCI,
nor are we here to debug your FPGA hardware setup.

If you are going to be working at a low level, you are expected to know
this stuff already.

	Jeff


