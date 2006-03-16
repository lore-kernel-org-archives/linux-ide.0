From: markus ebenhoeh <me_trash1@aon.at>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Thu, 16 Mar 2006 11:19:13 +1100
Message-ID: <200603161119.13214.me_trash1@aon.at>
References: <1142344212.4416ca14a26b4@webmail.aon.at>
Reply-To: me_trash1@aon.at
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ash25e.internode.on.net ([203.16.214.182]:3599 "EHLO
	ash25e.internode.on.net") by vger.kernel.org with ESMTP
	id S932621AbWCPAT3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Mar 2006 19:19:29 -0500
In-Reply-To: <1142344212.4416ca14a26b4@webmail.aon.at>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>

Yesterday, I also started with a 2.6.16-rc6 kernel (with the 2 op-code info 
patches).

The first two busy messages already are logged at boot up:
   kernel: [ 74.254530] ata5: status=0xd0 { Busy }
that happens right after the raids have been set up.
With 2.6.15.4 there never are any messages of the mentioned kind during
boot-up, but only e.g. with kmail retrieval or postgres insert&delete  writing 
to the volume group the raid6 with the 3 ot of 7 disks on Adaptec 1420SA.

Then, when the reiser filesystem on the vg made up of the raid6 is mounted, a 
couple of busy messages and these three abnormal status messages are logged:
   kernel: [152.627933] ata4: status=0xd0 { Busy }
   kernel: [152.740934] ata3: status=0xd0 { Busy }
   kernel: [152.750990] ATA: abnormal status 0xD0 on port 0xFFFFC2000092211C
   kernel: [152.761021] ATA: abnormal status 0xD0 on port 0xFFFFC2000092211C
   kernel: [152.771052] ATA: abnormal status 0xD0 on port 0xFFFFC2000092211C

This is followed later (caused by nothing known to me, but maybe still the
mounting? or smb starting?):
   kernel: [182.687864] ata3: Entering mv_eng_timeout
   kernel: [182.687871] mmio_base ffffc20000900000 ap ffff81007f4fc470 qc
   ffff81007f4fc9a8 scsi_cmnd ffff81007a0bcd40 &cmnd ffff81007a0bcdb0
   kernel: [182.814361] ata3: status=0x50 { DriveReady SeekComplete }
   kernel: [182.814364] ata3: error=0x01 { AddrMarkNotFound }
   kernel: [183.694148] Assertion failed! qc->flags &
   ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3635
   kernel: [183.694157] ata3: status=0x50 { DriveReady SeekComplete }
   kernel: [183.694159] ata3: error=0x01 { AddrMarkNotFound }

Then at the prompt after login, I typed find /nobak/ > somefile (/nobak is as 
softlink to a directory  on the raid6 with 184000 entries returned by find ) 
which takes a moment (7sec?) on 2.6.15.4 and does not trigger any log 
messages. 
With 2.6.16-rc6 it takes about 7 minutes (from 16:42:29 to 16:49:41)
and about 14 of the following log messages blocks being logged every ~30 
seconds:
   kernel: [245.189337] ata3: Entering mv_eng_timeout
   kernel: [245.189344] mmio_base ffffc20000900000 ap ffff81007f4fc470 qc 
ffff81007f4fc9a8 scsi_cmnd ffff81007a420d80 &cmnd ffff81007a420df0
   kernel: [245.315833] ata3: status=0x50 { DriveReady SeekComplete }
   kernel: [245.315835] ata3: error=0x01 { AddrMarkNotFound }
   kernel: [246.195640] Assertion failed! qc->flags & 
ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3635
   kernel: [246.195650] ata3: status=0x50 { DriveReady SeekComplete }
   kernel: [246.195652] ata3: error=0x01 { AddrMarkNotFound }
   kernel: [246.308724] ata5: status=0xd0 { Busy }
   kernel: [246.308970] ata4: status=0xd0 { Busy }
   kernel: [246.309446] ata3: status=0xd0 { Busy }
   kernel: [266.244826] ata5: status=0xd0 { Busy }
   kernel: [266.254877] ATA: abnormal status 0xD0 on port 0xFFFFC2000092611C
   kernel: [266.264907] ATA: abnormal status 0xD0 on port 0xFFFFC2000092611C
   kernel: [266.274937] ATA: abnormal status 0xD0 on port 0xFFFFC2000092611C

The whole messages log for this can be found as:
http://members.aon.at/~mebenhoc/sata_logs/messages_2.6.16-rc6_20060315_1640-1652.gz

Bye,
Markus
