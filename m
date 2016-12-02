From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Fri, 2 Dec 2016 08:37:04 -0500
Message-ID: <CAP8WD_bPns6hGPWUUGbRd_20+bHX460p5szrfCP4bKr9k76wsQ@mail.gmail.com>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <84a95190-9e30-81ac-5f23-744243ba7fce@cogentembedded.com> <20161130145322.252f7403@lxorguk.ukuu.org.uk>
 <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com> <20161130181539.59cbec41@lxorguk.ukuu.org.uk>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36674 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757459AbcLBNhZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2016 08:37:25 -0500
Received: by mail-yw0-f175.google.com with SMTP id a10so217476811ywa.3
        for <linux-ide@vger.kernel.org>; Fri, 02 Dec 2016 05:37:25 -0800 (PST)
In-Reply-To: <20161130181539.59cbec41@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Alan,

>> Alan,
>>   on my hardware it grabbed all those interrupts, showing up in
>> /proc/interrupts very clearly.
>
> Do you have a dmesg of the boot ?
>

Here is the relevant dmesg information and also the /proc/interrupts results:

dmesg info:

[   22.534587] scsi host0: pata_legacy
[   22.566618] ata1: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
[   22.730639] ata1.00: ATA-4: QUANTUM FIREBALL CR8.4A, A5U.1200, max UDMA/66
[   22.730639] ata1.00: 16514064 sectors, multi 0: LBA
[   22.730639] ata1.00: configured for PIO
[   22.738601] scsi 0:0:0:0: Direct-Access     ATA      QUANTUM
FIREBALL 1200 PQ: 0 ANSI: 5
[   22.798627] sd 0:0:0:0: [sda] 16514064 512-byte logical blocks:
(8.45 GB/7.87 GiB)
[   22.818640] sd 0:0:0:0: [sda] Write Protect is off
[   22.818640] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   22.830629] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   22.934729]  sda: sda1 sda2 sda3 sda4
[   23.062648] sd 0:0:0:0: [sda] Attached SCSI disk
[   23.162640] scsi host1: pata_legacy
[   23.186648] ata2: PATA max PIO4 cmd 0x170 ctl 0x376 irq 15
[   23.494643] scsi host2: pata_legacy
[   23.518656] ata3: PATA max PIO4 cmd 0x1e8 ctl 0x3ee irq 11
[   23.830691] scsi host3: pata_legacy
[   23.854692] ata4: PATA max PIO4 cmd 0x168 ctl 0x36e irq 10
[   24.086711] genirq: Flags mismatch irq 8. 00000000 (pata_legacy.4)
vs. 00000000 (rtc0)
[   24.190692] scsi host4: pata_legacy
[   24.214697] ata5: PATA max PIO4 cmd 0x160 ctl 0x366 irq 12

/proc/interrupts info :

           CPU0
  0:      49060    XT-PIC  timer
...
 10:          0    XT-PIC  pata_legacy.3
 11:          0    XT-PIC  pata_legacy.2
 12:          0    XT-PIC  pata_legacy.5
 14:      41233    XT-PIC  pata_legacy.0
 15:          0    XT-PIC  pata_legacy.1
...

Tejun: I will build a kernel with your patches today and let you know
the results.

- Matthew
