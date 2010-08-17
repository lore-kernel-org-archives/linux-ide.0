From: kenneth johansson <ken@kenjo.org>
Subject: promise sataII 150 TX4 issue
Date: Tue, 17 Aug 2010 23:39:32 +0000 (UTC)
Message-ID: <i4f6jk$969$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41217 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912Ab0HQXjl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2010 19:39:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1OlVkq-0003B6-F7
	for linux-ide@vger.kernel.org; Wed, 18 Aug 2010 01:39:40 +0200
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 18 Aug 2010 01:39:40 +0200
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 18 Aug 2010 01:39:40 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

00:0d.0 Mass storage controller: Promise Technology, Inc. PDC20518/
PDC40518 (SATAII 150 TX4) (rev 02)

I have a raid5 with 3 disks in and have started so see some weired
problems.First I thought it was the disk since it was always the same but 
after changing the disk I now have the same problems but another disk so 
I'm starting to suspect a driver issue. 

The only disk I have in the system is connected to this pci card and the 
problem is always with the disk named sda regardless if it is connected 
to the first sata port or the second and first is empty.
I have switch power cables and sata cables around but problem is not 
moving from sda. 

problem seen on kernel version vmlinuz-2.6.35,vmlinuz-2.6.33.3. was 
running vmlinuz-2.6.28.7 for about a year before that without any problem.

Now it took about two month before sda got kicked out of the raid on 
2.6.33.3 but 2.6.35 have not lasted more than a few days.

-------------------------------------------
Aug 15 20:27:22 amd kernel: [171585.020040] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x180000 action 0x6 frozen
Aug 15 20:29:15 amd kernel: [171585.020080] ata1: SError: { 10B8B Dispar }
Aug 15 20:29:15 amd kernel: [171585.020100] ata1.00: failed command: WRITE DMA EXT
Aug 15 20:29:15 amd kernel: [171585.020125] ata1.00: cmd 35/00:f8:3f:bb:a1/00:03:73:00:00/e0 tag 0 dma 520192 out
Aug 15 20:29:15 amd kernel: [171585.020127]          res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Aug 15 20:29:15 amd kernel: [171585.020184] ata1.00: status: { DRDY }
Aug 15 20:29:15 amd kernel: [171585.020210] ata1: hard resetting link
Aug 15 20:29:15 amd kernel: [171590.570096] ata1: link is slow to respond, please be patient (ready=-19)
Aug 15 20:29:15 amd kernel: [171595.070022] ata1: SRST failed (errno=-16)
Aug 15 20:29:15 amd kernel: [171595.070053] ata1: hard resetting link
Aug 15 20:29:15 amd kernel: [171600.620036] ata1: link is slow to respond, please be patient (ready=-19)
Aug 15 20:29:15 amd kernel: [171605.120020] ata1: SRST failed (errno=-16)
Aug 15 20:29:15 amd kernel: [171605.120052] ata1: hard resetting link
Aug 15 20:29:15 amd kernel: [171610.670019] ata1: link is slow to respond, please be patient (ready=-19)
Aug 15 20:29:15 amd kernel: [171640.130042] ata1: SRST failed (errno=-16)
Aug 15 20:29:15 amd kernel: [171640.130070] ata1: limiting SATA link speed to 1.5 Gbps
Aug 15 20:29:15 amd kernel: [171640.130094] ata1: hard resetting link
Aug 15 20:29:15 amd kernel: [171641.900021] ata1: SRST failed (errno=-19)
Aug 15 20:29:15 amd kernel: [171641.900048] ata1: reset failed, giving up
Aug 15 20:29:15 amd kernel: [171641.900067] ata1.00: disabled
------------------------------------------------------------
Aug 13 06:47:10 amd kernel: [451742.020192] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 13 06:52:11 amd kernel: [451742.020225] ata2.00: failed command: SMART
Aug 13 06:52:11 amd kernel: [451742.020249] ata2.00: cmd b0/d0:01:00:4f:c2/00:00:00:00:00/00 tag 0 pio 512 in
Aug 13 06:52:11 amd kernel: [451742.020307] ata2.00: status: { DRDY }
Aug 13 06:52:11 amd kernel: [451742.020333] ata2: hard resetting link
Aug 13 06:52:11 amd kernel: [451747.570019] ata2: link is slow to respond, please be patient (ready=-19)
Aug 13 06:52:11 amd kernel: [451752.070025] ata2: SRST failed (errno=-16)
Aug 13 06:52:11 amd kernel: [451752.070057] ata2: hard resetting link
Aug 13 06:52:11 amd kernel: [451757.620032] ata2: link is slow to respond, please be patient (ready=-19)
Aug 13 06:52:11 amd kernel: [451762.120047] ata2: SRST failed (errno=-16)
Aug 13 06:52:11 amd kernel: [451762.120078] ata2: hard resetting link
Aug 13 06:52:11 amd kernel: [451767.670022] ata2: link is slow to respond, please be patient (ready=-19)
Aug 13 06:52:11 amd kernel: [451797.130022] ata2: SRST failed (errno=-16)
Aug 13 06:52:11 amd kernel: [451797.130051] ata2: limiting SATA link speed to 1.5 Gbps
Aug 13 06:52:11 amd kernel: [451797.130075] ata2: hard resetting link
Aug 13 06:52:11 amd kernel: [451802.140038] ata2: SRST failed (errno=-16)
Aug 13 06:52:11 amd kernel: [451802.140064] ata2: reset failed, giving up
Aug 13 06:52:11 amd kernel: [451802.140084] ata2.00: disabled
------------------------------------------

Aug 18 00:02:38 amd kernel: [181709.050002] ata2: drained 65536 bytes to clear DRQ.
Aug 18 00:04:34 amd kernel: [181709.211538] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
Aug 18 00:04:34 amd kernel: [181709.211577] ata2.00: failed command: READ DMA
Aug 18 00:04:34 amd kernel: [181709.211602] ata2.00: cmd c8/00:08:3e:0c:86/00:00:00:00:00/e0 tag 0 dma 4096 in
Aug 18 00:04:34 amd kernel: [181709.211604]          res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Aug 18 00:04:34 amd kernel: [181709.211660] ata2.00: status: { DRDY }
Aug 18 00:04:34 amd kernel: [181709.211686] ata2: hard resetting link
Aug 18 00:04:34 amd kernel: [181714.760018] ata2: link is slow to respond, please be patient (ready=-19)
Aug 18 00:04:34 amd kernel: [181719.260023] ata2: SRST failed (errno=-16)
Aug 18 00:04:34 amd kernel: [181719.260055] ata2: hard resetting link
Aug 18 00:04:34 amd kernel: [181724.810018] ata2: link is slow to respond, please be patient (ready=-19)
Aug 18 00:04:34 amd kernel: [181729.310019] ata2: SRST failed (errno=-16)
Aug 18 00:04:34 amd kernel: [181729.310050] ata2: hard resetting link
Aug 18 00:04:34 amd kernel: [181734.860018] ata2: link is slow to respond, please be patient (ready=-19)
Aug 18 00:04:34 amd kernel: [181764.320021] ata2: SRST failed (errno=-16)
Aug 18 00:04:34 amd kernel: [181764.320078] ata2: limiting SATA link speed to 1.5 Gbps
Aug 18 00:04:34 amd kernel: [181764.320086] ata2: hard resetting link
Aug 18 00:04:34 amd kernel: [181769.330021] ata2: SRST failed (errno=-16)
Aug 18 00:04:34 amd kernel: [181769.330076] ata2: reset failed, giving up
Aug 18 00:04:34 amd kernel: [181769.330122] ata2.00: disabled
Aug 18 00:04:34 amd kernel: [181769.330130] ata2.00: device reported invalid CHS sector 0
Aug 18 00:04:34 amd kernel: [181769.330147] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen t4
Aug 18 00:04:34 amd kernel: [181769.330203] ata2: hotplug_status 0x20
Aug 18 00:04:34 amd kernel: [181769.330260] ata2: hard resetting link
Aug 18 00:04:34 amd kernel: [181775.280018] ata2: link is slow to respond, please be patient (ready=-19)
Aug 18 00:04:35 amd kernel: [181779.360019] ata2: SRST failed (errno=-16)
Aug 18 00:04:35 amd kernel: [181779.360070] ata2: hard resetting link
Aug 18 00:04:35 amd kernel: [181785.310016] ata2: link is slow to respond, please be patient (ready=-19)
Aug 18 00:04:35 amd kernel: [181789.390019] ata2: SRST failed (errno=-16)
Aug 18 00:04:35 amd kernel: [181789.390070] ata2: hard resetting link
Aug 18 00:04:37 amd kernel: [181824.440036] ata2: SRST failed (errno=-16)
Aug 18 00:04:37 amd kernel: [181824.440093] ata2: limiting SATA link speed to 1.5 Gbps
Aug 18 00:04:37 amd kernel: [181824.440102] ata2: hard resetting link
Aug 18 00:04:37 amd kernel: [181825.350047] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Aug 18 00:04:37 amd kernel: [181825.397682] ata2.00: ATA-8: ST31000333AS, SD35, max UDMA/133
Aug 18 00:04:37 amd kernel: [181825.397688] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Aug 18 00:04:37 amd kernel: [181825.477659] ata2.00: configured for UDMA/133
Aug 18 00:04:37 amd kernel: [181825.477683] sd 1:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Aug 18 00:04:37 amd kernel: [181825.477689] sd 1:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
Aug 18 00:04:37 amd kernel: [181825.477695] Descriptor sense data with sense descriptors (in hex):
Aug 18 00:04:37 amd kernel: [181825.477698]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Aug 18 00:04:37 amd kernel: [181825.477708]         00 00 00 00 
Aug 18 00:04:37 amd kernel: [181825.477712] sd 1:0:0:0: [sda] Add. Sense: No additional sense information
Aug 18 00:04:37 amd kernel: [181825.477718] sd 1:0:0:0: [sda] CDB: Read(10): 28 00 00 86 0c 3e 00 00 08 00
Aug 18 00:04:37 amd kernel: [181825.477727] end_request: I/O error, dev sda, sector 8784958
Aug 18 00:04:37 amd kernel: [181825.477799] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.477851] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.477901] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.477949] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.477997] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478045] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478092] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478140] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478195] ata2: EH complete
Aug 18 00:04:37 amd kernel: [181825.478212] sd 1:0:0:0: [sda] Unhandled error code
Aug 18 00:04:37 amd kernel: [181825.478215] sd 1:0:0:0: [sda] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
Aug 18 00:04:37 amd kernel: [181825.478220] sd 1:0:0:0: [sda] CDB: Read(10): 28 00 74 4c a3 3f 00 00 80 00
Aug 18 00:04:37 amd kernel: [181825.478228] end_request: I/O error, dev sda, sector 1951179583
Aug 18 00:04:37 amd kernel: [181825.478278] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478325] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478372] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478418] end_request: I/O error, dev sda, sector 20547006
Aug 18 00:04:37 amd kernel: [181825.478465] md: super_written gets error=-5, uptodate=0
Aug 18 00:04:37 amd kernel: [181825.478471] md/raid:md2: Disk failure on sda2, disabling device.
Aug 18 00:04:37 amd kernel: [181825.478473] <1>md/raid:md2: Operation continuing on 2 devices.
Aug 18 00:04:37 amd kernel: [181825.478573] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478619] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478665] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478712] end_request: I/O error, dev sda, sector 1953519935
Aug 18 00:04:37 amd kernel: [181825.478758] md: super_written gets error=-5, uptodate=0
Aug 18 00:04:37 amd kernel: [181825.478762] md/raid:md3: Disk failure on sda3, disabling device.
Aug 18 00:04:37 amd kernel: [181825.478764] <1>md/raid:md3: Operation continuing on 2 devices.
Aug 18 00:04:37 amd kernel: [181825.478870] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478920] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.478970] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.479018] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.479067] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.479115] sd 1:0:0:0: rejecting I/O to offline device
Aug 18 00:04:37 amd kernel: [181825.479173] ata2.00: detaching (SCSI 1:0:0:0)



