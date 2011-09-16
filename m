From: Dave Pitts <dpitts@cozx.com>
Subject: sata_sil24 on libata driver issue
Date: Fri, 16 Sep 2011 11:25:43 -0600
Message-ID: <4E738697.8090103@cozx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090101030900060208090904"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl228.bldr.co.csd.net ([205.240.12.228]:48835 "EHLO
	pullman.cozx.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753761Ab1IPRfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2011 13:35:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090101030900060208090904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello:

I didn't know who to contact for the sata_sil24 driver as there is no e-mail 
address for the developer...

Anyway, I'm working with a client that is running CentOS 5.5 with the sata_sil24 
and libata drivers. The application does async I/O using the sg layer 
(/dev/sgxx) and gets the errors shown in the attachment. The messages from 
"Engine" are the errors that the application is seeing. It appears that the I/O 
is timing out with the aborted command status. The question is why?? What's 
going on??

Any ideas on this would be great. Also, maybe fixed in newer kernels?

Thanks in advance...

-- 
Dave Pitts             PULLMAN: Travel and sleep in safety and comfort.
dpitts@cozx.com        My other RV IS a Pullman (Colorado Pine).
http://www.cozx.com


--------------090101030900060208090904
Content-Type: text/plain;
 name="messages.sil24"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="messages.sil24"

Sep 16 10:16:08 646cf843 kernel: ata3.00: failed to read SCR 1 (Emask=0x40)
Sep 16 10:16:08 646cf843 kernel: ata3.01: failed to read SCR 1 (Emask=0x40)
Sep 16 10:16:08 646cf843 kernel: ata3.02: failed to read SCR 1 (Emask=0x40)
Sep 16 10:16:08 646cf843 kernel: ata3.03: failed to read SCR 1 (Emask=0x40)
Sep 16 10:16:08 646cf843 kernel: ata3.04: failed to read SCR 1 (Emask=0x40)
Sep 16 10:16:08 646cf843 kernel: ata3.05: failed to read SCR 1 (Emask=0x40)
Sep 16 10:16:08 646cf843 kernel: ata3.15: exception Emask 0x4 SAct 0x0 SErr 0x0 action 0x6 frozen
Sep 16 10:16:08 646cf843 kernel: ata3.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Sep 16 10:16:08 646cf843 kernel: ata3.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Sep 16 10:16:08 646cf843 kernel: ata3.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Sep 16 10:16:08 646cf843 kernel: ata3.03: exception Emask 0x100 SAct 0x8 SErr 0x0 action 0x6 frozen
Sep 16 10:16:08 646cf843 kernel: ata3.03: cmd 60/40:18:c0:1e:35/00:00:00:00:00/40 tag 3 ncq 32768 in
Sep 16 10:16:08 646cf843 kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Sep 16 10:16:08 646cf843 kernel: ata3.03: status: { DRDY }
Sep 16 10:16:08 646cf843 kernel: ata3.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Sep 16 10:16:08 646cf843 kernel: ata3.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Sep 16 10:16:08 646cf843 kernel: ata3.15: hard resetting link
Sep 16 10:16:08 646cf843 kernel: ata3: controller in dubious state, performing PORT_RST
Sep 16 10:16:10 646cf843 kernel: ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Sep 16 10:16:10 646cf843 kernel: ata3.00: hard resetting link
Sep 16 10:16:10 646cf843 kernel: ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Sep 16 10:16:10 646cf843 kernel: ata3.01: hard resetting link
Sep 16 10:16:11 646cf843 kernel: ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Sep 16 10:16:11 646cf843 kernel: ata3.02: hard resetting link
Sep 16 10:16:11 646cf843 kernel: ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Sep 16 10:16:11 646cf843 kernel: ata3.03: hard resetting link
Sep 16 10:16:11 646cf843 kernel: ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Sep 16 10:16:11 646cf843 kernel: ata3.04: hard resetting link
Sep 16 10:16:11 646cf843 kernel: ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Sep 16 10:16:11 646cf843 kernel: ata3.05: hard resetting link
Sep 16 10:16:12 646cf843 kernel: ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Sep 16 10:16:12 646cf843 kernel: ata3.00: configured for UDMA/100
Sep 16 10:16:12 646cf843 kernel: ata3.01: configured for UDMA/100
Sep 16 10:16:12 646cf843 kernel: ata3.02: configured for UDMA/100
Sep 16 10:16:12 646cf843 kernel: ata3.03: configured for UDMA/100
Sep 16 10:16:12 646cf843 kernel: ata3.04: configured for UDMA/100
Sep 16 10:16:12 646cf843 Engine[5067]: [41C25940]<04> SgInt  [sg_err_category             (sg_int.c  :1284)]: masked_status=0x01, host_status=0x00, driver_status=0x0E
Sep 16 10:16:12 646cf843 Engine[5067]: [41C25940]<04> SgInt  [sg_err_category             (sg_int.c  :1309)]: SENSE INFO: response code=72 SK=B ASC=0 ASCQ=0 
Sep 16 10:16:12 646cf843 Engine[5067]: [40F97940]<04> BE     [BE_IO_Complete         (be_perform_io.c: 493)]:  IO ERROR: op=READ, drive=00.00.01.05 (0x500108600008D00E) lba=0x351EC0(0x40), code=-16, retryLevel=0, timeout=1000 ms, resp_time=5121(sg says 5121) ms 
Sep 16 10:16:12 646cf843 kernel: sd 6:3:0:0: timing out command, waited 1s
Sep 16 10:16:12 646cf843 kernel: ata3: EH complete
Sep 16 10:16:12 646cf843 kernel: SCSI device sdl: 3907029168 512-byte hdwr sectors (2000399 MB)
Sep 16 10:16:12 646cf843 kernel: sdl: Write Protect is off
Sep 16 10:16:12 646cf843 kernel: SCSI device sdl: drive cache: write back
Sep 16 10:16:12 646cf843 kernel: SCSI device sdm: 3907029168 512-byte hdwr sectors (2000399 MB)
Sep 16 10:16:12 646cf843 kernel: sdm: Write Protect is off
Sep 16 10:16:12 646cf843 kernel: SCSI device sdm: drive cache: write back
Sep 16 10:16:12 646cf843 kernel: SCSI device sdn: 3907029168 512-byte hdwr sectors (2000399 MB)
Sep 16 10:16:12 646cf843 kernel: sdn: Write Protect is off
Sep 16 10:16:12 646cf843 kernel: SCSI device sdn: drive cache: write back
Sep 16 10:16:12 646cf843 kernel: SCSI device sdo: 3907029168 512-byte hdwr sectors (2000399 MB)
Sep 16 10:16:12 646cf843 kernel: sdo: Write Protect is off
Sep 16 10:16:12 646cf843 kernel: SCSI device sdo: drive cache: write back
Sep 16 10:16:12 646cf843 kernel: SCSI device sdp: 3907029168 512-byte hdwr sectors (2000399 MB)
Sep 16 10:16:12 646cf843 kernel: sdp: Write Protect is off
Sep 16 10:16:12 646cf843 kernel: SCSI device sdp: drive cache: write back
Sep 16 10:16:12 646cf843 kernel: SCSI device sdl: 3907029168 512-byte hdwr sectors (2000399 MB)
Sep 16 10:16:12 646cf843 kernel: sdl: Write Protect is off
Sep 16 10:16:12 646cf843 kernel: SCSI device sdl: drive cache: write back
Sep 16 10:16:12 646cf843 kernel: SCSI device sdm: 3907029168 512-byte hdwr sectors (2000399 MB)
Sep 16 10:16:12 646cf843 kernel: sdm: Write Protect is off
Sep 16 10:16:12 646cf843 kernel: SCSI device sdm: drive cache: write back
Sep 16 10:16:12 646cf843 kernel: SCSI device sdn: 3907029168 512-byte hdwr sectors (2000399 MB)
Sep 16 10:16:12 646cf843 kernel: sdn: Write Protect is off
Sep 16 10:16:12 646cf843 kernel: SCSI device sdn: drive cache: write back
Sep 16 10:16:12 646cf843 kernel: SCSI device sdo: 3907029168 512-byte hdwr sectors (2000399 MB)
Sep 16 10:16:12 646cf843 kernel: sdo: Write Protect is off
Sep 16 10:16:12 646cf843 kernel: SCSI device sdo: drive cache: write back
Sep 16 10:16:12 646cf843 kernel: SCSI device sdp: 3907029168 512-byte hdwr sectors (2000399 MB)
Sep 16 10:16:12 646cf843 kernel: sdp: Write Protect is off
Sep 16 10:16:12 646cf843 kernel: SCSI device sdp: drive cache: write back
Sep 16 10:16:13 646cf843 Engine[5067]: [42C6C940]<05> Scrub  [Scrub_HandleMsg_Response              (scrub_task.c   : 439)]: FAILED read: beCmd=0x83e728, lba=3481280, error=-16

--------------090101030900060208090904--
