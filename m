From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: JMicron JMB361 sporadically failing to initialize from at least 2.6.18.4 to 2.6.22-rc2
Date: Mon, 21 May 2007 20:48:06 -0400
Message-ID: <76366b180705211748u670e3084j8df5246eca82a925@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:23910 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755687AbXEVAsH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 20:48:07 -0400
Received: by nz-out-0506.google.com with SMTP id z3so496456nzf
        for <linux-ide@vger.kernel.org>; Mon, 21 May 2007 17:48:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

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

http://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg339806.html

And numerous other people seem to be hitting this in newer kernels. A
Google search for 'jmb361 dma_base' turns up a lot of hits.

Does anyone know what is causing this and if it is fixed in any dev
branch? I've tried the stock Debian etch netinst 2.6.18.4 kernel, as
well as my own build of 2.6.21.1 and 2.6.22-rc2 and they all exhibit
the same problem.

Let me know what I can do to help debug this on my end.

Thanks
-Andrew
