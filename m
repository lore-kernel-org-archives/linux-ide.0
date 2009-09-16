From: Tejun Heo <htejun@gmail.com>
Subject: Re: Gigabyte GA-MA69VM-S2 can't do 64bit DMA
Date: Wed, 16 Sep 2009 19:49:17 +0900
Message-ID: <4AB0C2AD.6020503@gmail.com>
References: <4AAE8252.8000206@web.de> <4AAFE66D.8050807@gmail.com> <4AB0ADB2.8090009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.211.180]:40811 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbZIPKyz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Sep 2009 06:54:55 -0400
Received: by ywh10 with SMTP id 10so3398964ywh.1
        for <linux-ide@vger.kernel.org>; Wed, 16 Sep 2009 03:54:59 -0700 (PDT)
In-Reply-To: <4AB0ADB2.8090009@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Holger Hasselmann <hhasselm@web.de>
Cc: linux-ide@vger.kernel.org, Shane.Huang@amd.com

Holger Hasselmann wrote:
> I have tried the attached patch on a clean 2.6.31 source and it is working.
> 
> dmesg is showing the following:
> 
> libata version 3.00 loaded.
> ahci 0000:00:12.0: version 3.0
> ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
> ahci 0000:00:12.0: ASUS M2A-VM: BIOS too old, forcing 32bit DMA, update
> BIOS
> ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
> ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA
> mode
> ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pmp pio slum part
> 
> Will try it later on the latest git, I think the dmesg should identify
> the Board correct then and.

Oh, yes, please.  It should be printing different message.

-- 
tejun
