From: Tejun Heo <htejun@gmail.com>
Subject: Re: Gigabyte GA-MA69VM-S2 can't do 64bit DMA
Date: Fri, 18 Sep 2009 09:43:13 +0900
Message-ID: <4AB2D7A1.8060909@gmail.com>
References: <4AAE8252.8000206@web.de> <4AAFE66D.8050807@gmail.com> <4AB0ADB2.8090009@web.de> <4AB0C2AD.6020503@gmail.com> <4AB2B463.4010408@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:26788 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZIRAmh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Sep 2009 20:42:37 -0400
Received: by an-out-0708.google.com with SMTP id d40so1026216and.1
        for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2009 17:42:40 -0700 (PDT)
In-Reply-To: <4AB2B463.4010408@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Holger Hasselmann <hhasselm@web.de>
Cc: linux-ide@vger.kernel.org, Shane.Huang@amd.com

Hello,

Holger Hasselmann wrote:
> I have tried the 2.6.31-git2 and this is  the dmesg output :
> 
> ibata version 3.00
> 
> ahci 0000:00:12.0: version 3.0_
> ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
> ahci 0000:00:12.0: Fujitsu-Siemens AMILO Pa 2510: this board can't do 64bit
> DMA, forcing 32bit
> ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
> ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
> ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pmp pio slum part
> It's correct now.

Cool, patch posted with the id string shortened.

> By the way, I was wondering, because I am a lucky owner of the
> GA-MA69VM-S2 board.  I have seen it when I was trying out the issue
> with my laptop and read the name of the kernel patch.  You will not
> believe it, on my board with the bios version F8 I do not have any
> issue with the plain 2.6.31 kernel without patch.  Thanks again,
> Holger

I'm confused here.  Gigabyte GA-MA69VM-S2 can't do 64bit DMA either?

Thanks.

-- 
tejun
