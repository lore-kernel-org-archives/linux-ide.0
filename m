From: PairOfTwins <PairOfTwins@mindspring.com>
Subject: Accessing 3.4 TB RAID Drive
Date: Fri, 24 Oct 2008 09:30:03 -0400
Message-ID: <4901CDDB.8000409@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:36827 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752151AbYJXOLP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Oct 2008 10:11:15 -0400
Received: from [66.32.150.95] (helo=[192.168.1.100])
	by elasmtp-junco.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <PairOfTwins@mindspring.com>)
	id 1KtMjr-00054q-Qk
	for linux-ide@vger.kernel.org; Fri, 24 Oct 2008 09:30:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Folks (I was referred here by my local Linux group):

I'm replacing RHEL 3.2 with something newer, and need to access an 
external eSATA RAID array (Venus T5, Sil4726 chipset) about 3.4 TB.

Using a RIP (Recovery Is Possible) Live CD, I was able to read the GPT 
partition table and attempt to mount the device (though it was flagged 
dirty), on one test system. 

However, after installing Ubuntu Server 8.04 and 8.10 beta on a 
production box, I'm getting lots of errors.  One big difference, though, 
is the RIP test was using PCI eSATA card (Silicon Image Sil3124), and 
the production box has PCI-E eSATA card (Sil3132).

With Ubuntu Server 8.04 fully updated, kernel 2.6.24-21-server, driver 
sata_sil24, syslog says:

Oct 21 08:46:01 kg-ubuntu kernel: [  118.642284] ata5: exception Emask 
0x10 SAct 0x0 SErr 0x0 action 0xa frozen
Oct 21 08:46:01 kg-ubuntu kernel: [  118.642355] ata5: irq_stat 
0x00b40090, PHY RDY changed
Oct 21 08:46:01 kg-ubuntu kernel: [  118.642430] ata5: hard resetting link
Oct 21 08:46:03 kg-ubuntu kernel: [  120.859611] ata5: SATA link up 3.0 
Gbps (SStatus 123 SControl 0)
Oct 21 08:46:03 kg-ubuntu kernel: [  120.859856] ata5.15: Port 
Multiplier 1.1, 0x1095:0x4726 r31, 3 ports, feat 0x1/0x9
Oct 21 08:46:03 kg-ubuntu kernel: [  120.860093] ata5.00: hard resetting 
link
Oct 21 08:46:04 kg-ubuntu kernel: [  121.209439] ata5.00: SATA link down 
(SStatus 0 SControl 0)
Oct 21 08:46:04 kg-ubuntu kernel: [  121.209445] ata5.01: hard resetting 
link
Oct 21 08:46:04 kg-ubuntu kernel: [  121.558961] ata5.01: SATA link up 
3.0 Gbps (SStatus 123 SControl 0)
Oct 21 08:46:04 kg-ubuntu kernel: [  121.558967] ata5.02: hard resetting 
link
Oct 21 08:46:04 kg-ubuntu kernel: [  121.908513] ata5.02: SATA link up 
1.5 Gbps (SStatus 113 SControl 320)
Oct 21 08:46:04 kg-ubuntu kernel: [  121.908600] ata5.01: ATA-6: Config  
Disk, PLS12061, max UDMA/133
Oct 21 08:46:04 kg-ubuntu kernel: [  121.908603] ata5.01: 640 sectors, 
multi 1: LBA
Oct 21 08:46:04 kg-ubuntu kernel: [  121.908614] ata5.01: device is on 
DMA blacklist, disabling DMA
Oct 21 08:46:04 kg-ubuntu kernel: [  121.908721] ata5.01: configured for 
PIO4
Oct 21 08:46:04 kg-ubuntu kernel: [  121.908844] ata5.02: failed to 
IDENTIFY (I/O error, err_mask=0x1)
Oct 21 08:46:04 kg-ubuntu kernel: [  121.908846] ata5: failed to recover 
some devices, retrying in 5 secs
Oct 21 08:46:09 kg-ubuntu kernel: [  126.911897] ata5.02: hard resetting 
link
Oct 21 08:46:10 kg-ubuntu kernel: [  127.261709] ata5.02: SATA link up 
1.5 Gbps (SStatus 113 SControl 320)
Oct 21 08:46:10 kg-ubuntu kernel: [  127.261843] ata5.01: device is on 
DMA blacklist, disabling DMA
Oct 21 08:46:10 kg-ubuntu kernel: [  127.261972] ata5.01: configured for 
PIO4
Oct 21 08:46:10 kg-ubuntu kernel: [  127.262100] ata5.02: failed to 
IDENTIFY (I/O error, err_mask=0x1)
Oct 21 08:46:10 kg-ubuntu kernel: [  127.262103] ata5: failed to recover 
some devices, retrying in 5 secs
Oct 21 08:46:15 kg-ubuntu kernel: [  132.265098] ata5.02: hard resetting 
link
Oct 21 08:46:15 kg-ubuntu kernel: [  132.614902] ata5.02: SATA link up 
1.5 Gbps (SStatus 113 SControl 320)
Oct 21 08:46:15 kg-ubuntu kernel: [  132.615055] ata5.02: failed to 
IDENTIFY (I/O error, err_mask=0x1)
Oct 21 08:46:15 kg-ubuntu kernel: [  132.615058] ata5: failed to recover 
some devices, retrying in 5 secs
Oct 21 08:46:20 kg-ubuntu kernel: [  137.618270] ata5.02: hard resetting 
link
Oct 21 08:46:20 kg-ubuntu kernel: [  137.968090] ata5.02: SATA link up 
1.5 Gbps (SStatus 113 SControl 320)
Oct 21 08:46:20 kg-ubuntu kernel: [  137.968351] ata5: EH complete
Oct 21 08:46:20 kg-ubuntu kernel: [  137.968481] scsi 4:1:0:0: 
Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
================================================================================
Ubuntu Server 8.10 beta fully updated,, kernel 2.6.27-7-server, driver 
sata_sil24,  syslog says:

Oct 21 13:17:22 KG-BackupServ kernel: [  349.725504] ata3: exception 
Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
Oct 21 13:17:22 KG-BackupServ kernel: [  349.725580] ata3: irq_stat 
0x00b40090, PHY RDY changed
Oct 21 13:17:22 KG-BackupServ kernel: [  349.725647] ata3: hard 
resetting link
Oct 21 13:17:25 KG-BackupServ kernel: [  351.940047] ata3: SATA link up 
3.0 Gbps (SStatus 123 SControl 0)
Oct 21 13:17:25 KG-BackupServ kernel: [  351.940508] ata3.15: Port 
Multiplier 1.1, 0x1095:0x4726 r31, 3 ports, feat 0x1/0x9
Oct 21 13:17:25 KG-BackupServ kernel: [  351.940857] ata3.00: hard 
resetting link
Oct 21 13:17:25 KG-BackupServ kernel: [  352.290370] ata3.00: SATA link 
down (SStatus 0 SControl 0)
Oct 21 13:17:25 KG-BackupServ kernel: [  352.290494] ata3.01: hard 
resetting link
Oct 21 13:17:25 KG-BackupServ kernel: [  352.640335] ata3.01: SATA link 
up 3.0 Gbps (SStatus 123 SControl 0)
Oct 21 13:17:25 KG-BackupServ kernel: [  352.640343] ata3.02: hard 
resetting link
Oct 21 13:17:26 KG-BackupServ kernel: [  352.990309] ata3.02: SATA link 
up 1.5 Gbps (SStatus 113 SControl 320)
Oct 21 13:17:26 KG-BackupServ kernel: [  352.990481] ata3.01: 
unsupported device, disabling
Oct 21 13:17:26 KG-BackupServ kernel: [  352.990484] ata3.01: disabled
Oct 21 13:17:26 KG-BackupServ kernel: [  352.990813] ata3.02: both 
IDENTIFYs aborted, assuming NODEV
Oct 21 13:17:26 KG-BackupServ kernel: [  352.991212] ata3: EH complete
Oct 21 13:18:07 KG-BackupServ kernel: [  394.332730] kjournald 
starting.  Commit interval 5 seconds
Oct 21 13:18:07 KG-BackupServ kernel: [  394.335572] EXT3 FS on sdb1, 
internal journal
Oct 21 13:18:07 KG-BackupServ kernel: [  394.335582] EXT3-fs: mounted 
filesystem with ordered data mode.
==============================================================================

Any hints appreciated, like what software needs updating, or shall I 
replace PCI-E card with PCI ?

Thanks,
Tom

