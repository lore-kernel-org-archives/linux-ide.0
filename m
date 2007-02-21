From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Question about PATA Sil680 Cache Line Size and Performance Degradation on ARM XScale
Date: Wed, 21 Feb 2007 15:56:28 -0700
Message-ID: <8202f4270702211456h52498bbdk560d9d47e2e319d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:61862 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945896AbXBUW4c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 17:56:32 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2360854nze
        for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 14:56:31 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk

Hi Folks,

I've noticed the following code in both pata_sil680.c and IDE code siimage.c
        /* FIXME: double check */
	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, (class_rev) ? 1 : 255);
I was unable to find the recommended setting in Sil680 document. Could
someone explain the rational behind the code above? Does it need to be
adjusted on different processors for PCI read/write performance?

The problem I am investigating is slow IO on PATA Sil680 on ARM XScale
processor (VIVT cache) but not on i386. Based on libata trace below,
it took about 4ms for read DMA command to finish:
[4294934.196000] ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 0e fa 00 00 00 80
[4294934.196000] ata_scsi_translate: ENTER
[4294934.196000] scsi_10_lba_len: ten-byte command
[4294934.196000] ata_sg_setup: ENTER, ata1
[4294934.196000] ata_sg_setup: 13 sg elements mapped
[4294934.196000] ata_fill_sg: PRD[0] = (0x2C3F000, 0x1000)
[4294934.196000] ata_fill_sg: PRD[1] = (0x2D76000, 0x1000)
[4294934.196000] ata_fill_sg: PRD[2] = (0x2C5B000, 0x1000)
[4294934.196000] ata_fill_sg: PRD[3] = (0x2C98000, 0x1000)
[4294934.196000] ata_fill_sg: PRD[4] = (0x2D5E000, 0x1000)
[4294934.196000] ata_fill_sg: PRD[5] = (0x2D71000, 0x1000)
[4294934.196000] ata_fill_sg: PRD[6] = (0x2D7C000, 0x1000)
[4294934.196000] ata_fill_sg: PRD[7] = (0x2D8B000, 0x1000)
[4294934.196000] ata_fill_sg: PRD[8] = (0x2DA1000, 0x1000)
[4294934.196000] ata_fill_sg: PRD[9] = (0x2D0C000, 0x2000)
[4294934.196000] ata_fill_sg: PRD[10] = (0x33FC000, 0x2000)
[4294934.196000] ata_fill_sg: PRD[11] = (0x2D8C000, 0x2000)
[4294934.196000] ata_fill_sg: PRD[12] = (0x2C06000, 0x1000)
[4294934.196000] ata1: ata_dev_select: ENTER, ata1: device 0, wait 1
[4294934.196000] ata_tf_load_pio: feat 0x0 nsect 0x80 lba 0x0 0xFA 0xE
[4294934.196000] ata_tf_load_pio: device 0xE0
[4294934.196000] ata_exec_command_pio: ata1: cmd 0xC8
[4294934.196000] ata_scsi_translate: EXIT
[4294934.200000] ata_host_intr: ata1: protocol 3 task_state 3
[4294934.200000] ata_host_intr: ata1: host_stat 0x4
[4294934.200000] ata_hsm_move: ata1: protocol 3 task_state 3 (dev_stat 0x50)
[4294934.200000] ata_hsm_move: ata1: dev 0 command complete, drv_stat 0x50
[4294934.200000] ata_sg_clean: unmapping 13 sg elements

I did the same test on i386 with the same PATA Sil680 HBA and the
interrupt latency is reduced to around 1ms:
[  113.494605] ata_scsi_dump_cdb: CDB (5:0,0,0) 28 00 00 0a ad 80 00 00 80
[  113.494674] ata_scsi_translate: ENTER
[  113.494731] scsi_10_lba_len: ten-byte command
[  113.494791] ata_sg_setup: ENTER, ata5
[  113.494847] ata_sg_setup: 2 sg elements mapped
[  113.494907] ata_fill_sg: PRD[0] = (0x1158000, 0x4000)
[  113.494968] ata_fill_sg: PRD[1] = (0x1170000, 0xC000)
[  113.495029] ata5: ata_dev_select: ENTER, ata5: device 0, wait 1
[  113.495125] ata_tf_load_pio: feat 0x0 nsect 0x80 lba 0x80 0xAD 0xA
[  113.495190] ata_tf_load_pio: device 0xE0
[  113.495261] ata_exec_command_pio: ata5: cmd 0xC8
[  113.495324] ata_scsi_translate: EXIT
[  113.496005] ata_host_intr: ata5: protocol 3 task_state 3
[  113.496068] ata_host_intr: ata5: host_stat 0x4
[  113.496135] ata_hsm_move: ata5: protocol 3 task_state 3 (dev_stat 0x50)
[  113.496201] ata_hsm_move: ata5: dev 0 command complete, drv_stat 0x50
[  113.496266] ata_sg_clean: unmapping 2 sg elements

I also observed that the same AT command (Read DMA) took around 1ms on
the same test hardware with SATA Sil3124 HBA.

As part of the experiments, I've changed Sil680 cache line size to
0x08, 0x04, 0x02, etc, but the IO performance was not improved.  So
what might be the bottleneck causing the IO slowness on ARM XScale?
Thanks in advance for your help!

Thanks,
Fajun
