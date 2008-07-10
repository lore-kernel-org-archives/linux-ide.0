From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 11065] New: WARNING: at
 drivers/ata/libata-sff.c:1321 ata_sff_hsm_move+0x8f/0x661()
Date: Wed, 9 Jul 2008 19:50:24 -0700
Message-ID: <20080709195024.e6f3904d.akpm@linux-foundation.org>
References: <bug-11065-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47132 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753180AbYGJC4Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jul 2008 22:56:24 -0400
In-Reply-To: <bug-11065-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, netzdamon@gmail.com


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed,  9 Jul 2008 19:36:40 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11065
> 
>            Summary: WARNING: at drivers/ata/libata-sff.c:1321
>                     ata_sff_hsm_move+0x8f/0x661()
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.26-rc9
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: netzdamon@gmail.com
> 
> 
> I pasted the error I been seeing lately. I been getting this over the last few
> days. Hope this is filed in the right place, let me know if I can provide some
> more info. I'll see this a bunch of times in dmesg, eventually things start to
> slow down till my box will hard lock on me. Really don't think its a bad drive
> or cable considering two drives are acting up at the same time. I also tried
> 2.6.26-rc9-git5. As well as 2.6.25.10. 
> 
> ------------[ cut here ]------------
> WARNING: at drivers/ata/libata-sff.c:1321 ata_sff_hsm_move+0x8f/0x661()

That is

	case HSM_ST_ERR:
		/* make sure qc->err_mask is available to
		 * know what's wrong and recover
		 */
		WARN_ON(!(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM)));

> Modules linked in: 3c59x mii i2c_i801
> Pid: 0, comm: swapper Tainted: P        W 2.6.26-rc9-git5 #3
> 
> Call Trace:
>  <IRQ>  [<ffffffff8023438a>] warn_on_slowpath+0x51/0x6d
>  [<ffffffff802274ec>] enqueue_task+0x4d/0x5b
>  [<ffffffff8022a23b>] __resched_task+0x4b/0x77
>  [<ffffffff805f3b0a>] _spin_unlock_irqrestore+0x12/0x32
>  [<ffffffff8022a05b>] try_to_wake_up+0x8d/0x1f7
>  [<ffffffff8048e23c>] ata_sff_hsm_move+0x8f/0x661
>  [<ffffffff8023df26>] lock_timer_base+0x26/0x4e
>  [<ffffffff805f3b0a>] _spin_unlock_irqrestore+0x12/0x32
>  [<ffffffff8048f718>] ata_sff_interrupt+0x16c/0x224
>  [<ffffffff805f3b3b>] _spin_unlock_irq+0x11/0x31
>  [<ffffffff8026bc42>] handle_IRQ_event+0x32/0x62
>  [<ffffffff8026d0f7>] handle_fasteoi_irq+0x7f/0xea
>  [<ffffffff8020dec6>] do_IRQ+0xb6/0x18c
>  [<ffffffff80211478>] mwait_idle+0x0/0x48
>  [<ffffffff8020b851>] ret_from_intr+0x0/0xa
>  <EOI>  [<ffffffff80219915>] lapic_next_event+0x0/0xa
>  [<ffffffff802114b9>] mwait_idle+0x41/0x48
>  [<ffffffff8020a063>] cpu_idle+0x4a/0x85
> 
> ---[ end trace b43c66638fc6f3d5 ]---
> 
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> ata2.00: BMDMA stat 0x66
> ata2.00: cmd 35/00:f0:7d:e9:5c/00:01:03:00:00/e0 tag 0 dma 253952 out
>          res 51/84:a0:cd:e9:5c/84:01:03:00:00/e0 Emask 0x30 (host bus error)
> ata2.00: status: { DRDY ERR }
> ata2.00: error: { ICRC ABRT }
> ata2: soft resetting link
> ata2.00: configured for UDMA/133
> ata2.01: configured for UDMA/133
> ata2: EH complete
> sd 1:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
> sd 1:0:0:0: [sda] Write Protect is off
> sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> sd 1:0:1:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
> sd 1:0:1:0: [sdb] Write Protect is off
> sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> 

I assume this is a post-2.6.25 regression.
