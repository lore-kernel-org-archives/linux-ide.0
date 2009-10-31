From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 14518] New: I/O appears to get stuck on
 certain rsync backup job and system clock halts then
Date: Sat, 31 Oct 2009 00:17:11 -0700
Message-ID: <20091031001711.0d3a8238.akpm@linux-foundation.org>
References: <bug-14518-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40832 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753349AbZJaHRY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Oct 2009 03:17:24 -0400
In-Reply-To: <bug-14518-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin@Lichtvoll.de
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sat, 31 Oct 2009 06:59:07 GMT bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=14518
> 
>            Summary: I/O appears to get stuck on certain rsync backup job
>                     and system clock halts then
>            Product: IO/Storage
>            Version: 2.5
>     Kernel Version: 2.6.31.5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Block Layer
>         AssignedTo: axboe@kernel.dk
>         ReportedBy: Martin@Lichtvoll.de
>         Regression: Yes
> 
> 
> I sorted this to generic block problems, might be an issue with the sata_sil
> driver tough.

Yup, it looks more like an ata issue.

Or it might be that the errors are due to real hardware problems and
triggered not-well-tested code paths in block/scsi/VFS/etc.

Could someone take a look please?


> Happening with and a similar 2.6.31.3 kernel:
> shambhala:~> cat /proc/version
> Linux version 2.6.31.5-tp42-toi-3.0.1-04850-g4eddd0d (martin@shambhala) (gcc
> version 4.3.4 (Debian 4.3.4-5) ) #5 PREEMPT Sun Oct 25 18:39:35 CET 2009
> 
> Yes, the kernel contains TuxOnIce, but I believe thats completely unrelated to
> this issue. I think this is a regression, but since it appears that this does
> not happen on my usual desktop workloads, but it only happened during a rsync
> backup comparison with its original, I am not sure.
> 
> Summery: The machine appeared to got stuck in I/O for three times. Two has been
> accompanied with UDMA CRC errors and thus might be explainable from that.
> Although I believe even in that case the machine should respond to something.
> Why is it that I/O problems with a eSATA drive can make to *complete system*
> unusable even while the internal laptop harddisk is just spinning fine? IMHO on
> a decend operating system this should not happen. On the third occasion there
> have been no errors related to this incident in the log.
> 
> This happened on a ThinkPad T42 with:
> shambhala:~> lspci -nn
> 00:00.0 Host bridge [0600]: Intel Corporation 82855PM Processor to I/O
> Controller [8086:3340] (rev 03)
> 00:01.0 PCI bridge [0604]: Intel Corporation 82855PM Processor to AGP
> Controller [8086:3341] (rev 03)
> 00:1d.0 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 [8086:24c2] (rev 01)
> 00:1d.1 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 [8086:24c4] (rev 01)
> 00:1d.2 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 [8086:24c7] (rev 01)
> 00:1d.7 USB Controller [0c03]: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2
> EHCI Controller [8086:24cd] (rev 01)
> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
> [8086:2448] (rev 81)
> 00:1f.0 ISA bridge [0601]: Intel Corporation 82801DBM (ICH4-M) LPC Interface
> Bridge [8086:24cc] (rev 01)
> 00:1f.1 IDE interface [0101]: Intel Corporation 82801DBM (ICH4-M) IDE
> Controller [8086:24ca] (rev 01)
> 00:1f.3 SMBus [0c05]: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> SMBus Controller [8086:24c3] (rev 01)
> 00:1f.5 Multimedia audio controller [0401]: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller [8086:24c5] (rev 01)
> 00:1f.6 Modem [0703]: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> AC'97 Modem Controller [8086:24c6] (rev 01)
> 01:00.0 VGA compatible controller [0300]: ATI Technologies Inc RV350 [Mobility
> Radeon 9600 M10] [1002:4e50]
> 02:00.0 CardBus bridge [0607]: Texas Instruments PCI4520 PC card Cardbus
> Controller [104c:ac46] (rev 01)
> 02:00.1 CardBus bridge [0607]: Texas Instruments PCI4520 PC card Cardbus
> Controller [104c:ac46] (rev 01)
> 02:01.0 Ethernet controller [0200]: Intel Corporation 82540EP Gigabit Ethernet
> Controller (Mobile) [8086:101e] (rev 03)
> 02:02.0 Network controller [0280]: Intel Corporation PRO/Wireless 2200BG
> [Calexico2] Network Connection [8086:4220] (rev 05)
> 03:00.0 Mass storage controller [0180]: Silicon Image, Inc. SiI 3512
> [SATALink/SATARaid] Serial ATA Controller [1095:3512] (rev 01)
> 
> (the latter is a PCMCIA card I use for accessing my eSATA devices)
> 
> The first two times
> ===================
> 
> First there where problems on a backup. I got UDMA CRC on one harddisk:
> 
> Oct 15 09:37:16 shambhala kernel: ata3: SATA link up 1.5 Gbps (SStatus 113
> SControl 310)
> Oct 15 09:37:16 shambhala kernel: ata3.00: ATA-8: Hitachi HTS545050B9A300,
> PB4OC60G, max UDMA/133
> Oct 15 09:37:16 shambhala kernel: ata3.00: 976773168 sectors, multi 0: LBA48
> NCQ (depth 0/32)
> Oct 15 09:37:16 shambhala kernel: ata3.00: configured for UDMA/100
> Oct 15 09:37:16 shambhala kernel: scsi 2:0:0:0: Direct-Access     ATA     
> Hitachi HTS54505 PB4O PQ: 0 ANSI: 5
> Oct 15 09:37:16 shambhala kernel: sd 2:0:0:0: Attached scsi generic sg2 type 0
> Oct 15 09:37:16 shambhala kernel: sd 2:0:0:0: [sdb] 976773168 512-byte logical
> blocks: (500 GB/465 GiB)
> Oct 15 09:37:16 shambhala kernel: sd 2:0:0:0: [sdb] Write Protect is off
> Oct 15 09:37:16 shambhala kernel: sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> Oct 15 09:37:16 shambhala kernel: sd 2:0:0:0: [sdb] Write cache: enabled, read
> cache: enabled, doesn't support DPO or FUA
> Oct 15 09:37:16 shambhala kernel: sdb: sdb1 sdb2 sdb3
> Oct 15 09:37:16 shambhala kernel: sd 2:0:0:0: [sdb] Attached SCSI disk
> 
> This is my 500 GB 2,5 inch eSATA disk (500 GB). I copied from to 3 3,5 inch
> eSATA disk (1TB).
> 
> Like these:
> Oct 15 09:45:16 shambhala kernel: ata3: drained 32768 bytes to clear DRQ.
> Oct 15 09:45:16 shambhala kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr
> 0x280000 action 0x6 frozen
> Oct 15 09:45:16 shambhala kernel: ata3: SError: { 10B8B BadCRC }
> Oct 15 09:45:16 shambhala kernel: ata3.00: cmd
> 25/00:08:5d:bf:8f/00:01:13:00:00/e0 tag 0 dma 135168 in
> Oct 15 09:45:16 shambhala kernel:         res
> ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
> Oct 15 09:45:16 shambhala kernel: ata3.00: status: { Busy }
> Oct 15 09:45:16 shambhala kernel: ata3.00: error: { ICRC UNC IDNF ABRT }
> Oct 15 09:45:16 shambhala kernel: ata3: hard resetting link
> Oct 15 09:45:17 shambhala kernel: ata3: SATA link up 1.5 Gbps (SStatus 113
> SControl 310)
> Oct 15 09:45:17 shambhala kernel: ata3.00: configured for UDMA/100
> Oct 15 09:45:17 shambhala kernel: ata3: EH complete
> Oct 15 09:46:29 shambhala kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr
> 0x280000 action 0x6 frozen
> Oct 15 09:46:29 shambhala kernel: ata3: SError: { 10B8B BadCRC }
> Oct 15 09:46:29 shambhala kernel: ata3.00: cmd
> 25/00:08:5d:0f:c6/00:01:14:00:00/e0 tag 0 dma 135168 in
> Oct 15 09:46:29 shambhala kernel:         res
> 40/00:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x4 (timeout)
> Oct 15 09:46:29 shambhala kernel: ata3.00: status: { DRDY }
> Oct 15 09:46:29 shambhala kernel: ata3: hard resetting link
> Oct 15 09:46:29 shambhala kernel: ata3: SATA link up 1.5 Gbps (SStatus 113
> SControl 310)
> Oct 15 09:46:29 shambhala kernel: ata3.00: configured for UDMA/100
> Oct 15 09:46:29 shambhala kernel: ata3: EH complete
> Oct 15 09:47:43 shambhala kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr
> 0x280000 action 0x6 frozen
> Oct 15 09:47:43 shambhala kernel: ata3: SError: { 10B8B BadCRC }
> Oct 15 09:47:43 shambhala kernel: ata3.00: cmd
> 25/00:08:5d:9b:f5/00:01:0e:00:00/e0 tag 0 dma 135168 in
> Oct 15 09:47:43 shambhala kernel:         res
> 40/00:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x4 (timeout)
> Oct 15 09:47:43 shambhala kernel: ata3.00: status: { DRDY }
> Oct 15 09:47:43 shambhala kernel: ata3: hard resetting link
> Oct 15 09:47:43 shambhala kernel: ata3: SATA link up 1.5 Gbps (SStatus 113
> SControl 310)
> Oct 15 09:47:43 shambhala kernel: ata3.00: configured for UDMA/100
> Oct 15 09:47:43 shambhala kernel: ata3: EH complete
> Oct 15 09:48:57 shambhala kernel: ata3.00: limiting speed to UDMA/66:PIO4
> Oct 15 09:48:57 shambhala kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr
> 0x280000 action 0x6 frozen
> Oct 15 09:48:57 shambhala kernel: ata3: SError: { 10B8B BadCRC }
> Oct 15 09:48:57 shambhala kernel: ata3.00: cmd
> c8/00:f8:65:4a:0d/00:00:00:00:00/ef tag 0 dma 126976 in
> Oct 15 09:48:57 shambhala kernel:         res
> 40/00:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x4 (timeout)
> Oct 15 09:48:57 shambhala kernel: ata3.00: status: { DRDY }
> 
> I let the backup continue and it finished after a long time. libata reduced DMA
> speeds several times during that backup sessions. I have never seen this before
> when working with eSATA disks. Complete log available on request.
> 
> This might have had hardware related reasons: The Delock eSATA casing seems to
> have become flaky. I had sudden power losses on the harddisks recently. There
> seemed to be contact problems with the power cable at least. I replaced the
> casing and cables a few days ago.
> 
> As this has happened initially - the first time - I had the KDE session locked
> and the machine did not respond to any key press or mouse movement. It did not
> unlock the KDE session and it it not switch to Ctrl-Alt-Fx to switch to a TTY.
> On the second try this happened, I unplugged the PCMCIA eSATA controller and
> the machine suddenly reacted again. Later I found out that the time got stuck.
> The clock was going several hours to late.
> 
> On the second time I let KDE unlocked and it completed the backup after a long
> time.
> 
> Now with the new case for that I updated that backup and all went well this
> time.
> 
> 
> The third time
> ==============
> 
> Then I wanted to make sure that the backup on the last time was correct. Thus I
> dared a:
> 
> shambhala:~> rsync -a -c --acls --xattrs --sparse --hard-links --del -P
> /mnt/amazon-daten/ /mnt/zauberwald-daten/
> sending incremental file list                                                   
> 
> For some hours before going to bed this appeared to work nicely. rsync just
> compared checksums of old and new files.
> 
> Then I went to back and in the morning again my laptop didn't react to
> anything. I have it quite some time - about 30 seconds but it didn't unlock KDE
> nor switch to a TTY.
> 
> As I want to avoid a complete reboot I then unplugged both SATA disks. Nothing.
> Then I removed the PCMCIA SATA card and suddenly the machine was usable again.
> 
> Of cause the rsync complained:
> 
> file has vanished: "/mnt/amazon-daten/VirtualBox-Images/OpenSUSE 11.1.vdi"      
> file has vanished: "/mnt/amazon-daten/VirtualBox-Images/Kubuntu Jaunty
> Template.vdi"                             
> file has vanished: "/mnt/amazon-daten/VirtualBox-Images/Debian Lenny.vdi"       
> file has vanished:
> "/mnt/amazon-daten/VirtualBox-Images/Debian-Etch-Template.vdi"                  
> file has vanished: "/mnt/amazon-daten/VirtualBox-Images/Superkonqi.vdi"         
> file has vanished: "/mnt/amazon-daten/VirtualBox-Images/OpenSUSE 11.1
> Template.vdi"                              
> Spiele/ScummVM Spiele/Indiana Joney - Fate of Atlantis/                         
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)                                                      
> *** Skipping any contents from this failed directory ***                        
> somedirectory                                                                   
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)                                                      
> *** Skipping any contents from this failed directory ***                        
> Spiele/ScummVM Spiele/Monkey Island 1/                                          
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)                                                      
> *** Skipping any contents from this failed directory ***                        
> somedirectory
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)                                                      
> *** Skipping any contents from this failed directory ***                        
> somedirectory
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)                                                      
> *** Skipping any contents from this failed directory ***                        
> somedirectory
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)                                                      
> *** Skipping any contents from this failed directory ***                        
> somedirectory
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)                                                      
> *** Skipping any contents from this failed directory ***
> somedirectory
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)
> *** Skipping any contents from this failed directory ***
> somedirectory
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)
> *** Skipping any contents from this failed directory ***
> somedirectory
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)
> *** Skipping any contents from this failed directory ***
> somedirectory
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)
> *** Skipping any contents from this failed directory ***
> Spiele/ScummVM Spiele/brokensword1/
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)
> *** Skipping any contents from this failed directory ***
> somedirectory
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)
> *** Skipping any contents from this failed directory ***
> somedirectory
> rsync: recv_generator: mkdir "/mnt/zauberwald-daten/somedirectory" failed:
> Read-only file system (30)
> *** Skipping any contents from this failed directory ***
> rsync: readdir("/mnt/zauberwald-daten/VirtualBox-Images"): Input/output error
> (5)
> VirtualBox-Images/Fedora-11.vdi
>        32768   0%    0.00kB/s    0:00:00
> Message from syslogd@shambhala at Oct 31 00:49:52 ...
>  kernel:journal commit I/O error
>   4768080384 100%   65.60MB/s    0:01:09 (xfer#1, to-check=1/61674)
> rsync: read errors mapping "/mnt/amazon-daten/VirtualBox-Images/Fedora-11.vdi":
> Input/output error (5)
> VirtualBox-Images/Kubuntu Jaunty.vdi
>   5098381824 100%   68.16MB/s    0:01:11 (xfer#2, to-check=0/61674)
> rsync: read errors mapping "/mnt/amazon-daten/VirtualBox-Images/Kubuntu
> Jaunty.vdi": Input/output error (5)
> IO error encountered -- skipping file deletion
> rsync: mkstemp "/mnt/zauberwald-daten/VirtualBox-Images/.Fedora-11.vdi.sV8k6c"
> failed: Read-only file system (30)
> rsync: mkstemp "/mnt/zauberwald-daten/VirtualBox-Images/.Kubuntu
> Jaunty.vdi.fEIcS4" failed: Read-only file system (30)
> 
> sent 9870164565 bytes  received 3602 bytes  1441426.53 bytes/sec
> total size is 178703414972  speedup is 18.11
> rsync error: some files/attrs were not transferred (see previous errors) (code
> 23) at main.c(1057) [sender=3.0.6]
> 
> This brought some more UDMA CRC errors into the SMART LOG of my 500 GB eSATA
> drive. Good that this is only an old age attribute. Anyway, both drives are
> rather new and used to work flawlessly up to these incidents. SMART status is
> "PASSED" on both drives and the 1TB 3.5 inch drive completed a long self test
> just fine recently. I will schedule one more test on that drive and also one of
> the 500 GB drive just to make sure, drives are okay.
> 
> I looked into syslog, but this only showed the errors from my unplug and eSATA
> controller removal action. There is not a single sign of an error before that
> incident. Complete log available on request. Or I might just decide to attach
> it right after completing this test.
> 
> The machine appeared to have been completely frozen:
> 
> shambhala:~> date
> Sa 31. Okt 01:14:00 CET 2009
> shambhala:~> /etc/init.d/openntpd stop
> Stopping openntpd: ntpd.
> shambhala:~> ntpdate de.pool.ntp.org
> 31 Oct 07:19:55 ntpdate[21953]: step time server 188.40.77.71 offset
> 21931.103558 sec
> shambhala:~> /etc/init.d/openntpd start
> Starting openntpd: ntpd.
> shambhala:~> date
> Sa 31. Okt 07:20:05 CET 2009
> 
> Yes, I checked the machine this morning, but it still thought it was still in
> the night. 01:14 was just about 30 or 45 minutes after I went to bed. And the
> rsync job went fine for several hours prior to that. KDE session was blanked
> several times but I was always able to unblank it and see that rsync was
> spinning on its checksum verify job. As long as it was running in didn't copy a
> single file so the checksum appeared to be correct.
> 

