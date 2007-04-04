From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Subject: sata_mv error recovery issues
Date: Wed, 4 Apr 2007 15:25:33 +0200
Message-ID: <20070404132533.GA2339@xi.wantstofly.org>
Reply-To: "The CentOS developers mailing list." <centos-devel-IFYaIzF+flcdnm+yROfE0A@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <centos-devel-bounces-IFYaIzF+flcdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.centos.org/mailman/listinfo/centos-devel>,
	<mailto:centos-devel-request-IFYaIzF+flcdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.centos.org/pipermail/centos-devel>
List-Post: <mailto:centos-devel-IFYaIzF+flcdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:centos-devel-request-IFYaIzF+flcdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <http://lists.centos.org/mailman/listinfo/centos-devel>,
	<mailto:centos-devel-request-IFYaIzF+flcdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: centos-devel-bounces-IFYaIzF+flcdnm+yROfE0A@public.gmane.org
Errors-To: centos-devel-bounces-IFYaIzF+flcdnm+yROfE0A@public.gmane.org
To: jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, centos-devel-idqoXFIVOFKkGVvDs9mD4g@public.gmane.org
List-Id: linux-ide@vger.kernel.org

(please CC on replies, I'm not subscribed to linux-ide@)

Hi,

sata_mv (driving two 8-port Supermicro AOC-SAT2-MV8 PCI-X adapters) in
2.6.18-1.2747.el5 (RHEL/CentOS 5 beta kernel) didn't respond too well
to one of the attached disks experiencing what seems to be a head crash.

Apr  4 13:52:20 duality kernel: ata5: Entering mv_eng_timeout
Apr  4 13:52:20 duality kernel: mmio_base f8980000 ap f7b442dc qc f7b44cf8 scsi_cmnd e719ee00 &cmnd e719ee38
Apr  4 13:52:30 duality kernel: ata5: no sense translation for status: 0x40
Apr  4 13:52:30 duality kernel: ata5: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr  4 13:52:30 duality kernel: ata5: status=0x40 { DriveReady }
Apr  4 13:52:30 duality kernel: sd 4:0:0:0: SCSI error: return code = 0x08000002
Apr  4 13:52:30 duality kernel: sde: Current: sense key: Aborted Command
Apr  4 13:52:30 duality kernel:     Additional sense: No additional sense information
Apr  4 13:52:30 duality kernel: end_request: I/O error, dev sde, sector 684432191

At this point, the machine got into an endless loop where it would
completely freeze for a couple of seconds every minute or so (busy wait
in kernel space?), during which time it wouldn't respond to keyboard
input, ping packets or any other input.

Every time when it unfroze after being frozen for a couple of seconds,
it would spit out a similar mv_eng_timeout message as above, and it
would reply to the ping packets sent to it while it was frozen (i.e. a
sudden burst of ping reply packets with ping times of 1ms, 1001ms,
2001ms, 3001ms, 4001ms, 5001ms etc), which makes me think it was just
spinning in kernelspace somewhere.

Apr  4 13:56:02 duality kernel: BUG: soft lockup detected on CPU#3!
Apr  4 13:56:02 duality kernel:  [<c04051ba>] dump_trace+0x69/0x1af
Apr  4 13:56:02 duality kernel:  [<c0405318>] show_trace_log_lvl+0x18/0x2c
Apr  4 13:56:02 duality kernel:  [<c04058cc>] show_trace+0xf/0x11
Apr  4 13:56:02 duality kernel:  [<c04059c9>] dump_stack+0x15/0x17
Apr  4 13:56:02 duality kernel:  [<c044d4da>] softlockup_tick+0xa6/0xb4
Apr  4 13:56:02 duality kernel:  [<c042e32a>] update_process_times+0x39/0x5c
Apr  4 13:56:02 duality kernel:  [<c04188d4>] smp_apic_timer_interrupt+0x5c/0x64
Apr  4 13:56:02 duality kernel:  [<c0404a8b>] apic_timer_interrupt+0x1f/0x24
Apr  4 13:56:02 duality kernel: DWARF2 unwinder stuck at apic_timer_interrupt+0x1f/0x24
Apr  4 13:56:02 duality kernel: Leftover inexact backtrace:
Apr  4 13:56:02 duality kernel:  [<c0610468>] _spin_unlock_irqrestore+0x8/0x9
Apr  4 13:56:02 duality kernel:  [<f88cea77>] mv_eng_timeout+0xac/0x105 [sata_mv]
Apr  4 13:56:02 duality kernel:  [<f888728d>] scsi_error_handler+0x0/0x9c7 [scsi_mod]
Apr  4 13:56:02 duality kernel:  [<f88f8fdc>] ata_scsi_error+0x3c6/0x4be [libata]
Apr  4 13:56:02 duality kernel:  [<f8884217>] __scsi_iterate_devices+0x50/0x58 [scsi_mod]
Apr  4 13:56:02 duality kernel:  [<f888728d>] scsi_error_handler+0x0/0x9c7 [scsi_mod]
Apr  4 13:56:02 duality kernel:  [<f888732c>] scsi_error_handler+0x9f/0x9c7 [scsi_mod]
Apr  4 13:56:02 duality kernel:  [<c041e4f6>] complete+0x2b/0x3d
Apr  4 13:56:02 duality kernel:  [<f888728d>] scsi_error_handler+0x0/0x9c7 [scsi_mod]
Apr  4 13:56:02 duality kernel:  [<c0436620>] kthread+0xc0/0xec
Apr  4 13:56:02 duality kernel:  [<c0436560>] kthread+0x0/0xec
Apr  4 13:56:02 duality kernel:  [<c0404d63>] kernel_thread_helper+0x7/0x10
Apr  4 13:56:02 duality kernel:  =======================

All I/O to the RAID array that this disk was a member of (12 disk 6TB
software RAID6 array) froze completely.  It did mark the broken disk
failed, but didn't recover from the failure.  I had to reboot the box
with the power switch, as '/sbin/reboot -f' via ssh would also get
stuck in D state.

Any other info I can give?  I still have the crashed disk in case
anyone wants me to do some tests with it..


thanks,
Lennert
