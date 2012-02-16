From: Sebastian Muniz <basurerosebita@gmail.com>
Subject: Fwd: Re: sil3132 eSATA problem
Date: Thu, 16 Feb 2012 01:57:03 -0300
Message-ID: <4F3C8C9F.7090908@gmail.com>
References: <4F3C8C2F.1060300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46957 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333Ab2BPE5P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2012 23:57:15 -0500
Received: by ggnh1 with SMTP id h1so1076198ggn.19
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2012 20:57:15 -0800 (PST)
In-Reply-To: <4F3C8C2F.1060300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am sorry, my mailer sent it on html. Resending on plain text.


-------- Original Message --------
Subject: 	Re: sil3132 eSATA problem
Date: 	Thu, 16 Feb 2012 01:55:11 -0300
From: 	Sebastian Muniz <basurerosebita@gmail.com>
To: 	Robert Hancock <hancockrwd@gmail.com>
CC: 	linux-ide@vger.kernel.org



On 2/16/2012 1:45 AM, Robert Hancock wrote:
> Are you sure ata7 is an unused port? I'm pretty sure there must be a 
> drive on that port and it's throwing errors on writes. Can you post 
> the full dmesg log?
Hello Robert,
Indeed I am sure.
The lsscsi output says so:
root@ante:~# lsscsi -l
[0:0:0:0]    disk    ATA      HUA722050CLA330  JP2O  /dev/sda
   state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 
timeout=30
[4:0:0:0]    cd/dvd  TSSTcorp DVD-ROM TS-H353C LE01  /dev/sr0
   state=running queue_depth=1 scsi_level=6 type=5 device_blocked=0 
timeout=30
[6:0:0:0]    disk    ATA      WDC WD20EARS-00S 0957  /dev/sdb
   state=running queue_depth=1 scsi_level=6 type=0 device_blocked=0 
timeout=30
[6:1:0:0]    disk    ATA      WDC WD20EARS-00S 80.0  /dev/sdc
   state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 
timeout=30
[6:2:0:0]    disk    ATA      WDC WD20EARS-00S 80.0  /dev/sdd
   state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 
timeout=30
[6:3:0:0]    disk    ATA      WDC WD20EARS-00M 51.0  /dev/sde
   state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 
timeout=30
[6:4:0:0]    disk    ATA      WDC WD20EARS-00M 51.0  /dev/sdf
   state=running queue_depth=31 scsi_level=6 type=0 device_blocked=0 
timeout=30
root@ante:~#
Physically there is only one used port.
dmesg at:
http://pastebin.com/cJwKbPA9
Relevant parts I can see:
Ouch! you are correct!
Ata7 is scsi6 that is where the disks are connected!

 1.
    [    2.953688] sata_sil24 0000:10:00.0: version 1.1
 2.
    [    2.953702] sata_sil24 0000:10:00.0: PCI->APIC IRQ transform: INT
    A -> IRQ 18
 3.
    [    2.953835] sata_sil24 0000:10:00.0: setting latency timer to 64
 4. [    2.990750] scsi6 : sata_sil24
 5.
    [    3.022360] scsi7 : sata_sil24
 6.
    [    3.022455] ata7: SATA max UDMA/100 host m128@0x91b04000 port
    0x91b00000 irq 18
 7.
    [    3.022554] ata8: SATA max UDMA/100 host m128@0x91b04000 port
    0x91b02000 irq 18
 8.
    [    5.217790] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
 9.
    [    5.218248] ata7.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 5
    ports, feat 0x5/0xf
10.
    [    5.218670] ata7.00: hard resetting link
11.
    [    5.553352] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
12.
    [    5.553493] ata7.01: hard resetting link
13.
    [    5.888613] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
14.
    [    5.888753] ata7.02: hard resetting link
15.
    [    6.335621] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
16.
    [    6.335761] ata7.03: hard resetting link
17.
    [    6.782634] ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
18.
    [    6.782776] ata7.04: hard resetting link
19.
    [    7.245612] ata7.04: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
20.
    [    7.246217] ata7.00: ATA-7: WDC WD20EARS-00S8B1, 0957, max UDMA/133
21.
    [    7.246303] ata7.00: 3907029168 sectors, multi 1: LBA48
22.
    [    7.246930] ata7.00: configured for UDMA/100
23.
    [    7.250620] ata7.01: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max
    UDMA/133
24.
    [    7.250711] ata7.01: 3907029168 sectors, multi 0: LBA48 NCQ
    (depth 31/32)
25.
    [    7.254637] ata7.01: configured for UDMA/100
26.
    [    7.258461] ata7.02: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max
    UDMA/133
27.
    [    7.258550] ata7.02: 3907029168 sectors, multi 0: LBA48 NCQ
    (depth 31/32)
28.
    [    7.262478] ata7.02: configured for UDMA/100
29.
    [    7.265427] ata7.03: ATA-8: WDC WD20EARS-00MVWB0, 51.0AB51, max
    UDMA/133
30.
    [    7.265517] ata7.03: 3907029168 sectors, multi 0: LBA48 NCQ
    (depth 31/32)
31.
    [    7.269402] ata7.03: configured for UDMA/100
32.
    [    7.272915] ata7.04: ATA-8: WDC WD20EARS-00MVWB0, 51.0AB51, max
    UDMA/133
33.
    [    7.273004] ata7.04: 3907029168 sectors, multi 0: LBA48 NCQ
    (depth 31/32)
34.
    [    7.276599] ata7.04: configured for UDMA/100
35.
    [    7.276783] ata7: EH complete
36. [    9.352622] ata8: SATA link down (SStatus 0 SControl 0)

So I am in trouble here.
I have downloaded, configured and I am ready to install Linux-3.2.4 if 
that might help.

Thanks in advance.
Sebastian



