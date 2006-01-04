From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Tue, 3 Jan 2006 16:40:09 -0800
Message-ID: <20060103164009.1c7418a7.randy_d_dunlap@linux.intel.com>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
	<87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
	<20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
	<20060103172649.GV2772@suse.de>
	<20060103190346.GY2772@suse.de>
	<20060103115712.5ac7ec47.randy_d_dunlap@linux.intel.com>
	<87wthh0wcf.fsf@marrow.phys.tohoku.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:490 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751164AbWADAja (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jan 2006 19:39:30 -0500
In-Reply-To: <87wthh0wcf.fsf@marrow.phys.tohoku.ac.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Cc: axboe@suse.de, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

On 04 Jan 2006 07:40:00 +0900
Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp> wrote:

> Randy Dunlap <randy_d_dunlap@linux.intel.com> writes:
> > On Tue, 3 Jan 2006 20:03:47 +0100
> > Jens Axboe <axboe@suse.de> wrote:
> > > On Tue, Jan 03 2006, Jens Axboe wrote:
> > > > On Tue, Jan 03 2006, Randy Dunlap wrote:
> > > > > On 30 Dec 2005 17:36:44 +0900
> > > > > Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp> wrote:
> > > > > 
> > > > > > I tested kernel 2.6.15-rc7 with your patch applied on my ThinkPad X41.
> 
> My laptop is ThinkPad X41 Tablet, which has the same SATA controller
> as X41.
> 
> > > > > > While booting, it locks up after printing
> > > > > > 
> > > > > >     ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
> > > > > >     ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
> > > > > >     ata1(0): applying bridge limits
> > > > > >     ata1: dev 0 configured for UDMA/100
> > > > > > 
> > > > > > If I select CONFIG_SCSI_SATA_AHCI, then the kernel emits an oops and
> > > > > > panics during boot.
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > Can you capture the kernel oops & panic messages?
> > > > > Please send me your .config also.

This certainly isn't the same failure that Jens saw.

Could there be any informative & helpful messages missing
before these messages, e.g., an assert() failure?

I don't quite understand what CONFIG_SCSI_SATA_AHCI has to do
with this.  I see ata_interrupt() [from libata-core.c],
but ahci.c contains ahci_interrupt(), which isn't in this
stack dump.  Nevertheless, it looks like complete() is
being passed a NULL struct completion...  Maybe I'm misusing
the completion API and don't know it (?).

BTW, .config file, please.

> I tried to copy them here:
> 
>  sda:<1>Unable to handle kernel NULL pointer dereference at virtual address 00000172
>  printing eip:
> c0118fc5
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c0118fc5>] Not tainted VLI
> EFLAGS: 00010006   (2.6.15-rc7-randyahci)
> EIP is at complete+0x15/0x60
> eax: 00000172   ebx: c0352000   ecx: 00000000   edx: c1fe5760
> esi: 00000092   edi: 00000001   ebp: c0353f08   esp: c0353eec
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c0352000 task=c030fb00)
> Stack: c1fe5760 c1fe5760 00000000 c1fe5760 c0253f9a 00000000 c1fe5284 c1fd6500
>        c0253ebd c1fe5284 00000000 c1fe5760 c02545bc c1fe5760 00000000 c0353f50
>        c0353f28 c0352000 c0353fa4 00000282 00000000 c1fd64a0 00000000 c0353fa4
> Call Trace:
>  [<c0253f9a>] ata_qc_complete+0x3a/0xc0
>  [<c0253ebd>] __ata_qc_complete+0x6d/0x80
>  [<c02545bc>] ata_interrupt+0x11c/0x140
>  [<c013f5e9>] handle_IRQ_event+0x39/0x70
>  [<c013f69e>] __do_IRQ+0x7e/0x120
>  [<c01219a1>] __do_softirq+0x41/0xa0
>  [<c0105739>] do_IRQ+0x19/0x30
>  [<c0103b82>] common_interrupt+0x1a/0x20
>  [<c010105d>] default_idle+0x42/0x60
>  [<c01010e2>] cpu_idle+0x42/0x60
>  [<c035487f>] start_kernel+0x15f/0x180
>  [<c03543b0>] unknown_bootoption+0x0/0x1f0
> Code: 8b 5d f4 8b 75 f8 8b 7d fc 89 ec 5d e9 45 e9 1a 00 90 8d 74 26 00 55 89 e5 56 53 83 ec 14 9c 5e fa bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 00 31 c9 31 d2 89 4c 24 10 83 c0 04 b9 01 00 00 00 89 54 24
>  <0>Kernel panic - not syncing: Fatal exception in interrupt


> > New patch series is at
> >   http://www.xenotime.net/linux/SATA/2.6.15/
> > with a combined patch at
> >   http://www.xenotime.net/linux/SATA/2.6.15/libata-combine-2615.patch
> 
> With this patch series, resume still fails with snd_intel8x0m
> rmmod-ed.  Resume works if the snd_intel8x0m module has been inserted.
> I am curious about this, too.

Wow, interesting, but I have no idea about that.

---
~Randy
