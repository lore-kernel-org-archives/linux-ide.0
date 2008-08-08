From: Artem Bokhan <aptem@ngs.ru>
Subject: bad sectors, suspicious behaviour
Date: Fri, 08 Aug 2008 09:57:25 +0700
Message-ID: <489BB615.4070809@ngs.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010609060505070700000002"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:46663 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926AbYHHJ5Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Aug 2008 05:57:25 -0400
Received: from [192.168.2.119] (unknown [192.168.2.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: aptem@ngs.ru)
	by smtp.ngs.ru (smtp) with ESMTP id 0D8B956D843CC
	for <linux-ide@vger.kernel.org>; Fri,  8 Aug 2008 16:57:22 +0700 (NOVST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010609060505070700000002
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

I'm not sure  I chose correct maillist, so point me somewhere in case of 
mistake :)

I'm trying to emulate OS behaviour when something goes wrong with sata 
hard drive, for example, unrecoverable "bad blocks".
By some reason I do not want to use any sw/hw raid.

I took new hard drive, because it should contain (and it contains) 
unreadable (not reallocated yet) sectros, and did


'dd if=/dev/sda of=/dev/null bs=1M'. 

first run dd log (errors1.txt) looks OK, drive recovers, as I suppose, 
approximately at time

cat 
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4/target4:0:0/4:0:0:0/timeout
30

but when running dd second time, log looks strange (errors2.txt)


running
echo 1 > 
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4/target4:0:0/4:0:0:0/delete
echo "scsi add-single-device 4 0 0 0" > /proc/scsi/scsi

and then running dd solve situation until next dd

It is vanilla 2.6.26.2 kernel and sata_mv (MV88SX6081 8-port SATA II PCI-X)

--------------010609060505070700000002
Content-Type: text/plain;
 name="errors1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="errors1.txt"

Aug  8 05:34:30 ubuntu kernel: [75558.554046]          res 41/00:08:a8:a8:36/00:00:01:00:00/40 Emask 0x1 (device error)
Aug  8 05:34:30 ubuntu kernel: [75558.554117]          res 41/00:08:a8:a8:36/00:00:01:00:00/40 Emask 0x1 (device error)
Aug  8 05:34:30 ubuntu kernel: [75558.554187] ata5: hard resetting link
Aug  8 05:34:31 ubuntu kernel: [75559.623869] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:31 ubuntu kernel: [75559.688975] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:31 ubuntu kernel: [75559.763885] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:31 ubuntu kernel: [75559.763888] ata5.00: configured for UDMA/133
Aug  8 05:34:31 ubuntu kernel: [75559.763897] ata5: EH complete
Aug  8 05:34:31 ubuntu kernel: [75559.773847] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:31 ubuntu kernel: [75559.773847] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:31 ubuntu kernel: [75559.773847] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:32 ubuntu kernel: [75561.678986]          res 41/00:08:a8:a7:36/00:00:01:00:00/40 Emask 0x1 (device error)
Aug  8 05:34:32 ubuntu kernel: [75561.679056] ata5: hard resetting link
Aug  8 05:34:33 ubuntu kernel: [75562.387966] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:33 ubuntu kernel: [75562.587985] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:33 ubuntu kernel: [75562.667983] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:33 ubuntu kernel: [75562.667986] ata5.00: configured for UDMA/133
Aug  8 05:34:33 ubuntu kernel: [75562.667993] ata5: EH complete
Aug  8 05:34:33 ubuntu kernel: [75562.668027] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:33 ubuntu kernel: [75562.668039] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:33 ubuntu kernel: [75562.668058] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:35 ubuntu kernel: [75564.468246]          res 51/40:00:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:35 ubuntu kernel: [75564.468339] ata5: hard resetting link
Aug  8 05:34:35 ubuntu kernel: [75565.191441] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:35 ubuntu kernel: [75565.251460] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:35 ubuntu kernel: [75565.515045] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:35 ubuntu kernel: [75565.515048] ata5.00: configured for UDMA/133
Aug  8 05:34:35 ubuntu kernel: [75565.515052] ata5: EH complete
Aug  8 05:34:35 ubuntu kernel: [75565.515085] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:35 ubuntu kernel: [75565.515096] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:35 ubuntu kernel: [75565.515116] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:37 ubuntu kernel: [75567.359209]          res 51/40:00:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:37 ubuntu kernel: [75567.368921] ata5: hard resetting link
Aug  8 05:34:37 ubuntu kernel: [75568.136442] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:37 ubuntu kernel: [75568.376525] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:37 ubuntu kernel: [75568.476521] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:37 ubuntu kernel: [75568.476524] ata5.00: configured for UDMA/133
Aug  8 05:34:37 ubuntu kernel: [75568.476529] ata5: EH complete
Aug  8 05:34:37 ubuntu kernel: [75568.476562] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:37 ubuntu kernel: [75568.476573] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:37 ubuntu kernel: [75568.476593] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:39 ubuntu kernel: [75570.406705]          res 51/40:00:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:39 ubuntu kernel: [75570.406798] ata5: hard resetting link
Aug  8 05:34:40 ubuntu kernel: [75571.043944] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:40 ubuntu kernel: [75571.106461] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:40 ubuntu kernel: [75571.306500] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:40 ubuntu kernel: [75571.306503] ata5.00: configured for UDMA/133
Aug  8 05:34:40 ubuntu kernel: [75571.306507] ata5: EH complete
Aug  8 05:34:40 ubuntu kernel: [75571.306540] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:40 ubuntu kernel: [75571.306552] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:40 ubuntu kernel: [75571.306572] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:41 ubuntu kernel: [75572.914314]          res 51/40:00:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:41 ubuntu kernel: [75572.914408] ata5: hard resetting link
Aug  8 05:34:42 ubuntu kernel: [75573.424052] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:42 ubuntu kernel: [75573.624070] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:42 ubuntu kernel: [75573.704069] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:42 ubuntu kernel: [75573.704072] ata5.00: configured for UDMA/133
Aug  8 05:34:42 ubuntu kernel: [75573.704088] sd 4:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Aug  8 05:34:42 ubuntu kernel: [75573.704091] sd 4:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Aug  8 05:34:42 ubuntu kernel: [75573.704095] Descriptor sense data with sense descriptors (in hex):
Aug  8 05:34:42 ubuntu kernel: [75573.704096]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
Aug  8 05:34:42 ubuntu kernel: [75573.704102]         01 36 a7 e0
Aug  8 05:34:42 ubuntu kernel: [75573.704105] sd 4:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
Aug  8 05:34:42 ubuntu kernel: [75573.704139] __ratelimit: 22 messages suppressed
Aug  8 05:34:42 ubuntu kernel: [75573.704430] ata5: EH complete
Aug  8 05:34:42 ubuntu kernel: [75573.704393] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:42 ubuntu kernel: [75573.704393] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:42 ubuntu kernel: [75573.704393] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:44 ubuntu kernel: [75575.644677]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:44 ubuntu kernel: [75575.644771] ata5: hard resetting link
Aug  8 05:34:44 ubuntu kernel: [75576.434353] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:44 ubuntu kernel: [75576.494370] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:44 ubuntu kernel: [75576.644369] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:44 ubuntu kernel: [75576.644372] ata5.00: configured for UDMA/133
Aug  8 05:34:44 ubuntu kernel: [75576.644377] ata5: EH complete
Aug  8 05:34:44 ubuntu kernel: [75576.644330] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:44 ubuntu kernel: [75576.644330] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:44 ubuntu kernel: [75576.644330] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:46 ubuntu kernel: [75578.654332]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:46 ubuntu kernel: [75578.654332] ata5: hard resetting link
Aug  8 05:34:46 ubuntu kernel: [75579.552581] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:46 ubuntu kernel: [75579.815101] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:47 ubuntu kernel: [75579.902600] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:47 ubuntu kernel: [75579.902603] ata5.00: configured for UDMA/133
Aug  8 05:34:47 ubuntu kernel: [75579.902608] ata5: EH complete
Aug  8 05:34:47 ubuntu kernel: [75579.902639] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:47 ubuntu kernel: [75579.902650] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:47 ubuntu kernel: [75579.902669] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:48 ubuntu kernel: [75581.630346]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:48 ubuntu kernel: [75581.630439] ata5: hard resetting link
Aug  8 05:34:49 ubuntu kernel: [75582.400019] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:49 ubuntu kernel: [75582.480038] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:49 ubuntu kernel: [75582.580035] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:49 ubuntu kernel: [75582.580038] ata5.00: configured for UDMA/133
Aug  8 05:34:49 ubuntu kernel: [75582.580043] ata5: EH complete
Aug  8 05:34:49 ubuntu kernel: [75582.619935] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:49 ubuntu kernel: [75582.619935] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:49 ubuntu kernel: [75582.619935] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:50 ubuntu kernel: [75584.227719]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:50 ubuntu kernel: [75584.227812] ata5: hard resetting link
Aug  8 05:34:51 ubuntu kernel: [75585.067849] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:51 ubuntu kernel: [75585.160367] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:51 ubuntu kernel: [75585.254889] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:51 ubuntu kernel: [75585.254892] ata5.00: configured for UDMA/133
Aug  8 05:34:51 ubuntu kernel: [75585.254897] ata5: EH complete
Aug  8 05:34:51 ubuntu kernel: [75585.254929] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:51 ubuntu kernel: [75585.254940] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:51 ubuntu kernel: [75585.254959] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:53 ubuntu kernel: [75587.002634]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:53 ubuntu kernel: [75587.002727] ata5: hard resetting link
Aug  8 05:34:53 ubuntu kernel: [75587.682309] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:53 ubuntu kernel: [75587.742327] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:53 ubuntu kernel: [75587.842326] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:53 ubuntu kernel: [75587.842329] ata5.00: configured for UDMA/133
Aug  8 05:34:53 ubuntu kernel: [75587.842334] ata5: EH complete
Aug  8 05:34:53 ubuntu kernel: [75587.842326] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:53 ubuntu kernel: [75587.842326] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:53 ubuntu kernel: [75587.842326] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:55 ubuntu kernel: [75589.954997]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:55 ubuntu kernel: [75589.955090] ata5: hard resetting link
Aug  8 05:34:55 ubuntu kernel: [75590.727173] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:55 ubuntu kernel: [75590.806604] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:56 ubuntu kernel: [75590.914330] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:56 ubuntu kernel: [75590.914333] ata5.00: configured for UDMA/133
Aug  8 05:34:56 ubuntu kernel: [75590.914340] sd 4:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Aug  8 05:34:56 ubuntu kernel: [75590.914343] sd 4:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Aug  8 05:34:56 ubuntu kernel: [75590.914346] Descriptor sense data with sense descriptors (in hex):
Aug  8 05:34:56 ubuntu kernel: [75590.914348]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
Aug  8 05:34:56 ubuntu kernel: [75590.914353]         01 36 a7 e0
Aug  8 05:34:56 ubuntu kernel: [75590.914356] sd 4:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
Aug  8 05:34:56 ubuntu kernel: [75590.914389] __ratelimit: 15 messages suppressed
Aug  8 05:34:56 ubuntu kernel: [75590.914422] ata5: EH complete
Aug  8 05:34:56 ubuntu kernel: [75590.914463] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:56 ubuntu kernel: [75590.914473] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:56 ubuntu kernel: [75590.914491] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:57 ubuntu kernel: [75593.007075]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:57 ubuntu kernel: [75593.007169] ata5: hard resetting link
Aug  8 05:34:58 ubuntu kernel: [75593.732103] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:34:58 ubuntu kernel: [75593.952104] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:58 ubuntu kernel: [75594.033461] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:34:58 ubuntu kernel: [75594.033464] ata5.00: configured for UDMA/133
Aug  8 05:34:58 ubuntu kernel: [75594.033469] ata5: EH complete
Aug  8 05:34:58 ubuntu kernel: [75594.033500] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:34:58 ubuntu kernel: [75594.033511] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:34:58 ubuntu kernel: [75594.033529] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:34:59 ubuntu kernel: [75595.971250]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:34:59 ubuntu kernel: [75595.971343] ata5: hard resetting link
Aug  8 05:35:00 ubuntu kernel: [75596.573547] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:35:00 ubuntu kernel: [75596.685419] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:35:00 ubuntu kernel: [75596.777239] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:35:00 ubuntu kernel: [75596.777242] ata5.00: configured for UDMA/133
Aug  8 05:35:00 ubuntu kernel: [75596.777246] ata5: EH complete
Aug  8 05:35:00 ubuntu kernel: [75596.777278] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:35:00 ubuntu kernel: [75596.787200] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:35:00 ubuntu kernel: [75596.787200] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:35:02 ubuntu kernel: [75598.425197]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:35:02 ubuntu kernel: [75598.425290] ata5: hard resetting link
Aug  8 05:35:02 ubuntu kernel: [75599.326815] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:35:02 ubuntu kernel: [75599.536897] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:35:02 ubuntu kernel: [75599.616896] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:35:02 ubuntu kernel: [75599.616899] ata5.00: configured for UDMA/133
Aug  8 05:35:02 ubuntu kernel: [75599.616904] ata5: EH complete
Aug  8 05:35:02 ubuntu kernel: [75599.616936] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:35:02 ubuntu kernel: [75599.616946] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:35:02 ubuntu kernel: [75599.616964] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:35:04 ubuntu kernel: [75601.757134]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:35:04 ubuntu kernel: [75601.757227] ata5: hard resetting link
Aug  8 05:35:04 ubuntu kernel: [75602.434677] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:35:05 ubuntu kernel: [75602.621432] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:35:05 ubuntu kernel: [75602.700565] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:35:05 ubuntu kernel: [75602.700568] ata5.00: configured for UDMA/133
Aug  8 05:35:05 ubuntu kernel: [75602.700572] ata5: EH complete
Aug  8 05:35:05 ubuntu kernel: [75602.700604] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:35:05 ubuntu kernel: [75602.700614] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:35:05 ubuntu kernel: [75602.700633] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:35:06 ubuntu kernel: [75605.325872]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:35:06 ubuntu kernel: [75605.325965] ata5: hard resetting link
Aug  8 05:35:07 ubuntu kernel: [75606.221411] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:35:07 ubuntu kernel: [75606.341598] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:35:07 ubuntu kernel: [75606.441597] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:35:07 ubuntu kernel: [75606.441600] ata5.00: configured for UDMA/133
Aug  8 05:35:07 ubuntu kernel: [75606.441605] ata5: EH complete
Aug  8 05:35:07 ubuntu kernel: [75606.441636] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:35:07 ubuntu kernel: [75606.441646] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:35:07 ubuntu kernel: [75606.441664] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:35:08 ubuntu kernel: [75608.223366]          res 51/40:08:e0:a7:36/01:00:01:00:00/00 Emask 0x409 (media error) <F>
Aug  8 05:35:08 ubuntu kernel: [75608.223459] ata5: hard resetting link
Aug  8 05:35:09 ubuntu kernel: [75608.760949] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:35:09 ubuntu kernel: [75609.071613] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:35:09 ubuntu kernel: [75609.150759] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:35:09 ubuntu kernel: [75609.150762] ata5.00: configured for UDMA/133
Aug  8 05:35:09 ubuntu kernel: [75609.150768] sd 4:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Aug  8 05:35:09 ubuntu kernel: [75609.150771] sd 4:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Aug  8 05:35:09 ubuntu kernel: [75609.150774] Descriptor sense data with sense descriptors (in hex):
Aug  8 05:35:09 ubuntu kernel: [75609.150776]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
Aug  8 05:35:09 ubuntu kernel: [75609.150781]         01 36 a7 e0
Aug  8 05:35:09 ubuntu kernel: [75609.150784] sd 4:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
Aug  8 05:35:09 ubuntu kernel: [75609.150850] ata5: EH complete
Aug  8 05:35:09 ubuntu kernel: [75609.161573] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:35:09 ubuntu kernel: [75609.171574] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:35:09 ubuntu kernel: [75609.208690] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA



--------------010609060505070700000002
Content-Type: text/plain;
 name="errors2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="errors2.txt"

Aug  8 05:36:35 ubuntu kernel: [75699.107166]          res 41/00:00:00:a8:36/00:08:01:00:00/40 Emask 0x1 (device error)
Aug  8 05:36:35 ubuntu kernel: [75699.107236]          res 41/00:08:01:00:00/00:08:01:00:00/40 Emask 0x1 (device error)
Aug  8 05:36:35 ubuntu kernel: [75699.107307] ata5: hard resetting link
Aug  8 05:36:35 ubuntu kernel: [75699.666039] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:36:35 ubuntu kernel: [75699.846017] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:36 ubuntu kernel: [75699.942982] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:36 ubuntu kernel: [75699.942985] ata5.00: configured for UDMA/133
Aug  8 05:36:36 ubuntu kernel: [75699.942993] ata5: EH complete
Aug  8 05:36:36 ubuntu kernel: [75699.943029] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:36:36 ubuntu kernel: [75699.943040] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:36:36 ubuntu kernel: [75699.943059] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:36:37 ubuntu kernel: [75702.039300] ata5.00: NCQ disabled due to excessive errors
Aug  8 05:36:37 ubuntu kernel: [75702.039382]          res 41/00:08:00:a8:36/00:00:01:00:00/40 Emask 0x1 (device error)
Aug  8 05:36:37 ubuntu kernel: [75702.039452]          res 41/00:00:01:00:00/00:00:01:00:00/40 Emask 0x1 (device error)
Aug  8 05:36:37 ubuntu kernel: [75702.039522] ata5: hard resetting link
Aug  8 05:36:38 ubuntu kernel: [75702.936061] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:36:38 ubuntu kernel: [75702.996080] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:38 ubuntu kernel: [75703.296058] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:38 ubuntu kernel: [75703.296061] ata5.00: configured for UDMA/133
Aug  8 05:36:38 ubuntu kernel: [75703.296069] ata5: EH complete
Aug  8 05:36:38 ubuntu kernel: [75703.296098] ------------[ cut here ]------------
Aug  8 05:36:38 ubuntu kernel: [75703.296100] WARNING: at drivers/ata/libata-core.c:4732 ata_qc_issue+0x1ca/0x230 [libata]()
Aug  8 05:36:38 ubuntu kernel: [75703.296102] Modules linked in: dm_mod autofs4 ipv6 iptable_filter ip_tables x_tables lp loop af_packet sr_mod cdrom container e1000e button parport_pc parport iTCO_wdt iTCO_vendor_support pcspkr shpchp pci_hotplug psmouse evdev ext3 jbd mbcache sg sd_mod pata_it8213 ata_piix pata_acpi floppy ata_generic sata_mv libata scsi_mod dock ehci_hcd uhci_hcd usbcore thermal processor fan thermal_sys fuse
Aug  8 05:36:38 ubuntu kernel: [75703.296131] Pid: 2235, comm: scsi_eh_4 Tainted: G        W 2.6.26.2.030320 #1
Aug  8 05:36:38 ubuntu kernel: [75703.296133]
Aug  8 05:36:38 ubuntu kernel: [75703.296133] Call Trace:
Aug  8 05:36:38 ubuntu kernel: [75703.296140]  [ext3:warn_on_slowpath+0x64/0x320] warn_on_slowpath+0x64/0xa0
Aug  8 05:36:38 ubuntu kernel: [75703.296145]  [sched_clock_cpu+0xc1/0x150] sched_clock_cpu+0xc1/0x150
Aug  8 05:36:38 ubuntu kernel: [75703.296148]  [usbcore:up+0x16/0xc0] up+0x16/0x50
Aug  8 05:36:38 ubuntu kernel: [75703.296150]  [release_console_sem+0x19d/0x1e0] release_console_sem+0x19d/0x1e0
Aug  8 05:36:38 ubuntu kernel: [75703.296156]  [sata_mv:mv_qc_issue+0x3c0/0x500] :sata_mv:mv_qc_issue+0x3c0/0x500
Aug  8 05:36:38 ubuntu kernel: [75703.296159]  [nommu_map_sg+0x6b/0xe0] nommu_map_sg+0x6b/0xe0
Aug  8 05:36:38 ubuntu kernel: [75703.296170]  [libata:ata_build_rw_tf+0xc1/0x290] :libata:ata_build_rw_tf+0xc1/0x290
Aug  8 05:36:38 ubuntu kernel: [75703.296181]  [libata:ata_qc_issue+0x1ca/0x230] :libata:ata_qc_issue+0x1ca/0x230
Aug  8 05:36:38 ubuntu kernel: [75703.296193]  [scsi_mod:scsi_done+0x0/0x20] :scsi_mod:scsi_done+0x0/0x20
Aug  8 05:36:38 ubuntu kernel: [75703.296203]  [libata:ata_scsi_translate+0xf8/0x190] :libata:ata_scsi_translate+0xf8/0x190
Aug  8 05:36:38 ubuntu kernel: [75703.296213]  [scsi_mod:scsi_done+0x0/0x20] :scsi_mod:scsi_done+0x0/0x20
Aug  8 05:36:38 ubuntu kernel: [75703.296224]  [sata_mv:ata_scsi_queuecmd+0xbb/0x240] :libata:ata_scsi_queuecmd+0xbb/0x240
Aug  8 05:36:38 ubuntu kernel: [75703.296235]  [scsi_mod:scsi_dispatch_cmd+0x11e/0x2e0] :scsi_mod:scsi_dispatch_cmd+0x11e/0x2e0
Aug  8 05:36:38 ubuntu kernel: [75703.296246]  [scsi_mod:scsi_request_fn+0x213/0x3c0] :scsi_mod:scsi_request_fn+0x213/0x3c0
Aug  8 05:36:38 ubuntu kernel: [75703.296251]  [scsi_mod:__blk_run_queue+0x43/0xd0] __blk_run_queue+0x43/0xd0
Aug  8 05:36:38 ubuntu kernel: [75703.296253]  [scsi_mod:blk_run_queue+0x28/0x50] blk_run_queue+0x28/0x50
Aug  8 05:36:38 ubuntu kernel: [75703.296264]  [scsi_mod:scsi_error_handler+0x0/0x570] :scsi_mod:scsi_error_handler+0x0/0x570
Aug  8 05:36:38 ubuntu kernel: [75703.296274]  [scsi_mod:scsi_run_host_queues+0x19/0x40] :scsi_mod:scsi_run_host_queues+0x19/0x40
Aug  8 05:36:38 ubuntu kernel: [75703.296284]  [scsi_mod:scsi_error_handler+0x1d9/0x570] :scsi_mod:scsi_error_handler+0x1d9/0x570
Aug  8 05:36:38 ubuntu kernel: [75703.296296]  [scsi_mod:scsi_error_handler+0x0/0x570] :scsi_mod:scsi_error_handler+0x0/0x570
Aug  8 05:36:38 ubuntu kernel: [75703.296299]  [kthread+0x4b/0x80] kthread+0x4b/0x80
Aug  8 05:36:38 ubuntu kernel: [75703.296303]  [child_rip+0xa/0x12] child_rip+0xa/0x12
Aug  8 05:36:38 ubuntu kernel: [75703.296307]  [kthread+0x0/0x80] kthread+0x0/0x80
Aug  8 05:36:38 ubuntu kernel: [75703.296309]  [child_rip+0x0/0x12] child_rip+0x0/0x12
Aug  8 05:36:38 ubuntu kernel: [75703.296311]
Aug  8 05:36:38 ubuntu kernel: [75703.296312] ---[ end trace 98cca564749c28e3 ]---
Aug  8 05:36:38 ubuntu kernel: [75703.307281] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:36:38 ubuntu kernel: [75703.307281] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:36:38 ubuntu kernel: [75703.307281] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:36:40 ubuntu kernel: [75705.198509]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:36:40 ubuntu kernel: [75705.198509] ata5: hard resetting link
Aug  8 05:36:40 ubuntu kernel: [75706.235177] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:36:40 ubuntu kernel: [75706.315195] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:41 ubuntu kernel: [75706.396627] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:41 ubuntu kernel: [75706.396630] ata5.00: configured for UDMA/133
Aug  8 05:36:41 ubuntu kernel: [75706.396635] ata5: EH complete
Aug  8 05:36:41 ubuntu kernel: [75706.396667] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:36:41 ubuntu kernel: [75706.396677] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:36:41 ubuntu kernel: [75706.396695] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:36:42 ubuntu kernel: [75709.569567]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:36:42 ubuntu kernel: [75709.569567] ata5: hard resetting link
Aug  8 05:36:43 ubuntu kernel: [75710.486591] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:36:43 ubuntu kernel: [75710.726059] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:43 ubuntu kernel: [75710.843664] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:43 ubuntu kernel: [75710.843667] ata5.00: configured for UDMA/133
Aug  8 05:36:43 ubuntu kernel: [75710.843672] ata5: EH complete
Aug  8 05:36:43 ubuntu kernel: [75710.843705] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:36:43 ubuntu kernel: [75710.843715] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:36:43 ubuntu kernel: [75710.843733] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:36:45 ubuntu kernel: [75713.273625]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:36:45 ubuntu kernel: [75713.313701] ata5: hard resetting link
Aug  8 05:36:46 ubuntu kernel: [75713.899348] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:36:46 ubuntu kernel: [75713.979366] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:46 ubuntu kernel: [75714.059365] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:46 ubuntu kernel: [75714.059368] ata5.00: configured for UDMA/133
Aug  8 05:36:46 ubuntu kernel: [75714.059373] ata5: EH complete
Aug  8 05:36:46 ubuntu kernel: [75714.219264] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:36:46 ubuntu kernel: [75714.219264] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:36:46 ubuntu kernel: [75714.219264] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:36:48 ubuntu kernel: [75716.392820]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:36:48 ubuntu kernel: [75716.392820] ata5: hard resetting link
Aug  8 05:36:48 ubuntu kernel: [75717.322050] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:36:48 ubuntu kernel: [75717.580181] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:48 ubuntu kernel: [75717.660179] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:48 ubuntu kernel: [75717.660182] ata5.00: configured for UDMA/133
Aug  8 05:36:48 ubuntu kernel: [75717.660209] sd 4:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Aug  8 05:36:48 ubuntu kernel: [75717.660212] sd 4:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Aug  8 05:36:48 ubuntu kernel: [75717.660216] Descriptor sense data with sense descriptors (in hex):
Aug  8 05:36:48 ubuntu kernel: [75717.660217]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
Aug  8 05:36:48 ubuntu kernel: [75717.660223]         01 36 a7 e0
Aug  8 05:36:48 ubuntu kernel: [75717.660226] sd 4:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
Aug  8 05:36:48 ubuntu kernel: [75717.660375] ata5: EH complete
Aug  8 05:36:48 ubuntu kernel: [75717.671137] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:36:48 ubuntu kernel: [75717.671137] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:36:48 ubuntu kernel: [75717.671137] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:36:50 ubuntu kernel: [75719.782578]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:36:50 ubuntu kernel: [75719.782578] ata5: hard resetting link
Aug  8 05:36:51 ubuntu kernel: [75720.479530] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:36:51 ubuntu kernel: [75720.649548] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:51 ubuntu kernel: [75720.739608] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:51 ubuntu kernel: [75720.739611] ata5.00: configured for UDMA/133
Aug  8 05:36:51 ubuntu kernel: [75720.739616] ata5: EH complete
Aug  8 05:36:51 ubuntu kernel: [75720.739648] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:36:51 ubuntu kernel: [75720.739658] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:36:51 ubuntu kernel: [75720.739677] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:36:53 ubuntu kernel: [75723.202008]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:36:53 ubuntu kernel: [75723.202008] ata5: hard resetting link
Aug  8 05:36:53 ubuntu kernel: [75723.762090] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:36:54 ubuntu kernel: [75724.042130] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:54 ubuntu kernel: [75724.139630] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:54 ubuntu kernel: [75724.139633] ata5.00: configured for UDMA/133
Aug  8 05:36:54 ubuntu kernel: [75724.139637] ata5: EH complete
Aug  8 05:36:54 ubuntu kernel: [75724.139668] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:36:54 ubuntu kernel: [75724.139678] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:36:54 ubuntu kernel: [75724.139696] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:36:56 ubuntu kernel: [75726.492091]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:36:56 ubuntu kernel: [75726.492091] ata5: hard resetting link
Aug  8 05:36:56 ubuntu kernel: [75727.426773] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:36:56 ubuntu kernel: [75727.506792] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:56 ubuntu kernel: [75727.586792] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:56 ubuntu kernel: [75727.586795] ata5.00: configured for UDMA/133
Aug  8 05:36:56 ubuntu kernel: [75727.586800] ata5: EH complete
Aug  8 05:36:56 ubuntu kernel: [75727.746685] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:36:56 ubuntu kernel: [75727.746685] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:36:56 ubuntu kernel: [75727.746685] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:36:58 ubuntu kernel: [75730.090040]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:36:58 ubuntu kernel: [75730.090040] ata5: hard resetting link
Aug  8 05:36:59 ubuntu kernel: [75730.871583] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:36:59 ubuntu kernel: [75730.951513] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:59 ubuntu kernel: [75731.063768] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:36:59 ubuntu kernel: [75731.063768] ata5.00: configured for UDMA/133
Aug  8 05:36:59 ubuntu kernel: [75731.063768] ata5: EH complete
Aug  8 05:36:59 ubuntu kernel: [75731.063768] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:36:59 ubuntu kernel: [75731.063768] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:36:59 ubuntu kernel: [75731.063768] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:37:01 ubuntu kernel: [75733.503947]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:37:01 ubuntu kernel: [75733.503947] ata5: hard resetting link
Aug  8 05:37:01 ubuntu kernel: [75734.640474] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:37:01 ubuntu kernel: [75734.722993] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:02 ubuntu kernel: [75734.982993] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:02 ubuntu kernel: [75734.982993] ata5.00: configured for UDMA/133
Aug  8 05:37:02 ubuntu kernel: [75734.982993] ata5: EH complete
Aug  8 05:37:02 ubuntu kernel: [75734.982993] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:37:02 ubuntu kernel: [75734.982993] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:37:02 ubuntu kernel: [75734.982993] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:37:03 ubuntu kernel: [75737.420115]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:37:03 ubuntu kernel: [75737.420115] ata5: hard resetting link
Aug  8 05:37:04 ubuntu kernel: [75738.137382] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:37:04 ubuntu kernel: [75738.243825] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:04 ubuntu kernel: [75738.320964] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:04 ubuntu kernel: [75738.320967] ata5.00: configured for UDMA/133
Aug  8 05:37:04 ubuntu kernel: [75738.320973] sd 4:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Aug  8 05:37:04 ubuntu kernel: [75738.320976] sd 4:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Aug  8 05:37:04 ubuntu kernel: [75738.320980] Descriptor sense data with sense descriptors (in hex):
Aug  8 05:37:04 ubuntu kernel: [75738.320981]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
Aug  8 05:37:04 ubuntu kernel: [75738.320987]         01 36 a7 e0
Aug  8 05:37:04 ubuntu kernel: [75738.320990] sd 4:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
Aug  8 05:37:04 ubuntu kernel: [75738.321053] ata5: EH complete
Aug  8 05:37:04 ubuntu kernel: [75738.321095] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:37:04 ubuntu kernel: [75738.321105] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:37:04 ubuntu kernel: [75738.321123] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:37:06 ubuntu kernel: [75740.548554]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:37:06 ubuntu kernel: [75740.548554] ata5: hard resetting link
Aug  8 05:37:07 ubuntu kernel: [75741.318513] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:37:07 ubuntu kernel: [75741.398531] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:07 ubuntu kernel: [75741.478530] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:07 ubuntu kernel: [75741.478533] ata5.00: configured for UDMA/133
Aug  8 05:37:07 ubuntu kernel: [75741.478538] ata5: EH complete
Aug  8 05:37:07 ubuntu kernel: [75741.528399] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:37:07 ubuntu kernel: [75741.528399] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:37:07 ubuntu kernel: [75741.528399] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:37:09 ubuntu kernel: [75743.460929]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:37:09 ubuntu kernel: [75743.460929] ata5: hard resetting link
Aug  8 05:37:09 ubuntu kernel: [75744.338647] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:37:09 ubuntu kernel: [75744.401164] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:09 ubuntu kernel: [75744.507991] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:09 ubuntu kernel: [75744.507994] ata5.00: configured for UDMA/133
Aug  8 05:37:09 ubuntu kernel: [75744.507999] ata5: EH complete
Aug  8 05:37:09 ubuntu kernel: [75744.508030] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:37:09 ubuntu kernel: [75744.508041] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:37:09 ubuntu kernel: [75744.508059] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:37:11 ubuntu kernel: [75746.360494]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:37:11 ubuntu kernel: [75746.360494] ata5: hard resetting link
Aug  8 05:37:12 ubuntu kernel: [75747.471458] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:37:12 ubuntu kernel: [75747.531477] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:12 ubuntu kernel: [75747.612969] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:12 ubuntu kernel: [75747.612972] ata5.00: configured for UDMA/133
Aug  8 05:37:12 ubuntu kernel: [75747.612977] ata5: EH complete
Aug  8 05:37:12 ubuntu kernel: [75747.613008] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:37:12 ubuntu kernel: [75747.613019] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:37:12 ubuntu kernel: [75747.613037] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:37:14 ubuntu kernel: [75749.506557]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:37:14 ubuntu kernel: [75749.506557] ata5: hard resetting link
Aug  8 05:37:14 ubuntu kernel: [75750.568741] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:37:15 ubuntu kernel: [75750.838698] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:15 ubuntu kernel: [75750.928696] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:15 ubuntu kernel: [75750.928699] ata5.00: configured for UDMA/133
Aug  8 05:37:15 ubuntu kernel: [75750.928705] ata5: EH complete
Aug  8 05:37:15 ubuntu kernel: [75750.928696] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:37:15 ubuntu kernel: [75750.928696] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:37:15 ubuntu kernel: [75750.928696] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:37:17 ubuntu kernel: [75753.133354]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:37:17 ubuntu kernel: [75753.133354] ata5: hard resetting link
Aug  8 05:37:17 ubuntu kernel: [75753.700876] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:37:17 ubuntu kernel: [75753.920834] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:17 ubuntu kernel: [75754.020331] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:17 ubuntu kernel: [75754.020333] ata5.00: configured for UDMA/133
Aug  8 05:37:17 ubuntu kernel: [75754.020338] ata5: EH complete
Aug  8 05:37:17 ubuntu kernel: [75754.020370] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:37:17 ubuntu kernel: [75754.020381] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:37:17 ubuntu kernel: [75754.020400] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug  8 05:37:19 ubuntu kernel: [75756.348504]          res 51/40:00:e0:a7:36/00:00:01:00:00/e1 Emask 0x9 (media error)
Aug  8 05:37:19 ubuntu kernel: [75756.348504] ata5: hard resetting link
Aug  8 05:37:20 ubuntu kernel: [75757.090698] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Aug  8 05:37:20 ubuntu kernel: [75757.290812] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:20 ubuntu kernel: [75757.400812] ata5.00: max_sectors limited to 256 for NCQ
Aug  8 05:37:20 ubuntu kernel: [75757.400815] ata5.00: configured for UDMA/133
Aug  8 05:37:20 ubuntu kernel: [75757.400822] sd 4:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Aug  8 05:37:20 ubuntu kernel: [75757.400825] sd 4:0:0:0: [sda] Sense Key : Medium Error [current] [descriptor]
Aug  8 05:37:20 ubuntu kernel: [75757.400828] Descriptor sense data with sense descriptors (in hex):
Aug  8 05:37:20 ubuntu kernel: [75757.400830]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
Aug  8 05:37:20 ubuntu kernel: [75757.400836]         01 36 a7 e0
Aug  8 05:37:20 ubuntu kernel: [75757.400838] sd 4:0:0:0: [sda] Add. Sense: Unrecovered read error - auto reallocate failed
Aug  8 05:37:20 ubuntu kernel: [75757.400902] ata5: EH complete
Aug  8 05:37:20 ubuntu kernel: [75757.414241] sd 4:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
Aug  8 05:37:20 ubuntu kernel: [75757.414241] sd 4:0:0:0: [sda] Write Protect is off
Aug  8 05:37:20 ubuntu kernel: [75757.414241] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA


--------------010609060505070700000002
Content-Type: text/plain;
 name="errors3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="errors3.txt"

Aug  8 05:54:29 ubuntu kernel: [76898.778051] ------------[ cut here ]------------
Aug  8 05:54:29 ubuntu kernel: [76898.778051] WARNING: at drivers/ata/libata-core.c:4732 ata_qc_issue+0x1ca/0x230 [libata]()
Aug  8 05:54:29 ubuntu kernel: [76898.778051] Modules linked in: dm_mod autofs4 ipv6 iptable_filter ip_tables x_tables lp loop af_packet sr_mod cdrom container e1000e button parport_pc parport iTCO_wdt iTCO_vendor_support pcspkr shpchp pci_hotplug psmouse evdev ext3 jbd mbcache sg sd_mod pata_it8213 ata_piix pata_acpi floppy ata_generic sata_mv libata scsi_mod dock ehci_hcd uhci_hcd usbcore thermal processor fan thermal_sys fuse
Aug  8 05:54:29 ubuntu kernel: [76898.778051] Pid: 4150, comm: dd Tainted: G        W 2.6.26.2.030320 #1
Aug  8 05:54:29 ubuntu kernel: [76898.778051]
Aug  8 05:54:29 ubuntu kernel: [76898.778051] Call Trace:
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [ext3:warn_on_slowpath+0x64/0x320] warn_on_slowpath+0x64/0xa0
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [sg:sg_init_table+0x20/0x663e0] sg_init_table+0x20/0x50
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [scsi_mod:blk_rq_map_sg+0x7c/0x25e0] blk_rq_map_sg+0x7c/0x2b0
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [scsi_mod:scsi_sg_alloc+0x0/0x50] :scsi_mod:scsi_sg_alloc+0x0/0x50
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [scsi_mod:scsi_init_sgtable+0x54/0xb0] :scsi_mod:scsi_init_sgtable+0x54/0xb0
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [libata:ata_build_rw_tf+0xc1/0x290] :libata:ata_build_rw_tf+0xc1/0x290
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [libata:ata_qc_issue+0x1ca/0x230] :libata:ata_qc_issue+0x1ca/0x230
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [scsi_mod:scsi_done+0x0/0x20] :scsi_mod:scsi_done+0x0/0x20
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [libata:ata_scsi_translate+0xf8/0x190] :libata:ata_scsi_translate+0xf8/0x190
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [scsi_mod:scsi_done+0x0/0x20] :scsi_mod:scsi_done+0x0/0x20
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [sata_mv:ata_scsi_queuecmd+0xbb/0x240] :libata:ata_scsi_queuecmd+0xbb/0x240
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [scsi_mod:scsi_dispatch_cmd+0x11e/0x2e0] :scsi_mod:scsi_dispatch_cmd+0x11e/0x2e0
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [scsi_mod:scsi_request_fn+0x213/0x3c0] :scsi_mod:scsi_request_fn+0x213/0x3c0
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [sync_page_killable+0x0/0x40] sync_page_killable+0x0/0x40
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [floppy:generic_unplug_device+0x24/0xa0] generic_unplug_device+0x24/0x30
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [blk_unplug+0x35/0x70] blk_unplug+0x35/0x70
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [sync_page+0x2e/0x50] sync_page+0x2e/0x50
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [sync_page_killable+0x9/0x40] sync_page_killable+0x9/0x40
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [__wait_on_bit_lock+0x4a/0x80] __wait_on_bit_lock+0x4a/0x80
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [__lock_page_killable+0x5f/0x70] __lock_page_killable+0x5f/0x70
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [<ffffffff8024ac30>] wake_bit_function+0x0/0x30
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [fuse:generic_file_aio_read+0x36a/0x710] generic_file_aio_read+0x36a/0x570
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [ext3:do_sync_read+0xd9/0xbc0] do_sync_read+0xd9/0x120
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [<ffffffff8024ac00>] autoremove_wake_function+0x0/0x30
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [handle_mm_fault+0x575/0x810] handle_mm_fault+0x575/0x810
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [block_ioctl+0x1b/0x30] block_ioctl+0x1b/0x30
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [vfs_read+0xc5/0x180] vfs_read+0xc5/0x180
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [sys_read+0x53/0x90] sys_read+0x53/0x90
Aug  8 05:54:29 ubuntu kernel: [76898.778051]  [system_call_after_swapgs+0x7b/0x80] system_call_after_swapgs+0x7b/0x80
Aug  8 05:54:29 ubuntu kernel: [76898.778051]
Aug  8 05:54:29 ubuntu kernel: [76898.778051] ---[ end trace 98cca564749c28e3 ]---


--------------010609060505070700000002--
