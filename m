From: Sui Chen <suichen6@gmail.com>
Subject: Forcing CAP register value to make booting more reliable on the Acer
 Aspire Switch Alpha 12 tablet
Date: Thu, 1 Dec 2016 18:05:49 -0600
Message-ID: <90940a43-e37f-4c26-b2ca-170090a045bb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:32790 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbcLBAFv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2016 19:05:51 -0500
Received: by mail-oi0-f45.google.com with SMTP id w63so249311871oiw.0
        for <linux-ide@vger.kernel.org>; Thu, 01 Dec 2016 16:05:51 -0800 (PST)
Received: from ?IPv6:2620:105:b004:e100:6984:4fd8:afb8:69d? ([2620:105:b004:e100:6984:4fd8:afb8:69d])
        by smtp.googlemail.com with ESMTPSA id p48sm835127ota.18.2016.12.01.16.05.50
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Dec 2016 16:05:50 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello, Linux-IDE mailing list,

I recently bought an Acer Aspire Switch Alpha 12 (Model Number: SA5-271) 
2-in-1 convertible computer. This computer has an Intel Skylake i5-6200U 
processor and a Lite-On CV1-8B256 SSD.

I noticed that the kernel will intermittently fail to detect the SSD as 
/dev/sda and may be fixed by changing seemingly unrelated settings in 
the BIOS (such as clearing secure boot databases) or with a "dirty hack" 
in libahci.c (tested on Kernel 4.8). When the SSD is not detected, the 
kernel will print an alert saying "Gave Up waiting for root device. 
Alert! /dev/disk/by-uuid/ does not exist. Dropping to a shell." Typing 
"blkid" in the initramfs shell shows no devices either.

When the SSD is detected the following lines can be seen in the dmesg 
output:
    [    1.347021] ahci 0000:00:17.0: version 3.0
    [    1.365569] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 3 ports 6 
Gbps 0x7 impl SATA mode
    [    1.367519] ahci 0000:00:17.0: flags: 64bit ncq pm led clo only 
pio slum part deso sadm sds apst
    [    1.377574] scsi host0: ahci
    [    1.379465] scsi host1: ahci
    [    1.381373] scsi host2: ahci
    [    1.383060] ata1: SATA max UDMA/133 abar m2048@0xb1648000 port 
0xb1648100 irq 124
    [    1.384665] ata2: SATA max UDMA/133 abar m2048@0xb1648000 port 
0xb1648180 irq 124
    [    1.386305] ata3: SATA max UDMA/133 abar m2048@0xb1648000 port 
0xb1648200 irq 124

However, when the SSD is not detecting:
    [    1.337065] ahci 0000:00:17.0: version 3.0
-> [    1.343206] ahci 0000:00:17.0: implemented port map (0x7) contains 
more ports than nr_ports (2), using nr_ports
-> [    1.351165] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 
Gbps 0x0 impl SATA mode
    [    1.352323] ahci 0000:00:17.0: flags: 64bit ncq pm led clo only 
pio slum part deso sadm sds apst
    [    1.355960] scsi host0: ahci
    [    1.357292] scsi host1: ahci
-> [    1.358405] ata1: DUMMY
-> [    1.359466] ata2: DUMMY

One can note the differences in the marked lines in the dmesg output 
when the SSD is not detecting: 1) nr_ports becomes 2 instead of 3; 2) 
ATA1 and ATA2 are both DUMMY.


Adding the following lines in the function "ahci_save_initial_config" in 
file libahci.c, line 453 seems to fix this for now:
     if ((cap & 0xC734FF00) == 0xC734FF00) {
         dev_info(dev, "Forcing CAP to 0xC734FF02 and port_map to 0x7!\n");
         hpriv->saved_cap = cap = 0xC734FF02;
         hpriv->saved_port_map = port_map = 0x7;
     }

What the code does is to force port_map to become 0x7 and saved_cap to 
become 0xC734FF02. Actually, when the SSD is detecting the cap register 
holds a value of 0xC734FF02 but when it fails, cap can be either 
0xC734FF01 or 0xC734FF00.

My questions are:
Is this a bad way of solving this; can it possibly damage the computer?
Could this be possibly related to the BIOS of the specific computer?

Thank you so much!
2016-12-01
Sui

