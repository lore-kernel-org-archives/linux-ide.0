From: me_trash1@aon.at
Subject: LibPATA code issues / 2.6.15.4
Date: Tue, 14 Mar 2006 14:50:12 +0100 (MET)
Message-ID: <1142344212.4416ca14a26b4@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat01.aon.at ([195.3.96.107]:56724 "EHLO
	WARSBL112.highway.telekom.at") by vger.kernel.org with ESMTP
	id S1751089AbWCNNuO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Mar 2006 08:50:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>

Hi!

short:
system with 2.6.15.4 with Mark Lord's opcode info patches
sata_mv (Adaptec 1420SA Marvell 88SX6541)
e.g. postgres:insert&delete gives: ata3: translated op=0x2a cmd=0x35 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
or sometimes (unknown cause):
ata4: translated op=0x28 cmd=0x25 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata4: status=0xd0 { Busy }
Assertion failed! ((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == pp->rsp_c
onsumer,drivers/scsi/sata_mv.c,mv_get_crpb_status,line=1112


long:
I wanted to post this to the the thread "LibPATA code issues / 2.6.15.4".
But right now my system is a bit down and so I sent this via webmail.

If I understand correctly:
The messages originally mentioned by Justin and David in the mentioned thread have no relation to FUA, as FUA was not enabled in 2.6.15.4?
They just got worse when FUA got introduced in 2.6.16 (I tried 2.6.16-rc5 with similar effects as David Greaves had.)?
So moving to 2.6.16-rc6 has not effect on these particular problems, except FUA is turned off again?
(I also tried 2.6.16-rc5-git2-2 (comes with openSuSE 10.1Beta6), which also showed these messages.)

I am using 2.6.15.4 with 2 opcode info patches from Mark Lord posted in the thread (the 2nd adapted to 2.6.15.4).
I have 3 ide disks connected to the Asus Abit KV8 Pro onboard IDE controller (using VIA82CXXX) ,  2 SATA disks connected to the
onboard board (a using sata_via) and 3 SATA disks connected to a Adaptec 1420SA (with a 88SX6541-BCZ Marvell chip) (ata3-ata5)
all drivers are compiled into the kernel.

I know sata_mv is highly experimental.

The system is a bit akward. It was installed with SuSE 9.3 and  moved on with the kernel.

(the config has PCI_MSI = 0)

There are basically three types of log messages.

The following logs are easily reproduced by either simple insert/delete into a postgres or checking (receiving) e-mail with kmail (via cygwin xwin):
(both postgres and home dir are on the raid6 with 3 disks on the Adaptec 1420SA)
   Mar 14 08:56:50 meserv kernel: [ 1612.616632] ata3: translated op=0x2a cmd=0x35 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
   Mar 14 08:56:50 meserv kernel: [ 1612.616637] ata3: status=0xd0 { Busy }
   Mar 14 08:56:50 meserv kernel: [ 1612.708175] ata4: translated op=0x2a cmd=0x35 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
   Mar 14 08:56:50 meserv kernel: [ 1612.708180] ata4: status=0xd0 { Busy }

The next "Assertion failed!" messages come by the hundred and I only had these 2 times and have not found out when it happens, yet.
I make them go away by shuting down the system.

   Mar 11 17:47:32 meserv kernel: [ 1364.826147] ata3: translated op=0x28 cmd=0x25 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
   Mar 11 17:47:32 meserv kernel: [ 1364.826151] ata3: status=0xd0 { Busy }
   Mar 11 17:47:32 meserv kernel: [ 1364.840187] ata4: translated op=0x28 cmd=0x25 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
   Mar 11 17:47:32 meserv kernel: [ 1364.840190] ata4: status=0xd0 { Busy }
   Mar 11 17:47:32 meserv kernel: [ 1364.840211] Assertion failed! ((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == pp->rsp_c
onsumer,drivers/scsi/sata_mv.c,mv_get_crpb_status,line=1112

every now and then there was no error for a couple of seconds and then again a break of a minute and then again every second
   Mar 11 17:47:57 meserv kernel: [ 1389.785556] Assertion failed! ((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == pp->rsp_consumer,drivers/scsi/sata_mv.c,mv_get_crpb_status,line=1112
   Mar 11 17:48:50 meserv kernel: [ 1442.756405] Assertion failed! ((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == pp->rsp_consumer,drivers/scsi/sata_mv.c,mv_get_crpb_status,line=1112

That code is in static u8 mv_get_crpb_status(struct ata_port *ap) as probably obvious.


Lastly I had these messages only twice ( I also do not know the source, but I have the odd feeling that my wife's PC accessing
a lot of data over smb has something to do with it):
The difference are e.g
.) a different op code
.) assertion failure is at line=1067 in sata_mv.c
.) assertion failure in libata-core.c line=3517

   Mar  9 13:28:02 meserv kernel: [  650.731142] ata3: translated op=0x2a cmd=0x35 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
   Mar  9 13:28:02 meserv kernel: [  650.731147] ata3: status=0xd0 { Busy }
   Mar  9 13:28:02 meserv kernel: [  650.736058] ata4: translated op=0x2a cmd=0x35 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
   Mar  9 13:28:02 meserv kernel: [  650.736063] ata4: status=0xd0 { Busy }
   Mar  9 13:28:02 meserv kernel: [  650.774947] ata5: translated op=0x2a cmd=0x35 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
   Mar  9 13:28:02 meserv kernel: [  650.774950] ata5: status=0xd0 { Busy }
   Mar  9 13:28:33 meserv kernel: [  680.683623] ata4: Entering mv_eng_timeout
   Mar  9 13:28:33 meserv kernel: [  680.683630] mmio_base ffffc20000900000 ap ffff81007f679440 qc ffff81007f679980 scsi_cmnd ffff81006bd2e2c0 &cmnd ffff81006bd2e330
   Mar  9 13:28:33 meserv kernel: [  681.816087] Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3517
   Mar  9 13:28:33 meserv kernel: [  681.816102] ata4: status=0x50 { DriveReady SeekComplete }
   Mar  9 13:28:33 meserv kernel: [  681.816105] ata4: error=0x01 { AddrMarkNotFound }
   Mar  9 13:28:33 meserv kernel: [  681.816109] sdd: Current: sense key: No Sense
   Mar  9 13:28:33 meserv kernel: [  681.816111]     Additional sense: No additional sense information
   Mar  9 13:28:33 meserv kernel: [  681.816203] Assertion failed! ((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS)
    >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK),drivers/scsi/sata_mv.c,mv_qc_issue,line=1067
   Mar  9 13:29:04 meserv kernel: [  711.763158] ata4: Entering mv_eng_timeout
   Mar  9 13:29:04 meserv kernel: [  711.763165] mmio_base ffffc20000900000 ap ffff81007f679440 qc ffff81007f679980 scsi_cmnd ffff81006bd2e480 &cmnd ffff81006bd2e4f0
   Mar  9 13:29:04 meserv kernel: [  711.889637] ata4: status=0x50 { DriveReady SeekComplete }
   Mar  9 13:29:04 meserv kernel: [  711.889640] ata4: error=0x01 { AddrMarkNotFound }
   Mar  9 13:29:04 meserv kernel: [  712.769267] Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3517
   Mar  9 13:29:04 meserv kernel: [  712.769281] ata4: status=0x50 { DriveReady SeekComplete }
   Mar  9 13:29:04 meserv kernel: [  712.769284] ata4: error=0x01 { AddrMarkNotFound }
   Mar  9 13:29:04 meserv kernel: [  712.769288] sdd: Current: sense key: No Sense
   Mar  9 13:29:04 meserv kernel: [  712.769290]     Additional sense: No additional sense information
   Mar  9 13:29:04 meserv kernel: [  712.769380] Assertion failed! ((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS)
    >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK),drivers/scsi/sata_mv.c,mv_qc_issue,line=1067



And finally I had all types of the above messages happend at once when my wife copied 700MB to the raid via smb
and I searched a ide disk and used kmail via Cygwin/Xwin and accessed the raid via smb.
At first no new ssh connection could be created, after successful login it just hanged.
Then all my ssh connections to the machine were closed, the network activity blinked wildly, no ping,
blank screen, no keyboard numlock and I after  a while I just turned of the power.

A picture of the card Adaptec_Serial_ATA_II_RAID_1420SA_front_nosticker.JPG (for chip identification?),
dmesg,
some system infos (lspci, some /proc's),
current config
and the last error log
can be found on
http://members.aon.at/~mebenhoc/sata_logs/

Bye,
Markus



-------------------------------------------
Versendet durch aonWebmail (webmail.aon.at)
