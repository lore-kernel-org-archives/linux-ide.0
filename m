From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 17:24:21 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085181861.3266.11.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.edu
	 .	pl><1085162347.4791.24.camel@patibmrh9> <1085170025.3083.91.camel@patibm
	r h9><40AE79E1.9020005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:1473 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264622AbUEUXYb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 19:24:31 -0400
Received: from royntex01.iomegacorp.com (franklin [10.1.1.83])
	by email.iomega.com (Postfix) with ESMTP id 4D1B31A1E
	for <linux-ide@vger.kernel.org>; Fri, 21 May 2004 17:24:27 -0600 (MDT)
In-Reply-To: <40AE79E1.9020005@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

In linux-2.6.6-bk8 plus my bk8.good.always.patch,

One way to hang ata-piix.ko is ...

... for the device to refuse to copy the last bytes of a write.

In the example here, we tell the host to expect to copy out x1000 = 4 Ki
bytes, but we tell the device to agree to copy out only x0001 blocks
i.e. x800 = 2 Ki bytes.

The "ata2: unknown timeout, cmd 0xa0 stat 0xd0" message suggest we
didn't end clean, but to confirm that appearance we follow up with a
standard op x12 "INQUIRY" that indeed does not complete at all.

Pat LaVarre

P.S. This example I logged more carefully, but I first stumbled into
this with stimulus more like:

plscsi -o xC0 -x "3B 02 00:00:00:00 00 00:24 00" // "WRITE BUFFER" // Do < Ho

// Stimulus:

export PLSCSI='/dev/sg0 -X time 5 0'
plscsi -o x1000 -x "2A 00 00:00:00:10 00 00:01 00"
plscsi -i x24 -x "12 00:00:00 24 00"
Ctrl+C
sudo modprobe -r ata-piix
# FATAL: Module ata_piix is in use.
reboot

// Result:

kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 2a 00 00 00 00 10 00 00 01
kernel: ata_scsi_translate: ENTER
kernel: atapi_xlat: direction: write
kernel: ata_sg_setup_one: mapped buffer of 4096 bytes for write
kernel: ata_fill_sg: PRD[0] = (0x133B8000, 0x1000)
kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
kernel: ata_tf_load_pio: feat 0x1 nsect 0x0 lba 0x0 0x0 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: ata_scsi_translate: EXIT
kernel: atapi_packet_task: busy wait
kernel: atapi_packet_task: send cdb
kernel: ata_scsi_error: ENTER
kernel: ata_eng_timeout: ENTER
kernel: ata2: unknown timeout, cmd 0xa0 stat 0xd0
kernel: ata_sg_clean: unmapping 1 sg elements
kernel: ata_eng_timeout: EXIT
kernel: ata_scsi_error: EXIT

kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 00
kernel: ata_scsi_translate: ENTER
kernel: ata_sg_setup_one: mapped buffer of 36 bytes for read
kernel: ata_fill_sg: PRD[0] = (0x133B8000, 0x24)
kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
kernel: ATA: abnormal status 0xD0 on port 0xE007
kernel: ATA: abnormal status 0xD0 on port 0xE007
kernel: ata_tf_load_pio: feat 0x5 nsect 0x0 lba 0x0 0x0 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ATA: abnormal status 0xD0 on port 0xE007
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: ata_scsi_translate: EXIT
kernel: atapi_packet_task: busy wait
kernel: ata2 is slow to respond, please be patient
kernel: ata2 failed to respond (30 secs)
kernel: ata_sg_clean: unmapping 1 sg elements


