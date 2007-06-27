From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash PATA on libata failure to attach
Date: Wed, 27 Jun 2007 13:57:46 +1000
Message-ID: <4681e04b.22b38c0a.78ec.6f76@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca> <4680d387.24528c0a.3634.69bd@mx.google.com> <46815FF4.9040001@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:56354 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbXF0D6F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jun 2007 23:58:05 -0400
Received: by py-out-1112.google.com with SMTP id u77so77757pyb
        for <linux-ide@vger.kernel.org>; Tue, 26 Jun 2007 20:58:05 -0700 (PDT)
In-Reply-To: <46815FF4.9040001@rtr.ca>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, robert.de.rooy@gmail.com

> 
> This looks a lot like the other CF-card problem that was being debugged
> here over the past week -- the one where POLLING had to be turned on.
> Robert de Rooy (copied) was the reporter for that one.
> Perhaps you two could compare notes ?
> 
> Cheers

Thanks for getting back to me. I read through the thread Robert initiated
with CF on PCMCIA and noted with interest that the issue seemed to be
related in the end to lost interrupts. However the compact flash I'm using
is an IDE/PATA device connected directly to the motherboard with no
intermediate devices such as PCMCIA. As the issue is unlikely to be the same
but maybe similar I followed the same path, applying the patches that Tejun
issued to 2.6.22rc6 to provide more debug information in the hope that
someone can help me identify this issue.

I have applied 2.6.22rc6 + timing-debug.patch +
disable-dev_init_params.patch as per:

http://marc.info/?l=linux-kernel&m=117966084223982&w=2

Here is the relevant output from dmesg:

Linux version 2.6.22-rc6 (root@localhost) (gcc version 4.1.1 20070105 (Red
Hat 4
.1.1-51)) #3 SMP Wed Jun 27 14:25:12 EST 2007
...

ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x0001fa00 ctl 0x0001f902 bmdma 0x0001f600 irq 0
ata2: SATA max UDMA/133 cmd 0x0001f800 ctl 0x0001f702 bmdma 0x0001f608 irq 0
ata1: soft resetting port
ata1: reset complete
ata1.00: issuing IDENTIFY
ata1.00: IDENTIFY complete
ata1.00: ATA-0: CF CARD 512MB, 20070131, max MWDMA2
ata1.00: 990864 sectors, multi 0: LBA
ata1.00: applying bridge limits
ata1.00: issuing IDENTIFY
ata1.00: IDENTIFY complete
ata1.00: configured for MWDMA2
ata1: EH complete
ata2: soft resetting port
ata2: reset complete
ATA: abnormal status 0x7F on port 0x0001f807
ata2: EH complete
scsi 0:0:0:0: Direct-Access     ATA      CF CARD 512MB    2007 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 990864 512-byte hardware sectors (507 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DP
O or FUA
sd 0:0:0:0: [sda] 990864 512-byte hardware sectors (507 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DP
O or FUA
 sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: device not ready (errno=-16), forcing hardreset
ata1: BUG: prereset() requested invalid reset type
ata1: soft resetting port
ata1: reset complete
ata1.00: issuing IDENTIFY
ata1.00: IDENTIFY complete
ata1.00: model number mismatch 'CF CARD 512MB' != ''
ata1.00: revalidation failed (errno=-19)
ata1.00: limiting speed to MWDMA2:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ata1: reset complete
ata1.00: issuing IDENTIFY
ata1.00: IDENTIFY complete
ata1.00: model number mismatch 'CF CARD 512MB' != ''
ata1.00: revalidation failed (errno=-19)
ata1.00: disabled
ata1: soft resetting port
ata1: reset complete
ata1.00: issuing IDENTIFY
ata1.00: IDENTIFY complete
ata1.00: ATA-0: , , max PIO0
ata1.00: 0 sectors, multi 0, CHS 0/0/0
ata1.00: applying bridge limits
ata1.00: issuing IDENTIFY
ata1.00: IDENTIFY complete
ata1.00: model number mismatch '' != 'CF CARD 512MB'
ata1.00: revalidation failed (errno=-19)
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ata1: reset complete
ata1.00: issuing IDENTIFY
ata1.00: IDENTIFY complete
ata1.00: issuing IDENTIFY
ata1.00: IDENTIFY complete
ata1.00: configured for PIO0
ata1: EH complete
divide error: 0000 [#1]
SMP
CPU:    1
EIP:    0060:[<c03c7a48>]    Not tainted VLI
EFLAGS: 00010046   (2.6.22-rc6 #3)
EIP is at ata_build_rw_tf+0x20e/0x275
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c2134a40   edi: 00000000   ebp: 00000000   esp: f7c4be94
ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
Process scsi_eh_0 (pid: 972, ti=f7c4a000 task=f7867070 task.ti=f7c4a000)
Stack: 00000000 c2134188 00000000 00000000 f7c42bc0 c2134188 c2134a30
c03c8a86
       00000000 00000000 00000008 00000000 00000000 00000000 c20fb140
f7c42bc0
       00000000 f7c3bb58 00000000 00000000 00000008 c2134a30 f7c42bc0
c2134188
Call Trace:
 [<c03c8a86>] ata_scsi_rw_xlat+0x13d/0x1f8
 [<c030b815>] scsi_done+0x0/0x16
 [<c03c8c57>] ata_scsi_translate+0xf0/0x156
 [<c01215e8>] lock_timer_base+0x19/0x35
 [<c030b815>] scsi_done+0x0/0x16
 [<c03cad64>] ata_scsi_queuecmd+0x10f/0x12c
 [<c03c8949>] ata_scsi_rw_xlat+0x0/0x1f8
 [<c030bb44>] scsi_dispatch_cmd+0x185/0x1c9
 [<c030fdc4>] scsi_request_fn+0x20d/0x2c2
 [<c021fcf8>] blk_remove_plug+0x4f/0x5b
 [<c0220064>] blk_run_queue+0x37/0x63
 [<c030f46f>] scsi_run_host_queues+0x10/0x22
 [<c030e4bd>] scsi_error_handler+0x237/0x26f
 [<c0114d80>] complete+0x39/0x48
 [<c030e286>] scsi_error_handler+0x0/0x26f
 [<c01292f3>] kthread+0x38/0x5d
 [<c01292bb>] kthread+0x0/0x5d
 [<c0103153>] kernel_thread_helper+0x7/0x10
 =======================
Code: 0f 77 7b 81 7c 24 28 00 01 00 00 77 71 8b 54 24 04 89 f0 e8 f1 a2 ff
ff 85
 c0 78 69 8b 54 24 04 89 f8 0f b7 8a 40 02 00 00 31 d2 <f7> f1 89 04 24 8b
44 24
 04 89 d1 31 d2 0f b7 98 3e 02 00 00 8b
EIP: [<c03c7a48>] ata_build_rw_tf+0x20e/0x275 SS:ESP 0068:f7c4be94 

