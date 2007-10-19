From: MisterE <MisterE2002@zonnet.nl>
Subject: Re[2]: Sata Sil3512 bug?;  Promise SATA300 TX4
Date: Fri, 19 Oct 2007 14:02:36 +0200
Message-ID: <1319721523.20071019140236@zonnet.nl>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <471660B8.7080309@how.dk>
Reply-To: MisterE <MisterE2002@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.publishnet.nl ([212.241.49.8]:4706 "EHLO smtp.pn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764839AbXJSL6v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Oct 2007 07:58:51 -0400
Received: from localhost ([84.246.52.165])
	by smtp.pn.nl (smtp.pn.nl [212.241.49.8])
	(MDaemon.PRO.v8.1.3.R)
	with ESMTP id 11-md50000106156.msg
	for <linux-ide@vger.kernel.org>; Fri, 19 Oct 2007 13:58:45 +0200
In-Reply-To: <471660B8.7080309@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: Alexander Sabourenkov <screwdriver@lxnt.info>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hello Peter,

Wednesday, October 17, 2007, 9:21:28 PM, you wrote:


> On one box I had problems with the SATA300 TX4 using 2.6.21 through 
> 2.6.22 (different versions). I have 4x500GB Seagate ES SATA drives 
> connected. The system would run fine, but when put to a stress - i.e. 
> loaded on all sata ports one or two ports would fail - one after the 
> other. I have _always_ been able to make it fail doing:

> dd if=/dev/sda of=/dev/null bs=1M &
> dd if=/dev/sdb of=/dev/null bs=1M &
> dd if=/dev/sdc of=/dev/null bs=1M &
> dd if=/dev/sdd of=/dev/null bs=1M &

> The ports would freeze before running long - e.g. in less than an hour.

I followed your advice and tested it. I have 4x500GB drives (western
digital Caviar SE16 WD5000AAKS). I tested it with and without jumpers
(300 and 150Gb mode). All test are done with the Asus CUSL2-C


1 :: The first run; debian 2.6.18-4-686 (stable); 300Gb [3 hours in total]:
Oct 17 18:06:12 debian kernel: ata1: no sense translation for status: 0x50
Oct 17 18:06:12 debian kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Oct 17 18:06:12 debian kernel: ata1: status=0x50 { DriveReady SeekComplete }
Oct 17 19:37:15 debian kernel: ata1: no sense translation for status: 0x50
Oct 17 19:37:15 debian kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Oct 17 19:37:15 debian kernel: ata1: status=0x50 { DriveReady SeekComplete }
Oct 17 19:42:11 debian kernel: ata3: no sense translation for status: 0x50
Oct 17 19:42:12 debian kernel: ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Oct 17 19:42:12 debian kernel: ata3: status=0x50 { DriveReady SeekComplete }
Oct 17 20:23:38 debian kernel: ata1: no sense translation for status: 0x50
Oct 17 20:23:39 debian kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Oct 17 20:23:39 debian kernel: ata1: status=0x50 { DriveReady SeekComplete }
Oct 17 20:31:38 debian kernel: ata2: no sense translation for status: 0x50
Oct 17 20:31:38 debian kernel: ata2: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Oct 17 20:31:38 debian kernel: ata2: status=0x50 { DriveReady SeekComplete }
Oct 17 20:44:56 debian kernel: ata3: no sense translation for status: 0x50
Oct 17 20:44:56 debian kernel: ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Oct 17 20:44:56 debian kernel: ata3: status=0x50 { DriveReady SeekComplete }

2 :: Second run (1 hour); same settings:
Oct 18 09:27:47 debian kernel: ata4: no sense translation for status: 0x50
Oct 18 09:27:47 debian kernel: ata4: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Oct 18 09:27:47 debian kernel: ata4: status=0x50 { DriveReady SeekComplete }
Oct 18 09:38:18 debian kernel: ata3: no sense translation for status: 0x50
Oct 18 09:38:18 debian kernel: ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Oct 18 09:38:18 debian kernel: ata3: status=0x50 { DriveReady SeekComplete }


3 :: After that 3 a 5 hours with the drives jumpered. No problems.


4 :: 17:15 - 18:28; 2.6.22-2-686; 300Gb

Oct 18 13:45:25 fileserver kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
Oct 18 13:45:25 fileserver kernel: ata1.00: (port_status 0x20080000)
Oct 18 13:45:25 fileserver kernel: ata1.00: cmd c8/00:08:00:e6:cb/00:00:00:00:00/e2 tag 0 cdb 0x0 data 4096 in
Oct 18 13:45:25 fileserver kernel:          res 50/00:00:07:e6:cb/00:00:00:00:00/e2 Emask 0x2 (HSM violation)
Oct 18 13:45:26 fileserver kernel: ata1: soft resetting port
Oct 18 13:45:26 fileserver kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 18 13:45:26 fileserver kernel: ata1.00: configured for UDMA/133
Oct 18 13:45:26 fileserver kernel: ata1: EH complete
Oct 18 13:45:26 fileserver kernel: sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
Oct 18 13:45:26 fileserver kernel: sd 0:0:0:0: [sda] Write Protect is off
Oct 18 13:45:26 fileserver kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 18 13:45:26 fileserver kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 18 13:57:19 fileserver kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
Oct 18 13:57:19 fileserver kernel: ata2.00: (port_status 0x20080000)
Oct 18 13:57:19 fileserver kernel: ata2.00: cmd c8/00:08:00:e6:92/00:00:00:00:00/e4 tag 0 cdb 0x0 data 4096 in
Oct 18 13:57:19 fileserver kernel:          res 50/00:00:07:e6:92/00:00:00:00:00/e4 Emask 0x2 (HSM violation)
Oct 18 13:57:19 fileserver kernel: ata2: soft resetting port
Oct 18 13:57:20 fileserver kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 18 13:57:20 fileserver kernel: ata2.00: configured for UDMA/133
Oct 18 13:57:20 fileserver kernel: ata2: EH complete
Oct 18 13:57:20 fileserver kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Oct 18 13:57:20 fileserver kernel: sd 1:0:0:0: [sdb] Write Protect is off
Oct 18 13:57:20 fileserver kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Oct 18 13:57:20 fileserver kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 18 14:09:44 fileserver kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
Oct 18 14:09:44 fileserver kernel: ata1.00: (port_status 0x20080000)
Oct 18 14:09:44 fileserver kernel: ata1.00: cmd c8/00:e0:20:8d:3b/00:00:00:00:00/e6 tag 0 cdb 0x0 data 114688 in
Oct 18 14:09:44 fileserver kernel:          res 50/00:00:ff:8d:3b/00:00:00:00:00/e6 Emask 0x2 (HSM violation)
Oct 18 14:09:44 fileserver kernel: ata1: soft resetting port
Oct 18 14:09:44 fileserver kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 18 14:09:44 fileserver kernel: ata1.00: configured for UDMA/133
Oct 18 14:09:44 fileserver kernel: ata1: EH complete
Oct 18 14:09:44 fileserver kernel: sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
Oct 18 14:09:44 fileserver kernel: sd 0:0:0:0: [sda] Write Protect is off
Oct 18 14:09:44 fileserver kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 18 14:09:44 fileserver kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 18 14:15:37 fileserver kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
Oct 18 14:15:37 fileserver kernel: ata3.00: (port_status 0x20080000)
Oct 18 14:15:37 fileserver kernel: ata3.00: cmd c8/00:08:00:4a:27/00:00:00:00:00/e7 tag 0 cdb 0x0 data 4096 in
Oct 18 14:15:37 fileserver kernel:          res 50/00:00:07:4a:27/00:00:00:00:00/e7 Emask 0x2 (HSM violation)
Oct 18 14:15:37 fileserver kernel: ata3: soft resetting port
Oct 18 14:15:38 fileserver kernel: ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 18 14:15:38 fileserver kernel: ata3.00: configured for UDMA/133
Oct 18 14:15:38 fileserver kernel: ata3: EH complete
Oct 18 14:15:38 fileserver kernel: sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
Oct 18 14:15:38 fileserver kernel: sd 2:0:0:0: [sdc] Write Protect is off
Oct 18 14:15:38 fileserver kernel: sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Oct 18 14:15:38 fileserver kernel: sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA


5 :: 2.6.22-2-686 - 2 hours with the drives jumpered. No problems.


> The above issue was fixed by updating to vanilla 2.6.23.1.

So, when running in the 150Gb mode there are no problems.

I'm going to try the same with .23(.1). I'm not really familiar with
updating the kernel. Tried it before with: http://www.debianhelp.co.uk/kernel2.6.htm
but not much success. But, i'm going to try...
I will post the results later.



-- 
Best regards,
 MisterE                            mailto:MisterE2002@zonnet.nl


