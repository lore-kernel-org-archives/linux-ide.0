From: kenneth johansson <ken@kenjo.org>
Subject: Read error generated oops.
Date: Sat, 27 Jan 2007 19:49:37 +0100
Message-ID: <1169923777.18828.38.camel@duo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:4423 "EHLO
	garbo.kenjo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbXA0Stj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Jan 2007 13:49:39 -0500
Received: from duo.kenjo.org ([172.16.0.10])
	by garbo.kenjo.org with esmtp (Exim 4.63)
	(envelope-from <ken@kenjo.org>)
	id 1HAscL-0000pa-Vq
	for linux-ide@vger.kernel.org; Sat, 27 Jan 2007 19:49:38 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a read error on one drive that triggers an oops.

HEAD=99abfeafb5f2eea1bb481330ff37343e1133c924

-----------
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x40 { UncorrectableError }, LBAsect=227940458, high=13, low=9836650, sector=227940352
ide: failed opcode was: unknown
end_request: I/O error, dev hdg, sector 227940352
BUG: unable to handle kernel paging request at virtual address 6b707483
printing eip:
c0241019
*pde = 00000000
Oops: 0002 [#1]
DEBUG_PAGEALLOC
Modules linked in: netconsole ipv6 ppdev lp dm_snapshot dm_mirror sk98lin st via_agp uhci_hcd skge aic7xxx scsi_transport_spi agpgart evdev sd_mod
CPU:    0
EIP:    0060:[<c0241019>]    Not tainted VLI
EFLAGS: 00210006   (2.6.20-rc6 #5)
EIP is at __end_that_request_first+0x3e9/0x540
eax: 6b70747b   ebx: ee542f90   ecx: 00000001   edx: 0001adb0
esi: 00010000   edi: 00000000   ebp: ebe53e64   esp: ebe53e08
ds: 007b   es: 007b   ss: 0068
Process rosetta_5.43_i6 (pid: 2437, ti=ebe52000 task=ebdcb5d0 task.ti=ebe52000)
Stack: fffffffb ef7c9f04 0d961800 00000000 00000000 c057e580 ebe53e94 00200046 
       c0515f7c d9a7ff40 00001000 00001000 fffffffb 00000001 00000001 c0515f60 
       00200082 00000000 ebe53e6c c03f2d1a d9a7ff40 c07ca680 00000001 ebe53e6c 
Call Trace:
[<c0103e9a>] show_trace_log_lvl+0x1a/0x30
[<c0103f59>] show_stack_log_lvl+0xa9/0xd0
[<c010413e>] show_registers+0x1be/0x2a0
[<c0104333>] die+0x113/0x270
[<c03f45f0>] do_page_fault+0x2b0/0x5d0
[<c03f2ecc>] error_code+0x74/0x7c
[<c024118b>] end_that_request_first+0xb/0x10
[<c02e6ff3>] ide_end_request+0x63/0x100
[<c02e70b4>] ide_kill_rq+0x24/0x50
[<c02e7f4b>] __ide_error+0x9b/0x270
[<c02e818b>] ide_error+0x6b/0x90
[<c02ef2b6>] ide_dma_intr+0x46/0xc0
[<c02e7ca4>] ide_intr+0x74/0x1e0
[<c013d678>] handle_IRQ_event+0x28/0x60
-----------

This was triggered by the badblocks program. The last output was 

Checking for bad blocks (read-only test):       113968064/ 245117375
the numbers are in block where a block is 1024.

Now I would like to write over the bad block with zeros but I want to
write as little as I could possibly do so I need to convert the sector
numbers to something I can use with dd.

But what sector is wrong here ? LBAsect=227940458 or sector=227940352
and how do I turn this into a byte offset "dd if=/dev/zero of=/dev/hdg
bs=512 count=1 seek=??????





