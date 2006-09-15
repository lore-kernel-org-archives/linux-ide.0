From: "Fajun Chen" <fajunchen@gmail.com>
Subject: How to make SATA hotplug path tight?
Date: Fri, 15 Sep 2006 09:12:33 -0600
Message-ID: <8202f4270609150812r654c1319r511b18aadf7e1f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:30051 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751470AbWIOPMe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Sep 2006 11:12:34 -0400
Received: by py-out-1112.google.com with SMTP id n25so4112428pyg
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2006 08:12:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com

Hi,

I'm trying to speed up the SATA hotplug sequence so I can measure the
disk spinup time more accurately.  I noticed two delays which may be
unnecessary in SATA hotplug:
1. About 4-5 seconds delay during power cycle (power down then power
up) as shown below (detail log at the end):
[65642.680000] ata_eh_prep_resume: ENTER
[65642.680000] ata_eh_prep_resume: EXIT
[65642.680000] __ata_port_freeze: ata2 port frozen
[65646.970000] ata2: soft resetting port
[65646.970000] sil24_softreset: ENTER
Question: where is the delay introduced and can we eliminate this delay?

2. Soft reset fails sometimes then followed by a successful hard reset.
Question: may I do hard reset to start with and where is the best
place to change this? I know sata spec recommend attempting less
intrusive recovery procedure first, but I need to eliminate as much
unnecessary delay as possible.

Is there any other place in new eh where SATA hotplug can be optimized?

Thanks,
Fajun

Details log:

[65642.680000] ata2.00: ata_dev_read_id: ENTER, host 2, dev 0
[65642.680000] ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
[65642.680000] ata_sg_setup_one: mapped buffer of 512 bytes for read
[65642.680000] ata_sg_clean: unmapping 1 sg elements
[65642.680000] ata_port_flush_task: ENTER
[65642.680000] ata_port_flush_task: flush #1
[65642.680000] ata2: ata_port_flush_task: flush #2
[65642.680000] ata2: ata_port_flush_task: EXIT
[65642.680000] ata2.00: ata_dev_configure: ENTER, host 2, dev 0
[65642.680000] ata2.00: ata_dev_configure: cfg 49:2f00 82:346b 83:7d09
84:6003 85:3469 86:3c09 87:6003 88:007f
[65642.680000] ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407
64==0x0003  75==0x001f
[65642.680000] ata_dump_id: 80==0x00fe  81==0x0000  82==0x346b
83==0x7d09  84==0x6003
[65642.680000] ata_dump_id: 88==0x007f  93==0x0000
[65642.680000] ata2.00: ata_dev_configure: EXIT, drv_stat = 0x50
[65642.680000] ata_eh_revalidate_and_attach: EXIT
[65642.680000] ata_eh_resume: ENTER
[65642.680000] ata_eh_resume: EXIT
[65642.680000] ata_dev_set_xfermode: set features - xfer mode
[65642.680000] ata_port_flush_task: ENTER
[65642.680000] ata_port_flush_task: flush #1
[65642.680000] ata2: ata_port_flush_task: flush #2
[65642.680000] ata2: ata_port_flush_task: EXIT
[65642.680000] ata_dev_set_xfermode: EXIT, err_mask=0
[65642.680000] ata2.00: ata_dev_read_id: ENTER, host 2, dev 0
[65642.680000] ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
[65642.680000] ata_sg_setup_one: mapped buffer of 512 bytes for read
[65642.680000] ata_sg_clean: unmapping 1 sg elements
[65642.680000] ata_port_flush_task: ENTER
[65642.680000] ata_port_flush_task: flush #1
[65642.680000] ata2: ata_port_flush_task: flush #2
[65642.680000] ata2: ata_port_flush_task: EXIT
[65642.680000] ata2.00: ata_dev_configure: ENTER, host 2, dev 0
[65642.680000] ata2.00: ata_dev_configure: cfg 49:2f00 82:346b 83:7d09
84:6003 85:3469 86:3c09 87:6003 88:207f
[65642.680000] ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007
64==0x0003  75==0x001f
[65642.680000] ata_dump_id: 80==0x00fe  81==0x0000  82==0x346b
83==0x7d09  84==0x6003
[65642.680000] ata_dump_id: 88==0x207f  93==0x0000
[65642.680000] ata2.00: ata_dev_configure: EXIT, drv_stat = 0x50
[65642.680000] ata_dev_set_mode: xfer_shift=8, xfer_mode=0x45
[65642.680000] ata2.00: configured for UDMA/100
[65642.680000] ata_eh_suspend: ENTER
[65642.680000] ata_eh_suspend: EXIT
[65642.680000] ata_eh_recover: EXIT, rc=0
[65642.680000] ata2: EH pending after completion, repeating EH (cnt=4)
[65642.680000] ata_eh_autopsy: ENTER
[65642.680000] ata_eh_autopsy: EXIT
[65642.680000] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x1
[65642.680000] ata2: (irq_stat 0x00a00080, device exchanged)
[65642.680000] ata_eh_recover: ENTER
[65642.680000] ata_eh_prep_resume: ENTER
[65642.680000] ata_eh_prep_resume: EXIT
[65642.680000] __ata_port_freeze: ata2 port frozen
[65646.970000] ata2: soft resetting port
[65646.970000] sil24_softreset: ENTER
[65647.080000] ata_dev_classify: found ATA device by sig
[65647.080000] sil24_softreset: EXIT, class=1
[65647.080000] ata_std_postreset: ENTER
[65647.080000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[65647.080000] ata_std_postreset: EXIT
[65647.080000] ata_eh_thaw_port: ata2 port thawed
[65647.080000] ata_eh_revalidate_and_attach: ENTER
[65647.080000] ata2.00: ata_dev_read_id: ENTER, host 2, dev 0
[65647.080000] ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
[65647.080000] ata_sg_setup_one: mapped buffer of 512 bytes for read
[65647.080000] ata_sg_clean: unmapping 1 sg elements
[65647.080000] ata_port_flush_task: ENTER
[65647.080000] ata_port_flush_task: flush #1
[65647.080000] ata2: ata_port_flush_task: flush #2
[65647.080000] ata2: ata_port_flush_task: EXIT
[65647.080000] ata2.00: ata_dev_configure: ENTER, host 2, dev 0
[65647.080000] ata2.00: ata_dev_configure: cfg 49:2f00 82:346b 83:7d09
84:6003 85:3469 86:3c09 87:6003 88:207f
[65647.080000] ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007
64==0x0003  75==0x001f
[65647.080000] ata_dump_id: 80==0x00fe  81==0x0000  82==0x346b
83==0x7d09  84==0x6003
[65647.080000] ata_dump_id: 88==0x207f  93==0x0000
[65647.080000] ata2.00: ata_dev_configure: EXIT, drv_stat = 0x50
[65647.080000] ata_eh_revalidate_and_attach: EXIT
[65647.080000] ata_eh_resume: ENTER
[65647.080000] ata_eh_resume: EXIT
[65647.080000] ata_dev_set_xfermode: set features - xfer mode
[65647.080000] ata_port_flush_task: ENTER
[65647.080000] ata_port_flush_task: flush #1
[65647.080000] ata2: ata_port_flush_task: flush #2
[65647.080000] ata2: ata_port_flush_task: EXIT
[65647.080000] ata_dev_set_xfermode: EXIT, err_mask=0
[65647.080000] ata2.00: ata_dev_read_id: ENTER, host 2, dev 0
[65647.080000] ata2: ata_dev_select: ENTER, ata2: device 0, wait 1
[65647.080000] ata_sg_setup_one: mapped buffer of 512 bytes for read
[65647.080000] ata_sg_clean: unmapping 1 sg elements
[65647.080000] ata_port_flush_task: ENTER
[65647.080000] ata_port_flush_task: flush #1
[65647.080000] ata2: ata_port_flush_task: flush #2
[65647.080000] ata2: ata_port_flush_task: EXIT
[65647.080000] ata2.00: ata_dev_configure: ENTER, host 2, dev 0
[65647.080000] ata2.00: ata_dev_configure: cfg 49:2f00 82:346b 83:7d09
84:6003 85:3469 86:3c09 87:6003 88:207f
[65647.080000] ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007
64==0x0003  75==0x001f
[65647.080000] ata_dump_id: 80==0x00fe  81==0x0000  82==0x346b
83==0x7d09  84==0x6003
[65647.080000] ata_dump_id: 88==0x207f  93==0x0000
[65647.080000] ata2.00: ata_dev_configure: EXIT, drv_stat = 0x50
[65647.080000] ata_dev_set_mode: xfer_shift=8, xfer_mode=0x45
[65647.080000] ata2.00: configured for UDMA/100
[65647.080000] ata_eh_suspend: ENTER
[65647.080000] ata_eh_suspend: EXIT
[65647.080000] ata_eh_recover: EXIT, rc=0
[65647.080000] ata2: EH complete
[65647.080000] ata_scsi_error: EXIT
[65647.080000] ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 24
[65647.080000] ata_scsiop_noop: ENTER
[65647.080000] ata_scsi_dump_cdb: CDB (2:0,0,0) a1 08 08 00 00 00 00 00 00
[65647.080000] ata_scsi_translate: ENTER
[65647.080000] ata_sg_setup: ENTER, ata2
[65647.080000] ata_sg_setup: 1 sg elements mapped
[65647.080000] ata_scsi_translate: EXIT
[65647.080000] ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
[65647.080000] ata_scsiop_read_cap: ENTER
[65647.080000] SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
[65647.080000] ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
[65647.080000] ata_scsiop_mode_sense: ENTER
[65647.080000] sda: Write Protect is off
[65647.080000] sda: Mode Sense: 00 3a 00 00
[65647.080000] ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
[65647.080000] ata_scsiop_mode_sense: ENTER
[65647.080000] ata_sg_clean: unmapping 1 sg elements
[65647.080000] ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 24
[65647.080000] ata_scsiop_mode_sense: ENTER
[65647.080000] SCSI device sda: drive cache: write back
[65647.080000] ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 24
[65647.080000] ata_scsiop_noop: ENTER
[65647.080000] ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
[65647.080000] ata_scsiop_read_cap: ENTER
[65647.080000] SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
[65647.080000] ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
[65647.080000] ata_scsiop_mode_sense: ENTER
[65647.090000] sda: Write Protect is off
[65647.090000] sda: Mode Sense: 00 3a 00 00
[65647.090000] ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
[65647.090000] ata_scsiop_mode_sense: ENTER
[65647.090000] ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 24
[65647.090000] ata_scsiop_mode_sense: ENTER
[65647.090000] SCSI device sda: drive cache: write back
