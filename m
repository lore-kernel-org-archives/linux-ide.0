From: Peter Favrholdt <linux-ide@how.dk>
Subject: Correction Re: Bug is fixed in 2.6.23.1: sata_promise: port is slow
 to respond, reset failed
Date: Sat, 10 Nov 2007 00:58:55 +0100
Message-ID: <4734F43F.5080601@how.dk>
References: <46DA9AAA.3070808@how.dk> <4711DF89.5000208@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:33331 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578AbXKIX66 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 18:58:58 -0500
Received: from how3.how.dk (0x50a32a37.unknown.tele.dk [80.163.42.55])
	by pfepa.post.tele.dk (Postfix) with ESMTP id 91048FAC025
	for <linux-ide@vger.kernel.org>; Sat, 10 Nov 2007 00:58:55 +0100 (CET)
Received: from how7.how.dk ([192.168.0.7] ident=pfavr)
	by how3.how.dk with esmtp (Exim 4.50)
	id 1IqdkV-0003B4-CH
	for linux-ide@vger.kernel.org; Sat, 10 Nov 2007 00:58:55 +0100
In-Reply-To: <4711DF89.5000208@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I previously wrote this issue was fixed by upgrading to 2.6.23.1

There were some mails on this list regarding a workaround for an Asic 
bug and of course I'm looking forward to trying it :-)

Anyway here goes for completeness:

* 2.6.23.1 completed dd-stress tests as described earlier (these same 
tests would always make 2.6.22.9 fail before completing even a single run)

* after 21 days and 8 hours normal operation, one sata channel froze 
while doing checkarray with the following dmesg output (only md/sata 
stuff - rest deleted):

01:06:02 kernel: [1843824.893109] md: data-check of RAID array md0
01:06:02 kernel: [1843824.893117] md: minimum _guaranteed_  speed: 1000 
KB/sec/disk.
01:06:02 kernel: [1843824.893121] md: using maximum available idle IO 
bandwidth (but not more than 200000 KB/sec) for data-check.
01:06:02 kernel: [1843824.893126] md: using 128k window, over a total of 
488386496 blocks.
01:06:02 mdadm: RebuildStarted event detected on md device /dev/md0
01:15:30 kernel: [1844393.053517] ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x1380000 action 0x2 frozen
01:15:30 kernel: [1844393.053533] ata1.00: cmd 
25/00:00:00:1e:e6/00:04:01:00:00/e0 tag 0 cdb 0x0 data 524288 in
01:15:30 kernel: [1844393.053535]          res 
40/00:28:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
01:15:35 kernel: [1844398.420543] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:15:40 kernel: [1844403.098409] ata1: device not ready (errno=-16), 
forcing hardreset
01:15:40 kernel: [1844403.098420] ata1: hard resetting port
01:15:46 kernel: [1844408.645861] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:15:50 kernel: [1844413.144653] ata1: COMRESET failed (errno=-16)
01:15:50 kernel: [1844413.144663] ata1: hard resetting port
01:15:56 kernel: [1844418.691270] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:16:00 kernel: [1844423.189228] ata1: COMRESET failed (errno=-16)
01:16:00 kernel: [1844423.189237] ata1: hard resetting port
01:16:06 kernel: [1844428.736687] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:16:35 kernel: [1844458.193217] ata1: COMRESET failed (errno=-16)
01:16:35 kernel: [1844458.193228] ata1: limiting SATA link speed to 1.5 Gbps
01:16:35 kernel: [1844458.193231] ata1: hard resetting port
01:16:40 kernel: [1844463.201458] ata1: COMRESET failed (errno=-16)
01:16:40 kernel: [1844463.201468] ata1: reset failed, giving up
01:16:40 kernel: [1844463.201472] ata1.00: disabled
01:16:40 kernel: [1844463.201483] ata1: EH pending after completion, 
repeating EH (cnt=4)
01:16:40 kernel: [1844463.201491] ata1: exception Emask 0x10 SAct 0x0 
SErr 0x1390002 action 0x2 frozen
01:16:40 kernel: [1844463.201495] ata1: hotplug_status 0x80
01:16:40 kernel: [1844463.201506] ata1: hard resetting port
01:16:46 kernel: [1844469.148300] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:16:50 kernel: [1844473.226345] ata1: COMRESET failed (errno=-16)
01:16:50 kernel: [1844473.226355] ata1: hard resetting port
01:16:56 kernel: [1844479.173709] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:17:00 kernel: [1844483.252279] ata1: COMRESET failed (errno=-16)
01:17:00 kernel: [1844483.252289] ata1: hard resetting port
01:17:06 kernel: [1844489.199287] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:17:35 kernel: [1844518.245767] ata1: COMRESET failed (errno=-16)
01:17:35 kernel: [1844518.245778] ata1: limiting SATA link speed to 1.5 Gbps
01:17:35 kernel: [1844518.245782] ata1: hard resetting port
01:17:40 kernel: [1844523.293460] ata1: COMRESET failed (errno=-16)
01:17:40 kernel: [1844523.293469] ata1: reset failed, giving up
01:17:40 kernel: [1844523.293476] ata1: EH pending after completion, 
repeating EH (cnt=3)
01:17:40 kernel: [1844523.293485] ata1: exception Emask 0x10 SAct 0x0 
SErr 0x1390002 action 0x2 frozen
01:17:40 kernel: [1844523.293488] ata1: hotplug_status 0x80
01:17:40 kernel: [1844523.293500] ata1: hard resetting port
01:17:46 kernel: [1844529.240746] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:17:50 kernel: [1844533.319339] ata1: COMRESET failed (errno=-16)
01:17:50 kernel: [1844533.319349] ata1: hard resetting port
01:17:56 kernel: [1844539.266172] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:18:00 kernel: [1844543.344817] ata1: COMRESET failed (errno=-16)
01:18:00 kernel: [1844543.344827] ata1: hard resetting port
01:18:06 kernel: [1844549.291715] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:18:35 kernel: [1844578.338834] ata1: COMRESET failed (errno=-16)
01:18:35 kernel: [1844578.338846] ata1: limiting SATA link speed to 1.5 Gbps
01:18:35 kernel: [1844578.338849] ata1: hard resetting port
01:18:41 kernel: [1844583.385996] ata1: COMRESET failed (errno=-16)
01:18:41 kernel: [1844583.386006] ata1: reset failed, giving up
01:18:41 kernel: [1844583.386012] ata1: EH pending after completion, 
repeating EH (cnt=2)
01:18:41 kernel: [1844583.386021] ata1: exception Emask 0x10 SAct 0x0 
SErr 0x1390002 action 0x2 frozen
01:18:41 kernel: [1844583.386024] ata1: hotplug_status 0x80
01:18:41 kernel: [1844583.386036] ata1: hard resetting port
01:18:46 kernel: [1844589.333287] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:18:51 kernel: [1844593.411414] ata1: COMRESET failed (errno=-16)
01:18:51 kernel: [1844593.411424] ata1: hard resetting port
01:18:56 kernel: [1844599.358702] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:19:01 kernel: [1844603.436851] ata1: COMRESET failed (errno=-16)
01:19:01 kernel: [1844603.436862] ata1: hard resetting port
01:19:07 kernel: [1844609.384125] ata1: port is slow to respond, please 
be patient (Status 0xff)
01:19:36 kernel: [1844638.430836] ata1: COMRESET failed (errno=-16)
01:19:36 kernel: [1844638.430848] ata1: limiting SATA link speed to 1.5 Gbps
01:19:36 kernel: [1844638.430851] ata1: hard resetting port
01:20:41 kernel: [1844703.571175] ata1: COMRESET failed (errno=-16)
01:20:41 kernel: [1844703.571185] ata1: reset failed, giving up
01:20:41 kernel: [1844703.571192] ata1: EH pending after 5 tries, giving up
01:20:41 kernel: [1844703.571245] sd 0:0:0:0: [sda] Result: 
hostbyte=0x00 driverbyte=0x08
01:20:41 kernel: [1844703.571249] sd 0:0:0:0: [sda] Sense Key : 0xb 
[current] [descriptor]
01:20:41 kernel: [1844703.571255] Descriptor sense data with sense 
descriptors (in hex):
01:20:41 kernel: [1844703.571258]         72 0b 00 00 00 00 00 0c 00 0a 
80 00 00 00 00 00
01:20:41 kernel: [1844703.571265]         00 00 00 00
01:20:41 kernel: [1844703.571268] sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
01:20:41 kernel: [1844703.571271] end_request: I/O error, dev sda, 
sector 31858176
01:20:41 kernel: [1844703.571343] sd 0:0:0:0: rejecting I/O to offline 
device
01:20:41 kernel: [1844703.571349] sd 0:0:0:0: rejecting I/O to offline 
device
01:20:41 kernel: [1844703.571413] ata1: EH complete
01:20:41 kernel: [1844703.572352] sd 0:0:0:0: [sda] Result: 
hostbyte=0x01 driverbyte=0x00
01:20:41 kernel: [1844703.572358] end_request: I/O error, dev sda, 
sector 31859200
01:20:41 kernel: [1844703.572375] sd 0:0:0:0: rejecting I/O to offline 
device
01:20:41 kernel: [1844703.572378] sd 0:0:0:0: rejecting I/O to offline 
device
01:20:41 kernel: [1844703.572381] sd 0:0:0:0: rejecting I/O to offline 
device
01:20:41 kernel: [1844703.572387] md: super_written gets error=-5, 
uptodate=0
01:20:41 kernel: [1844703.572390] raid5: Disk failure on sda, disabling 
device. Operation continuing on 3 devices
01:20:41 kernel: [1844703.572827] ata1.00: detaching (SCSI 0:0:0:0)
01:20:41 kernel: [1844703.573155] sd 0:0:0:0: [sda] Synchronizing SCSI cache
01:20:41 kernel: [1844703.573347] sd 0:0:0:0: [sda] Result: 
hostbyte=0x04 driverbyte=0x00
01:20:41 kernel: [1844703.573353] sd 0:0:0:0: [sda] Stopping disk
01:20:41 kernel: [1844703.573519] sd 0:0:0:0: [sda] START_STOP FAILED
01:20:41 kernel: [1844703.573522] sd 0:0:0:0: [sda] Result: 
hostbyte=0x04 driverbyte=0x00
01:20:48 kernel: [1844711.027697] md: md0: data-check done.
01:20:48 kernel: [1844711.128915] RAID5 conf printout:
01:20:48 kernel: [1844711.128924]  --- rd:4 wd:3
01:20:48 kernel: [1844711.128927]  disk 0, o:0, dev:sda
01:20:48 kernel: [1844711.128930]  disk 1, o:1, dev:sdd
01:20:48 kernel: [1844711.128933]  disk 2, o:1, dev:sdc
01:20:48 kernel: [1844711.128935]  disk 3, o:1, dev:sdb
01:20:48 kernel: [1844711.157764] RAID5 conf printout:
01:20:48 kernel: [1844711.157774]  --- rd:4 wd:3
01:20:48 kernel: [1844711.157778]  disk 1, o:1, dev:sdd
01:20:48 kernel: [1844711.157782]  disk 2, o:1, dev:sdc
01:20:48 kernel: [1844711.157784]  disk 3, o:1, dev:sdb
01:20:49 mdadm: Fail event detected on md device /dev/md0, component 
device /dev/sda
01:20:49 mdadm: RebuildFinished event detected on md device /dev/md0

Best regards,

Peter



Peter Favrholdt wrote:
> The problem is solved in 2.6.23.1 regarding the "port slow to respond" 
> issue.
> 
> I'm using sata_promise on Promise Technology, Inc. PDC40718 (SATA 300 
> TX4) (rev 02) and 4 Seagate 500GB ES drives.
> 
> Using 2.6.23.1 it is possible to run
> 
> dd if=/dev/sda of=/dev/null bs=1M &
> dd if=/dev/sdb of=/dev/null bs=1M &
> dd if=/dev/sdc of=/dev/null bs=1M &
> dd if=/dev/sdd of=/dev/null bs=1M &
> 
> And it just runs perfectly to the end with no hickups :-)
> 
> Thank you very much :-)
> 
> Best regards,
> 
> Peter

