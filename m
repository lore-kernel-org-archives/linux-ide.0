From: George Socker <gsocker@redpin.com>
Subject: SATA tape - partial success w/Sony i390ST
Date: Tue, 1 Jul 2008 21:32:59 -0400
Message-ID: <20080701213259.6fbed097@redpin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from radar.redpin.com ([208.110.80.114]:38654 "EHLO
	hawkeye.redpin.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756730AbYGBBxW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jul 2008 21:53:22 -0400
Received: from localhost ([127.0.0.1])
	by hawkeye.redpin.com with esmtpa (Exim 4.67)
	(envelope-from <gsocker@redpin.com>)
	id 1KDqnX-0004C9-8V
	for linux-ide@vger.kernel.org; Tue, 01 Jul 2008 20:06:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,
 
I have the same sata tape drive as Russell Brown (Sony i390ST) - same
chipset as well - nVidia  MCP55.

Results seem to vary depending on the software used.

BRU dies as soon as it starts to write to the tape with below message:
 ------------[ cut here ]------------
 WARNING: at drivers/ata/libata-sff.c:1309 ata_sff_hsm_move+0x98/0x630()
 Modules linked in: radeon drm snd_seq_midi snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_em ul snd_pcm_oss
snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq k8temp hwmon
ohci1394 hci_usb snd_emu10k1 snd_rawmidi snd_ac97_c odec ac97_bus
snd_seq_device snd_util_mem snd_hwdep snd_hda_intel snd_pcm snd_timer
snd_page_alloc wacom ieee1394 snd bluetooth i2c_ nforce2 i2c_core
joydev
 Pid: 0, comm: swapper Not tainted 2.6.26-rc8 #4 
Call Trace:
<IRQ>  [<ffffffff80232824>] warn_on_slowpath+0x64/0xa0
[<ffffffff802473c9>] autoremove_wake_function+0x9/0x30
[<ffffffff80228b7a>] __wake_up_common+0x5a/0x90 
[<ffffffff8023c944>] lock_timer_base+0x34/0x70 
[<ffffffff8023cab0>] __mod_timer+0xb0/0xd0 
[<ffffffff80371cfa>] cfq_completed_request+0x1da/0x2c0
[<ffffffff80447d48>] ata_sff_hsm_move+0x98/0x630 
[<ffffffff80368631>] __blk_run_queue+0x11/0xd0 
[<ffffffff8024a8b5>] ktime_get_ts+0x25/0x60 
[<ffffffff80448375>] ata_sff_host_intr+0x95/0x130 
[<ffffffff8044df97>] nv_swncq_interrupt+0x57/0x6b0 
[<ffffffff8024a618>] hrtimer_start+0xe8/0x180 
[<ffffffff8025c564>] handle_IRQ_event+0x34/0x70 
[<ffffffff8025dff5>] handle_fasteoi_irq+0x85/0x100 
[<ffffffff8020e36b>] do_IRQ+0x7b/0x100 
[<ffffffff8020a5a0>] default_idle+0x0/0x40 
[<ffffffff8020b9d1>] ret_from_intr+0x0/0xa <EOI>  
[<ffffffff8021d4c0>] lapic_next_event+0x0/0x10 
[<ffffffff8020a5c7>] default_idle+0x27/0x40 
[<ffffffff8020a0c9>] cpu_idle+0x59/0xb0 
---[ end trace 1f03762346e0ff62 ]--- 
ata4.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x6 ata4.00: BMDMA stat 0x4
 ata4.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 1048576 out
          cdb 0a 01 00 00 01 00 00 00  00 00 00 00 00 00 00 00
          res 10/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x2 (HSM
violation)
 ata4: hard resetting link ata4: SATA link up 1.5 Gbps
(SStatus 113 SControl 300) ata4.00: configured for UDMA/100
 ata4: EH complete
 st0: Error: 8000002, cmd: a 1 0 0 1 0
 st0: Sense Key : Aborted Command [current] [descriptor]
 Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0e 09 0c 00 00 00 03 00 00 
         00 00 00 00 a0 10 
st0: Add. Sense: No additional sense information
st0: Error on write:
 st0: Async write waits 0, finished 0.
 st0: Error: 8000002, cmd: 10 0 0 0 1 0
 st0: Sense Key : Unit Attention [current] 
 Info fld=0x1
 st0: Add. Sense: Power on, reset, or bus device reset occurred
 st0: Error on write filemark.


However, using xfsdump, I can get ~300MB written to tape before 
the above error occurs.
xfsdump appears to use a different block size; with BRU there are many
st0: Incorrect block size
 messages in the log, but xfsdump  only generates the following:
st0: Setting block size to 1048576 bytes. 
Block size may be part of the problem.
Sony does have a "Product Specification Manual" available on their
website which lists all valid ATA/ATAPI commands for the drive.

Hope this provides some hints. Am willing to apply patches or do other
testing.

George
