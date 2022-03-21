Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D9DC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 08:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbiCUIqO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 04:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242941AbiCUIqN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 04:46:13 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA07A6E2A
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 01:44:45 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aef4e.dynamic.kabel-deutschland.de [95.90.239.78])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 75B5C61E6478B
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 09:44:44 +0100 (CET)
Message-ID: <36288054-bc9d-c80c-502e-79bddcacd5f6@molgen.mpg.de>
Date:   Mon, 21 Mar 2022 09:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     linux-ide@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: How to match disk to controller in Linux log?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Linux folks,


AMD Ryzen devices come with two SATA controllers:

     $ lspci -nn | grep SATA
     01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 
300 Series Chipset SATA Controller [1022:43b7] (rev 02)
     07:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 
FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)

lsscsi [1] in verbose mode shows the controller a disk is actually 
attached to.

     $ lsscsi -v
     [0:0:0:0]    disk    ATA      ST500LM021-1KJ15 SDM1  /dev/sda
       dir: /sys/bus/scsi/devices/0:0:0:0 
[/sys/devices/pci0000:00/0000:00:01.3/0000:01:00.1/ata1/host0/target0:0:0/0:0:0:0]

For analysis and bug reports, it’d be great if the Linux kernel log 
would contain that information too. But I am unable to find it. Is it 
present?

     [    0.426850] calling  ahci_pci_driver_init+0x0/0x1a @ 1
     [    0.426869] ahci 0000:01:00.1: version 3.0
     [    0.426970] ahci 0000:01:00.1: SSS flag set, parallel bus scan 
disabled
     [    0.427004] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 8 ports 6 
Gbps 0x33 impl SATA mode
     [    0.427008] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led 
clo only pmp pio slum part sxs deso sadm sds apst
     [    0.427412] scsi host0: ahci
     [    0.427493] scsi host1: ahci
     [    0.427569] scsi host2: ahci
     [    0.427653] scsi host3: ahci
     [    0.427728] scsi host4: ahci
     [    0.427801] scsi host5: ahci
     [    0.427876] scsi host6: ahci
     [    0.427950] scsi host7: ahci
     [    0.427978] ata1: SATA max UDMA/133 abar m131072@0xf0600000 port 
0xf0600100 irq 36
     [    0.427982] ata2: SATA max UDMA/133 abar m131072@0xf0600000 port 
0xf0600180 irq 36
     [    0.427985] ata3: DUMMY
     [    0.427986] ata4: DUMMY
     [    0.427988] ata5: SATA max UDMA/133 abar m131072@0xf0600000 port 
0xf0600300 irq 36
     [    0.427991] ata6: SATA max UDMA/133 abar m131072@0xf0600000 port 
0xf0600380 irq 36
     [    0.427994] ata7: DUMMY
     [    0.427995] ata8: DUMMY
     [    0.428015] ata1: hard resetting link
     [    0.428116] ahci 0000:07:00.2: AHCI 0001.0301 32 slots 1 ports 6 
Gbps 0x1 impl SATA mode
     [    0.428124] ahci 0000:07:00.2: flags: 64bit ncq sntf ilck pm led 
clo only pmp fbs pio slum part
     [    0.428250] scsi host8: ahci
     [    0.428278] ata9: SATA max UDMA/133 abar m4096@0xf0108000 port 
0xf0108100 irq 38
     [    0.428295] initcall ahci_pci_driver_init+0x0/0x1a returned 0 
after 1409 usecs
     […]
     [    0.428316] ata9: hard resetting link
     [    0.532308] ata9: SATA link down (SStatus 0 SControl 300)
     [    0.696316] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
     [    0.725963] ata1.00: ATA-8: ST500LM021-1KJ152, 0005SDM1, max 
UDMA/133
     [    0.725982] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ 
(depth 32)
     [    0.764845] ata1.00: configured for UDMA/133

Can you think of a way and log format, what controller the disk is 
actually attached to?

     [    0.765133] ata2: hard resetting link
     [    0.868330] ata2: SATA link down (SStatus 0 SControl 300)
     [    0.868965] ata5: hard resetting link
     [    0.973337] ata5: SATA link down (SStatus 0 SControl 300)
     [    0.973910] ata6: hard resetting link
     [    1.077832] ata6: SATA link down (SStatus 0 SControl 300)


Kind regards,

Paul


[1]: https://sg.danny.cz/scsi/lsscsi.html
