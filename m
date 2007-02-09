From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata_via problems in a Vintage2-AE1
Date: Fri, 09 Feb 2007 04:46:39 -0500
Message-ID: <45CC42FF.5030507@gmail.com>
References: <200702090010.06897.lepalom@wol.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:32351 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946279AbXBIJqv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 04:46:51 -0500
Received: by nz-out-0506.google.com with SMTP id s1so743369nze
        for <linux-ide@vger.kernel.org>; Fri, 09 Feb 2007 01:46:50 -0800 (PST)
In-Reply-To: <200702090010.06897.lepalom@wol.es>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lepalom@wol.es
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Leopold Palomo Avellaneda wrote:
> Dear people,
> 
> I have a barebone Asus Vintage2-AE1 [1]. This box has a mobo Asus A8V-MQ. The 
> board has:
> - the Socket 939 for AMD Athlon 64FX/Athlon 64.
> - North Bridge: VIA K8M800  
> - South Bridge: VIA VT8251
> - VIA Graphics Integrated
> - IDE 2 x UltraDMA 133
> - 4 x Serial ATA
> ...
> 
> I'm using the bios version 0206. The 0210 doesn't show me the vga card, so I 
> don't have graphics mode. I think that is a buggy bios.
> 
> The bios is configured with vt8251 in AHCI mode and bios boot up activated, so 
> the hd is recognized in the beginning. I don't have any raid, only one hd. 
> The hd is a Maxtor 6V250F0.
> 
> I'm using a debian etch but the i386 version. The only way that I can use the 
> hd is using a 2.6.16 standard kernel with the modifications explained in this 
> page [2]. Basically you have to use their ahci.c and sata_via.c. The 
> modifications are small from the original code from Mr Jeff Garzik.
> 
> I have tried to use the 2.6.18 and 2.6.20rc6 and the result is the same. The  
> kernel boots, but when arrives at the ata3, 
> 
> scsi2 : ahci
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: qc timeout (cmd 0xec)
> ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> .... repeated some times ...
> scsi3 : ahci
> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> scsi4 : ahci
> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> scsi5 : ahci
> ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> Done.
> Begin: Mounting root file system... ...
> Begin: Running /scripts/local-top
> ide0: I/O resource 0x3F6-0x3F6 not free.
> ide0: ports already in use, skipping probe.
> ide1: I/O resource 0x376-0x376 not free.
> ide1: ports already in use, skipping probe.
> Done.
> Begin: Waiting for root file system ...

It might be VIA IRQ quirk problem.

1. Does giving 'irqpoll' parameter to kernel make any difference?

2. Can you give a shot at 2.6.20?

-- 
tejun
