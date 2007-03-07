From: Peter Favrholdt <linux-ide@how.dk>
Subject: sata_promise SATA300TX4 "intermittent problems"
Date: Wed, 07 Mar 2007 15:32:50 +0100
Message-ID: <45EECD12.1000506@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pqueuea.post.tele.dk ([193.162.153.9]:37004 "EHLO
	pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965540AbXCGOyF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 09:54:05 -0500
Received: from pfepc.post.tele.dk (pfepc.post.tele.dk [195.41.46.237])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id 6A65AE3913
	for <linux-ide@vger.kernel.org>; Wed,  7 Mar 2007 15:33:57 +0100 (CET)
Received: from how3.how.dk (0x50a32a37.unknown.tele.dk [80.163.42.55])
	by pfepc.post.tele.dk (Postfix) with ESMTP id DB6848A004F
	for <linux-ide@vger.kernel.org>; Wed,  7 Mar 2007 15:32:51 +0100 (CET)
Received: from how7.how.dk ([192.168.0.7] ident=pfavr)
	by how3.how.dk with esmtp (Exim 4.50)
	id 1HOxCE-0000L5-F7
	for linux-ide@vger.kernel.org; Wed, 07 Mar 2007 15:32:50 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've seen "intermittent problems" with Promise SATA300 TX4 controllers
and Linux kernel 2.6.19 (through 2.6.20-rc2 with some additional
patches).

Sometimes the TX4 will loose a port - a reboot brings the drive back up 
again. I'm quite sure the harddrives are not at fault.

I have experienced this using "plain vanilla" Linux 2.6.19.2 and 
2.6.20.1. Today I have tested using Linux 2.6.21-rc2 with Mikael 
Petterson's patches (more on that further down).

Yesterday (using 2.6.20.1) I could fail two out of four drives by doing:
dd if=/dev/sda of=/dev/null bs=1M &
dd if=/dev/sdb of=/dev/null bs=1M &
dd if=/dev/sdc of=/dev/null bs=1M &
dd if=/dev/sdd of=/dev/null bs=1M &

sdd would fail first then after a while sdc, here is the dmesg output 
when sdd failed:

[14895.092650] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x2 frozen
[14895.092664] ata4.00: cmd 25/00:00:00:3e:1a/00:02:05:00:00/e0 tag 0 
cdb 0x0 data 262144 in
[14895.092666]          res 40/00:01:09:4f:c2/00:00:00:00:00/00 Emask 
0x4 (timeout)
[14895.404597] ata4: soft resetting port
[14895.560511] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[14925.555206] ata4.00: qc timeout (cmd 0xec)
[14925.555437] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[14925.555441] ata4.00: revalidation failed (errno=-5)
[14925.555452] ata4: failed to recover some devices, retrying in 5 secs
[14930.556912] ata4: hard resetting port
[14930.876763] ata4: COMRESET failed (device not ready)
[14930.876772] ata4: hardreset failed, retrying in 5 secs
[14935.878525] ata4: hard resetting port
[14936.198407] ata4: COMRESET failed (device not ready)
[14936.198416] ata4: hardreset failed, retrying in 5 secs
[14941.200169] ata4: hard resetting port
[14941.520051] ata4: COMRESET failed (device not ready)
[14941.520060] ata4: reset failed, giving up
[14941.520063] ata4.00: disabled
[14941.520075] ata4: EH complete
[14941.520567] sd 4:0:0:0: SCSI error: return code = 0x00040000
[14941.520572] end_request: I/O error, dev sdd, sector 85605888
[14941.520577] Buffer I/O error on device sdd, logical block 10700736
[14941.520582] Buffer I/O error on device sdd, logical block 10700737

After a reboot the drives are operating again. But with an entry in the 
SMART log, e.g.:

Error 6 occurred at disk power-on lifetime: 353 hours (14 days + 17 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 ef 11 3e 1a e0  Error: ICRC, ABRT 239 sectors at LBA = 
0x001a3e11 = 1719825

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   25 00 00 00 3e 1a e0 00      04:08:17.774  READ DMA EXT
   25 00 00 00 3c 1a e0 00      04:08:17.764  READ DMA EXT
   25 00 00 00 3a 1a e0 00      04:08:17.753  READ DMA EXT
   25 00 00 00 38 1a e0 00      04:08:17.743  READ DMA EXT
   25 00 00 00 36 1a e0 00      04:08:17.734  READ DMA EXT


Today I have tested using Linux 2.6.21-rc2 with Mikael Petterson's
patches. In order to make it build I had to disable local-apic. So far
it seems to work better, but doing

dd if=/dev/sda of=/dev/null bs=1M &
dd if=/dev/sdb of=/dev/null bs=1M &
dd if=/dev/sdc of=/dev/null bs=1M &
dd if=/dev/sdd of=/dev/null bs=1M &

and then a couple of times:

for each in /dev/sd[abcd]; do smartctl -d ata -a $each | awk 
'/194/{print $10}'; done

will trig the error again:

[52849.930755] pdc_error_intr: port_status 0x00001000 serror 0x00000000
[52849.930880] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[52849.930883] ata2.00: (port_status 0x00001000)
[52849.930892] ata2.00: cmd 25/00:00:00:f7:1e/00:02:1b:00:00/e0 tag 0 
cdb 0x0 data 262144 in
[52849.930894]          res 50/00:00:ff:f8:1e/00:00:ff:59:c8/e0 Emask 
0x4 (timeout)
[52850.241962] ata2: soft resetting port
[52850.397984] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[52850.424344] pdc_error_intr: port_status 0x00001000 serror 0x00000000
[52850.424639] ata2.00: failed to set xfermode (err_mask=0x104)
[52850.424643] ata2: failed to recover some devices, retrying in 5 secs
[52855.423576] ata2: hard resetting port
[52855.899453] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[52855.933438] ata2.00: configured for UDMA/133
[52855.933456] ata2: EH complete
[52855.973979] SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
[52856.022739] sdb: Write Protect is off
[52856.022747] sdb: Mode Sense: 00 3a 00 00
[52856.085241] SCSI device sdb: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[52856.089287] SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
[52856.092552] sdb: Write Protect is off
[52856.092560] sdb: Mode Sense: 00 3a 00 00
[52856.099067] SCSI device sdb: write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA

although this time the hard reset is working, and the port comes back
up and continues reading. This is of course much better because a raid
device would not fail. But I still think the reset should not be
necessary?

I wonder if the earlier problems I've seen has been due to my own poking 
around with smartctl during heavy load. I'll try to test this some more.

I would be very happy to help debug this issue. Any suggestions on what 
I should try next?

Some background info:

I have three systems with SATA300TX4s:

System 1 (can be used for testing):
Linux 2.6.21-rc2+Mikael_Petterson
AMD Athlon(tm) XP 2500+ on a Nvidia nForce2 motherboard.
4 harddrives all connected to the TX4 in a normal PCI slot 133MHz
Seagate ST3500630NS (Barracuda 500GB ES) Firmware 3.AEE

System 2 (production system)
Dell PowerEdge 2800
Linux 2.6.19.5
Identical harddrives all connected to TX4 in a PCI-X slot 266MHz.

System 3 (production backup):
Linux 2.6.15
Identical to System 2 except only two disks. These are Barracuda 500GB
(non ES version).

Best regards,

Peter
