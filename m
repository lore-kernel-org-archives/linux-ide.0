From: Peter Ganzhorn <peter.ganzhorn@googlemail.com>
Subject: Re: [PATCH] AHCI powersaving and port-stopping (2.6.22-rc4)
Date: Mon, 11 Jun 2007 13:33:45 +0200
Message-ID: <466D3319.6070008@googlemail.com>
References: <873b0yvk14.fsf-genuine-vii@john.fremlin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:65485 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbXFKLdt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 07:33:49 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1447605ugf
        for <linux-ide@vger.kernel.org>; Mon, 11 Jun 2007 04:33:48 -0700 (PDT)
In-Reply-To: <873b0yvk14.fsf-genuine-vii@john.fremlin.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Fremlin <john@fremlin.org>
Cc: linux-ide@vger.kernel.org, power@bughost.org

I just wanted to have a look at the patch and see if it works for me - 
looks like somethings not all straight, I get this while booting:

ahci 0000:00:1f.2: version 2.2
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: nr_ports (3) and implemented port map (0x1) don't match
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x1 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc20000048100 ctl 0x0000000000000000 
bmdma 0x0000000000000000 irq 0
WARNING: at drivers/ata/libata-eh.c:1917 ata_eh_set_powersave()

Call Trace:
 [<ffffffff804a99ce>] ata_eh_set_powersave+0x34e/0x370
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff804a9e27>] ata_do_eh+0xb7/0x16f0
 [<ffffffff80229f9d>] find_busiest_group+0x1bd/0x800
 [<ffffffff804aece0>] ahci_postreset+0x0/0x80
 [<ffffffff804ada70>] ahci_hardreset+0x0/0xf0
 [<ffffffff804aee20>] ahci_softreset+0x0/0x270
 [<ffffffff804a40f0>] ata_std_prereset+0x0/0xf0
 [<ffffffff8023b134>] lock_timer_base+0x34/0x70
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff804abc27>] ata_scsi_error+0x297/0x730
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff8048c893>] scsi_error_handler+0xe3/0x330
 [<ffffffff80229507>] __wake_up_common+0x47/0x80
 [<ffffffff8048c7b0>] scsi_error_handler+0x0/0x330
 [<ffffffff8024675b>] kthread+0x4b/0x80
 [<ffffffff8020a9a8>] child_rip+0xa/0x12
 [<ffffffff80246710>] kthread+0x0/0x80
 [<ffffffff8020a99e>] child_rip+0x0/0x12

ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ata_hpa_resize 1: sectors = 312581808, hpa_sectors = 312581808
ata1.00: ATA-7: Hitachi HTS541616J9SA00, SB4OC7DP, max UDMA/100
ata1.00: 312581808 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: ata_hpa_resize 1: sectors = 312581808, hpa_sectors = 312581808
ata1.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SB4O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0

I hope this output from dmesg helps to make the patch better - if I can 
do any further testing please let me know!

Peter


John Fremlin wrote:
> Tejun Heo has made an excellent patch for saving power with the AHCI
> chipset. It saves about 1 W on my Thinkpad X60s.
>
> This patch will stop the ports when they are idle. To turn it on, 
>
>      echo 1 > /sys/module/libata/parameters/powersave
>
> This is very different from the patch I posted a while ago turning on
> a few bits in the CMD register (ALPE and ASP) and which Intel is
> apparently now trying. That only saves around 250mW. Tejun's patch
> saves about 1 W. It should also make the ALPE and ASP stuff irrelevant
> because it performs the same operation in software where better
> information about usage is (theoretically) available.
>
> I have updated the patch for 2.6.22-rc4. That is the extent of my
> involvement - if it works, thank Tejun Heo. But problems are quite
> likely to have been introduced by my clumsy update, so if it doesn't
> work, blame me first.
>
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Power mailing list
> Power@bughost.org
> http://www.bughost.org/mailman/listinfo/power
>   

