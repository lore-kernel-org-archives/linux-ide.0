From: ethanhsiao@jmicron.com
Subject: RE: JMicron JMB361 sporadically failing to initialize from at least 2.6.18.4
 to 2.6.22-rc2
Date: Tue, 22 May 2007 10:15:56 +0800
Message-ID: <OF56F17817.010E0227-ON482572E3.000B1A94@jmicron.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from spamfilter.jmicron.com ([220.130.51.235]:35109 "EHLO
	spamfilter.jmicron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758150AbXEVCUh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 22:20:37 -0400
Received: from jms10 (pop3.jmicron.com [192.168.101.166])
	by spamfilter.jmicron.com (8.13.1/8.13.1) with ESMTP id l4M2Gd6i003666
	for <linux-ide@vger.kernel.org>; Tue, 22 May 2007 10:16:55 +0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: andrew@ishiboo.com
Cc: linux-ide@vger.kernel.org

Hi Andrew:

This Chip is JMB363 not JMB361. ;-)

This is a known issue.
Because jmicron module will probe both fn0 and fn1 device under Debian
4.0r0.
Please add " jmicron.jmicron=no_probe" to skip jmicron module probing in
OS installation.

Best Regards,
Ethan Hsiao

-----Original Message-----
From: linux-ide-owner@vger.kernel.org
[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Andrew Paprocki
Sent: Tuesday, May 22, 2007 8:48 AM
To: linux-ide@vger.kernel.org
Subject: JMicron JMB361 sporadically failing to initialize from at least
2.6.18.4 to 2.6.22-rc2

I have a Gigabyte GA-965P-DQ6 motherboard which has onboard Intel ICH8
raid as well as a "Gigabyte" (rebranded JMicron) chipset for 2
separate SATA ports. When I boot the machine, it completely
sporadically fails to initialize the JMB361 chipset which it detects,
claiming "dma_base is invalid". When it works (~20% of the time), it
will correctly detect the chip and all drives connected to it. It
feels like a race condition..

I have a DVD-RW & my boot SATAII drive connected to the controller, so
this bug has the nasty side effect of hanging my machine for eternity
waiting for the root drive to appear.

The dma_base trace is listed below:

JMB361: IDE controller at PCI slot 0000:03:00.0
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 177
JMB361: chipset revision 3
JMB361: 100% native mode on irq 177
JMB361: dma_base is invalid
ide0: JMB361 Bus-Master DMA disabled (BIOS)
JMB361: dma_base is invalid
ide1: JMB361 Bus-Master DMA disabled (BIOS)

This seems to be the same problem as reported here:

http://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg339806.ht
ml

And numerous other people seem to be hitting this in newer kernels. A
Google search for 'jmb361 dma_base' turns up a lot of hits.

Does anyone know what is causing this and if it is fixed in any dev
branch? I've tried the stock Debian etch netinst 2.6.18.4 kernel, as
well as my own build of 2.6.21.1 and 2.6.22-rc2 and they all exhibit
the same problem.

Let me know what I can do to help debug this on my end.

Thanks
-Andrew
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
