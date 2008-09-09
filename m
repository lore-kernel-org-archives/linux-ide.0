From: Antonio Cardoso Martins <digiplan.pt@gmail.com>
Subject: Re: UDMA with CS5530 using IBM Netvista N2200 (8363)
Date: Tue, 09 Sep 2008 01:03:21 +0100
Message-ID: <48C5BD49.6090204@gmail.com>
References: <48C45BEF.5090502@gmail.com> <20080908094332.7b021b4e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:30693 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbYIIADv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Sep 2008 20:03:51 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1328276fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 08 Sep 2008 17:03:49 -0700 (PDT)
In-Reply-To: <20080908094332.7b021b4e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Alan Cox wrote:
>> Netvista will complain with the messages bellow, using kernel 2.6.24.7
>> (i haven't used any more recent kernel because since kernel 2.6.24.7
>> they just fail to boot in Netvista 8363).
>>     
>
> What was the last kernel that did boot correctly ?
> If you are using a CF/ATA adapter do you have one which is rated for
> UDMA ?
> Does 2.6.24.7 work with CS5530=n and CONFIG_PATA_CS5530 enabled instead ?
> (If it doesn't then the different diagnostics will be useful)
>
> Alan
>
>   
>From kernel 2.6.25, using the same .config as in 2.6.24.7, kernel does
not start. I also tried with 2.6.25.2 and 2.6.26.3 with the same results.
The ATA adapter is embedded into the motherboard. Looking at the board,
the chipset reads Cyrix Cx5530. There is some contradictory information
about whether this chip supports DMA or not. Regarding the CF, i am
almost sure it supports some form of UDMA. You can see an image of the
Netvista in http://jeanchristophe.duber.free.fr/netvista_8363/

Booting with CONFIG_BLK_DEV_CS5530=n  and  CONFIG_PATA_CS5530=y  and
kernel 2.6.24.7 gives:
...
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Driver 'sd' needs updating - please use bus_type methods
scsi0: pata_cs5530
scsi1: pata_cs5530
ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
ata1.00: ATA-5: SILICON POWER, 2.0, mas UDMA/66
ata1.00: 2000880 sectors, multi 1: LBA
ata1.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access           ATA         SILICON POWER       
2.0    PQ:   0   ANSI: 5
sd 0:0:0:0: [sda] 2000880 512-byte hardware sectors (1024 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 2000880 512-byte hardware sectors (1024 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
 sda:<4>Clocksource tsc unstable (delta = 120000656 ns)
Time: pit clocksource has been installed.
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 actions 0x2 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
                 res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: device not ready (errno=-16), forcing hardreset
ata1: soft resetting link
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0x80)
ata1: device not ready (errno=-16), forcing hardreset
ata1: soft resetting link
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1.00: disabled
ata1: port is slow to respond, please be patient (Status 0x80)
ata1: device not ready (errno=-16), forcing hardreset
ata1: soft resetting link
ata1: EH complete
sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
  unable to read partition table
sd 0:0:0.0: [sda] attached SCSI disk
sd 0:0:0.0: Attached scsi generic sg0 type 0
...
VFS: Cannot open root device "<NULL>" or unknown-block(0,0)
Please append a correct "root=" boot option; here are the available
partitions:
0800        1000440 sda driver: sd
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0)

Does this give any interesting info to the problem?
PS: Since i cannot provide parameters to the kernel, i don't know how
the kernel i have completely working (2.6.22.15) figure out that he
should continue boot from root=/dev/hda1. This kernel does not seem to
get to that conclusion.

Best regards
