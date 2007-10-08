From: Tejun Heo <htejun@gmail.com>
Subject: Re: Serial ATA does not find partitions (Hitachi HD, new? ATI controller)
 where old SATA works
Date: Mon, 08 Oct 2007 10:03:42 +0900
Message-ID: <470981EE.30103@gmail.com>
References: <46FC4384.7080607@df.uba.ar> <46FCCD57.2020507@gmail.com> <47014740.5080002@df.uba.ar> <4701EA71.2000609@gmail.com> <470220FE.2090506@gmail.com> <47044C6C.5030905@gmail.com> <47083555.2060605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:17366 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844AbXJHBDv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 21:03:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1480618wah
        for <linux-ide@vger.kernel.org>; Sun, 07 Oct 2007 18:03:50 -0700 (PDT)
In-Reply-To: <47083555.2060605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hgsolari@gmail.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

Hello, Hernan.

Hernan G Solari wrote:
> 
>> If you can set up a serial console, it would be better.  If not, can you
>> please take a photo of the crash and post it?
>>   
> I am running short of elements, no digital camera o movil phone for the
> case or serial link.
> However, what it is on the screen when it crashes follows:
> 
> KERNEL 2.6.23-rc8
> -----------------------------------------------------begin screen dump
> PCI: Bridge: 0000:00:14.4
>  IO window: a000-afff
>  MEM window: d0300000-d03fffff
>  PREFETCH window: 50000000-53ffffff
> PCI: Enabling device 0000:00:04.0 (0000 -> 0002)
> PCI: Enabling device 0000:08:01.0 (0000 -> 0003)
> ACPI: PCI Interrupt 0000:08:01.0[A] -> GSI 23 (level, low) -> IRQ 23
> NET: Registered protocol family 2
> IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
> TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> TCP reno registered
> Simple Boot Flag at 0x36 set to 0x1
> Total HugeTLB memory allocated, 0
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> PCI: MSI quirk detected. MSI deactivated.
> assign_interrupt_mode Found MSI capability
> assign_interrupt_mode Found MSI capability
> assign_interrupt_mode Found MSI capability
> assign_interrupt_mode Found MSI capability

Hmmm... and the kernel freezes after this?  libata driver isn't
initialized yet.  I don't think libata has anything to do with here.

Thanks.

-- 
tejun
