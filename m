From: Tyler <pml@dtbb.net>
Subject: Re: TX4000 RAID and sata_promise
Date: Tue, 16 Aug 2005 06:10:29 -0700
Message-ID: <4301E5C5.2030203@dtbb.net>
References: <01f501c5a223$9faf5470$6f0aa8c0@rgkb.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tor.primus.ca ([216.254.136.21]:35815 "EHLO
	smtp-01.primus.ca") by vger.kernel.org with ESMTP id S965207AbVHPNKf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 09:10:35 -0400
In-Reply-To: <01f501c5a223$9faf5470$6f0aa8c0@rgkb.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuri Kirsanov <flash@rccb.ru>
Cc: linux-ide@vger.kernel.org

Check out dmraid or dm_raid (not sure which it goes by, in order to
google it), it is the package that tries to support "bios raids" on
ide/sata cards.  It may be what you're looking for.

Tyler.

Yuri Kirsanov wrote:

>Good day. I have Mandrake Linux LE2005 with custom kernel
>2.6.12.2+Reiser4 patch+TX4000 patch
>(First part of this patch
>http://www.mail-archive.com/linux-ide@vger.kernel.org/msg00150.html
>second part failed and I can't figure out how to apply it). When i do
>'modprobe sata_promise' it only says:
>
>Aug 14 19:24:21 mandr kernel: libata version 1.11 loaded.
>Aug 14 19:24:21 mandr kernel: sata_promise version 1.01
>Aug 14 19:24:21 mandr kernel: PCI: Found IRQ 9 for device 0000:01:09.0
>Aug 14 19:24:21 mandr kernel: ata1: PATA max UDMA/133 cmd 0xC89FE200 ctl
>0xC89FE238 bmdma 0x0 irq 9
>Aug 14 19:24:21 mandr kernel: ata2: PATA max UDMA/133 cmd 0xC89FE280 ctl
>0xC89FE2B8 bmdma 0x0 irq 9
>Aug 14 19:24:21 mandr kernel: ata3: PATA max UDMA/133 cmd 0xC89FE300 ctl
>0xC89FE338 bmdma 0x0 irq 9
>Aug 14 19:24:21 mandr kernel: ata4: PATA max UDMA/133 cmd 0xC89FE380 ctl
>0xC89FE3B8 bmdma 0x0 irq 9
>Aug 14 19:24:21 mandr kernel: ata1: no device found (phy stat 00000000)
>Aug 14 19:24:21 mandr kernel: scsi0 : sata_promise
>Aug 14 19:24:21 mandr kernel: ata2: no device found (phy stat 00000000)
>Aug 14 19:24:21 mandr kernel: scsi1 : sata_promise
>Aug 14 19:24:21 mandr kernel: ata3: no device found (phy stat 00000000)
>Aug 14 19:24:21 mandr kernel: scsi2 : sata_promise
>Aug 14 19:24:22 mandr kernel: ata4: no device found (phy stat 00000000)
>Aug 14 19:24:22 mandr kernel: scsi3 : sata_promise
>
> I have 2 hard drives connected to TX4000 on IDE1 channel, in stripe
>mode. I've set up raid in TX4000 BIOS, but in Linux it can't see my
>hard disks, and so I have no /dev/sd* and can't mount this hard
>disks...Could you please help me, what am I doing wrong?
>I've already tried to install sata_promise both as a module and as a
>built-in...I've tried to do 'modprobe sd_mod' first, it only says
>'SCSI system initialized'. I'm completely stuck with it :(
>
> PS. I have ASUS i815 CUSL2-M motherboard.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>



-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.338 / Virus Database: 267.10.9/72 - Release Date: 8/14/2005

