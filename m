From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Mon, 05 Sep 2005 13:18:58 +0900
Message-ID: <431BC732.2010907@gmail.com>
References: <loom.20050904T095233-120@post.gmane.org> <20050904140239.GA11855@htj.dyndns.org> <loom.20050905T024247-999@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:56505 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932195AbVIEETJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Sep 2005 00:19:09 -0400
Received: by zproxy.gmail.com with SMTP id i11so668968nzh
        for <linux-ide@vger.kernel.org>; Sun, 04 Sep 2005 21:19:08 -0700 (PDT)
In-Reply-To: <loom.20050905T024247-999@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <mb@opensc.org>
Cc: linux-ide@vger.kernel.org


  Hello, Marc.

Marc Bevand wrote:
> Tejun Heo writes:
> 
>> Weird, I can tell you that 0.2 driver works for at least two sil24
>>controllers - mine and Edward Falk's.  Can you please apply the
>>following patch to the current ALL head and post dmesg?
> 
> 
> Done. But dmesg is quite large (240 kB), so here it is:
> http://epita.fr/~bevand_m/pub/sata_sil24.dmesg
> 
> Notes:
> o This time 2 disks were plugged (ata19 and ata20, on ports 2 and 3).
> o I had to #undef ATA_VERBOSE_DEBUG in your patch else the kernel freezes
>   when init(8) starts running all the initscripts, probably because too
>   many messages are printk()ed on the console. Let me know if you _really_
>   need ATA_VERBOSE_DEBUG, I can try with a serial console.

  Nope, ATA_DEBUG is enough.

> Here is the relevant part of dmesg, for ata19:
> 
>   ata_device_add: ata19: probe begin
>   ata_dev_identify: ENTER, host 19, dev 0
>   ata_dev_identify: do ATA identify
>   ata_sg_setup_one: mapped buffer of 512 bytes for read
>   sil24_host_intr: sata_sil24 ata19: normal interrupt on port2
>     stat=0x0 irq=0xb00000 cmd_err=0 sstatus=0x113 serror=0x4050000
>   ata_sg_clean: unmapping 1 sg elements
>   ata19: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
>   ata19: no dma
>   ata19: dev 0 not supported, ignoring
>   ata_dev_identify: EXIT, err
>   ata_dev_identify: ENTER/EXIT (host 19, dev 1) -- nodev
>   ata_device_add: ata19: probe end
> 
> There is definitely a problem when issuing the IDENTIFY DEVICE command.
> However I don't have any hardware doc so I can't interpert the "normal
> interrupt" log line.

  I don't have hw doc either but the line looks fine compared to my 
working output.

> More information about my context:
> o My arch is x86_64, what is yours ?

  Tested both on x86 and EM64T.

> o The controller is using a SiI3124-2 chip (SATA 3.0 Gbps) not a
>   SiI 3124-1 one (1.5 Gbps); does it matter ?

  Mine is a 3.0G chip, too.

> o I am using the controller in a 64-bit 133 MHz PCI-X bus.

  Mine is hanging off regular PCI slot.

> o lspci output:
>   $ lspci -vvs 1:6
>   0000:01:06.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology
> Inc) SiI 3124 PCI-X Serial ATA Controller (rev 01)
>         Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc): Unknown
> device 6124
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
> Stepping+ SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Interrupt: pin A routed to IRQ 193
>         Region 0: Memory at fc5ffc00 (64-bit, non-prefetchable) [size=128]
>         Region 2: Memory at fc5f0000 (64-bit, non-prefetchable) [size=32K]
>         Region 4: I/O ports at 8c00 [size=16]
>         Expansion ROM at fc500000 [disabled] [size=512K]
>         Capabilities: [64] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [40] PCI-X non-bridge device.
>                 Command: DPERE- ERO+ RBC=0 OST=5
>                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple,
> DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [54] Message Signalled
> Interrupts: 64bit+ Queue=0/0 Enable-
>                 Address: 0000000000000000  Data: 0000
> 

  Okay, it seems that command is normally issued and completed.  My 
primary suspicion now is regarding memory IO mapping.

  - How much memory do you have on the system?
  - Can you try to boot with iommu=off kernel parameter?
  - Can you try to boot with x86 kernel?

  Thanks.

-- 
tejun
