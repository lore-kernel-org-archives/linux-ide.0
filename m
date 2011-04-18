From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: libata-sff/pata_cmd64x problem with hardwired configurations
Date: Mon, 18 Apr 2011 14:12:59 +0400
Message-ID: <4DAC0EAB.2090306@ru.mvista.com>
References: <1303084704.2583.23.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44035 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab1DRKOi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Apr 2011 06:14:38 -0400
Received: by wwa36 with SMTP id 36so5445070wwa.1
        for <linux-ide@vger.kernel.org>; Mon, 18 Apr 2011 03:14:37 -0700 (PDT)
In-Reply-To: <1303084704.2583.23.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, 622997@bugs.debian.org

Hello.

On 18-04-2011 3:58, James Bottomley wrote:

> I've got a parisc system where the DVD drive is hardwired to a silicon
> image controller:

> 00:02.0 IDE interface: Silicon Image, Inc. SiI 0649 Ultra ATA/100 PCI to
> ATA Host Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
>          Subsystem: Silicon Image, Inc. SiI 0649 Ultra ATA/100 PCI to ATA
> Host Controller
>          Flags: bus master, medium devsel, latency 64, IRQ 69
>          I/O ports at 0d18 [size=8]
>          I/O ports at 0d24 [size=4]
>          I/O ports at 0d10 [size=8]
>          I/O ports at 0d20 [size=4]
>          I/O ports at 0d00 [size=16]
>          Capabilities: [60] Power Management version 2
>          Kernel driver in use: pata_cmd64x

> The specific problem is that any access to the registers where the
> secondary port should be causes an instant fault on the box (I think
> because the second port just isn't wired up internally, so the memory
> doesn't respond), so the default libata-sff driver that pata_cmd64x is
> attached to causes this by insisting on probing both ports.

    Perhaps the secondary port is disabled (though it's strange that your 
lspci dump shows I/O resources for both ports allocated).

> I can get all of this working by fixing up all the hard coded knowledge
> in libata-sff only to use a single port.

> However, I can't fix the libata-sff driver until I know how to tell
> there's only one port wired.  Does anyone with cmd649 knowledge have any
> idea how I might tell this?

    The secondary port is enabled in the PCI config. space: register 0x51 bit 
3 controls this. Unfortunately, pata_cmd64x driver still doesn't check the 
channel enable bits; the cmd64x driver does though, so it might be worth trying...

> James

WBR, Sergei
