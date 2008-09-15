From: "Alex Gonzalez" <langabe@gmail.com>
Subject: Re: [libata/sata_sil] Error on startup
Date: Mon, 15 Sep 2008 10:49:30 +0100
Message-ID: <c58a7a270809150249qa0bb8e5ifdbfeb7fb5ef0565@mail.gmail.com>
References: <c58a7a270809120334r16164e3ej9f8ab769a09742ed@mail.gmail.com>
	 <c58a7a270809120427p2af9885eo9cbc2d4455372882@mail.gmail.com>
	 <48CBB831.9030403@ru.mvista.com>
	 <c58a7a270809131023g6c5dad8em8cee2ace3b678209@mail.gmail.com>
	 <48CE2389.9080205@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:36132 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbYIOJtc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 05:49:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1327830fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 02:49:30 -0700 (PDT)
In-Reply-To: <48CE2389.9080205@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Of course,

An extract of the working kernel log,

[4294670.795000] 0:<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294670.796000] 0:<6>ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
[4294670.797000] 0:Initializing Phoenix PCMCIA IDE...
[4294670.798000] 0:Phoenix PCMCIA configured as IDE interface = 0
[4294670.799000] 0:<7>Probing IDE interface ide0...
[4294671.058000] 0:hda: CF CARD 2GB, 0:CFA DISK drive
[4294671.672000] 0:ide0 at 0xbd0001f1-0xbd0001f8,0xbd0003f7 on irq 210:
[4294671.674000] 0:<6>hda: max request size: 128KiB
[4294671.675000] 0:<6>hda: 3964464 sectors (2029 MB)0: w/1KiB Cache0:,
CHS=3933/16/630:
[4294671.679000] 0:<6> hda:0: hda10:
[4294671.721000] 0:<7>sata_sil 0000:00:01.0: version 2.1
[4294671.722000] 0:<6>sata_sil 0000:00:01.0: Applying R_ERR on DMA
activate FIS errata fix
[4294671.723000] 0:<6>ata1: SATA max UDMA/100 cmd 0xc0000080 ctl
0xc000008a bmdma 0xc0000000 irq 24
[4294671.724000] 0:<6>ata2: SATA max UDMA/100 cmd 0xc00000c0 ctl
0xc00000ca bmdma 0xc0000008 irq 24
[4294671.725000] 0:<6>scsi0 : sata_sil
[4294672.180000] 3:<6>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[4294672.205000] 3:<6>ata1.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[4294672.223000] 3:<6>ata1.00: 312581808 sectors, multi 0: LBA48 NCQ
(depth 0/32)
[4294672.248000] 3:<6>ata1.00: configured for UDMA/100
[4294672.262000] 0:<6>scsi1 : sata_sil
[4294672.567000] 3:<6>ata2: SATA link down (SStatus 0 SControl 310)
[4294672.585000] 0:<5>scsi 0:0:0:0: Direct-Access     ATA
ST3160815AS      4.AA PQ: 0 ANSI: 5
[4294672.586000] 0:<5>SCSI device sda: 312581808 512-byte hdwr sectors
(160042 MB)
[4294672.587000] 0:<5>sda: Write Protect is off
[4294672.588000] 0:<7>sda: Mode Sense: 00 3a 00 00
[4294672.589000] 0:<5>SCSI device sda: write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
[4294672.590000] 0:<5>SCSI device sda: 312581808 512-byte hdwr sectors
(160042 MB)
[4294672.591000] 0:<5>sda: Write Protect is off
[4294672.592000] 0:<7>sda: Mode Sense: 00 3a 00 00
[4294672.593000] 0:<5>SCSI device sda: write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
[4294672.594000] 0:<6> sda:0: sda10: sda20: sda30: sda40:
[4294672.624000] 0:<5>sd 0:0:0:0: Attached scsi disk sda

And the non working log,

[4294670.790000] 0:<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294670.791000] 0:<6>ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
[4294670.792000] 0:Initializing Phoenix PCMCIA IDE...
[4294670.793000] 0:Phoenix PCMCIA configured as IDE interface = 0
[4294670.794000] 0:<7>Probing IDE interface ide0...
[4294671.053000] 0:hda: CF CARD 2GB, 0:CFA DISK drive
[4294671.667000] 0:ide0 at 0xbd0001f1-0xbd0001f8,0xbd0003f7 on irq 210:
[4294671.669000] 0:<6>hda: max request size: 128KiB
[4294671.670000] 0:<6>hda: 3964464 sectors (2029 MB)0: w/1KiB Cache0:,
CHS=3933/16/630:
[4294671.674000] 0:<6> hda:0: hda10:
[4294671.680000] 0:<7>sata_sil 0000:00:01.0: version 2.1
[4294671.681000] 0:<6>sata_sil 0000:00:01.0: Applying R_ERR on DMA
activate FIS errata fix
[4294671.682000] 0:<6>ata1: SATA max UDMA/100 cmd 0xc0000080 ctl
0xc000008a bmdma 0xc0000000 irq 24
[4294671.683000] 0:<6>ata2: SATA max UDMA/100 cmd 0xc00000c0 ctl
0xc00000ca bmdma 0xc0000008 irq 24
[4294671.684000] 0:<6>scsi0 : sata_sil
[4294672.142000] 2:<6>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[4294672.165000] 2:<6>ata1.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[4294672.183000] 2:<6>ata1.00: 312581808 sectors, multi 0: LBA48 NCQ
(depth 0/32)
[4294672.208000] 2:<6>ata1.00: configured for UDMA/100
[4294672.222000] 0:<6>scsi1 : sata_sil
[4294672.526000] 2:<6>ata2: SATA link down (SStatus 0 SControl 310)
[4294672.544000] 0:<5>scsi 0:0:0:0: Direct-Access     ATA
ST3160815AS      4.AA PQ: 0 ANSI: 5
[4294672.545000] 0:<5>SCSI device sda: 312581808 512-byte hdwr sectors
(160042 MB)
[4294672.546000] 0:<5>sda: Write Protect is off
[4294672.547000] 0:<7>sda: Mode Sense: 00 3a 00 00
[4294672.548000] 0:<5>SCSI device sda: write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
[4294672.549000] 0:<5>SCSI device sda: 312581808 512-byte hdwr sectors
(160042 MB)
[4294672.550000] 0:<5>sda: Write Protect is off
[4294672.551000] 0:<7>sda: Mode Sense: 00 3a 00 00
[4294672.552000] 0:<5>SCSI device sda: write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
[4294672.553000] 0:<6> sda:

< Added: Big pause around 10 secs>

*********************************************
cpu_0 received a bus/cache error
*********************************************
Bridge: Phys Addr = 0x0000000000, Device_AERR = 0x00000000
Bridge: The devices reporting AERR are:
CPU: (XLR specific) Cache Error log = 0x0000007800004601, Phy Addr =
0x00f0000088
CPU: epc = 0x8340e324, errorepc = 0x835bccd4, cacheerr = 0x00000000
Can not handle bus/cache error - Halting cpu

With some printks to follow the action:

:<6> sda:0:msdos_partition: sector_size=1
0:read_dev_sector: mapping = 87946cac
0:__read_cache_page:cached_page=83a15580
0:read_cache_page: page=83a15580
0:lock_page
0:sync_page on mm/filemap.c
0:block_sync_page
0:blk_run_backing_dev()
0:blk_backing_dev_unplug()
0:scsi_request_fn
0:scsi_dispatch_cmd
0:ata_scsi_queuecmd
0:ata_scsi_translate
0:***ata_qc_prep***
0:***ata_check_status***
0:***ata_std_dev_select***
0:***ata_check_status***
0:***ata_check_status***
0:***ata_tf_load
0:***ata_bmdma_setup***
0:***ata_exec_command***
0:***ata_bmdma_start***
0:Dispatched cmd 8b64eba0 with rth 0

<PAUSE>

0:***sil_freeze()***
0:***ata_bmdma_error_handler***
0:***ata_bmdma_status***
0:***ata_bmdma_stop***
*********************************************
cpu_0 received a bus/cache error
*********************************************
Bridge: Phys Addr = 0x0000000000, Device_AERR = 0x00000000
Bridge: The devices reporting AERR are:
CPU: (XLR specific) Cache Error log = 0x0000007800004601, Phy Addr =
0x00f0000088
CPU: epc = 0x83435dfc, errorepc = 0x835bf054, cacheerr = 0x00000000
Can not handle bus/cache error - Halting cpu

Please tell me if a full trace would be better than these extracts,

Regards,
Alex

On Mon, Sep 15, 2008 at 9:57 AM, Tejun Heo <tj@kernel.org> wrote:
> Alex Gonzalez wrote:
>> Thanks for the tip Sergei. The timeout in question lasts several
>> seconds and is unrecoverable, finishing with a bus error. I could be
>> looking at a hardware problem, but I have tried different drives,
>> cables and I even see it on different units.
>>
>> And most of the times everything works fine.
>
> Care to post the kernel log, preferably with timestamps?
>
> --
> tejun
>
