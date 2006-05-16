From: Ric Wheeler <ric@emc.com>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 14:29:53 -0400
Message-ID: <446A1A21.80501@emc.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080008040402070506080000"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:26520 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S932502AbWEPSa3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 14:30:29 -0400
In-Reply-To: <4469EEC0.4060907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

This is a multi-part message in MIME format.
--------------080008040402070506080000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:

> J
>
>>
>> Definitely new behavior.  In each case you have irq_stat == 0x8, 
>> which indicates a Set Device Bits FIS has been received.
>>
>
> Yeap, new behavior.  Though, one thing to note is that the original 
> ahci_host_intr() never bothered to report spurious interrupt.  It 
> always returned 1 telling ahci_interrupt() that the interrupt is 
> handled.  But as this is SDB instead of D2H, my guess is that the 
> drive is sending spurious NCQ completions with no new command completed.
>
> Hmm.. Can you try the attached patch and report what the kernel says?
>
> The message reminds me of several things...
>
> * can we make tags int and use -1 for invalid tag?  ATA_TAG_POISON 
> looks horrible when printed.
>
> * it would be nice to have some framework to determine whether the 
> controller is receiving too many consecutive spurious interrupts.  
> Say, 32 irqs in a row without intervening valid interrupts is a good 
> reason to be suspicious about stuck IRQ.  Freezing & resetting will 
> resolve the situation in most cases.
>
> * With NCQ, some drives generate spurious D2H FISes with I bit set as 
> if it were executing non-NCQ commands.  So, regardless of controller, 
> we're likely to see similar problems (but sil24 does all the protocol 
> handling and ignores such FISes by itself).  This can be combined with 
> the above freeze on too many spurious, I guess.

Here is the result of running with your patch applied (on a set of nodes):

c001n01: 0: [  OK  ]
ata3: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
0x2000000f)
ata3: spurious SDB FIS 004040a1:10000000 ap->qc_active=2000000f 
qc_active=2000000f
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0xfffc0)
ata1: spurious SDB FIS 004040a1:00000020 ap->qc_active=000fffc0 
qc_active=000fffc0
ata2: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
0x7fffff3f)
ata2: spurious SDB FIS 004040a1:00000080 ap->qc_active=7fffff3f 
qc_active=7fffff3f
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
0x7fffff9f)
ata1: spurious SDB FIS 004040a1:00000040 ap->qc_active=7fffff9f 
qc_active=7fffff9f
c001n03: 0: [  OK  ]
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
0x7ffe7fff)
ata1: spurious SDB FIS 004040a1:00010000 ap->qc_active=7ffe7fff 
qc_active=7ffe7fff
c001n04: 0: [  OK  ]
ata3: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x31)
ata3: spurious SDB FIS 004040a1:00000008 ap->qc_active=00000031 
qc_active=00000031
ata3: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
0x7fff800f)
ata3: spurious SDB FIS 004040a1:00004000 ap->qc_active=7fff800f 
qc_active=7fff800f
c001n06: 1: [ FAIL ]
c001n07: 0: [  OK  ]
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
0x7ffffcff)
ata1: spurious SDB FIS 004040a1:00000200 ap->qc_active=7ffffcff 
qc_active=7ffffcff
c001n08: 0: [  OK  ]
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
0x4fffffff)
ata1: spurious SDB FIS 004040a1:20000000 ap->qc_active=4fffffff 
qc_active=4fffffff


Attached is one (pretty uninteresting) whole log,

ric








--------------080008040402070506080000
Content-Type: text/plain;
 name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages"

May 16 16:27:10 centera exiting on signal 15
May 16 16:28:55 centera syslogd 1.4.1: restart.
May 16 16:28:55 centera xinetd[5605]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
May 16 16:28:55 centera xinetd[5605]: Started working: 1 available service
May 16 16:29:00 centera kernel: klogd 1.4.1, log source = /proc/kmsg started.
May 16 16:29:00 centera kernel: 
May 16 16:29:00 centera kernel: program smartctl is using a deprecated SCSI ioctl, please convert it to SG_IO
May 16 16:29:00 centera last message repeated 47 times
May 16 16:29:00 centera kernel: ReiserFS: sdb9: found reiserfs format "3.6" with standard journal
May 16 16:29:00 centera kernel: ReiserFS: sdb9: using journaled data mode
May 16 16:29:00 centera kernel: ReiserFS: sdb9: journal params: device sdb9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:29:00 centera kernel: ReiserFS: sdb9: checking transaction log (sdb9)
May 16 16:29:00 centera kernel: ReiserFS: sdb9: Using r5 hash to sort names
May 16 16:29:00 centera kernel: ReiserFS: sdd9: found reiserfs format "3.6" with standard journal
May 16 16:29:00 centera kernel: ReiserFS: sdd9: using journaled data mode
May 16 16:29:00 centera kernel: ReiserFS: sdd9: journal params: device sdd9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:29:00 centera kernel: ReiserFS: sdd9: checking transaction log (sdd9)
May 16 16:29:00 centera kernel: ReiserFS: sdd9: Using r5 hash to sort names
May 16 16:29:00 centera kernel: Adding 1004052k swap on /dev/cstardm9.  Priority:1 extents:1 across:1004052k
May 16 16:29:00 centera kernel: Adding 1004052k swap on /dev/cstardo9.  Priority:1 extents:1 across:1004052k
May 16 16:29:00 centera kernel: e1000: eth2: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
May 16 16:29:00 centera kernel: e1000: eth2: e1000_set_tso: TSO is Enabled
May 16 16:29:00 centera kernel: microcode: CPU0 updated from revision 0x9 to 0x12, date = 11222004 
May 16 16:29:00 centera kernel: e1000: eth2: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
May 16 16:29:00 centera kernel: e1000: eth0: e1000_set_tso: TSO is Enabled
May 16 16:29:01 centera kernel: e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
May 16 16:29:08 centera kernel: e1000: eth1: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
May 16 16:29:08 centera kernel: NET: Registered protocol family 17
May 16 16:29:11 centera kernel: device eth0 entered promiscuous mode
May 16 16:29:16 centera kernel: device eth0 left promiscuous mode
May 16 16:29:16 centera kernel: e1000: eth1: e1000_set_tso: TSO is Enabled
May 16 16:29:19 centera kernel: e1000: eth1: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
May 16 16:29:30 centera ntpd[5859]: ntpd 4.1.1@1.786 Sat Sep 27 05:48:59 UTC 2003 (1)
May 16 16:29:30 centera ntpd[5859]: precision = 8 usec
May 16 16:29:30 centera ntpd[5859]: kernel time discipline status 0040
May 16 16:29:30 centera ntpd[5859]: Can't open /var/lib/ntp/var/run/ntp/ntpd.pid: No such file or directory
May 16 16:29:30 centera ntpd[5859]: frequency initialized 2.597 from /etc/ntp/drift
May 16 16:30:01 centera kernel: program smartctl is using a deprecated SCSI ioctl, please convert it to SG_IO
May 16 16:30:01 centera last message repeated 47 times
May 16 16:30:01 centera kernel: ReiserFS: sdb10: found reiserfs format "3.6" with standard journal
May 16 16:30:01 centera kernel: ReiserFS: sdc10: found reiserfs format "3.6" with standard journal
May 16 16:30:01 centera kernel: ReiserFS: sdd10: found reiserfs format "3.6" with standard journal
May 16 16:30:01 centera kernel: ReiserFS: sda10: found reiserfs format "3.6" with standard journal
May 16 16:30:03 centera kernel: ReiserFS: sdd10: using ordered data mode
May 16 16:30:03 centera kernel: ReiserFS: sdd10: journal params: device sdd10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:03 centera kernel: ReiserFS: sdd10: checking transaction log (sdd10)
May 16 16:30:03 centera kernel: ReiserFS: sdd10: Using r5 hash to sort names
May 16 16:30:03 centera kernel: ReiserFS: sda10: using ordered data mode
May 16 16:30:04 centera kernel: ReiserFS: sda10: journal params: device sda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:04 centera kernel: ReiserFS: sda10: checking transaction log (sda10)
May 16 16:30:04 centera kernel: ReiserFS: sda10: Using r5 hash to sort names
May 16 16:30:04 centera kernel: ReiserFS: sdb10: using ordered data mode
May 16 16:30:04 centera kernel: ReiserFS: sdb10: journal params: device sdb10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:04 centera kernel: ReiserFS: sdb10: checking transaction log (sdb10)
May 16 16:30:04 centera kernel: ReiserFS: sdb10: Using r5 hash to sort names
May 16 16:30:04 centera kernel: ReiserFS: sdc10: using ordered data mode
May 16 16:30:04 centera kernel: ReiserFS: sdc10: journal params: device sdc10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:04 centera kernel: ReiserFS: sdc10: checking transaction log (sdc10)
May 16 16:30:04 centera kernel: ReiserFS: sdc10: Using r5 hash to sort names
May 16 16:30:04 centera kernel: ReiserFS: sda11: found reiserfs format "3.6" with standard journal
May 16 16:30:04 centera kernel: ReiserFS: sdb11: found reiserfs format "3.6" with standard journal
May 16 16:30:04 centera kernel: ReiserFS: sdc11: found reiserfs format "3.6" with standard journal
May 16 16:30:04 centera kernel: ReiserFS: sdd11: found reiserfs format "3.6" with standard journal
May 16 16:30:06 centera kernel: ReiserFS: sda11: using ordered data mode
May 16 16:30:06 centera kernel: ReiserFS: sda11: journal params: device sda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:06 centera kernel: ReiserFS: sda11: checking transaction log (sda11)
May 16 16:30:06 centera kernel: ReiserFS: sdc11: using ordered data mode
May 16 16:30:06 centera kernel: ReiserFS: sda11: Using r5 hash to sort names
May 16 16:30:06 centera kernel: ReiserFS: sdc11: journal params: device sdc11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:06 centera kernel: ReiserFS: sdc11: checking transaction log (sdc11)
May 16 16:30:06 centera kernel: ReiserFS: sdb11: using ordered data mode
May 16 16:30:06 centera kernel: ReiserFS: sdc11: Using r5 hash to sort names
May 16 16:30:06 centera kernel: ReiserFS: sdb11: journal params: device sdb11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:06 centera kernel: ReiserFS: sdb11: checking transaction log (sdb11)
May 16 16:30:06 centera kernel: ReiserFS: sdb11: Using r5 hash to sort names
May 16 16:30:06 centera kernel: ReiserFS: sdd11: using ordered data mode
May 16 16:30:06 centera kernel: ReiserFS: sdd11: journal params: device sdd11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:06 centera kernel: ReiserFS: sdd11: checking transaction log (sdd11)
May 16 16:30:07 centera kernel: ReiserFS: sdc12: found reiserfs format "3.6" with standard journal
May 16 16:30:07 centera kernel: ReiserFS: sdb12: found reiserfs format "3.6" with standard journal
May 16 16:30:07 centera kernel: ReiserFS: sda12: found reiserfs format "3.6" with standard journal
May 16 16:30:07 centera kernel: ReiserFS: sdd11: Using r5 hash to sort names
May 16 16:30:09 centera kernel: ReiserFS: sda12: using ordered data mode
May 16 16:30:09 centera kernel: ReiserFS: sda12: journal params: device sda12, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:09 centera kernel: ReiserFS: sda12: checking transaction log (sda12)
May 16 16:30:09 centera kernel: ReiserFS: sda12: Using r5 hash to sort names
May 16 16:30:09 centera kernel: ReiserFS: sdb12: using ordered data mode
May 16 16:30:09 centera kernel: ReiserFS: sdb12: journal params: device sdb12, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:09 centera kernel: ReiserFS: sdb12: checking transaction log (sdb12)
May 16 16:30:09 centera kernel: ReiserFS: sdc12: using ordered data mode
May 16 16:30:09 centera kernel: ReiserFS: sdc12: journal params: device sdc12, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:09 centera kernel: ReiserFS: sdc12: checking transaction log (sdc12)
May 16 16:30:09 centera kernel: ReiserFS: sdb12: Using r5 hash to sort names
May 16 16:30:09 centera kernel: ReiserFS: sdc12: Using r5 hash to sort names
May 16 16:30:09 centera kernel: ReiserFS: sdd12: found reiserfs format "3.6" with standard journal
May 16 16:30:09 centera kernel: ReiserFS: sda13: found reiserfs format "3.6" with standard journal
May 16 16:30:09 centera kernel: ReiserFS: sdc13: found reiserfs format "3.6" with standard journal
May 16 16:30:09 centera kernel: ReiserFS: sdb13: found reiserfs format "3.6" with standard journal
May 16 16:30:11 centera kernel: ReiserFS: sdd12: using ordered data mode
May 16 16:30:11 centera kernel: ReiserFS: sdd12: journal params: device sdd12, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:11 centera kernel: ReiserFS: sdd12: checking transaction log (sdd12)
May 16 16:30:11 centera kernel: ReiserFS: sdd12: Using r5 hash to sort names
May 16 16:30:11 centera kernel: ReiserFS: sdb13: using ordered data mode
May 16 16:30:12 centera kernel: ReiserFS: sdb13: journal params: device sdb13, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:12 centera kernel: ReiserFS: sdb13: checking transaction log (sdb13)
May 16 16:30:12 centera kernel: ReiserFS: sdb13: Using r5 hash to sort names
May 16 16:30:12 centera kernel: ReiserFS: sda13: using ordered data mode
May 16 16:30:12 centera kernel: ReiserFS: sda13: journal params: device sda13, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:12 centera kernel: ReiserFS: sda13: checking transaction log (sda13)
May 16 16:30:12 centera kernel: ReiserFS: sda13: Using r5 hash to sort names
May 16 16:30:12 centera kernel: ReiserFS: sdc13: using ordered data mode
May 16 16:30:12 centera kernel: ReiserFS: sdc13: journal params: device sdc13, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:12 centera kernel: ReiserFS: sdc13: checking transaction log (sdc13)
May 16 16:30:12 centera kernel: ReiserFS: sdc13: Using r5 hash to sort names
May 16 16:30:12 centera kernel: ReiserFS: sdd13: found reiserfs format "3.6" with standard journal
May 16 16:30:12 centera kernel: ReiserFS: sdb14: found reiserfs format "3.6" with standard journal
May 16 16:30:12 centera kernel: ReiserFS: sda14: found reiserfs format "3.6" with standard journal
May 16 16:30:12 centera kernel: ReiserFS: sdc14: found reiserfs format "3.6" with standard journal
May 16 16:30:15 centera kernel: ReiserFS: sdb14: using ordered data mode
May 16 16:30:15 centera kernel: ReiserFS: sdd13: using ordered data mode
May 16 16:30:15 centera kernel: ReiserFS: sdd13: journal params: device sdd13, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:15 centera kernel: ReiserFS: sdd13: checking transaction log (sdd13)
May 16 16:30:15 centera kernel: ReiserFS: sdb14: journal params: device sdb14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:15 centera kernel: ReiserFS: sdb14: checking transaction log (sdb14)
May 16 16:30:15 centera kernel: ReiserFS: sdd13: Using r5 hash to sort names
May 16 16:30:15 centera kernel: ReiserFS: sdb14: Using r5 hash to sort names
May 16 16:30:15 centera kernel: ReiserFS: sda14: using ordered data mode
May 16 16:30:15 centera kernel: ReiserFS: sda14: journal params: device sda14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:15 centera kernel: ReiserFS: sda14: checking transaction log (sda14)
May 16 16:30:15 centera kernel: ReiserFS: sda14: Using r5 hash to sort names
May 16 16:30:15 centera kernel: ReiserFS: sdc14: using ordered data mode
May 16 16:30:15 centera kernel: ReiserFS: sdc14: journal params: device sdc14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:15 centera kernel: ReiserFS: sdc14: checking transaction log (sdc14)
May 16 16:30:15 centera kernel: ReiserFS: sdc14: Using r5 hash to sort names
May 16 16:30:15 centera kernel: ReiserFS: sdd14: found reiserfs format "3.6" with standard journal
May 16 16:30:17 centera kernel: ReiserFS: sdd14: using ordered data mode
May 16 16:30:17 centera kernel: ReiserFS: sdd14: journal params: device sdd14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
May 16 16:30:17 centera kernel: ReiserFS: sdd14: checking transaction log (sdd14)
May 16 16:30:17 centera kernel: ReiserFS: sdd14: Using r5 hash to sort names
May 16 17:00:02 centera run-crons[19634]: logrotate returned 1
May 16 17:16:57 centera kernel: ata3: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x2000000f)
May 16 17:16:57 centera kernel: ata3: spurious SDB FIS 004040a1:10000000 ap->qc_active=2000000f qc_active=2000000f
May 16 17:21:36 centera kernel: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0xfffc0)
May 16 17:21:36 centera kernel: ata1: spurious SDB FIS 004040a1:00000020 ap->qc_active=000fffc0 qc_active=000fffc0
May 16 17:38:45 centera kernel: ata2: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x7fffff3f)
May 16 17:38:45 centera kernel: ata2: spurious SDB FIS 004040a1:00000080 ap->qc_active=7fffff3f qc_active=7fffff3f
May 16 17:59:52 centera kernel: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x7fffff9f)
May 16 17:59:52 centera kernel: ata1: spurious SDB FIS 004040a1:00000040 ap->qc_active=7fffff9f qc_active=7fffff9f
May 16 18:00:04 centera run-crons[10734]: logrotate returned 1
May 16 19:00:02 centera run-crons[5306]: logrotate returned 1

--------------080008040402070506080000--
