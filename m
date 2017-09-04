From: John Loy <john.robert.loy@gmail.com>
Subject: Boot failure due to some interaction between per-port MSI-X and Intel
 RST
Date: Sun, 3 Sep 2017 18:42:35 -0700
Message-ID: <fc6edbd0-d720-4112-550c-fbed78ee8b32@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33558 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbdIDBmi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Sep 2017 21:42:38 -0400
Received: by mail-pf0-f173.google.com with SMTP id n73so13903444pfj.0
        for <linux-ide@vger.kernel.org>; Sun, 03 Sep 2017 18:42:37 -0700 (PDT)
Received: from ninamori.local ([2601:648:8101:bece:325a:3aff:fe54:9e80])
        by smtp.gmail.com with ESMTPSA id z8sm8314251pgc.92.2017.09.03.18.42.36
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Sep 2017 18:42:36 -0700 (PDT)
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a system that stopped booting Linux between kernel versions 4.4.9 
and 4.5.3.  It has a SATA + NVMe accelerated volume that I use with 
Windows and a separate SATA drive with my Linux installation.  I'm not 
expecting the remapped NVMe thing to be accessible, just the Linux disk, 
but none of the drives are accessible.

Bisecting the changes turned up d684a90 as the first failing change. 
Passing pci=nomsi also allows the system to boot newer kernels.  Just to 
be sure, I built a recent kernel (4.12.9) with the PCI_IRQ_MSIX flag 
removed from the per-port call to pci_alloc_irq_vectors in 
ahci_init_msi.  This also allowed the system to boot normally.

I'm totally out of my depth though so I'd really appreciate it if anyone 
has some ideas on how to proceed with a proper fix.

Thanks,
John

I can post the entire dmesg output if it would be helpful but the 
following seems like the most relevant parts:

[    0.516776] libata version 3.00 loaded.
[    2.866275] ahci 0000:00:17.0: version 3.0
[    2.866331] ahci 0000:00:17.0: Found 1 remapped NVMe devices.
[    2.866331] ahci 0000:00:17.0: Switch your BIOS from RAID to AHCI 
mode to use them.
[    2.866335] ahci 0000:00:17.0: controller can't do SNTF, turning off 
CAP_SNTF
[    2.876533] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps 
0x3f impl RAID mode
[    2.876534] ahci 0000:00:17.0: flags: 64bit ncq led clo only pio slum 
part deso sadm sds apst
[    2.876538] ahci 0000:00:17.0: both AHCI_HFLAG_MULTI_MSI flag set and 
custom irq handler implemented
[    2.877032] scsi host0: ahci
[    2.877178] scsi host1: ahci
[    2.877342] scsi host2: ahci
[    2.877483] scsi host3: ahci
[    2.877647] scsi host4: ahci
[    2.877831] scsi host5: ahci
[    2.877845] ata1: SATA max UDMA/133 abar m524288@0xdf200000 port 
0xdf200100 irq 121
[    2.877846] ata2: SATA max UDMA/133 abar m524288@0xdf200000 port 
0xdf200180 irq 122
[    2.877847] ata3: SATA max UDMA/133 abar m524288@0xdf200000 port 
0xdf200200 irq 123
[    2.877848] ata4: SATA max UDMA/133 abar m524288@0xdf200000 port 
0xdf200280 irq 124
[    2.877849] ata5: SATA max UDMA/133 abar m524288@0xdf200000 port 
0xdf200300 irq 125
[    2.877850] ata6: SATA max UDMA/133 abar m524288@0xdf200000 port 
0xdf200380 irq 126
[    3.186836] ata6: SATA link down (SStatus 4 SControl 300)
[    3.186882] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.186919] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.186970] ata2: SATA link down (SStatus 4 SControl 300)
[    3.187003] ata1: SATA link down (SStatus 4 SControl 300)
[    3.187042] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.676029] ata5.00: qc timeout (cmd 0xa1)
[    8.676037] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[    8.676054] ata4.00: qc timeout (cmd 0xec)
[    8.676062] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[    8.676079] ata3.00: qc timeout (cmd 0xec)
[    8.676087] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[    8.986227] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.986282] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    8.986309] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   19.428027] ata4.00: qc timeout (cmd 0xec)
[   19.428035] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   19.428039] ata4: limiting SATA link speed to 1.5 Gbps
[   19.428056] ata3.00: qc timeout (cmd 0xec)
[   19.428064] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   19.428068] ata3: limiting SATA link speed to 3.0 Gbps
[   19.428086] ata5.00: qc timeout (cmd 0xa1)
[   19.428094] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   19.428097] ata5: limiting SATA link speed to 1.5 Gbps
[   19.738226] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   19.738251] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   19.738276] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   50.148029] ata5.00: qc timeout (cmd 0xa1)
[   50.148037] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   50.148054] ata4.00: qc timeout (cmd 0xec)
[   50.148062] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   50.148078] ata3.00: qc timeout (cmd 0xec)
[   50.148086] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   50.458231] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   50.458260] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   50.458289] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
