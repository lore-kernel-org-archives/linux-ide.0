From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [BUGREPORT 1/3] Kernel Oops with HPT372A IDE controller
Date: Mon, 15 May 2006 18:54:05 +0400
Message-ID: <4468960D.2090004@ru.mvista.com>
References: <200605142110.53348.it21@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:57293 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750976AbWEOOzO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 10:55:14 -0400
In-Reply-To: <200605142110.53348.it21@arcor.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 101551.753@compuserve.com
Cc: linux-ide@vger.kernel.org

Hello.

Foli Ayivoh wrote:
> Kernel Oops with HighPoint RocketRAID ATA133 aka HPT372A/N since kernel 2.6
> Now tested with kernel 2.6.17-rc4
> 
> Kernel is on bootable CD-ROM
> Modules are loaded from initrd
> 
> This is what I copied from screen:
> 
> Loading hpt366
> [17179578.396000] HPT372A: IDE controller at PCI slot 0000:01:0a.0
> [17179578.400000] ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
> [17179578.404000] ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC1] -> GSI 16 (level, high) -> IRQ 18
> [17179578.408000] HPT372A: chipset revision 2
> [17179578.412000] HPT372A: 100% native mode on irq 18
> [17179578.416000] hpt: HPT372N detected, using 372N timing.
> [17179578.420000] FREQ: 125 PLL: 45
> [17179579.536000] No Clock Stabilization!!!
> [17179579.540000] hpt: no known IDE timings, disabling DMA
> [17179579.544000] hpt: HPT372N detected, using 372N timing.
> [17179579.548000] FREQ: 156 PLL: 66
> [17179579.664000] No Clock Stabilization!!!

    Please try my latest patches. This one should fix this (and oops should be
gone):

http://marc.theaimsgroup.com/?l=linux-ide&m=114677223914159&w=2

MBR, Sergei

