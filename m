From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: maintenence sata_sis
Date: Tue, 23 Aug 2005 10:04:21 +0200
Message-ID: <430AD885.4080001@gmx.net>
References: <m31x4pkhjb.fsf@anduin.mandrakesoft.com> <4309A268.8090203@gmx.net> <430AA69A.1030307@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:48876 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750910AbVHWIEW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2005 04:04:22 -0400
In-Reply-To: <430AA69A.1030307@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wes Newell <w.newell@verizon.net>
Cc: "linux.ide" <linux-ide@vger.kernel.org>

Wes Newell wrote:

> I've got a Jetway S755MAX that also has a real SIS180 onboard and have
> been trying to get PATA support for it without any luck for several
> months now. The sata_sis driver from SIS just locks up the machine
> when I attach a pata drive. With the help of a few here, I patched the
> sis5513 driver, but it has lost interrupt problems. I basically gave
> up on this ever working a couple of months ago. Do you think there's
> any hope at all? I'm willing to try whatever some can point me
> towards, but I'm not a C programmer. I can compile kernels though and
> follow instructions.
>
The SiS180 has disabled the interrupts by default. You must enable the
interrupts in the PCI-config space.
You can find a function pci_enable_intx() in the sata_sis.c.

regards
Uwe Koziolek
