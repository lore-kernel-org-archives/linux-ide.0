From: Jonas Lundgren <jonas@local.se>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Wed, 29 Nov 2006 08:14:56 +0100
Message-ID: <456D3370.5050003@local.se>
References: <456CB72A.3010004@local.se> <456CDB06.40806@gmail.com>
Reply-To: jonas@local.se
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep04.bredband.com ([195.54.107.79]:14817 "EHLO
	mxfep04.bredband.com") by vger.kernel.org with ESMTP
	id S934190AbWK2HPK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Nov 2006 02:15:10 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep04.bredband.com with ESMTP
          id <20061129071508.TWWP29239.mxfep04.bredband.com@ironport2.bredband.com>
          for <linux-ide@vger.kernel.org>; Wed, 29 Nov 2006 08:15:08 +0100
In-Reply-To: <456CDB06.40806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org



Tejun Heo wrote:
> Jonas Lundgren wrote:
> [--snip--]
>> Also, it doesn't matter if I enable AHCI in the BIOS (But with AHCI
>> enabled the disks spin down/power down when I boot, just to power up
>> again a few seconds after. The boot progress freezes until the disks
>> have spun up again. (This happens when the kernel probes the sata
>> controller ports at bootup, the disks spin down at the same time, but
>> spin up one by one as they're getting probed))
> 
> Likely fix is pending for this problem.
> 
>> I've tried changing I/O scheduler, only noticable diffrence is when I
>> use "noop". Then I get like 20mb/sec write instead of 4mb/sec. I have no
>> idea why this is :P
>>
>> Example of what I mean with crappy performance:
>> dd if=/dev/zero of=test232 bs=1M count=100; time sync
>> 100+0 records in
>> 100+0 records out
>> 104857600 bytes (105 MB) copied, 0.130424 s, 804 MB/s
>> real 0m21.104s
>> user 0m0.000s
>> sys 0m0.011s
>>
>> 21 seconds to do a seq write of 100mb.. And during this time ALL other
>> disk IO gets starved, I can't do anything that uses disk IO for the
>> duration.. (not even `ls`)
> 
> What does the kernel say during this writing?  Can you post the result
> of the following?
> 
> 1. reboot
> 2. dmesg -c
> 3. time dd if=/dev/zero.. blah
> 4. dmesg
> 
> Also, does 'mount -o remount,barrier=0 /' change anything?

I will post this info as soon as I can "reproduce" the error.

> 
>> Yet, a hdparm shows a decent read
>> hdparm -tT /dev/md4
>> /dev/md4:
>> Timing cached reads: 8060 MB in 1.99 seconds = 4042.19 MB/sec
>> Timing buffered disk reads: 400 MB in 3.00 seconds = 133.28 MB/sec
>>
>> dd if=1GBzeroFile of=/dev/null bs=1M count=1000
>> 1000+0 records in
>> 1000+0 records out
>> 1048576000 bytes (1.0 GB) copied, 11.4335 s, 91.7 MB/s
>>
>> This is the cpu usage stats I get from top when running the dd write:
>> Cpu0 : 0.0%us, 0.0%sy, 0.0%ni, 0.0%id, 99.0%wa, 0.5%hi, 0.5%si, 0.0%st
>> Cpu1 : 0.0%us, 0.0%sy, 0.0%ni,100.0%id, 0.0%wa, 0.0%hi, 0.0%si, 0.0%st
>>
>> Pretty crappy read speeds compared to what I got on my previous mobo
>> (around 140mb/sec), but still alot better than the 4mb/sec I get when
>> writing..
> 
> Which controller did you use on your previous mobo?  If you're using
> ata_piix and hook two hard drives as primary and secondary on the same
> channel, some level of performance degradation is expected.  ata_piix
> can only issue command to only one of the two drives at once.  Is the
> read performance still bad in ahci mode?

Atm I run the ICH8 SATA ports in AHCI mode with "IDE bus master"(To be
honest I don't really know what this option does, no info about it in
the BIOS nor the mobo manual) turned off in BIOS. The drives are
connected to port 1, 3, 6 and 8 (raptor+raptor on 1+3, and WD 250G + WD
250G (also a raid0) on ports 6+8)

> 
> [--snip--]
>> Dmesg output from the error(s): (sda and sdb are 2 * 74GB raptor SATA
>> drives in a Linux software raid0)
>>
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata1.00: (BMDMA stat 0x20)
>> ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
> 
> This might be a missed interrupt.  It's a write.  DMA engine is done
> finishing transferring all data.  Device is ready for the next command
> but the interrupt has never arrived.
> 
>> ata1: port is slow to respond, please be patient
>> ata1: port failed to respond (30 secs)
>> ata1: soft resetting port
>> ATA: abnormal status 0xD0 on port 0xFA07
>> ATA: abnormal status 0xD0 on port 0xFA07
>> ATA: abnormal status 0xD0 on port 0xFA07
>> ATA: abnormal status 0xD0 on port 0xFA07
>> ATA: abnormal status 0xD0 on port 0xFA07
>> ATA: abnormal status 0xD0 on port 0xFA07
>> ata1.00: qc timeout (cmd 0xec)
>> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> ata1.00: revalidation failed (errno=-5)
>> ata1: failed to recover some devices, retrying in 5 secs
> 
> But this is weird.  If it were a missed interrupt, softreset should have
> recovered it instantly.  Something fishy is going on.
> 
> [--snip--]
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata1.00: (BMDMA stat 0x21)
>> ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
> 
> Same thing for read.
> 
>> ata1: port is slow to respond, please be patient
>> ata1: port failed to respond (30 secs)
> 
> Again, pre-reset wait times out.  Weird.
> 
>> ata1: soft resetting port
>> ata1.00: configured for UDMA/100
>> ata1: EH complete
> [--snip--]
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata1.00: (BMDMA stat 0x21)
>> ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
> 
> Again, for read.
> 
>> Most of the time when I get these errors the system will recover after
>> anything from 10 seconds to 10 minutes of unresponsiveness (no disk
>> I/O), and sometimes hang.
> 
> Yeap, libata needs stricter timing constraints for recovery.  That's
> high on to-do list.
> 
>> IF the system does recover, I start getting
>> the extremly low disk write speeds that I reported above, and only a
>> reboot will get the performance back to regular.
> 
> Please full dmesg after your computer got really slow.  I suspect libata
> decided to switch to PIO mode.

If that's so, how come I still get good read speeds? o.O

> 
>> I don't know what causes it, but most of the times when I've gotten it
>> my system has been under heavy load (compiling, downloading torrents in
>> 11mb/sec etc). Please let me know if you want any additional info, want
>> me to try something out, or whatever. My recent hardware upgrade for
>> around $1200 (to a core2duo system, i965 mobo) is just going to waste
>> because of this problem. :/
> 
> Heh, nice machine you got there.  When you look at the dmesg, do the
> error messages occur only on one of the two drives?  Or are both
> affected?  If only one is affected,

IIRC only sda is affected, and later today I'm gonna switch back to
non-AHCI mode and try to reproduce this error (This might be my
imagination, but it feels like I get the error more frequently if I
don't run the ports in AHCI mode..) so I can try out the things you've
listed here.. Would suck if there's a hardware problem with one of my
disks, but I guess it's possible.

> 
> 1. swap the two.  you'll probably have to dance a little bit with boot
> loader but md should handle that fine once the kernel is loaded.  does
> the errors persist?  on which device do they occur?  do they follow the
> drive or stay on the mobo port?

(I'm running my /boot on a raid1, so switching drives should require no
reconfiguration at all :)

> 
> 2. try different cable / port.  if you change port, again, you need to
> dance w/ boot loader.  who's carrying the error messages with it?
> 
> 3. try different power plug from different power lane.
> 
>> I just got so glad when I saw the post of this on linux-ide, I've been
>> searching like crazy to find another person having the same problem (and
>> possibly a solution) for the past 2-3 weeks or so.
> 
> My first guess is frequent transmission errors.  Please report the test
> results.  Thanks.
>

I've pushing my system really hard for half an hour or so to reproduce
this problem, and I got something else (no write speed slowdown, but
some page allocation errors, no idea if this has something to do with
anything, but I'll post it anyways)

My dmesg is filled up with this:

swapper: page allocation failure. order:0, mode:0x20
 [<c0143a29>] __alloc_pages+0x2ec/0x308
 [<c03507a7>] tcp_v4_rcv+0x984/0x99d
 [<c0159ef2>] cache_alloc_refill+0x2d0/0x507
 [<c015a1a5>] __kmalloc+0x7c/0x7e
 [<c031c901>] __alloc_skb+0x58/0x108
 [<c026e369>] rtl8169_rx_fill+0x7b/0x140
 [<c026e6ea>] rtl8169_rx_interrupt+0x2bc/0x413
 [<c027069e>] rtl8169_poll+0x3f/0x20a
 [<c0132fa7>] hrtimer_run_queues+0xc0/0x14b
 [<c03226ef>] net_rx_action+0x79/0x106
 [<c01221e4>] __do_softirq+0x73/0xd9
 [<c0122281>] do_softirq+0x37/0x39
 [<c01056b5>] do_IRQ+0x40/0x7b
 [<c01037df>] common_interrupt+0x23/0x28
 [<c01010fe>] mwait_idle_with_hints+0x39/0x3b
 [<c0101118>] mwait_idle+0x18/0x1c
 [<c010123b>] cpu_idle+0x64/0x79
 =======================
Mem-info:
DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1
usd:   0
CPU    1: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1
usd:   0
Normal per-cpu:
CPU    0: Hot: hi:  186, btch:  31 usd:  30   Cold: hi:   62, btch:  15
usd:  60
CPU    1: Hot: hi:  186, btch:  31 usd:  30   Cold: hi:   62, btch:  15
usd:  13
HighMem per-cpu:
CPU    0: Hot: hi:  186, btch:  31 usd: 147   Cold: hi:   62, btch:  15
usd:  49
CPU    1: Hot: hi:  186, btch:  31 usd: 174   Cold: hi:   62, btch:  15
usd:  14
Active:149205 inactive:322562 dirty:155279 writeback:8923 unstable:0
free:3019 slab:36075 mapped:52151 pagetables:808
DMA free:3520kB min:68kB low:84kB high:100kB active:0kB inactive:6684kB
present:16256kB pages_scanned:64 all_unreclaimable? no
lowmem_reserve[]: 0 873 2015
Normal free:1404kB min:3744kB low:4680kB high:5616kB active:20436kB
inactive:714124kB present:894080kB pages_scanned:45728 all_unreclaimable? no
lowmem_reserve[]: 0 0 9135
HighMem free:7152kB min:512kB low:1736kB high:2960kB active:576384kB
inactive:569440kB present:1169292kB pages_scanned:7 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB
1*2048kB 0*4096kB = 3520kB
Normal: 1*4kB 1*8kB 7*16kB 0*32kB 0*64kB 0*128kB 1*256kB 0*512kB
1*1024kB 0*2048kB 0*4096kB = 1404kB
HighMem: 1140*4kB 96*8kB 80*16kB 3*32kB 1*64kB 1*128kB 1*256kB 0*512kB
0*1024kB 0*2048kB 0*4096kB = 7152kB
Swap cache: add 29537, delete 19491, find 7603/9179, race 1+0
Free swap  = 1704516kB
Total swap = 1767128kB
Free swap:       1704516kB
524000 pages of RAM
294624 pages of HIGHMEM
5482 reserved pages
486945 pages shared
10046 pages swap cached
155279 pages dirty
8798 pages writeback
52151 pages mapped
36075 pages slab
808 pages pagetables

printk: 892 messages suppressed.
ent:md4!: page allocation failure. order:0, mode:0x20
 [<c0143a29>] __alloc_pages+0x2ec/0x308
 [<c03507a7>] tcp_v4_rcv+0x984/0x99d
 [<c0159ef2>] cache_alloc_refill+0x2d0/0x507
 [<c015a1a5>] __kmalloc+0x7c/0x7e
 [<c031c901>] __alloc_skb+0x58/0x108
 [<c026e369>] rtl8169_rx_fill+0x7b/0x140
 [<c026e6ea>] rtl8169_rx_interrupt+0x2bc/0x413
 [<c027069e>] rtl8169_poll+0x3f/0x20a
 [<c01168f9>] find_busiest_group+0x124/0x4fd
 [<c0270ed7>] rtl8169_interrupt+0xce/0x22b
 [<c03226ef>] net_rx_action+0x79/0x106
 [<c01221e4>] __do_softirq+0x73/0xd9
 [<c0122281>] do_softirq+0x37/0x39
 [<c01056b5>] do_IRQ+0x40/0x7b
 [<c036fc19>] __sched_text_start+0x309/0x937
 [<c01037df>] common_interrupt+0x23/0x28
 [<c02256ed>] _atomic_dec_and_lock+0x1d/0x80
 [<c0179044>] generic_sync_sb_inodes+0xe2/0x249
 [<c016f8f9>] iput+0x41/0x77
 [<c01b4a8f>] put_wbq+0x13/0x21
 [<c01b4c27>] entd+0x18a/0x2b8
 [<c01b4a9d>] entd+0x0/0x2b8
 [<c0130345>] kthread+0xcc/0xf3
 [<c0130279>] kthread+0x0/0xf3
 [<c01039eb>] kernel_thread_helper+0x7/0x1c
 =======================
Mem-info:
DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1
usd:   0
CPU    1: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1
usd:   0
Normal per-cpu:
CPU    0: Hot: hi:  186, btch:  31 usd:  31   Cold: hi:   62, btch:  15
usd:  53
CPU    1: Hot: hi:  186, btch:  31 usd:  30   Cold: hi:   62, btch:  15
usd:  51
HighMem per-cpu:
CPU    0: Hot: hi:  186, btch:  31 usd: 131   Cold: hi:   62, btch:  15
usd:  54
CPU    1: Hot: hi:  186, btch:  31 usd:  77   Cold: hi:   62, btch:  15
usd:  15
Active:188954 inactive:272272 dirty:147727 writeback:8547 unstable:0
free:1969 slab:47710 mapped:50495 pagetables:832
DMA free:3520kB min:68kB low:84kB high:100kB active:0kB inactive:5256kB
present:16256kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 873 2015
Normal free:1284kB min:3744kB low:4680kB high:5616kB active:23140kB
inactive:666264kB present:894080kB pages_scanned:19930 all_unreclaimable? no
lowmem_reserve[]: 0 0 9135
HighMem free:3072kB min:512kB low:1736kB high:2960kB active:732676kB
inactive:417568kB present:1169292kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB
1*2048kB 0*4096kB = 3520kB
Normal: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 0*512kB
1*1024kB 0*2048kB 0*4096kB = 1284kB
HighMem: 172*4kB 66*8kB 18*16kB 35*32kB 1*64kB 1*128kB 1*256kB 0*512kB
0*1024kB 0*2048kB 0*4096kB = 3072kB
Swap cache: add 29623, delete 19495, find 7636/9238, race 1+0
Free swap  = 1704512kB
Total swap = 1767128kB
Free swap:       1704512kB
524000 pages of RAM
294624 pages of HIGHMEM
5482 reserved pages
474337 pages shared
10128 pages swap cached
147727 pages dirty
8447 pages writeback
50495 pages mapped
47710 pages slab
832 pages pagetables


This happened after I kicked up a "dd if=/dev/mdX of=/dev/null" and "dd
if=/dev/zero of=tfile1" on both my raid0's (2 dd's per raid (1 read+1
write) per drive), started a recompile of kdelibs, and had a torrent
download running for 11mb/sec, ie pretty heavy load. (done with the
anticipatory scheduler)

I guess it could just be that the kernel couldn't read the swap in a
reasonable amount of time because of all the other disk activity, but
I'm posting it anyways, since you guys will know if it has something to
do with this or not.


ps. The system is back to stable now after those allocation errors.
-- 
-Jonas

Name:   Jonas Lundgren
ICQ#:   52064961
Mail:   jonas@local.se
IRC:    neon / neonman @ EFnet, Undernet, Quakenet, freenode
