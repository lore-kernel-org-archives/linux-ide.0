From: Ric Wheeler <ric@emc.com>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 07:36:30 -0400
Message-ID: <4469B93E.6010201@emc.com>
References: <20060515170006.GA29555@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060606000409010202050907"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:49509 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751787AbWEPLhk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 07:37:40 -0400
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------060606000409010202050907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Jeff Garzik wrote:

>TESTING:
>* Although most drivers by count received few operational changes, the
>common probe path was updated, so all drivers need fresh "yes, it sees
>all my disks" regression testing.
>
>* ahci and sata_sil24 were touched a lot, and so need additional
>testing.
>
>* sata_sil and ata_piix also need healthy re-testing of all basic
>functionality.
>
>
>  
>
I have been running a moderate write workload on this (built using 
linux-2.6.17-rc4 with your patch applied on top).  Last night, I ran on 
a set of clean AHCI based boxes (no bad drives) and got a serious of 
occasional spurious interrupts logged:


May 15 21:24:38 centera kernel: ReiserFS: sdd14: Using r5 hash to sort names
May 15 21:52:44 centera kernel: ata1: spurious interrupt (irq_stat 0x8 
active_tag -84148995 sactive 0x800)
May 15 22:00:02 centera run-crons[26837]: logrotate returned 1
May 15 22:16:00 centera kernel: ata1: spurious interrupt (irq_stat 0x8 
active_tag -84148995 sactive 0x4)
May 15 22:29:14 centera kernel: ata1: spurious interrupt (irq_stat 0x8 
active_tag -84148995 sactive 0x7e007fff)
May 15 22:35:04 centera kernel: ata3: spurious interrupt (irq_stat 0x8 
active_tag -84148995 sactive 0x4fffffff)

Full messages file and lspci below, but note that this hardware has been 
running ahci with this config in production for over a year now.

I have some bad disks that I will insert & try to get some testing on 
later today,

ric









--------------060606000409010202050907
Content-Type: text/plain;
 name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages"

May 15 21:23:15 centera xinetd[5484]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
May 15 21:23:15 centera xinetd[5484]: Started working: 1 available service
May 15 21:23:19 centera kernel: klogd 1.4.1, log source = /proc/kmsg started.
May 15 21:23:19 centera kernel: 
May 15 21:23:19 centera kernel: program smartctl is using a deprecated SCSI ioctl, please convert it to SG_IO
May 15 21:23:19 centera last message repeated 47 times
May 15 21:23:19 centera kernel: ReiserFS: sdb9: found reiserfs format "3.6" with standard journal
May 15 21:23:19 centera kernel: ReiserFS: sdb9: using journaled data mode
May 15 21:23:19 centera kernel: ReiserFS: sdb9: journal params: device sdb9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:23:19 centera kernel: ReiserFS: sdb9: checking transaction log (sdb9)
May 15 21:23:19 centera kernel: ReiserFS: sdb9: Using r5 hash to sort names
May 15 21:23:19 centera kernel: ReiserFS: sdd9: found reiserfs format "3.6" with standard journal
May 15 21:23:19 centera kernel: ReiserFS: sdd9: using journaled data mode
May 15 21:23:19 centera kernel: ReiserFS: sdd9: journal params: device sdd9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:23:19 centera kernel: ReiserFS: sdd9: checking transaction log (sdd9)
May 15 21:23:19 centera kernel: ReiserFS: sdd9: Using r5 hash to sort names
May 15 21:23:19 centera kernel: Adding 1004052k swap on /dev/cstardm9.  Priority:1 extents:1 across:1004052k
May 15 21:23:19 centera kernel: Adding 1004052k swap on /dev/cstardo9.  Priority:1 extents:1 across:1004052k
May 15 21:23:19 centera kernel: microcode: CPU0 updated from revision 0x9 to 0x12, date = 11222004 
May 15 21:23:19 centera kernel: e1000: eth0: e1000_set_tso: TSO is Enabled
May 15 21:23:21 centera kernel: e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
May 15 21:23:28 centera kernel: e1000: eth1: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
May 15 21:23:28 centera kernel: NET: Registered protocol family 17
May 15 21:23:32 centera kernel: device eth0 entered promiscuous mode
May 15 21:23:37 centera kernel: device eth0 left promiscuous mode
May 15 21:23:37 centera kernel: e1000: eth1: e1000_set_tso: TSO is Enabled
May 15 21:23:40 centera kernel: e1000: eth1: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
May 15 21:23:50 centera kernel: device eth0 entered promiscuous mode
May 15 21:23:55 centera kernel: device eth0 left promiscuous mode
May 15 21:23:55 centera ntpd[5715]: ntpd 4.1.1@1.786 Sat Sep 27 05:48:59 UTC 2003 (1)
May 15 21:23:55 centera ntpd[5715]: precision = 11 usec
May 15 21:23:55 centera ntpd[5715]: kernel time discipline status 0040
May 15 21:23:55 centera ntpd[5715]: Can't open /var/lib/ntp/var/run/ntp/ntpd.pid: No such file or directory
May 15 21:23:55 centera ntpd[5715]: Un-parsable frequency in /etc/ntp/drift
May 15 21:24:15 centera kernel: device eth0 entered promiscuous mode
May 15 21:24:20 centera kernel: device eth0 left promiscuous mode
May 15 21:24:22 centera kernel: program smartctl is using a deprecated SCSI ioctl, please convert it to SG_IO
May 15 21:24:22 centera last message repeated 47 times
May 15 21:24:22 centera kernel: ReiserFS: sdc10: found reiserfs format "3.6" with standard journal
May 15 21:24:22 centera kernel: ReiserFS: sdb10: found reiserfs format "3.6" with standard journal
May 15 21:24:22 centera kernel: ReiserFS: sdd10: found reiserfs format "3.6" with standard journal
May 15 21:24:22 centera kernel: ReiserFS: sda10: found reiserfs format "3.6" with standard journal
May 15 21:24:25 centera kernel: ReiserFS: sdc10: using ordered data mode
May 15 21:24:25 centera kernel: ReiserFS: sdc10: journal params: device sdc10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:25 centera kernel: ReiserFS: sdc10: checking transaction log (sdc10)
May 15 21:24:25 centera kernel: ReiserFS: sdc10: Using r5 hash to sort names
May 15 21:24:25 centera kernel: ReiserFS: sdc11: found reiserfs format "3.6" with standard journal
May 15 21:24:27 centera kernel: ReiserFS: sdb10: using ordered data mode
May 15 21:24:27 centera kernel: ReiserFS: sdd10: using ordered data mode
May 15 21:24:27 centera kernel: ReiserFS: sdb10: journal params: device sdb10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:27 centera kernel: ReiserFS: sdb10: checking transaction log (sdb10)
May 15 21:24:27 centera kernel: ReiserFS: sdd10: journal params: device sdd10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:27 centera kernel: ReiserFS: sdd10: checking transaction log (sdd10)
May 15 21:24:27 centera kernel: ReiserFS: sdd10: Using r5 hash to sort names
May 15 21:24:27 centera kernel: ReiserFS: sdb10: Using r5 hash to sort names
May 15 21:24:27 centera kernel: ReiserFS: sda10: using ordered data mode
May 15 21:24:27 centera kernel: ReiserFS: sda10: journal params: device sda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:27 centera kernel: ReiserFS: sda10: checking transaction log (sda10)
May 15 21:24:27 centera kernel: ReiserFS: sda10: Using r5 hash to sort names
May 15 21:24:27 centera kernel: ReiserFS: sdc11: using ordered data mode
May 15 21:24:27 centera kernel: ReiserFS: sdc11: journal params: device sdc11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:27 centera kernel: ReiserFS: sdc11: checking transaction log (sdc11)
May 15 21:24:27 centera kernel: ReiserFS: sdc11: Using r5 hash to sort names
May 15 21:24:27 centera kernel: ReiserFS: sdb11: found reiserfs format "3.6" with standard journal
May 15 21:24:27 centera kernel: ReiserFS: sda11: found reiserfs format "3.6" with standard journal
May 15 21:24:27 centera kernel: ReiserFS: sdd11: found reiserfs format "3.6" with standard journal
May 15 21:24:27 centera kernel: ReiserFS: sdc12: found reiserfs format "3.6" with standard journal
May 15 21:24:29 centera kernel: ReiserFS: sdb11: using ordered data mode
May 15 21:24:30 centera kernel: ReiserFS: sdd11: using ordered data mode
May 15 21:24:30 centera kernel: ReiserFS: sdb11: journal params: device sdb11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:30 centera kernel: ReiserFS: sdb11: checking transaction log (sdb11)
May 15 21:24:30 centera kernel: ReiserFS: sdd11: journal params: device sdd11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:30 centera kernel: ReiserFS: sdd11: checking transaction log (sdd11)
May 15 21:24:30 centera kernel: ReiserFS: sdd11: Using r5 hash to sort names
May 15 21:24:30 centera kernel: ReiserFS: sdb11: Using r5 hash to sort names
May 15 21:24:30 centera kernel: ReiserFS: sdc12: using ordered data mode
May 15 21:24:30 centera kernel: ReiserFS: sdc12: journal params: device sdc12, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:30 centera kernel: ReiserFS: sdc12: checking transaction log (sdc12)
May 15 21:24:30 centera kernel: ReiserFS: sdc12: Using r5 hash to sort names
May 15 21:24:30 centera kernel: ReiserFS: sda11: using ordered data mode
May 15 21:24:30 centera kernel: ReiserFS: sda11: journal params: device sda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:30 centera kernel: ReiserFS: sda11: checking transaction log (sda11)
May 15 21:24:30 centera kernel: ReiserFS: sda11: Using r5 hash to sort names
May 15 21:24:30 centera kernel: ReiserFS: sdb12: found reiserfs format "3.6" with standard journal
May 15 21:24:30 centera kernel: ReiserFS: sda12: found reiserfs format "3.6" with standard journal
May 15 21:24:30 centera kernel: ReiserFS: sdd12: found reiserfs format "3.6" with standard journal
May 15 21:24:30 centera kernel: ReiserFS: sdc13: found reiserfs format "3.6" with standard journal
May 15 21:24:32 centera kernel: ReiserFS: sdb12: using ordered data mode
May 15 21:24:32 centera kernel: ReiserFS: sdb12: journal params: device sdb12, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:32 centera kernel: ReiserFS: sdb12: checking transaction log (sdb12)
May 15 21:24:32 centera kernel: ReiserFS: sdb12: Using r5 hash to sort names
May 15 21:24:32 centera kernel: ReiserFS: sda12: using ordered data mode
May 15 21:24:32 centera kernel: ReiserFS: sda12: journal params: device sda12, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:32 centera kernel: ReiserFS: sda12: checking transaction log (sda12)
May 15 21:24:32 centera kernel: ReiserFS: sdd12: using ordered data mode
May 15 21:24:32 centera kernel: ReiserFS: sdd12: journal params: device sdd12, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:33 centera kernel: ReiserFS: sdd12: checking transaction log (sdd12)
May 15 21:24:33 centera kernel: ReiserFS: sda12: Using r5 hash to sort names
May 15 21:24:33 centera kernel: ReiserFS: sdd12: Using r5 hash to sort names
May 15 21:24:33 centera kernel: ReiserFS: sdc13: using ordered data mode
May 15 21:24:33 centera kernel: ReiserFS: sdc13: journal params: device sdc13, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:33 centera kernel: ReiserFS: sdc13: checking transaction log (sdc13)
May 15 21:24:33 centera kernel: ReiserFS: sdc13: Using r5 hash to sort names
May 15 21:24:33 centera kernel: ReiserFS: sdd13: found reiserfs format "3.6" with standard journal
May 15 21:24:33 centera kernel: ReiserFS: sda13: found reiserfs format "3.6" with standard journal
May 15 21:24:33 centera kernel: ReiserFS: sdc14: found reiserfs format "3.6" with standard journal
May 15 21:24:33 centera kernel: ReiserFS: sdb13: found reiserfs format "3.6" with standard journal
May 15 21:24:35 centera kernel: ReiserFS: sdc14: using ordered data mode
May 15 21:24:35 centera kernel: ReiserFS: sdc14: journal params: device sdc14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:35 centera kernel: ReiserFS: sdc14: checking transaction log (sdc14)
May 15 21:24:36 centera kernel: ReiserFS: sdb13: using ordered data mode
May 15 21:24:36 centera kernel: ReiserFS: sdc14: Using r5 hash to sort names
May 15 21:24:36 centera kernel: ReiserFS: sdb13: journal params: device sdb13, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:36 centera kernel: ReiserFS: sdb13: checking transaction log (sdb13)
May 15 21:24:36 centera kernel: ReiserFS: sda13: using ordered data mode
May 15 21:24:36 centera kernel: ReiserFS: sdb13: Using r5 hash to sort names
May 15 21:24:36 centera kernel: ReiserFS: sda13: journal params: device sda13, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:36 centera kernel: ReiserFS: sda13: checking transaction log (sda13)
May 15 21:24:36 centera kernel: ReiserFS: sdd13: using ordered data mode
May 15 21:24:36 centera kernel: ReiserFS: sdd13: journal params: device sdd13, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:36 centera kernel: ReiserFS: sdd13: checking transaction log (sdd13)
May 15 21:24:36 centera kernel: ReiserFS: sda13: Using r5 hash to sort names
May 15 21:24:36 centera kernel: ReiserFS: sdd13: Using r5 hash to sort names
May 15 21:24:36 centera kernel: ReiserFS: sda14: found reiserfs format "3.6" with standard journal
May 15 21:24:36 centera kernel: ReiserFS: sdb14: found reiserfs format "3.6" with standard journal
May 15 21:24:36 centera kernel: ReiserFS: sdd14: found reiserfs format "3.6" with standard journal
May 15 21:24:38 centera kernel: ReiserFS: sdb14: using ordered data mode
May 15 21:24:38 centera kernel: ReiserFS: sdb14: journal params: device sdb14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:38 centera kernel: ReiserFS: sdb14: checking transaction log (sdb14)
May 15 21:24:38 centera kernel: ReiserFS: sdd14: using ordered data mode
May 15 21:24:38 centera kernel: ReiserFS: sda14: using ordered data mode
May 15 21:24:38 centera kernel: ReiserFS: sdb14: Using r5 hash to sort names
May 15 21:24:38 centera kernel: ReiserFS: sda14: journal params: device sda14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:38 centera kernel: ReiserFS: sda14: checking transaction log (sda14)
May 15 21:24:38 centera kernel: ReiserFS: sdd14: journal params: device sdd14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 15 21:24:38 centera kernel: ReiserFS: sdd14: checking transaction log (sdd14)
May 15 21:24:38 centera kernel: ReiserFS: sda14: Using r5 hash to sort names
May 15 21:24:38 centera kernel: ReiserFS: sdd14: Using r5 hash to sort names
May 15 21:52:44 centera kernel: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x800)
May 15 22:00:02 centera run-crons[26837]: logrotate returned 1
May 15 22:16:00 centera kernel: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x4)
May 15 22:29:14 centera kernel: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x7e007fff)
May 15 22:35:04 centera kernel: ata3: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x4fffffff)
May 15 23:00:01 centera run-crons[18123]: logrotate returned 1
May 16 00:00:01 centera run-crons[12217]: logrotate returned 1
May 16 01:00:01 centera run-crons[6356]: logrotate returned 1
May 16 02:00:02 centera run-crons[487]: logrotate returned 1
May 16 03:00:01 centera run-crons[27086]: logrotate returned 1
May 16 04:00:01 centera run-crons[21110]: logrotate returned 1
May 16 04:15:05 centera logrotate: ALERT exited abnormally with [1]
May 16 05:00:01 centera run-crons[15671]: logrotate returned 1
May 16 06:00:01 centera run-crons[9783]: logrotate returned 1
May 16 07:00:01 centera run-crons[3913]: logrotate returned 1
May 16 08:00:02 centera run-crons[30486]: logrotate returned 1
May 16 09:00:01 centera run-crons[24591]: logrotate returned 1
May 16 10:00:01 centera run-crons[18768]: logrotate returned 1
May 16 11:00:01 centera run-crons[12894]: logrotate returned 1
May 16 12:00:01 centera run-crons[6992]: logrotate returned 1

--------------060606000409010202050907
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

0000:00:00.0 Host bridge: Intel Corporation E7220/E7221 Memory Controller Hub (rev 05)
	Subsystem: Intel Corporation E7220/E7221 Memory Controller Hub
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corporation E7220/E7221 PCI Express Root Port (rev 05) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: d0000000-d02fffff
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [a0] #10 [0141]

0000:00:02.0 VGA compatible controller: Intel Corporation E7221 Integrated Graphics Controller (rev 05) (prog-if 00 [VGA])
	Subsystem: Tyan Computer: Unknown device 5150
	Flags: bus master, fast devsel, latency 0, IRQ 12
	Memory at d0300000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at e000 [size=8]
	Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Memory at d0380000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [d0] Power Management version 2

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Tyan Computer: Unknown device 5150
	Flags: bus master, medium devsel, latency 0, IRQ 3
	I/O ports at e100 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Tyan Computer: Unknown device 5150
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at e200 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Tyan Computer: Unknown device 5150
	Flags: bus master, medium devsel, latency 0, IRQ 7
	I/O ports at e300 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Tyan Computer: Unknown device 5150
	Flags: bus master, medium devsel, latency 0, IRQ 12
	I/O ports at e400 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Tyan Computer: Unknown device 5150
	Flags: bus master, medium devsel, latency 0, IRQ 3
	Memory at d03c0000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
	Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
	Subsystem: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge
	Flags: bus master, medium devsel, latency 0

0000:00:1f.2 IDE interface: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Tyan Computer: Unknown device 5150
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 17
	I/O ports at e900 [size=8]
	I/O ports at ea00 [size=4]
	I/O ports at eb00 [size=8]
	I/O ports at ec00 [size=4]
	I/O ports at ed00 [size=16]
	Memory at d03c3000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
	Subsystem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller
	Flags: medium devsel, IRQ 10
	I/O ports at 0500 [size=32]

0000:01:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d0000000-d00fffff
	Capabilities: [44] #10 [0071]
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.

0000:01:00.1 PIC: Intel Corporation 6700/6702PXH I/OxAPIC Interrupt Controller A (rev 09) (prog-if 20 [IO(X)-APIC])
	Flags: bus master, fast devsel, latency 0
	Memory at d0200000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] #10 [0001]
	Capabilities: [6c] Power Management version 2

0000:01:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: d0100000-d01fffff
	Capabilities: [44] #10 [0071]
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.

0000:01:00.3 PIC: Intel Corporation 6700PXH I/OxAPIC Interrupt Controller B (rev 09) (prog-if 20 [IO(X)-APIC])
	Flags: bus master, fast devsel, latency 0
	Memory at d0201000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] #10 [0001]
	Capabilities: [6c] Power Management version 2

0000:02:06.0 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
	Subsystem: Intel Corporation PRO/1000 MT Dual Port Network Connection
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 17
	Memory at d0000000 (64-bit, non-prefetchable) [size=128K]
	I/O ports at c000 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:02:06.1 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
	Subsystem: Intel Corporation: Unknown device 1179
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
	Memory at d0020000 (64-bit, non-prefetchable) [size=128K]
	I/O ports at c100 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:03:07.0 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
	Subsystem: Intel Corporation PRO/1000 MT Dual Port Network Connection
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
	Memory at d0100000 (64-bit, non-prefetchable) [size=128K]
	I/O ports at d000 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:03:07.1 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet Controller (rev 03)
	Subsystem: Intel Corporation PRO/1000 MT Dual Port Network Connection
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
	Memory at d0120000 (64-bit, non-prefetchable) [size=128K]
	I/O ports at d100 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-


--------------060606000409010202050907--
