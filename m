From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Tue, 15 Aug 2006 18:30:48 +0400
Message-ID: <44E1DA98.2040404@ru.mvista.com>
References: <44E1D760.6070600@atipa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:43611 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1030306AbWHOO3k
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 10:29:40 -0400
In-Reply-To: <44E1D760.6070600@atipa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hello,

Roger Heflin wrote:

> On Linux when interrupts are defined similar to below, what defines say
> ide2, ide3 to be on the same interrupt? The bios, linux, the driver 
> using the interrupt?

    In this particular case (I suppoer both belong to the same IDE conrtoller) 
the hardware design determines this in part and software in another part.
If the PCI IDE controller was in the leagcy mode (it should be ide0/1 then), 
the interrupts would've been 14 and 15. But in the native PCI mode, both 
chanels share the same interrupt level (if they're both in native mode that is).

> And can that be controlled/overrode at the kernel/driver level?

    The only possibility might be do disable ide0/1 in the BIOS I guess.

> I have identified that the disks that are shared on ide2, ide3 do funny
> things when both are being heavily used (dma_expiry), this is an older 
> driver versions
> but I have experienced it before with a lot newer driver, and a bios 
> adjustment
> previously fixed a similar issue, so that may be what is needed in this 
> case also,
> I am not sure how they fixed it, but I suspect that the setup the interrupt
> to not be shared.

    I doubt that your suspicions are justified.

>   I have a large number of machines and under heavy 
> loads all
> seem to duplicate the issue, and it always happens with the disks on 
> ide2/ide3,
> never on the disk connected to ide4.

    BTW, you never named your particular IDE hardware.

>            CPU0       CPU1       CPU2       CPU3
>   0:   56616921    5359998    7002142     938817          XT-PIC  timer
>   1:          8         88         96          0    IO-APIC-edge  i8042
>   2:          0          0          0          0          XT-PIC  cascade
>   4:       2091        100        208       2477    IO-APIC-edge  serial
>   8:          0          0          0          0    IO-APIC-edge  rtc
>   9:          0          0          0          0   IO-APIC-level  acpi
>  20:          0          0          0          0   IO-APIC-level  ehci_hcd
>  21:          0        950     401419     414482   IO-APIC-level  ide4, 
> ohci_hcd
>  22:       1165    1704243     576247       6796   IO-APIC-level  ide2, 
> ide3
>  47:      65971          0          0          0   IO-APIC-level  eth0
> NMI:          1          1          1          1
> LOC:   69904264   69877733   69879541   69901903
> ERR:          0
> MIS:        105

MBR, Sergei
