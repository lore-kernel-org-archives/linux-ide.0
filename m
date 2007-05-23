From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: JMicron JMB361 sporadically failing to initialize from at least 2.6.18.4 to 2.6.22-rc2
Date: Wed, 23 May 2007 01:48:03 -0400
Message-ID: <76366b180705222248w79ae8d6ai9d59224e21b804f4@mail.gmail.com>
References: <76366b180705211748u670e3084j8df5246eca82a925@mail.gmail.com>
	 <20070522020708.5dff26da@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:15377 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694AbXEWFsE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 01:48:04 -0400
Received: by nz-out-0506.google.com with SMTP id o37so114560nzf
        for <linux-ide@vger.kernel.org>; Tue, 22 May 2007 22:48:04 -0700 (PDT)
In-Reply-To: <20070522020708.5dff26da@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, ethanhsiao@jmicron.com
Cc: linux-ide@vger.kernel.org

Everyone, I tried rebuilding 2.6.22-rc2 last night with CONFIG_IDE
disabled, but it still produces the same problem. The relevant config
options:

# CONFIG_IDE is not set
CONFIG_ATA=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_AHCI=y
CONFIG_ATA_PIIX=y
CONFIG_PATA_JMICRON=y

Ethan, you mention that this is a known issue.. I can't find any link
to this problem. This is happening on a cleanly rebuilt kernel, so I'm
not sure if this has to do with Debian 4.0r0 probing the module
incorrectly. I already have the OS installed, and I figured a newer
kernel would have resolved this issue. Unlike the bug report I linked
to, I am not seeing the driver detect JMB363 & JMB361 in the same boot
log. Even when everything works, it only detects a JMB361.

A working boot looks like this:

JMB361: IDE controller at PCI slot 0000:04:00.1
ACPI: PCI Interrupt 0000:04:00.1[B] -> GSI 18 (level, low) -> IRQ 58
JMB361: chipset revision 2
JMB361: 100% native mode on irq 58
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA

No use of acpi=off, noapic, nolapic seems to affect the JMB361 from
being detected properly or not.

Any next steps? Ethan, do you have more information about this
particular issue with the DQ6 motherboard?

Thanks -Andrew

On 5/21/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Does anyone know what is causing this and if it is fixed in any dev
> > branch? I've tried the stock Debian etch netinst 2.6.18.4 kernel, as
> > well as my own build of 2.6.21.1 and 2.6.22-rc2 and they all exhibit
> > the same problem.
> >
> > Let me know what I can do to help debug this on my end.
>
> What configuration options have you got selected - in particular if you
> have the libata support for SATA enabled then the kernel configures the
> hardware to expose the AHCI interface for SATA and the PATA interface
> separately. This requires you to be using the libata drivers for both the
> SATA and PATA components of the hardware if you wish to use both.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
